#main(){
#   int size = 5, int array[size], int i = 0;
#   while (i < size ) {
#      array[i] = -1
#      i++; }}

  .text 
inicialização:
	la $t0, array
	la $t1, size
	la $t2, i 
	
	lw $t1, 0($t1)
	lw $t2, 0($t2)
	
	addi $t3, $zero, -1 #$t3 <- -1

while:	
	slt $t8, $t2, $t1 # i<size
	beq $t8, $zero, end # if i==size
	
	sll $t7, $t2, 2 # t7 <- i * 4
	add $t7, $t0, $t7 # t7 <- $aray[i]
	sw $t3, 0 ($t7) #array [i] <- -1
	addi $t2, $t2, 1 #i++
	
	j while

end: 
	la $t0, i #t0 <- &i
	sw $t2, 0 ($t0) # i<- t2
.data
	array: .space 20 #int array[5] 
	size: .word 5
 	i: .word 0