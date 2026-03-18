JMP start
x:   DB 1.0_h
res: DB 0.0_h
ln2: DB 0.693147_h         ; ~= 0,69314718055995
inv_ln2: DB 1.442695_h     ; ~= 1,442695040889
n: DB 4
coeff: DB 0.0416_h, 0.16666_h, 0.5_h, 1.0_h, 1.0_h

start:
    MOV A, x
    ;MOV B, res
    MOV B, coeff
    MOV C, inv_ln2
    FMOV.H FHA, [A]
    FMOV.H FHB, [C]   ; получили inv_ln2 в FHB
    FMUL.H FHB, FHA   ; получили k в FHB - нецелое
    ;FMOV.H FPCR.RM 0x08 ?????????
    FFTOI.H D, FHB  ; получили k в D - округленное
    FITOF.H FHB, D  ; получили k в FHB - округленное
    
    MOV C, ln2
    FMOV.H FHC, [C] ; получили ln2 в FHC
    FMUL.H FHC, FHB ; ln2*k
    FSUB.H FHA, FHC ; получили r в FHA (r = x - ln2*k)
    
    MOV D, [n]

    FMOV.H FHC, [B]  ; получили coeff в FHC
    FMOV.H FHD, FHC  ; собираем в FHD полиномиальное разложение e^r 
loop:    
    FMUL.H FHD, FHA
    INC B
    INC B
    DEC D
    FMOV.H FHC, [B]  
    FADD.H FHD, FHC
    CMP D, 0
    JA loop
    JMP done
done: 
    FFTOI.H D, FHB ; получили k в D
    FMOV.H FHC, 1.0_h ; получаем 2^k в FHC
    JMP loop2
loop2:
    FMOV.H FHA, 2.0
    FMUL.H FHC, FHA
    DEC D
    CMP D, 0
    JZ done2
    JMP loop2
done2:
    FMUL.H FHC, FHD
    MOV B, res
    FMOV.H [B], FHC 
    HLT
