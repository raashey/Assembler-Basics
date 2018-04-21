SYSEXIT = 1
EXIT_SUCCESS = 0

SYSWRITE = 4
STDOUT = 1

.text
msg: .ascii "Hello World! \n"
msg_len = . - msg

.global _start
_start:

movl $SYSWRITE, %eax #odczyt -> eax
movl $STDOUT, %ebx  #strumien wyjściowy -> ebx
movl $msg, %ecx	#adres msg -> ecx
movl $msg_len, %edx #dlugosc msg -> edx
int $0x80 #przerwanie syscall

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80

