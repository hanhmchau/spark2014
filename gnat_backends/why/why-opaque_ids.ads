------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                       W H Y - O P A Q U E _ I D S                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                       Copyright (C) 2010-2011, AdaCore                   --
--                                                                          --
-- gnat2why is  free  software;  you can redistribute it and/or modify it   --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software Foundation;  either version  2,  or  (at your option) any later --
-- version. gnat2why is distributed in the hope that it will  be  useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN-  --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License  for more details. You  should  have  received a copy of the GNU --
-- General Public License  distributed with GNAT; see file COPYING. If not, --
-- write to the Free Software Foundation,  51 Franklin Street, Fifth Floor, --
-- Boston,                                                                  --
--                                                                          --
-- gnat2why is maintained by AdaCore (http://www.adacore.com)               --
--                                                                          --
------------------------------------------------------------------------------
--  This package is automatically generated by xtree. Do not edit manually.

with Why.Types; use Why.Types;

package Why.Opaque_Ids is
   --  Declarations of subtypes of Why_Node_Id/Why_Node_List; one per
   --  node kind/multiplicity.

   --  A comprehensive description of the different subtypes may be
   --  found in Why.Ids. This package only defines opaque ids;
   --  In a nutshell, those are the same as regular ids, except that they
   --  have no subtype predicate. These should only be needed in
   --  Why.Atree; this package cannot depend on Why.Ids without a
   --  circular dependancy. At any other location than Why.Atree,
   --  regular ids or unchecked ids should be used.

   subtype W_Unused_At_Start_Opaque_OId is Why_Node_Id;

   subtype W_Unused_At_Start_Opaque_OList is Why_Node_List;

   subtype W_Unused_At_Start_Opaque_Id is Why_Node_Id;

   subtype W_Unused_At_Start_Opaque_List is Why_Node_List;

   subtype W_Identifier_Opaque_OId is Why_Node_Id;

   subtype W_Identifier_Opaque_OList is Why_Node_List;

   subtype W_Identifier_Opaque_Id is Why_Node_Id;

   subtype W_Identifier_Opaque_List is Why_Node_List;

   subtype W_Type_Prop_Opaque_OId is Why_Node_Id;

   subtype W_Type_Prop_Opaque_OList is Why_Node_List;

   subtype W_Type_Prop_Opaque_Id is Why_Node_Id;

   subtype W_Type_Prop_Opaque_List is Why_Node_List;

   subtype W_Type_Int_Opaque_OId is Why_Node_Id;

   subtype W_Type_Int_Opaque_OList is Why_Node_List;

   subtype W_Type_Int_Opaque_Id is Why_Node_Id;

   subtype W_Type_Int_Opaque_List is Why_Node_List;

   subtype W_Type_Bool_Opaque_OId is Why_Node_Id;

   subtype W_Type_Bool_Opaque_OList is Why_Node_List;

   subtype W_Type_Bool_Opaque_Id is Why_Node_Id;

   subtype W_Type_Bool_Opaque_List is Why_Node_List;

   subtype W_Type_Real_Opaque_OId is Why_Node_Id;

   subtype W_Type_Real_Opaque_OList is Why_Node_List;

   subtype W_Type_Real_Opaque_Id is Why_Node_Id;

   subtype W_Type_Real_Opaque_List is Why_Node_List;

   subtype W_Type_Unit_Opaque_OId is Why_Node_Id;

   subtype W_Type_Unit_Opaque_OList is Why_Node_List;

   subtype W_Type_Unit_Opaque_Id is Why_Node_Id;

   subtype W_Type_Unit_Opaque_List is Why_Node_List;

   subtype W_Abstract_Type_Opaque_OId is Why_Node_Id;

   subtype W_Abstract_Type_Opaque_OList is Why_Node_List;

   subtype W_Abstract_Type_Opaque_Id is Why_Node_Id;

   subtype W_Abstract_Type_Opaque_List is Why_Node_List;

   subtype W_Generic_Formal_Type_Opaque_OId is Why_Node_Id;

   subtype W_Generic_Formal_Type_Opaque_OList is Why_Node_List;

   subtype W_Generic_Formal_Type_Opaque_Id is Why_Node_Id;

   subtype W_Generic_Formal_Type_Opaque_List is Why_Node_List;

   subtype W_Generic_Actual_Type_Chain_Opaque_OId is Why_Node_Id;

   subtype W_Generic_Actual_Type_Chain_Opaque_OList is Why_Node_List;

   subtype W_Generic_Actual_Type_Chain_Opaque_Id is Why_Node_Id;

   subtype W_Generic_Actual_Type_Chain_Opaque_List is Why_Node_List;

   subtype W_Array_Type_Opaque_OId is Why_Node_Id;

   subtype W_Array_Type_Opaque_OList is Why_Node_List;

   subtype W_Array_Type_Opaque_Id is Why_Node_Id;

   subtype W_Array_Type_Opaque_List is Why_Node_List;

   subtype W_Ref_Type_Opaque_OId is Why_Node_Id;

   subtype W_Ref_Type_Opaque_OList is Why_Node_List;

   subtype W_Ref_Type_Opaque_Id is Why_Node_Id;

   subtype W_Ref_Type_Opaque_List is Why_Node_List;

   subtype W_Computation_Type_Opaque_OId is Why_Node_Id;

   subtype W_Computation_Type_Opaque_OList is Why_Node_List;

   subtype W_Computation_Type_Opaque_Id is Why_Node_Id;

   subtype W_Computation_Type_Opaque_List is Why_Node_List;

   subtype W_Integer_Constant_Opaque_OId is Why_Node_Id;

   subtype W_Integer_Constant_Opaque_OList is Why_Node_List;

   subtype W_Integer_Constant_Opaque_Id is Why_Node_Id;

   subtype W_Integer_Constant_Opaque_List is Why_Node_List;

   subtype W_Real_Constant_Opaque_OId is Why_Node_Id;

   subtype W_Real_Constant_Opaque_OList is Why_Node_List;

   subtype W_Real_Constant_Opaque_Id is Why_Node_Id;

   subtype W_Real_Constant_Opaque_List is Why_Node_List;

   subtype W_True_Literal_Opaque_OId is Why_Node_Id;

   subtype W_True_Literal_Opaque_OList is Why_Node_List;

   subtype W_True_Literal_Opaque_Id is Why_Node_Id;

   subtype W_True_Literal_Opaque_List is Why_Node_List;

   subtype W_False_Literal_Opaque_OId is Why_Node_Id;

   subtype W_False_Literal_Opaque_OList is Why_Node_List;

   subtype W_False_Literal_Opaque_Id is Why_Node_Id;

   subtype W_False_Literal_Opaque_List is Why_Node_List;

   subtype W_Void_Literal_Opaque_OId is Why_Node_Id;

   subtype W_Void_Literal_Opaque_OList is Why_Node_List;

   subtype W_Void_Literal_Opaque_Id is Why_Node_Id;

   subtype W_Void_Literal_Opaque_List is Why_Node_List;

   subtype W_Arith_Operation_Opaque_OId is Why_Node_Id;

   subtype W_Arith_Operation_Opaque_OList is Why_Node_List;

   subtype W_Arith_Operation_Opaque_Id is Why_Node_Id;

   subtype W_Arith_Operation_Opaque_List is Why_Node_List;

   subtype W_Negative_Term_Opaque_OId is Why_Node_Id;

   subtype W_Negative_Term_Opaque_OList is Why_Node_List;

   subtype W_Negative_Term_Opaque_Id is Why_Node_Id;

   subtype W_Negative_Term_Opaque_List is Why_Node_List;

   subtype W_Term_Identifier_Opaque_OId is Why_Node_Id;

   subtype W_Term_Identifier_Opaque_OList is Why_Node_List;

   subtype W_Term_Identifier_Opaque_Id is Why_Node_Id;

   subtype W_Term_Identifier_Opaque_List is Why_Node_List;

   subtype W_Operation_Opaque_OId is Why_Node_Id;

   subtype W_Operation_Opaque_OList is Why_Node_List;

   subtype W_Operation_Opaque_Id is Why_Node_Id;

   subtype W_Operation_Opaque_List is Why_Node_List;

   subtype W_Named_Term_Opaque_OId is Why_Node_Id;

   subtype W_Named_Term_Opaque_OList is Why_Node_List;

   subtype W_Named_Term_Opaque_Id is Why_Node_Id;

   subtype W_Named_Term_Opaque_List is Why_Node_List;

   subtype W_Conditional_Term_Opaque_OId is Why_Node_Id;

   subtype W_Conditional_Term_Opaque_OList is Why_Node_List;

   subtype W_Conditional_Term_Opaque_Id is Why_Node_Id;

   subtype W_Conditional_Term_Opaque_List is Why_Node_List;

   subtype W_Matching_Term_Opaque_OId is Why_Node_Id;

   subtype W_Matching_Term_Opaque_OList is Why_Node_List;

   subtype W_Matching_Term_Opaque_Id is Why_Node_Id;

   subtype W_Matching_Term_Opaque_List is Why_Node_List;

   subtype W_Binding_Term_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Term_Opaque_OList is Why_Node_List;

   subtype W_Binding_Term_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Term_Opaque_List is Why_Node_List;

   subtype W_Protected_Term_Opaque_OId is Why_Node_Id;

   subtype W_Protected_Term_Opaque_OList is Why_Node_List;

   subtype W_Protected_Term_Opaque_Id is Why_Node_Id;

   subtype W_Protected_Term_Opaque_List is Why_Node_List;

   subtype W_Op_Add_Opaque_OId is Why_Node_Id;

   subtype W_Op_Add_Opaque_OList is Why_Node_List;

   subtype W_Op_Add_Opaque_Id is Why_Node_Id;

   subtype W_Op_Add_Opaque_List is Why_Node_List;

   subtype W_Op_Substract_Opaque_OId is Why_Node_Id;

   subtype W_Op_Substract_Opaque_OList is Why_Node_List;

   subtype W_Op_Substract_Opaque_Id is Why_Node_Id;

   subtype W_Op_Substract_Opaque_List is Why_Node_List;

   subtype W_Op_Multiply_Opaque_OId is Why_Node_Id;

   subtype W_Op_Multiply_Opaque_OList is Why_Node_List;

   subtype W_Op_Multiply_Opaque_Id is Why_Node_Id;

   subtype W_Op_Multiply_Opaque_List is Why_Node_List;

   subtype W_Op_Divide_Opaque_OId is Why_Node_Id;

   subtype W_Op_Divide_Opaque_OList is Why_Node_List;

   subtype W_Op_Divide_Opaque_Id is Why_Node_Id;

   subtype W_Op_Divide_Opaque_List is Why_Node_List;

   subtype W_Op_Modulo_Opaque_OId is Why_Node_Id;

   subtype W_Op_Modulo_Opaque_OList is Why_Node_List;

   subtype W_Op_Modulo_Opaque_Id is Why_Node_Id;

   subtype W_Op_Modulo_Opaque_List is Why_Node_List;

   subtype W_True_Literal_Pred_Opaque_OId is Why_Node_Id;

   subtype W_True_Literal_Pred_Opaque_OList is Why_Node_List;

   subtype W_True_Literal_Pred_Opaque_Id is Why_Node_Id;

   subtype W_True_Literal_Pred_Opaque_List is Why_Node_List;

   subtype W_False_Literal_Pred_Opaque_OId is Why_Node_Id;

   subtype W_False_Literal_Pred_Opaque_OList is Why_Node_List;

   subtype W_False_Literal_Pred_Opaque_Id is Why_Node_Id;

   subtype W_False_Literal_Pred_Opaque_List is Why_Node_List;

   subtype W_Predicate_Identifier_Opaque_OId is Why_Node_Id;

   subtype W_Predicate_Identifier_Opaque_OList is Why_Node_List;

   subtype W_Predicate_Identifier_Opaque_Id is Why_Node_Id;

   subtype W_Predicate_Identifier_Opaque_List is Why_Node_List;

   subtype W_Predicate_Instance_Opaque_OId is Why_Node_Id;

   subtype W_Predicate_Instance_Opaque_OList is Why_Node_List;

   subtype W_Predicate_Instance_Opaque_Id is Why_Node_Id;

   subtype W_Predicate_Instance_Opaque_List is Why_Node_List;

   subtype W_Related_Terms_Opaque_OId is Why_Node_Id;

   subtype W_Related_Terms_Opaque_OList is Why_Node_List;

   subtype W_Related_Terms_Opaque_Id is Why_Node_Id;

   subtype W_Related_Terms_Opaque_List is Why_Node_List;

   subtype W_Implication_Opaque_OId is Why_Node_Id;

   subtype W_Implication_Opaque_OList is Why_Node_List;

   subtype W_Implication_Opaque_Id is Why_Node_Id;

   subtype W_Implication_Opaque_List is Why_Node_List;

   subtype W_Equivalence_Opaque_OId is Why_Node_Id;

   subtype W_Equivalence_Opaque_OList is Why_Node_List;

   subtype W_Equivalence_Opaque_Id is Why_Node_Id;

   subtype W_Equivalence_Opaque_List is Why_Node_List;

   subtype W_Disjunction_Opaque_OId is Why_Node_Id;

   subtype W_Disjunction_Opaque_OList is Why_Node_List;

   subtype W_Disjunction_Opaque_Id is Why_Node_Id;

   subtype W_Disjunction_Opaque_List is Why_Node_List;

   subtype W_Conjunction_Opaque_OId is Why_Node_Id;

   subtype W_Conjunction_Opaque_OList is Why_Node_List;

   subtype W_Conjunction_Opaque_Id is Why_Node_Id;

   subtype W_Conjunction_Opaque_List is Why_Node_List;

   subtype W_Negation_Opaque_OId is Why_Node_Id;

   subtype W_Negation_Opaque_OList is Why_Node_List;

   subtype W_Negation_Opaque_Id is Why_Node_Id;

   subtype W_Negation_Opaque_List is Why_Node_List;

   subtype W_Conditional_Pred_Opaque_OId is Why_Node_Id;

   subtype W_Conditional_Pred_Opaque_OList is Why_Node_List;

   subtype W_Conditional_Pred_Opaque_Id is Why_Node_Id;

   subtype W_Conditional_Pred_Opaque_List is Why_Node_List;

   subtype W_Binding_Pred_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Pred_Opaque_OList is Why_Node_List;

   subtype W_Binding_Pred_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Pred_Opaque_List is Why_Node_List;

   subtype W_Universal_Quantif_Opaque_OId is Why_Node_Id;

   subtype W_Universal_Quantif_Opaque_OList is Why_Node_List;

   subtype W_Universal_Quantif_Opaque_Id is Why_Node_Id;

   subtype W_Universal_Quantif_Opaque_List is Why_Node_List;

   subtype W_Existential_Quantif_Opaque_OId is Why_Node_Id;

   subtype W_Existential_Quantif_Opaque_OList is Why_Node_List;

   subtype W_Existential_Quantif_Opaque_Id is Why_Node_Id;

   subtype W_Existential_Quantif_Opaque_List is Why_Node_List;

   subtype W_Named_Predicate_Opaque_OId is Why_Node_Id;

   subtype W_Named_Predicate_Opaque_OList is Why_Node_List;

   subtype W_Named_Predicate_Opaque_Id is Why_Node_Id;

   subtype W_Named_Predicate_Opaque_List is Why_Node_List;

   subtype W_Protected_Predicate_Opaque_OId is Why_Node_Id;

   subtype W_Protected_Predicate_Opaque_OList is Why_Node_List;

   subtype W_Protected_Predicate_Opaque_Id is Why_Node_Id;

   subtype W_Protected_Predicate_Opaque_List is Why_Node_List;

   subtype W_Pattern_Opaque_OId is Why_Node_Id;

   subtype W_Pattern_Opaque_OList is Why_Node_List;

   subtype W_Pattern_Opaque_Id is Why_Node_Id;

   subtype W_Pattern_Opaque_List is Why_Node_List;

   subtype W_Match_Case_Opaque_OId is Why_Node_Id;

   subtype W_Match_Case_Opaque_OList is Why_Node_List;

   subtype W_Match_Case_Opaque_Id is Why_Node_Id;

   subtype W_Match_Case_Opaque_List is Why_Node_List;

   subtype W_Triggers_Opaque_OId is Why_Node_Id;

   subtype W_Triggers_Opaque_OList is Why_Node_List;

   subtype W_Triggers_Opaque_Id is Why_Node_Id;

   subtype W_Triggers_Opaque_List is Why_Node_List;

   subtype W_Trigger_Opaque_OId is Why_Node_Id;

   subtype W_Trigger_Opaque_OList is Why_Node_List;

   subtype W_Trigger_Opaque_Id is Why_Node_Id;

   subtype W_Trigger_Opaque_List is Why_Node_List;

   subtype W_Rel_Eq_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Eq_Opaque_OList is Why_Node_List;

   subtype W_Rel_Eq_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Eq_Opaque_List is Why_Node_List;

   subtype W_Rel_Ne_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Ne_Opaque_OList is Why_Node_List;

   subtype W_Rel_Ne_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Ne_Opaque_List is Why_Node_List;

   subtype W_Rel_Lt_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Lt_Opaque_OList is Why_Node_List;

   subtype W_Rel_Lt_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Lt_Opaque_List is Why_Node_List;

   subtype W_Rel_Le_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Le_Opaque_OList is Why_Node_List;

   subtype W_Rel_Le_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Le_Opaque_List is Why_Node_List;

   subtype W_Rel_Gt_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Gt_Opaque_OList is Why_Node_List;

   subtype W_Rel_Gt_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Gt_Opaque_List is Why_Node_List;

   subtype W_Rel_Ge_Opaque_OId is Why_Node_Id;

   subtype W_Rel_Ge_Opaque_OList is Why_Node_List;

   subtype W_Rel_Ge_Opaque_Id is Why_Node_Id;

   subtype W_Rel_Ge_Opaque_List is Why_Node_List;

   subtype W_Type_Opaque_OId is Why_Node_Id;

   subtype W_Type_Opaque_OList is Why_Node_List;

   subtype W_Type_Opaque_Id is Why_Node_Id;

   subtype W_Type_Opaque_List is Why_Node_List;

   subtype W_Logic_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Opaque_OList is Why_Node_List;

   subtype W_Logic_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Opaque_List is Why_Node_List;

   subtype W_Function_Opaque_OId is Why_Node_Id;

   subtype W_Function_Opaque_OList is Why_Node_List;

   subtype W_Function_Opaque_Id is Why_Node_Id;

   subtype W_Function_Opaque_List is Why_Node_List;

   subtype W_Predicate_Definition_Opaque_OId is Why_Node_Id;

   subtype W_Predicate_Definition_Opaque_OList is Why_Node_List;

   subtype W_Predicate_Definition_Opaque_Id is Why_Node_Id;

   subtype W_Predicate_Definition_Opaque_List is Why_Node_List;

   subtype W_Inductive_Opaque_OId is Why_Node_Id;

   subtype W_Inductive_Opaque_OList is Why_Node_List;

   subtype W_Inductive_Opaque_Id is Why_Node_Id;

   subtype W_Inductive_Opaque_List is Why_Node_List;

   subtype W_Axiom_Opaque_OId is Why_Node_Id;

   subtype W_Axiom_Opaque_OList is Why_Node_List;

   subtype W_Axiom_Opaque_Id is Why_Node_Id;

   subtype W_Axiom_Opaque_List is Why_Node_List;

   subtype W_Goal_Opaque_OId is Why_Node_Id;

   subtype W_Goal_Opaque_OList is Why_Node_List;

   subtype W_Goal_Opaque_Id is Why_Node_Id;

   subtype W_Goal_Opaque_List is Why_Node_List;

   subtype W_External_Opaque_OId is Why_Node_Id;

   subtype W_External_Opaque_OList is Why_Node_List;

   subtype W_External_Opaque_Id is Why_Node_Id;

   subtype W_External_Opaque_List is Why_Node_List;

   subtype W_Logic_Type_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Type_Opaque_OList is Why_Node_List;

   subtype W_Logic_Type_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Type_Opaque_List is Why_Node_List;

   subtype W_Logic_Binder_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Binder_Opaque_OList is Why_Node_List;

   subtype W_Logic_Binder_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Binder_Opaque_List is Why_Node_List;

   subtype W_Inductive_Case_Opaque_OId is Why_Node_Id;

   subtype W_Inductive_Case_Opaque_OList is Why_Node_List;

   subtype W_Inductive_Case_Opaque_Id is Why_Node_Id;

   subtype W_Inductive_Case_Opaque_List is Why_Node_List;

   subtype W_Transparent_Type_Definition_Opaque_OId is Why_Node_Id;

   subtype W_Transparent_Type_Definition_Opaque_OList is Why_Node_List;

   subtype W_Transparent_Type_Definition_Opaque_Id is Why_Node_Id;

   subtype W_Transparent_Type_Definition_Opaque_List is Why_Node_List;

   subtype W_Adt_Definition_Opaque_OId is Why_Node_Id;

   subtype W_Adt_Definition_Opaque_OList is Why_Node_List;

   subtype W_Adt_Definition_Opaque_Id is Why_Node_Id;

   subtype W_Adt_Definition_Opaque_List is Why_Node_List;

   subtype W_Constr_Decl_Opaque_OId is Why_Node_Id;

   subtype W_Constr_Decl_Opaque_OList is Why_Node_List;

   subtype W_Constr_Decl_Opaque_Id is Why_Node_Id;

   subtype W_Constr_Decl_Opaque_List is Why_Node_List;

   subtype W_Effects_Opaque_OId is Why_Node_Id;

   subtype W_Effects_Opaque_OList is Why_Node_List;

   subtype W_Effects_Opaque_Id is Why_Node_Id;

   subtype W_Effects_Opaque_List is Why_Node_List;

   subtype W_Precondition_Opaque_OId is Why_Node_Id;

   subtype W_Precondition_Opaque_OList is Why_Node_List;

   subtype W_Precondition_Opaque_Id is Why_Node_Id;

   subtype W_Precondition_Opaque_List is Why_Node_List;

   subtype W_Postcondition_Opaque_OId is Why_Node_Id;

   subtype W_Postcondition_Opaque_OList is Why_Node_List;

   subtype W_Postcondition_Opaque_Id is Why_Node_Id;

   subtype W_Postcondition_Opaque_List is Why_Node_List;

   subtype W_Exn_Condition_Opaque_OId is Why_Node_Id;

   subtype W_Exn_Condition_Opaque_OList is Why_Node_List;

   subtype W_Exn_Condition_Opaque_Id is Why_Node_Id;

   subtype W_Exn_Condition_Opaque_List is Why_Node_List;

   subtype W_Prog_Constant_Opaque_OId is Why_Node_Id;

   subtype W_Prog_Constant_Opaque_OList is Why_Node_List;

   subtype W_Prog_Constant_Opaque_Id is Why_Node_Id;

   subtype W_Prog_Constant_Opaque_List is Why_Node_List;

   subtype W_Prog_Identifier_Opaque_OId is Why_Node_Id;

   subtype W_Prog_Identifier_Opaque_OList is Why_Node_List;

   subtype W_Prog_Identifier_Opaque_Id is Why_Node_Id;

   subtype W_Prog_Identifier_Opaque_List is Why_Node_List;

   subtype W_Any_Expr_Opaque_OId is Why_Node_Id;

   subtype W_Any_Expr_Opaque_OList is Why_Node_List;

   subtype W_Any_Expr_Opaque_Id is Why_Node_Id;

   subtype W_Any_Expr_Opaque_List is Why_Node_List;

   subtype W_Deref_Opaque_OId is Why_Node_Id;

   subtype W_Deref_Opaque_OList is Why_Node_List;

   subtype W_Deref_Opaque_Id is Why_Node_Id;

   subtype W_Deref_Opaque_List is Why_Node_List;

   subtype W_Assignment_Opaque_OId is Why_Node_Id;

   subtype W_Assignment_Opaque_OList is Why_Node_List;

   subtype W_Assignment_Opaque_Id is Why_Node_Id;

   subtype W_Assignment_Opaque_List is Why_Node_List;

   subtype W_Array_Access_Opaque_OId is Why_Node_Id;

   subtype W_Array_Access_Opaque_OList is Why_Node_List;

   subtype W_Array_Access_Opaque_Id is Why_Node_Id;

   subtype W_Array_Access_Opaque_List is Why_Node_List;

   subtype W_Array_Update_Opaque_OId is Why_Node_Id;

   subtype W_Array_Update_Opaque_OList is Why_Node_List;

   subtype W_Array_Update_Opaque_Id is Why_Node_Id;

   subtype W_Array_Update_Opaque_List is Why_Node_List;

   subtype W_Infix_Call_Opaque_OId is Why_Node_Id;

   subtype W_Infix_Call_Opaque_OList is Why_Node_List;

   subtype W_Infix_Call_Opaque_Id is Why_Node_Id;

   subtype W_Infix_Call_Opaque_List is Why_Node_List;

   subtype W_Prefix_Call_Opaque_OId is Why_Node_Id;

   subtype W_Prefix_Call_Opaque_OList is Why_Node_List;

   subtype W_Prefix_Call_Opaque_Id is Why_Node_Id;

   subtype W_Prefix_Call_Opaque_List is Why_Node_List;

   subtype W_Binding_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Prog_Opaque_OList is Why_Node_List;

   subtype W_Binding_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Prog_Opaque_List is Why_Node_List;

   subtype W_Binding_Ref_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Ref_Opaque_OList is Why_Node_List;

   subtype W_Binding_Ref_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Ref_Opaque_List is Why_Node_List;

   subtype W_Conditional_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Conditional_Prog_Opaque_OList is Why_Node_List;

   subtype W_Conditional_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Conditional_Prog_Opaque_List is Why_Node_List;

   subtype W_While_Loop_Opaque_OId is Why_Node_Id;

   subtype W_While_Loop_Opaque_OList is Why_Node_List;

   subtype W_While_Loop_Opaque_Id is Why_Node_Id;

   subtype W_While_Loop_Opaque_List is Why_Node_List;

   subtype W_Statement_Sequence_Opaque_OId is Why_Node_Id;

   subtype W_Statement_Sequence_Opaque_OList is Why_Node_List;

   subtype W_Statement_Sequence_Opaque_Id is Why_Node_Id;

   subtype W_Statement_Sequence_Opaque_List is Why_Node_List;

   subtype W_Label_Opaque_OId is Why_Node_Id;

   subtype W_Label_Opaque_OList is Why_Node_List;

   subtype W_Label_Opaque_Id is Why_Node_Id;

   subtype W_Label_Opaque_List is Why_Node_List;

   subtype W_Assert_Opaque_OId is Why_Node_Id;

   subtype W_Assert_Opaque_OList is Why_Node_List;

   subtype W_Assert_Opaque_Id is Why_Node_Id;

   subtype W_Assert_Opaque_List is Why_Node_List;

   subtype W_Post_Assertion_Opaque_OId is Why_Node_Id;

   subtype W_Post_Assertion_Opaque_OList is Why_Node_List;

   subtype W_Post_Assertion_Opaque_Id is Why_Node_Id;

   subtype W_Post_Assertion_Opaque_List is Why_Node_List;

   subtype W_Opaque_Assertion_Opaque_OId is Why_Node_Id;

   subtype W_Opaque_Assertion_Opaque_OList is Why_Node_List;

   subtype W_Opaque_Assertion_Opaque_Id is Why_Node_Id;

   subtype W_Opaque_Assertion_Opaque_List is Why_Node_List;

   subtype W_Fun_Def_Opaque_OId is Why_Node_Id;

   subtype W_Fun_Def_Opaque_OList is Why_Node_List;

   subtype W_Fun_Def_Opaque_Id is Why_Node_Id;

   subtype W_Fun_Def_Opaque_List is Why_Node_List;

   subtype W_Binding_Fun_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Fun_Opaque_OList is Why_Node_List;

   subtype W_Binding_Fun_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Fun_Opaque_List is Why_Node_List;

   subtype W_Binding_Rec_Opaque_OId is Why_Node_Id;

   subtype W_Binding_Rec_Opaque_OList is Why_Node_List;

   subtype W_Binding_Rec_Opaque_Id is Why_Node_Id;

   subtype W_Binding_Rec_Opaque_List is Why_Node_List;

   subtype W_Prog_Call_Opaque_OId is Why_Node_Id;

   subtype W_Prog_Call_Opaque_OList is Why_Node_List;

   subtype W_Prog_Call_Opaque_Id is Why_Node_Id;

   subtype W_Prog_Call_Opaque_List is Why_Node_List;

   subtype W_Raise_Statement_Opaque_OId is Why_Node_Id;

   subtype W_Raise_Statement_Opaque_OList is Why_Node_List;

   subtype W_Raise_Statement_Opaque_Id is Why_Node_Id;

   subtype W_Raise_Statement_Opaque_List is Why_Node_List;

   subtype W_Raise_Statement_With_Parameters_Opaque_OId is Why_Node_Id;

   subtype W_Raise_Statement_With_Parameters_Opaque_OList is Why_Node_List;

   subtype W_Raise_Statement_With_Parameters_Opaque_Id is Why_Node_Id;

   subtype W_Raise_Statement_With_Parameters_Opaque_List is Why_Node_List;

   subtype W_Try_Block_Opaque_OId is Why_Node_Id;

   subtype W_Try_Block_Opaque_OList is Why_Node_List;

   subtype W_Try_Block_Opaque_Id is Why_Node_Id;

   subtype W_Try_Block_Opaque_List is Why_Node_List;

   subtype W_Unreachable_Code_Opaque_OId is Why_Node_Id;

   subtype W_Unreachable_Code_Opaque_OList is Why_Node_List;

   subtype W_Unreachable_Code_Opaque_Id is Why_Node_Id;

   subtype W_Unreachable_Code_Opaque_List is Why_Node_List;

   subtype W_Begin_Block_Opaque_OId is Why_Node_Id;

   subtype W_Begin_Block_Opaque_OList is Why_Node_List;

   subtype W_Begin_Block_Opaque_Id is Why_Node_Id;

   subtype W_Begin_Block_Opaque_List is Why_Node_List;

   subtype W_Protected_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Protected_Prog_Opaque_OList is Why_Node_List;

   subtype W_Protected_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Protected_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Add_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Add_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Add_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Add_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Substract_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Substract_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Substract_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Substract_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Multiply_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Multiply_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Multiply_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Multiply_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Divide_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Divide_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Divide_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Divide_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Mod_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Mod_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Mod_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Mod_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Eq_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Eq_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Eq_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Eq_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Ne_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Ne_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Ne_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Ne_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Lt_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Lt_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Lt_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Lt_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Le_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Le_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Le_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Le_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Gt_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Gt_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Gt_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Gt_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Ge_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Ge_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Ge_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Ge_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Or_Else_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Or_Else_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Or_Else_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Or_Else_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_And_Then_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_And_Then_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_And_Then_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_And_Then_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Minus_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Minus_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Minus_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Minus_Prog_Opaque_List is Why_Node_List;

   subtype W_Op_Not_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Op_Not_Prog_Opaque_OList is Why_Node_List;

   subtype W_Op_Not_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Op_Not_Prog_Opaque_List is Why_Node_List;

   subtype W_Binder_Opaque_OId is Why_Node_Id;

   subtype W_Binder_Opaque_OList is Why_Node_List;

   subtype W_Binder_Opaque_Id is Why_Node_Id;

   subtype W_Binder_Opaque_List is Why_Node_List;

   subtype W_Recfun_Opaque_OId is Why_Node_Id;

   subtype W_Recfun_Opaque_OList is Why_Node_List;

   subtype W_Recfun_Opaque_Id is Why_Node_Id;

   subtype W_Recfun_Opaque_List is Why_Node_List;

   subtype W_Loop_Annot_Opaque_OId is Why_Node_Id;

   subtype W_Loop_Annot_Opaque_OList is Why_Node_List;

   subtype W_Loop_Annot_Opaque_Id is Why_Node_Id;

   subtype W_Loop_Annot_Opaque_List is Why_Node_List;

   subtype W_Wf_Arg_Opaque_OId is Why_Node_Id;

   subtype W_Wf_Arg_Opaque_OList is Why_Node_List;

   subtype W_Wf_Arg_Opaque_Id is Why_Node_Id;

   subtype W_Wf_Arg_Opaque_List is Why_Node_List;

   subtype W_Handler_Opaque_OId is Why_Node_Id;

   subtype W_Handler_Opaque_OList is Why_Node_List;

   subtype W_Handler_Opaque_Id is Why_Node_Id;

   subtype W_Handler_Opaque_List is Why_Node_List;

   subtype W_File_Opaque_OId is Why_Node_Id;

   subtype W_File_Opaque_OList is Why_Node_List;

   subtype W_File_Opaque_Id is Why_Node_Id;

   subtype W_File_Opaque_List is Why_Node_List;

   subtype W_Global_Binding_Opaque_OId is Why_Node_Id;

   subtype W_Global_Binding_Opaque_OList is Why_Node_List;

   subtype W_Global_Binding_Opaque_Id is Why_Node_Id;

   subtype W_Global_Binding_Opaque_List is Why_Node_List;

   subtype W_Global_Rec_Binding_Opaque_OId is Why_Node_Id;

   subtype W_Global_Rec_Binding_Opaque_OList is Why_Node_List;

   subtype W_Global_Rec_Binding_Opaque_Id is Why_Node_Id;

   subtype W_Global_Rec_Binding_Opaque_List is Why_Node_List;

   subtype W_Parameter_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Parameter_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Parameter_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Parameter_Declaration_Opaque_List is Why_Node_List;

   subtype W_Global_Ref_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Global_Ref_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Global_Ref_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Global_Ref_Declaration_Opaque_List is Why_Node_List;

   subtype W_Exception_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Exception_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Exception_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Exception_Declaration_Opaque_List is Why_Node_List;

   subtype W_Logic_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Logic_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Declaration_Opaque_List is Why_Node_List;

   subtype W_Include_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Include_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Include_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Include_Declaration_Opaque_List is Why_Node_List;

   subtype W_Term_Opaque_OId is Why_Node_Id;

   subtype W_Term_Opaque_OList is Why_Node_List;

   subtype W_Term_Opaque_Id is Why_Node_Id;

   subtype W_Term_Opaque_List is Why_Node_List;

   subtype W_Constant_Opaque_OId is Why_Node_Id;

   subtype W_Constant_Opaque_OList is Why_Node_List;

   subtype W_Constant_Opaque_Id is Why_Node_Id;

   subtype W_Constant_Opaque_List is Why_Node_List;

   subtype W_Arith_Op_Opaque_OId is Why_Node_Id;

   subtype W_Arith_Op_Opaque_OList is Why_Node_List;

   subtype W_Arith_Op_Opaque_Id is Why_Node_Id;

   subtype W_Arith_Op_Opaque_List is Why_Node_List;

   subtype W_Predicate_Opaque_OId is Why_Node_Id;

   subtype W_Predicate_Opaque_OList is Why_Node_List;

   subtype W_Predicate_Opaque_Id is Why_Node_Id;

   subtype W_Predicate_Opaque_List is Why_Node_List;

   subtype W_Primitive_Type_Opaque_OId is Why_Node_Id;

   subtype W_Primitive_Type_Opaque_OList is Why_Node_List;

   subtype W_Primitive_Type_Opaque_Id is Why_Node_Id;

   subtype W_Primitive_Type_Opaque_List is Why_Node_List;

   subtype W_Relation_Opaque_OId is Why_Node_Id;

   subtype W_Relation_Opaque_OList is Why_Node_List;

   subtype W_Relation_Opaque_Id is Why_Node_Id;

   subtype W_Relation_Opaque_List is Why_Node_List;

   subtype W_Logic_Declaration_Class_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Declaration_Class_Opaque_OList is Why_Node_List;

   subtype W_Logic_Declaration_Class_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Declaration_Class_Opaque_List is Why_Node_List;

   subtype W_Logic_Return_Type_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Return_Type_Opaque_OList is Why_Node_List;

   subtype W_Logic_Return_Type_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Return_Type_Opaque_List is Why_Node_List;

   subtype W_Logic_Arg_Type_Opaque_OId is Why_Node_Id;

   subtype W_Logic_Arg_Type_Opaque_OList is Why_Node_List;

   subtype W_Logic_Arg_Type_Opaque_Id is Why_Node_Id;

   subtype W_Logic_Arg_Type_Opaque_List is Why_Node_List;

   subtype W_Simple_Value_Type_Opaque_OId is Why_Node_Id;

   subtype W_Simple_Value_Type_Opaque_OList is Why_Node_List;

   subtype W_Simple_Value_Type_Opaque_Id is Why_Node_Id;

   subtype W_Simple_Value_Type_Opaque_List is Why_Node_List;

   subtype W_Prog_Opaque_OId is Why_Node_Id;

   subtype W_Prog_Opaque_OList is Why_Node_List;

   subtype W_Prog_Opaque_Id is Why_Node_Id;

   subtype W_Prog_Opaque_List is Why_Node_List;

   subtype W_Infix_Opaque_OId is Why_Node_Id;

   subtype W_Infix_Opaque_OList is Why_Node_List;

   subtype W_Infix_Opaque_Id is Why_Node_Id;

   subtype W_Infix_Opaque_List is Why_Node_List;

   subtype W_Prefix_Opaque_OId is Why_Node_Id;

   subtype W_Prefix_Opaque_OList is Why_Node_List;

   subtype W_Prefix_Opaque_Id is Why_Node_Id;

   subtype W_Prefix_Opaque_List is Why_Node_List;

   subtype W_Declaration_Opaque_OId is Why_Node_Id;

   subtype W_Declaration_Opaque_OList is Why_Node_List;

   subtype W_Declaration_Opaque_Id is Why_Node_Id;

   subtype W_Declaration_Opaque_List is Why_Node_List;

   subtype W_Any_Node_Opaque_OId is Why_Node_Id;

   subtype W_Any_Node_Opaque_OList is Why_Node_List;

   subtype W_Any_Node_Opaque_Id is Why_Node_Id;

   subtype W_Any_Node_Opaque_List is Why_Node_List;

   subtype W_Type_Definition_Opaque_OId is Why_Node_Id;

   subtype W_Type_Definition_Opaque_OList is Why_Node_List;

   subtype W_Type_Definition_Opaque_Id is Why_Node_Id;

   subtype W_Type_Definition_Opaque_List is Why_Node_List;

end Why.Opaque_Ids;
