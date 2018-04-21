SYSEXIT = 1
EXIT_SUCCESS = 0

SYSWRITE = 4
STDOUT = 1
SYSREAD = 3
STDIN = 0

.data
buf: .ascii "      "
buf_len = . - buf

.text
msg: .ascii "Write text: "
msg_len = . - msg

msg3: .ascii "Lab 1"
msg3_len = . - msg3

msg4: .ascii "\nMessages are the same!\n"
msg4_len = . - msg4

msg5: .ascii "\nMessages are not the same!\n"
msg5_len = . - msg5

newline: .ascii "\n"
newline_len = . - newline

.global _start
_start:

movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $msg, %ecx
movl $msg_len, %edx
int $0x80

movl $SYSREAD, %eax
movl $STDIN, %ebx
movl $buf, %ecx
movl $buf_len, %edx
int $0x80

movl $-1, %esi #adres -1 do rejestru indeksujacego esi

_loop:

incl %esi #inkrementacja rejestru
cmp $buf_len, %esi #porownanie dlugosci 
je same #skok do etykiety same

movb buf(,%esi,1), %al #przeniesienie 1 bajtu z bufora do akumulatora

cmp msg3(,%esi,1), %al #porownanie bajtu bufora z bajtem tekstu
jne different #skok do etykiety different

jmp _loop #ponowny skok do petli

same:
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $msg4, %ecx
movl $msg4_len, %edx
int $0x80

jmp exit

different:
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $msg5, %ecx
movl $msg5_len, %edx
int $0x80

exit:
movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80

