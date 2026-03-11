JMP start
vec_a: DB 2.0_o3, 3.0_o3, 1.5_o3
vec_b: DB 1.75_o3, 1.0_o3, 2.5_o3
acc:   DB 0.0_h

start:
    MOV A, vec_a
    MOV B, vec_b
    MOV C, 3
    MOV D, acc
    FMOV.H FHD, [acc]
    CALL vectors_multiplication
    FMOV.H [D], FHD
    HLT
        
vectors_multiplication: ; res = FHD
.loop:
    FMOV.O3 FQA, [A]
    FMOV.O3 FQE, [B]
    FCVT.H.O3 FHA, FQA
    FCVT.H.O3 FHB, FQE
    FMUL.H FHA, FHB
    FADD.H FHD, FHA
    DEC C
    INC A
    INC B
    CMP C, 0
    JA .loop
    JMP .done
.done: RET
    
    
    

