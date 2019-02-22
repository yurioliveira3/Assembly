ori $t1, $t1, 0x0000
ori $t2, $t2, 0x0003
ori $t3, $t3, 0x0000

imenor:
slt $t4,$t1,$t2
bnez $t4,for
j fim

for:
add $t3,$t3,$t1
addi $t1,$t1, 1 
j imenor

fim:
nop