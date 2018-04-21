all: adder subtract

adder: adder.o
	ld -o adder adder.o
adder.o: adder.s
	as --gstabs -o adder.o adder.s

subtract: subtract.o
	ld -o subtract subtract.o
subtract.o: subtract.s
	as --gstabs -o subtract.o subtract.s	
