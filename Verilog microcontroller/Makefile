COMPILER =iverilog
MODULES = acc_unit.v ALU_unit.v and_unit.v comparator_unit.v control_unit.v flags_unit.v MK.v MUX_unit.v not_unit.v or_unit.v PC_unit.v RAM_unit.v ROM_unit.v sum_unit.v test.v trigger.v xor_unit.v
EXEC = sim
VCD = out.vcd

all:
	$(COMPILER) -o $(EXEC) $(MODULES)
	vvp $(EXEC)
	gtkwave $(VCD)
clean:
	rm $(EXEC) $(VCD)
