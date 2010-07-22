------------------------------------------------------------------------------
--                            IPSTACK COMPONENTS                            --
--             Copyright (C) 2010, Free Software Foundation, Inc.           --
------------------------------------------------------------------------------

--  Callback oriented low level access to the UDP services.

with System;

with AIP.Config;
with AIP.Callbacks;
with AIP.Buffers;
with AIP.NIF;
with AIP.IP;
with AIP.IPaddrs;

--# inherit System, AIP, AIP.Config, AIP.Callbacks, AIP.Buffers,
--#         AIP.NIF, AIP.IP, AIP.IPaddrs;

package AIP.UDP is

   --  UDP connections materialize as "UDP Protocol Control Blocks"

   subtype PCB_Id is AIP.EID range AIP.NULID .. Config.MAX_UDP_PCB;
   NOPCB : constant AIP.EID := AIP.NULID;

   subtype Port_T is AIP.U16_T;
   NOPORT : constant Port_T := 0;

   --------------------
   -- User interface --
   --------------------

   procedure UDP_New (Id : out PCB_Id);
   --  Allocate and return Id of a new UDP PCB. PCB_NOID on failure.

   procedure UDP_Bind
     (PCB        : PCB_Id;
      Local_IP   : IPaddrs.IPaddr;
      Local_Port : Port_T;
      Err        : out AIP.Err_T);
   --  Bind PCB to a Local_IP address and Local_Port, after which datagrams
   --  received for this endpoint might be delivered to PCB and trigger an
   --  UDP_RECV event/callback. If Local_IP is IP_ADDR_ANY, the endpoint
   --  serves the port on all the active network interfaces. Local_Port might
   --  be NOPORT, in which case an arbitrary available one is picked.
   --
   --  ERR_USE if another PCB is already bound to this local endpoint and
   --  we are configured not to accept that.
   --
   --  ERR_USE if Local_Port is NOPORT and no available port could be found.

   procedure UDP_Connect
     (PCB         : PCB_Id;
      Remote_IP   : IPaddrs.IPaddr;
      Remote_Port : Port_T;
      Err         : out AIP.Err_T);
   --  Register Remote_IP/Remote_Port as the destination endpoint for
   --  datagrams sent later with UDP_Send on this PCB. Until disconnected,
   --  packets from this endpoint only are processed by PCB. A forced local
   --  binding is attempted if none was established beforehand. No network
   --  trafic gets generated.
   --
   --  ERR_USE if a forced binding is attempted and no port is available.

   procedure UDP_Send
     (PCB : PCB_Id;
      Buf : Buffers.Buffer_Id;
      Err : out AIP.Err_T);
   --  Send BUF data to the current destination endpoint of PCB, as
   --  established by UDP_Connect. BUF is not deallocated.
   --
   --  ERR_USE if PCB isn't connected
   --  ERR_RTE if no route to remote IP could be found
   --  ERR_MEM e.g.if the UDP header couldn't be allocated
   --  Possibly other errors from lower layers.

   procedure UDP_Disconnect (PCB : PCB_Id);
   --  Disconnect PCB from its current destination endpoint, which leaves
   --  it open to its initial binding again.

   procedure UDP_Release (PCB : PCB_Id);
   --  Release PCB, to become available for Udb_New again

   ------------------------------
   -- Event/callback interface --
   ------------------------------

   --  Event kinds and descriptor used to communicate with the
   --  applicative handler (UDP_Event).

   type UDP_Event_Kind is
     (UDP_RECV   -- UDP Datagram received
     );

   type UDP_Event_T is record
      Kind : UDP_Event_Kind;
      Buf  : Buffers.Buffer_Id;
      IP   : IPaddrs.IPaddr;
      Port : Port_T;
   end record;

   --  UDP_RECV triggers when a datagram is received for a destination port
   --  to which we have a bound PCB. One which in addition is UDP_Connect'ed
   --  to the datagram origin endpoint gets preference.
   --
   --  .Buf is the datagram packet buffer
   --  .IP/.Port is the datagram origin endpoint (remote source)

   procedure UDP_Callback
     (Evk : UDP_Event_Kind; PCB : PCB_Id; Cbid : Callbacks.CBK_Id);
   --  Register that ID should be passed back to the user defined
   --  UDP_Event hook when an event of kind EVK triggers for PCB.

   procedure UDP_Set_Udata (PCB : PCB_Id; Udata : System.Address);
   --  Attach application level UDATA to PCB for later retrieval
   --  on UDP_Event calls.

   function UDP_Udata (PCB : PCB_Id) return System.Address;
   --  Retrieve Udata previously attached to PCB, System.Null_Address if none.

   procedure UDP_Event
     (Ev : UDP_Event_T; PCB : PCB_Id; Cbid : Callbacks.CBK_Id);
   --  Process UDP event EV, aimed at bound PCB, for which Cbid was
   --  registered. Expected to be provided by the applicative code.

   pragma Import (Ada, UDP_Event, "aip_udp_event");

   -----------------------
   -- IPstack interface --
   -----------------------

   procedure UDP_Input (Buf : Buffers.Buffer_Id; Netif : NIF.Netif_Id);
   --  Hook for IP.  Dispatches a UDP datagram in BUF to the user callback
   --  registered for the destination port, if any. Discards the datagram
   --  (free BUF) otherwise.

   UDP_HLEN : constant := 8;

