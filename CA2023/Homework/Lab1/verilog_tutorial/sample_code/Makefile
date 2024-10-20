src = $(filter-out sample_test.v multiplexer.v register_4bit.v, $(wildcard *.v))

all: test

test: $(src)
	iverilog -o test $(src)

vvp: test
	vvp test

gtk: vvp
	gtkwave test.vcd&

clear:
	rm -rf test *.vcd
