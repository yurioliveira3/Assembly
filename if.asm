ori $t1, $t1, 0x0001
ori $t2, $t2, 0x0001

beq $t1,$t2, ad
bne $t1,$t2, su
j fim
ad: 
 add $t3, $t1,$t2
 j fim
su:
 sub $t3, $t1,$t2
 
fim: 
  nop