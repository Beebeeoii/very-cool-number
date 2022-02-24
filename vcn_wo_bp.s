   .text
   .globl ent
vcn:
    /**
     * Reserve 4*8bytes for the 4 results
     */
    subq $32, %rsp

    /**
     * Push n onto the stack where
     * n is the argument passed
     */
    pushq %rdi

    /**
     * Base cases
     */
    cmpq $0, (%rsp)
    je B0
    cmpq $1, (%rsp)
    je B1
    cmpq $2, (%rsp)
    je B2
    cmpq $3, (%rsp)
    je B3

    jmp R1

R4R:
    /**
     * Add up the 4 results from
     * the recursive calls
     * and store into %rax
     */
    movq 32(%rsp), %rax
    addq 24(%rsp), %rax
    addq 16(%rsp), %rax
    addq 8(%rsp), %rax
    pushq %rax
res:
    /**
     * Stack teardown
     */
    popq %rax
    popq %rdi
    addq $32, %rsp
    ret
R1:
    /**
     * Call vcn(n-1), vcn(n-2), vcn(n-3)
     * and vcn(n-4) and store it into
     * their spaces reserved on stack
     */
    subq $1, (%rsp)
    movq (%rsp), %rdi
    call vcn
    movq %rax, 32(%rsp)

    subq $1, (%rsp)
    movq (%rsp), %rdi
    call vcn
    movq %rax, 24(%rsp)

    subq $1, (%rsp)
    movq (%rsp), %rdi
    call vcn
    movq %rax, 16(%rsp)

    subq $1, (%rsp)
    movq (%rsp), %rdi
    call vcn
    movq %rax, 8(%rsp)

    jmp R4R
B0:
    # Base case 1
    pushq $2
    jmp res
B1:
    # Base case 2
    pushq $1
    jmp res
B2:
    # Base case 3
    pushq $0
    jmp res
B3:
    # Base case 4
    pushq $6
    jmp res

/**
 * Start here
 */
ent:
    /**
     * Call vcn(41)
     */
    movq $41, %rdi
    call vcn
    ret
