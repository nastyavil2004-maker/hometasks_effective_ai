JMP start
data: DB 10, 20, 30, 15, 25
      DB 40, 10, 5, 35, 10
len:  DB 10

start:
    VSET VL, 10 ; длина массива
    VSET VA, {data}, data ; указатель на данные
    VSET VC, 0x20  ; указывается адрес
    VADD.U VC, VA   ; в VC записываем результат вектор инструкции
    VWAIT
    MOV A, [0x20]
    HLT             