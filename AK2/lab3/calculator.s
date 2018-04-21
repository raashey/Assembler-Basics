SYSEXIT = 1
EXIT_SUCCESS = 0


.data

dodatnia:
	.float 12.25
zero:
	.float 0
ujemna:
	.float -2.5
ctrl_word:
	.short 0
masksp:
	.short 0xF0FF
maskdp:
	.short 0x200
maskrdti:
	.short 0x400
maskruti:
	.short 0x800
maskrtz:
	.short 0xC00
.text
.global _start

_start:

single_prec:

fstcw ctrl_word	#umieszczenie control word 
movw ctrl_word, %ax #wrzucenie control word do rejestru ax
and masksp, %ax	#wyzerowanie 8 i 9 bitu za pomoca maski

#skok do odpowiedniego zaokraglenia

#jmp double_prec
#jmp rtne
jmp rdtinf
#jmp rutinf
#jmp rtzero

double_prec:

addw maskdp, %ax #dodanie maski dp do rejestru ax, aby uzyskac 1 na 9 bicie

#jmp rtne
#jmp rdtinf
jmp rutinf
#jmp rtzero

rtne:

fldcw ctrl_word

jmp test

rdtinf:

addw maskrdti, %ax #dodanie maskrdti, aby uzyskac 1 na 10 bicie
movw %ax, ctrl_word #umieszczenie wartosci z rejestru ax w control wordzie
fldcw ctrl_word #załadowanie control warda

jmp test

rutinf:

addw maskruti, %ax #dodanie maskruti, aby uzyskac 1 na 11 bicie
movw %ax, ctrl_word
fldcw ctrl_word

jmp test

rtzero:

addw maskrtz, %ax #dodanie maskrtz aby uzyskac 1 na 10 i 11 bicie
movw %ax, ctrl_word
fldcw ctrl_word

test:

pInf:

fld dodatnia
fdiv zero

mInf:

fld ujemna
fdiv zero

pZero:

fld zero
fdiv dodatnia

mZero:

fld zero
fdiv dodatnia

NaN:
fld zero
fdiv zero

exit:

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80

