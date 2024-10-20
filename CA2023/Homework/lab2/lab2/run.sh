cp testcases/instruction_$1.txt instruction.txt
iverilog -o cpu code/src/*.v code/supplied/*.v
vvp cpu
diff output.txt testcases/output_$1.txt
echo "0 for correct, 1 for wrong: $?"
