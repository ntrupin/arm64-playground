.macro push r1, r2
    stp \r1, \r2, [SP, #-16]!
.endm

.macro pop r1, r2
    ldp \r1, \r2, [SP], #16
.endm

.macro pushAllRegs
    push X0, X1
    push X2, X3
    push X4, X5
    push X6, X7
    push X8, X9
    push X10, X11
    push X12, X13
    push X14, X15
    push X16, X17
    push X18, LR
.endm

.macro popAllRegs
    pop X18, LR
    pop X16, X17
    pop X14, X15
    pop X12, X13
    pop X10, X11
    pop X8, X9
    pop X6, X7
    pop X4, X5
    pop X2, X3
    pop X0, X1
.endm

.macro printReg reg
    pushAllRegs

    mov X2, X\reg // %d
    mov X3, X\reg // %x
    mov X1, #\reg // literal
    add X1, X1, #'0' // %c
    str X1, [SP, #-32]! // four doublewords, push x1
    str X2, [SP, #8] // one doubleword push
    str X3, [SP, #16] // two doubleword push
    adrp X0, regFormatStr@page
    add X0, X0, regFormatStr@pageOFF
    bl _printf
    add SP, SP, #32 // clean stack

    popAllRegs
.endm

.macro printStr str
    pushAllRegs
    adrp X0, \str@page
    add X0, X0, \str@pageOFF
    bl _printf
    popAllRegs
    b 2f
1:  .asciz "\str\n"
    .align 4
2:
.endm

.data
regFormatStr:
    .asciz "X%c[%ld, 0x%016lx]\n"
.align 4
.text
