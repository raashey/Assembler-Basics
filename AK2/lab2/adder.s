SYSEXIT = 1
EXIT_SUCCESS = 0

.code32

.data
num1:
        .long 0x0, 0x0, 0xFFFFFFFF, 0xFFFFFFFF
num2:
        .long 0x0, 0x0, 0x0, 0x00000001

.text

.global _start

_start:


	movl $3, %esi #iterator po petli
	clc 	      #czyszczenie flagi

loop:

	movl num1(,%esi,4), %eax #czesc liczby 1 do rejestru eax
	movl num2(,%esi,4), %ebx #czesc liczby 2 do rejestru ebx
	adcl %edx, %eax		#dodanie przeniesienia
	adcl %ebx, %eax 	#dodawanie tych samych czesci liczb(z flaga)

	pushl %eax 	#wrzucenie wyniku na stos
	jc carry
	jnc nocarry
next:
	cmp $0, %esi	#porownanie wartosci iteratora z zerem
	je last		#skok do etykiety last jest rowne

	subl $1, %esi	#dekrementacja iteratora
	jmp loop	#skok do petli
carry:
	movl $1, %edx
	jmp next
nocarry:
	movl $0, %edx
	jmp next

last:

cmp $1, %edx
je overload		#skok do petli overload w razie flagi = 1
jmp exit		#skok do petli exit

overload:

pushl $1		#wrzucenie na stos dodatkowej 1 (przeladowanie)
clc			#czyszczenie flagi

exit:

movl $SYSEXIT, %eax	#zamykanie programu
movl $EXIT_SUCCESS, %ebx
int $0x80