private

   type UDP_PCB is record
      IPCB        : IP.IP_PCB;        -- IP control block

      Local_Port  : Port_T;           --  Local UDP port PCB is bound to
      Remote_Port : Port_T;           --  Remote UDP port PCB is connected to

      Connected   : Boolean;          --  True if Remote_IP/Remote_Port are set

      Udata       : System.Address;       --  User/Application data pointer
      RECV_Cb     : Callbacks.CBK_Id; --  Callback id for UDP_RECV events

      Link : AIP.EID;                 --  Chaining link
   end record;

   PCB_UNUSED : constant AIP.EID := -2;
   --  Invalid PCB EID used in PCB.Link to indicate that the PCB is currently
   --  unused, IOW free for UDP_New.

   --  PCB.Link may also be NOPCB to indicate end-of-list for a PCB chained in
   --  a list, or mere use of the PCB (in-use though currently not in a list).

   --  PCB.Connected is used to detect proper remote endpoint definition on
   --  UDP_Send, and to prevent selection of PCB to handle an incoming datagram
   --  if it is not connected to its remote origin (UDP_Input).

   --------------------------
   -- Internal subprograms --
   --------------------------

   --  All declared here because SPARK forbids forward declarations in package
   --  bodies.

   procedure Init_PCBs;
   --  Initialize static pool of UDP PCBs

   procedure PCB_Allocate (Id : out AIP.EID);
   --  Find one PCB free for use from the static pool and mark it in-use

   procedure PCB_Clear (PCB : PCB_Id);
   --  Reset/Initialize PCB fields for fresh (re)use

   procedure PCB_Unlink (PCB : PCB_Id);
   --  Unlink PCB from the list of bound PCBs if it is there

   procedure PCB_Force_Bind (PCB : PCB_Id; Err : out AIP.Err_T);
   --  Force a local binding on PCB if it isn't bound already

   ------------------------
   -- UDP_Bind internals --
   ------------------------

   function PCB_Binding_Matches
     (PCB  : UDP_PCB;
      IPA  : IPaddrs.IPaddr;
      Port : Port_T) return Boolean;
   --  Whether PCB's local IP/port binding matches the provided
   --  IP/PORT pair.

   function PCB_Bound_To (Port : Port_T) return AIP.EID;
   --  From the list of bound PCBs, first one bound to local PORT
   --  NOPCB if none is found.

   function Available_Port return Port_T;
   --  Arbitrary local Port number to which no PCB is currently bound.
   --  NOPORT if no such port is available.

   -------------------------
   -- UDP_Input internals --
   -------------------------

   procedure IP_To_UDP
     (Buf  : Buffers.Buffer_Id;
      Uhdr : out System.Address;
      Err  : out AIP.Err_T);
   --  Get Uhdr to designate the UDP header of a datagram received from IP in
   --  BUF, and adjust BUF's payload accordingly.
   --  ERR_MEM if BUF is found too short to possibly carry a UDP datagram.

   function UDP_PCB_For
     (Ihdr  : System.Address;
      Uhdr  : System.Address;
      Netif : NIF.Netif_Id) return AIP.EID;
   --  Search bound PCBs for one taker of a datagram with IP header Ihdr and
   --  UDP header Uhdr arrived on NETIF.

   ------------------------
   -- UDP_Send internals --
   ------------------------

   procedure Prepend_UDP_Header
     (Buf  : Buffers.Buffer_Id;
      Ubuf : out Buffers.Buffer_Id;
      Err  : out AIP.Err_T);
   --  Setup space for a UDP header before the data in Buf. See if there is
   --  enough room preallocated for this purpose, and adjust the payload
   --  pointer in this case. Prepend a separate buffer otherwise.
   --  ERR_MEM if the operation failed. BUF is unchanged in this case.

   procedure UDP_Send_To_If
     (PCB      : PCB_Id;
      Buf      : Buffers.Buffer_Id;
      Dst_IP   : IPaddrs.IPaddr;
      Dst_Port : Port_T;
      Netif    : NIF.Netif_Id;
      Err      : out AIP.Err_T);
   --  Send BUF to DST_IP/DST_PORT through NETIF, acting for PCB.
   --  ERR_VAL if PCB has a specific local IP set which differs from
   --  NETIF's IP.

end AIP.UDP;
