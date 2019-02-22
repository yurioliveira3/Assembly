	; CORDIC - (32 bit)

	; Rotational Mode - find Cos(theta) and Sin(theta)

	mov 	#ATAN_I p_ARR

  loop:

	; N = 32 to 1

	mov 	N Shift

	; Shift = 0 to -31

	sub 	#32d Shift

	; dir = 1

	mov 	#1 DIR

	; is (z - theta) < 0 ?

	mov 	Z_H r0
	mov 	Z_L r1

	mov 	TH_H r2
	mov 	TH_L r3

	sub 	r3 r1
	sbc 	r0
	sub 	r2 r0

	tst 	r0

	bmi 	rotate

	; dir = -1

	neg 	DIR

  rotate:

	; get atan[i] and increment p_ARR

	mov 	@p_ARR ATAN_H
	add 	#2 p_ARR
	mov 	@p_ARR ATAN_L
	add 	#2 p_ARR

	; which direction ?

	tst 	DIR

	bpl 	next_1

	; negate atan[i]

	com 	ATAN_L
	com 	ATAN_H
	add 	#1 ATAN_L
	adc 	ATAN_H

  next_1:

	; z = z + atan[i]

	add 	ATAN_L Z_L
	adc 	Z_H
	add 	ATAN_H Z_H

	; x1 = x

	mov 	X_H X1_H
	mov 	X_L X1_L

	; y1 = y

	mov 	Y_H Y1_H
	mov 	Y_L Y1_L

	; x >> i

	mov 	X_H r0
	mov 	X_L r1
	ashc 	Shift r0

	; y >> i

	mov 	Y_H r2
	mov 	Y_L r3
	ashc 	Shift r2

	; which direction ?

	tst 	DIR

	bpl 	next_2

	; negate (x >> i)

	com 	r1
	com 	r0
	add 	#1 r1
	adc 	r0

	; negate (y >> i)

	com 	r3
	com 	r2
	add 	#1 r3
	adc 	r2

  next_2:

	; x1 = x - (y >> i)

	sub 	r3 X1_L
	sbc 	X1_H
	sub 	r2 X1_H

	; y1 = y + (x >> i)

	add 	r1 Y1_L
	adc 	Y1_H
	add 	r0 Y1_H

	; update x = x1

	mov 	X1_H X_H
	mov 	X1_L X_L

	; update y = y1

	mov 	Y1_H Y_H
	mov 	Y1_L Y_L

	dec 	N

	bne 	loop

	halt

	; loop counter = 32 to 1

  N: .word 32d

	; left shift = (N - 32) = 0 to -31

  Shift: .word

	; direction of rotation = -1 or +1

  DIR: .word

	; x, y and z

  X_H: .word 23335
  X_L: .word 35552
  Y_H: .word
  Y_L: .word
  Z_H: .word
  Z_L: .word
 
	; x1 and y1 = temp x and y 

  X1_H: .word
  X1_L: .word
  Y1_H: .word
  Y1_L: .word

	; theta

  TH_H: .word 166314
  TH_L: .word 146315

	; atan for the current i = (N - 32)

  ATAN_H: .word
  ATAN_L: .word

	; pointer to atan[i]

  p_ARR: .word

	; atan[i] = atan(pow(2,-i)) for i = 0 to 31

  ATAN_I:

  .word 16314, 146314
  .word 10400, 65401
  .word 4373, 131270
  .word 2217, 56330
  .word 1111, 171125 
  .word 445, 41112
  .word 222, 125116
  .word 111, 53114
  .word 44, 125512
  .word 22, 52652
  .word 11, 25325
  .word 4, 112552
  .word 2, 45265
  .word 1, 22532
  .word 0, 111255
  .word 0, 44526
  .word 0, 22253
  .word 0, 11125
  .word 0, 4452
  .word 0, 2225
  .word 0, 1112
  .word 0, 445
  .word 0, 222
  .word 0, 111
  .word 0, 44
  .word 0, 22
  .word 0, 11
  .word 0, 4
  .word 0, 2
  .word 0, 1
  .word 0, 0
  .word 0, 0

  .end 0