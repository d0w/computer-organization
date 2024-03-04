.data

    ia: .word 7
    ib: .word 0x23
    ic: .word 0
    ...
    ig

.text

    li $t0, 0x1234
    sw $t0, ib
    sw $t0, ia

    add $t1, $t0, $t0
    sw $t1, ic

    or $t2, $t0, $t1
    andi $t2, $t2, 17
    sw $t2, id

    lw $t3, ig
    xori $t3, 0xFFFF
    sw $t3, ie



.text
main:

    lw $s0, a
    lw $s1, b
    lw $s2, c
    lw $s3, d

if:
    bne $s0, $s1, elseif
    li $t0, 33
    sw $t0, c
    j end

elseif:
    beq $s1, $s2, else
    li $t0, 20
    sw $t0, a
    j end

else:
    slt $t0, $s0, $s1
    bgtz $t0, innerelseif
    j innerend

    innerelseif:
    ----
    j inner end

    innerelse:

    innerend:
    

end:

.text

    li $t0, 20
    sw $t0, VarA

    sw $t0, VarB

    la $s0, ArrayA
    sw $t0, 4($s0)

    la $t1, VarE
    sw $t1, VarF