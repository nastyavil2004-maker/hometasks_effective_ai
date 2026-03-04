; Q2.2: a = 1 (0x04), b = 2.0 (0x08)
	;DB 0x0F ;3.75
	;DB 0x08 ;2
  	;DB 0x05 ;1.25
  	;DB 0x04 ;1
	;DB 0x03 ;0.75
	;DB 0x02 ;0.5
	;DB 0x01 ;0.25
JMP start

a_val:
	DB 0x04
b_val:
	DB 0x08
inverse_b:
	DB 0x00
res:
	DB 0x00
control_points:
	DB 0x02
	DB 0x08 
  	DB 0x05 
  	DB 0x04 
	DB 0x03 
	DB 0x02 
	DB 0x01 

start:
	MOV A, [a_val]
	MOV B, [b_val]
	MOV C, [inverse_b]
	MOV D, [control_points]
	CMP D, B
	JG inv_1
	INC D
	CMP D, B
	JG inv_2
	INC D
	CMP D, B
	JG inv_3
	INC D
	CMP D, B
	JG inv_4	
	INC D
	CMP D, B
	JG inv_5
	INC D
	CMP D, B
	JG inv_6

	MOV C, 0x01
	MUL C
	MOV [res], A
	HLT

inv_1:
	MOV C, 0x0F
	MUL C
	MOV [res], A
	HLT
inv_2:
	MOV C, 0x08
	MUL C
	MOV [res], A
	HLT
inv_3:
	MOV C, 0x05
	MUL C
	MOV [res], A
	HLT
inv_4:
	MOV C, 0x04
	MUL C
	MOV [res], A
	HLT
inv_5:
	MOV C, 0x03
	MUL C
	MOV [res], A
	HLT
inv_6:
	MOV C, 0x02
	MUL C
	MOV [res], A
	HLT