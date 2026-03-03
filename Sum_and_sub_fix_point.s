; Q4.4: a = 2.5 (0x28), b = 1.25 (0x14)
JMP start

a_val:
	DB 0x28
b_val:
	DB 0x14
sum:	DB 0
sub:	DB 0
start:
	MOV A, [a_val]
	MOV B, [b_val]
	; считаем сумму
	MOV C, A
	ADD C, B
	MOV [sum], C
	; считаем разность
	SUB A, B
	MOV [sub], A	

	; ваш код здесь
	; 1) получить c = a + b
	; 2) получить d = a - b
	; 3) сохранить c и d в память

	HLT