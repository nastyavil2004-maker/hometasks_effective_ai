; Q2.2: a = 1.5 (0x06), b = 2.0 (0x08)
JMP start

a_val:
	DB 0x06
b_val:
	DB 0x08
res:
	DB 0x00

start:
	MOV A, [a_val]
	MOV B, [b_val]
	MUL B
	SHR A, 2
	MOV [res], A


	; ваш код здесь
	; 1) вычислить a * b в Q2.2
	; 2) учесть масштаб (сдвиг вправо на 2)
	; 3) сохранить результат в [res]

	HLT