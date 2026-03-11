JMP start
m:   DB 2
n:   DB 3
mat: DB 1.0_o3, 2.0_o3, 0.5_o3
     DB 1.5_o3, 1.0_o3, 2.0_o3
vec: DB 2.0_o3, 1.0_o3, 1.5_o3
res: DB 0.0_h, 0.0_h

start:
    MOV A, mat
    MOV B, vec
    MOV C, m
    MOV D, res

    FMOV.H FHC, 0.0_h
    FMOV.H FHD, 0.0_h
    CALL mat_mul_vec
    
    HLT
    
mat_mul_vec:
.loop1:
    CALL vectors_multiplication ; res = FHC
    FMOV.H [D], FHC
    FMOV.H FHC, 0.0_h
    INC D
    INC D
    DEC C
    MOV B, vec
    CMP C, 0
    JA .loop1
    JMP .done1
.done1: RET
    
vectors_multiplication: ; res = FHC
    PUSH C
    MOV C, n
.loop2:
    FMOV.O3 FQA, [A]
    FMOV.O3 FQC, [B]
    FCVT.H.O3 FHA, FQA
    FCVT.H.O3 FHB, FQC
    FMUL.H FHA, FHB
    FADD.H FHC, FHA
    DEC C
    INC A
    INC B
    CMP C, 0
    JA .loop2
    JMP .done2
.done2: 
    POP C
    RET