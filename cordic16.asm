; CORDIC - (16 bit)

	; Rotational Mode - find Cos(theta) and Sin(theta)

	mov 	#ATAN_I p_ARR

  loop:

	; N = 16 to 1

	mov 	N Shift

	; Shift = 0 to -15

	sub 	#16d Shift

	; dir = 1

	mov 	#1 DIR

	; is (z - theta) < 0 ?

	mov 	Z r0
	mov 	THETA r1

	sub 	r1 r0

	tst 	r0

	bmi 	rotate

	; dir = -1

	neg 	DIR

  rotate:

	; get atan[i] and increment p_ARR

	mov 	@p_ARR ATAN
	add 	#2 p_ARR

	; which direction ?

	tst 	DIR

	bpl 	next_1

	; negate atan[i]

	neg ATAN

  next_1:

	; z = z + atan[i]

	add 	ATAN Z

	; x1 = x and y1 = y

	mov 	X X1
	mov 	Y Y1

	; x >> i

	mov 	X r0
	ash 	Shift r0

	; y >> i

	mov 	Y r1
	ash 	Shift r1

	; which direction ?

	tst 	DIR

	bpl 	next_2

	; negate (x >> i) and (y >> i)

	neg 	r0
	neg 	r1

  next_2:

	; x1 = x - (y >> i)

	sub 	r1 X1

	; y1 = y + (x >> i)

	add 	r0 Y1

	; update x = x1 and y = y1

	mov 	X1 X
	mov 	Y1 Y

	dec 	N

	bne 	loop

	halt

	; loop counter = 16 to 1

  N: .word 16d

	; left shift = (N - 16) = 0 to -15

  Shift: .word

	; direction of rotation = -1 or +1

  DIR: .word

	; x, y and z

  X: .word 23335
  Y: .word
  Z: .word

	; x1 and y1 = temp x and y 

  X1: .word
  Y1: .word

	; theta

  THETA: .word 166315

	; atan for the current i = (N - 16)

  ATAN: .word

	; pointer to atan[i]

  p_ARR: .word

	; atan[i] = atan(pow(2,-i)) for i = 0 to 15

  ATAN_I:

  .word 16314
  .word 10400
  .word 4373
  .word 2217
  .word 1111
  .word 445
  .word 222
  .word 111
  .word 44
  .word 22
  .word 11
  .word 4
  .word 2
  .word 1
  .word 0
  .word 0

  .end 0