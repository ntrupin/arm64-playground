.include "libnoah.s"

.global main
.align 4

main:
    mov X5, #1

row_loop:
    printReg 5

    // loop body
    add X5, X5, #1
    cmp X5, #10
    b.le row_loop

    // exit
    mov X0, #0 // exit code
    ret

.data
helloworld: 
    .ascii "Hello World!\n"
