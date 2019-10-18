
    .globl matrix_prod
matrix_prod:    # void matrix_prod(void *A, void *B, void *C, int n);
	pushq   %rbp
	movq    %rsp, %rbp # prologue

    movl    $0,   -16(%rbp) # i
    movl    %ecx, -24(%rbp) # n
    movq    %rdi, -32(%rbp) # A
    movq    %rsi, -40(%rbp) # B
    movq    %rdx, -48(%rbp) # C

outerLoop:  # for i from 0 to n-1
    movl   -16(%rbp), %eax
    cmpl     %eax, -24(%rbp)
    je      endl
    movl    $0, -20(%rbp)   # j

innerLoop:  # for j from 0 to n-1  
    movl    -20(%rbp), %eax    
    cmpl     %eax, -24(%rbp)
    je      innerEndl
    
    # Putting saved values inside arg registers and calling dot_prod
    movq    -32(%rbp), %rdi # A
    movq    -40(%rbp), %rsi # B
    movl    -24(%rbp), %edx # n
    movl    -16(%rbp), %ecx # i
    movl    -20(%rbp), %r8d # j
    call    dot_prod

    # moving return value of dot_prod to rdi, 17 to rsi and calling mod
    movq    %rax, %rdi
    movl    $17, %esi
    call    mod

    movl    %eax, %edx # saving return value of mod func for later
    
    movl    -16(%rbp), %eax
    imull   -24(%rbp), %eax
    addl    -20(%rbp), %eax  # eax = value of the current index (i*n+j)
    
    addq    -48(%rbp), %rax # rax pointing to current index of C
    mov    %dl, (%rax)      # place the value inside C[i][j]

    add     $1, -20(%rbp)
    jmp     innerLoop

innerEndl:
     add     $1, -16(%rbp)
     jmp outerLoop

endl:
    pop %rbp
	ret
