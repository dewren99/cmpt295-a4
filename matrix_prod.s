
    .globl matrix_prod
matrix_prod:            # void matrix_prod(void *A, void *B, void *C, int n);
	pushq   %rbp
	movq    %rsp, %rbp # prologue
    movq    %rdi, -8(%rbp)
    movq    %rsi, -16(%rbp)
    movq    %rdx, -24(%rbp)
    movq    %rcx, -32(%rbp)
    movq    $0,   %r8

outerLoop:
    cmp     %r8, -32(%rbp)
    je      endl
    movq    $0, %r9

innerLoop:
    cmp     %r9, -32(%rbp)
    je      innerEndl
    inc     %r9

    

    jmp     innerLoop


innerEndl:
     inc    %r8
     jmp outerLoop

endl:
	ret
