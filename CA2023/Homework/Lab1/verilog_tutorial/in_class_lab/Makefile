alu_src = $(wildcard *alu.v)
acc_src = $(wildcard *accumulator.v)
accumulator: $(acc_src)
	iverilog -o $@ $(acc_src)

baby_alu: $(alu_src)
	iverilog -o $@ $(alu_src)

clear:
	rm -f accumulator baby_alu *.vcd