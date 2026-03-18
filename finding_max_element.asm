JMP start
vect: DB 1.0_h, 2.0_h, 0.5_h
len: DB 3
max: DB 0.0_h
res: DB 0.0_h

start:
    MOV A, vect
    MOV B, [len]
    MOV C, max
    FMOV.H FHA, [A]
    FMOV.H FHC, [C] ; храним max значение
loop:
    FCMP.H FHA, FHC
    JA new_max
    INC A
    INC A
    FMOV.H FHA, [A]
    DEC B
    CMP B, 0
    JA loop
    JMP done
new_max:
    FMOV.H FHC, FHA
    INC A
    INC A
    FMOV.H FHA, [A]
    DEC B
    CMP B, 0
    JA loop
    JMP done
done:
    MOV B, res
    ;FMOV.H [B], FHC
    FMOV.H FHA, FHC
    FMOV.H [B], FHA
    MOV D, 232
    CALL print_f16_3 ; взяла Вашу реализацию для вывода
    HLT

put_char:                        ; put_char(A:char, D:*to)
        MOV [D], A               ; Write char to output
        INC D
        RET

print:                           ; print(C:*from, D:*to)
.loop:  MOV A, [C]
        CMP A, 0                 ; Check if end
        JZ .done
        CALL put_char
        INC C
        JMP .loop
.done:  RET

; Print FHA as decimal with 3 fractional digits
; Modifies: FHA, FHB, A, C
print_f16_3:
        MOV A, 1                 ; Truncate mode
        FSCFG A

        FMOV.H FHB, 0.0
        FCMP.H FHA, FHB
        JNC .non_negative
        MOV A, '-'                ; Print sign
        CALL put_char
        FNEG.H FHA

.non_negative:
        FFTOI.H A, FHA            ; Integer part
        FITOF.H FHB, A
        FSUB.H FHA, FHB           ; FHA = fractional part
        ADD A, '0'
        CALL put_char

        MOV A, '.'
        CALL put_char

        MOV C, 3                  ; 3 decimal digits
.frac_loop:
        FMOV.H FHB, 10.0
        FMUL.H FHA, FHB           ; Shift left one digit
        FFTOI.H A, FHA
        FITOF.H FHB, A
        FSUB.H FHA, FHB           ; Remove integer part
        ADD A, '0'
        CALL put_char
        DEC C
        JNZ .frac_loop
        RET