JMP start
vec_a: DB 3, 5, 2, 4, 1
vec_b: DB 4, 1, 6, 2, 3
len:   DB 5
res:   DB 0

start:
    MOV A, [res]
    CALL vectors_multiplication
    MOV A, [res]
    HLT             

vectors_multiplication: ; res = VA
    VSET VL, 5 ; длина массивов
    VSET VA, {vec_a}, vec_a ; указатель на данные
    VSET VB, {vec_b}, vec_b	
    VSET VC, {res}, res
    VMUL.U VC, VA, VB ; поэлементное умножение
    VSET VC, {res}, res
    VSET VA, {res}, res  ; указывается адрес
    VADD.U VA, VC   ; сохраняем результат в ячейку по адресу VA
    VWAIT
    RET

           

  

