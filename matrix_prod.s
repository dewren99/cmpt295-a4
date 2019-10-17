
    .globl matrix_prod
matrix_prod:            # void matrix_prod(void *A, void *B, void *C, int n);
	pushq   %rbp
	movq    %rsp, %rbp # prologue
    movq    %rdi, -48(%rbp)  # A
    movq    %rsi, -16(%rbp) # B
    movq    %rdx, -24(%rbp) # C
    movl    %ecx, -32(%rbp) # n
    movl    $0,   -36(%rbp) # i

outerLoop:
    movl   -36(%rbp), %eax
    cmpl     %eax, -32(%rbp)
    je      endl
    movl    $0, -40(%rbp)   # j

innerLoop:
    movl    -40(%rbp), %eax    
    cmpl     %eax, -32(%rbp)
    je      innerEndl
    

    movq    -48(%rbp), %rdi  # A
    movq    -16(%rbp), %rsi # B
    movl    -32(%rbp), %edx # n
    movl    -36(%rbp), %ecx # i
    movl    -40(%rbp), %r8d # j
    call    dot_prod # rax = # long dot_prod(void *A, void *B, int n, int i, int j);
    movq    -48(%rbp), %rdi  # A 
    movq    %rax, -56(%rbp)
    movq    %rax, %rdi
    movl    $17, %esi
    call    mod

    movq    -48(%rbp), %rdi  # A

    movl    %eax, %edx # rdx = rax = mod()
    movl    -36(%rbp), %eax # eax = i
    imull   -32(%rbp), %eax # eax = i * n
    addl    -40(%rbp), %eax  # eax = i*n+j
    
    addq    -24(%rbp), %rax # rax = rax + rcx = C + i*n+j
    mov    %dl, (%rax) # C[i][j] = rdx

    movq    -48(%rbp), %rdi  # A

    add     $1, -40(%rbp)
    jmp     innerLoop

innerEndl:
     add     $1, -36(%rbp)
     jmp outerLoop

endl:
    pop %rbp
	ret
