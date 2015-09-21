from test_support import *

print "At level 0"
print "----------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--level=0"])

print ""
print "Equivalent switches"
print "-------------------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--prover=cvc4", "--steps=100", "--timeout=1"])

print ""
print "At level 1"
print "----------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--level=1"])

print ""
print "Equivalent switches"
print "-------------------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--prover=cvc4,z3,altergo", "--steps=100", "--timeout=1"])

print ""
print "At level 2"
print "----------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--level=2"])

print ""
print "Equivalent switches"
print "-------------------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--prover=cvc4,z3,altergo", "--steps=1000", "--timeout=10"])

print ""
print "At level 3"
print "----------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--level=3"])

print ""
print "Equivalent switches"
print "-------------------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--prover=cvc4,z3,altergo", "--steps=1000", "--timeout=10", "--proof=progressive"])

print ""
print "At level 4"
print "----------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--level=4"])

print ""
print "Equivalent switches"
print "-------------------"
gnatprove(opt=["-P", "test.gpr", "-q", "-j8", "--report=all", "--prover=cvc4,z3,altergo", "--steps=10000", "--timeout=60", "--proof=progressive"])
