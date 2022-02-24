   .text
   .globl ent
vcn:
    /**
     * Save old bp set bp=sp
     */
    pushq %rbp
    movq %rsp, %rbp

    /**
     * Reserve 4*8bytes for the 4 results
     */
    subq $32, %rsp

    /**
     * Push n onto the stack
     * n is the argument passed
     */
    pushq %rdi

    /**
     * Base cases
     */
    cmpq $0, -40(%rbp)
    je B0
    cmpq $1, -40(%rbp)
    je B1
    cmpq $2, -40(%rbp)
    je B2
    cmpq $3, -40(%rbp)
    je B3

    jmp R1

R4R:
    /**
     * Add up the 4 results from
     * the recursive calls
     * and store it into %rax
     */
    movq -8(%rbp), %rax
    addq -16(%rbp), %rax
    addq -24(%rbp), %rax
    addq -32(%rbp), %rax
    pushq %rax
res:
    /**
     * Stack teardown
     */
    popq %rax
    popq %rdi
    movq %rbp, %rsp
    popq %rbp
    ret
R1:
    /**
     * Call vcn(n-1), vcn(n-2), vcn(n-3)
     * and vcn(n-4) and store it into
     * their spaces reserved on stack
     */
    subq $1, -40(%rbp)
    movq -40(%rbp), %rdi
    call vcn
    movq %rax, -8(%rbp)

    subq $1, -40(%rbp)
    movq -40(%rbp), %rdi
    call vcn
    movq %rax, -16(%rbp)

    subq $1, -40(%rbp)
    movq -40(%rbp), %rdi
    call vcn
    movq %rax, -24(%rbp)

    subq $1, -40(%rbp)
    movq -40(%rbp), %rdi
    call vcn
    movq %rax, -32(%rbp)

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
    # Basee case 3
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
     * Push original bp as a requirement
     * to be restored later
     */
    pushq %rbp

    /**
     * Call vcn(41)
     */
    movq $41, %rdi
    call vcn

    /**
     * Restore original bp
     */
    popq %rbp
    ret
