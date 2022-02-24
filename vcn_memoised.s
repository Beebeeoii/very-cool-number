   .text
   .globl ent
vcn:
    /**
     * Save old register values onto stack
     * as they will be modified
     */
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15

    /**
     * Base cases
     */
    cmpq $0, %rdi
    je B0
    cmpq $1, %rdi
    je B1
    cmpq $2, %rdi
    je B2
    cmpq $3, %rdi
    je B3

    /**
     * Check if arr[n-1] == -1
     * If true, enter recursion to compute
     * value.
     */
    movq %rdi, %r15
    salq $3, %r15
    leaq -8(%rsi, %r15), %r12
    cmpq $-1, (%r12)
    je R1

R1R:
    /**
     * Check if arr[n-2] == -1
     * If true, enter recursion to compute
     * value.
     */
    leaq -16(%rsi, %r15), %r13
    cmpq $-1, (%r13)
    je R2

R2R:
    /**
     * Check if arr[n-3] == -1
     * If true, enter recursion to compute
     * value.
     */
    leaq -24(%rsi, %r15), %r14
    cmpq $-1, (%r14)
    je R3

R3R:
    /**
     * Check if arr[n-4] == -1
     * If true, enter recursion to compute
     * value.
     */
    leaq -32(%rsi, %r15), %r15
    cmpq $-1, (%r15)
    je R4

R4R:
    /**
     * Add up the 4 results from the
     * recursive calls
     */
    movq (%r12), %r12
    addq (%r13), %r12
    addq (%r14), %r12
    addq (%r15), %r12
    pushq %r12
res:
    /**
     * Stack teardown
     */
    popq %rax
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    ret

/**
 * Call vcn(n-1), vcn(n-2), vcn(n-3)
 * and vcn(n-4) and store it into
 * arr[n-1],...,arr[n-4] respectively
 */
R1:
    leaq -1(%rdi), %rdi
    call vcn
    leaq 1(%rdi), %rdi
    movq %rax, (%r12)
    jmp R1R
R2:
    leaq -2(%rdi), %rdi
    call vcn
    leaq 2(%rdi), %rdi
    movq %rax, (%r13)
    jmp R2R
R3:
    leaq -3(%rdi), %rdi
    call vcn
    leaq 3(%rdi), %rdi
    movq %rax, (%r14)
    jmp R3R
R4:
    leaq -4(%rdi), %rdi
    call vcn
    leaq 4(%rdi), %rdi
    movq %rax, (%r15)
    jmp R4R

/**
 * Base cases
 */
B0:
    pushq $2
    jmp res
B1:
    pushq $1
    jmp res
B2:
    pushq $0
    jmp res
B3:
    pushq $6
    jmp res

/**
 * Start here
 */
ent:
    /**
     * Push registers that requires to be
     * restored later
     */
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15

    /**
     * malloc(42 * sizeof(long long))
     */
    movq $336, %rdi
    call malloc
    movq %rax, %rbx
    movq $0, %r12
    jmp L19
L20:
    /**
     * Loop through the 42 elements
     * after malloc and set all of them
     * to be -1
     */
    movq %r12, %rdx
    movq $-1, (%rbx, %rdx, 8)
    addq $1, %r12
L19:
    cmpq $41, %r12
    jle L20

    /**
     * vcn(41)
     */
    movq $41, %rdi
    movq %rbx, %rsi
    call vcn

    /**
     * Restore original registers
     */
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    ret
