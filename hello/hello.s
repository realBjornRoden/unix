.section __DATA,__data
str:
  .asciz "Hello World!\n"

.section __TEXT,__text
.globl _main
_main:
  movl $0x2000004, %eax
  movl $1, %edi
  leaq str(%rip), %rsi
  movq $100, %rdx
  syscall

  movl $0, %ebx
  movl $0x2000001, %eax           # exit 0
  syscall
