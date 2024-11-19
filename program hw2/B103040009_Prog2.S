    .text
    .align  2
    .global main
main:   stmfd   sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
        ADD     fp, sp, #4

        ldr r0, =string1
        BL  printf
        BL  start
        .include "test.s"

start:  ldr	r7, =start
        mov	r8, r14
        mov	r10, #0
    		
LOOP:	cmp	r8, r7
		beq	EXIT
		ldr     r4, [r8]
        ldr     r5, =0xf0000000
        and     r6, r4, r5
		
		ldr 	r0, =string2
		mov	    r1, r10
		add	    r10, r10, #4
        BL  	printf
       	cmp     r6, #0x00000000
                beq     EQ
                cmp     r6, #0x10000000
                beq     NE
                cmp     r6, #0x20000000
                beq     CSHS
                cmp     r6, #0x30000000
                beq     CCLO
                cmp     r6, #0x40000000
                beq     MI
                cmp     r6, #0x50000000
                beq     PL
                cmp     r6, #0x60000000
                beq     VS
                cmp     r6, #0x70000000
                beq     VC
                cmp     r6, #0x80000000
                beq     HI
                cmp     r6, #0x90000000
                beq     LS
                cmp     r6, #0xa0000000
                beq     GE
                cmp     r6, #0xb0000000
                beq     LT
                cmp     r6, #0xc0000000
                beq     GT
                cmp     r6, #0xd0000000
                beq     LE
                cmp     r6, #0xe0000000
                beq     AL
                cmp     r6, #0xf0000000
                beq     NV

Determine:      ldr     r5, =0x0f0000f0
                and     r6, r4, r5

                cmp	    r6, #0x00000090
                beq	    Undef
                ldr     r5, =0x0fff0ff0
                and     r6, r4, r5
                ldr	    r9, =0x01600010
                cmp	    r6, r9
                beq	    Undef
                ldr     r5, =0x0e000090
                and     r6, r4, r5
                cmp	    r6, #0x00000090
                beq	    Undef
                ldr     r5, =0x0e000000
                and     r6, r4, r5
                cmp	    r6, #0x08000000
                beq	    Undef

		        ldr     r5, =0x0c000000
                and     r6, r4, r5
                cmp     r6, #0x00000000
                beq     DataProcessing
                cmp     r6, #0x04000000
                beq     DataMovement
                b	    Branch

EQ:         ldr r0, =stringEQ
            BL  printf
            B   Determine
NE:         ldr r0, =stringNE
            BL  printf
            B   Determine
CSHS:       ldr r0, =stringCSHS
            BL  printf
            B   Determine
CCLO:       ldr r0, =stringCCLO
            BL  printf
            B   Determine
MI:         ldr r0, =stringMI
            BL  printf
            B   Determine
PL:         ldr r0, =stringPL
            BL  printf
            B   Determine
VS:         ldr r0, =stringVS
            BL  printf
            B   Determine
VC:         ldr r0, =stringVC
            BL  printf
            B   Determine
HI:         ldr r0, =stringHI
            BL  printf
            B   Determine
LS:         ldr r0, =stringLS
            BL  printf
            B   Determine
GE:         ldr r0, =stringGE
            BL  printf
            B   Determine
LT:         ldr r0, =stringLT
            BL  printf
            B   Determine
GT:         ldr r0, =stringGT
            BL  printf
            B   Determine
LE:         ldr r0, =stringLE
            BL  printf
            B   Determine
AL:         ldr r0, =stringAL
            BL  printf
            B   Determine
NV:         ldr r0, =stringNV
            BL  printf
            B   Determine

DataProcessing: ldr     r5, =0x01e00000
                and     r6, r4, r5

                cmp     r6, #0x00000000
                beq     outAND
                cmp     r6, #0x00200000
                beq     outEOR
                cmp     r6, #0x00400000
                beq     outSUB
                cmp     r6, #0x00600000
                beq     outRSB
                cmp     r6, #0x00800000
                beq     outADD
                cmp     r6, #0x00a00000
                beq     outADC
                cmp     r6, #0x00c00000
                beq     outSBC
                cmp     r6, #0x00e00000
                beq     outRSC
                cmp     r6, #0x01000000
                beq     outTST
                cmp     r6, #0x01200000
                beq     outTEQ
                cmp     r6, #0x01400000
                beq     outCMP
                cmp     r6, #0x01600000
                beq     outCMN
                cmp     r6, #0x01800000
                beq     outORR
                cmp     r6, #0x01a00000
                beq     outMOV
                cmp     r6, #0x01c00000
                beq     outBIC
                cmp     r6, #0x01e00000
                beq     outMVN

DataMovement:   ldr     r5, =0x00500000
                and     r6, r4, r5

                cmp     r6, #0x00000000
                beq     outSTR
                cmp     r6, #0x00100000
                beq     outLDR
                cmp     r6, #0x00400000
                beq     outSTRB
                cmp     r6, #0x00500000
                beq     outLDRB

Branch:     ldr     r5, =0x01000000
            and     r6, r4, r5

            cmp     r6, #0x01000000
            ldreq   r5, =0x00ffffff
            andeq   r6, r4, r5     
            
            beq     outBL
            cmp     r6, #0x00000000
            ldreq   r5, =0x00ffffff
            andeq   r6, r4, r5
            
            beq     outB

    

outAND:     ldr r0, =stringAND
            BL  printf
            add r8, r8, #4
            B   LOOP
outEOR:     ldr r0, =stringEOR
            BL  printf
            add r8, r8, #4
            B   LOOP
outSUB:     ldr r0, =stringSUB
            BL  printf
            add r8, r8, #4
            B   LOOP
outRSB:     ldr r0, =stringRSB
            BL  printf
            add r8, r8, #4
            B   LOOP
outADD:     ldr r0, =stringADD
            BL  printf
            add r8, r8, #4
            B   LOOP
outADC:     ldr r0, =stringADC
            BL  printf
            add r8, r8, #4
            B   LOOP
outSBC:     ldr r0, =stringSBC
            BL  printf
            add r8, r8, #4
            B   LOOP
outRSC:     ldr r0, =stringRSC
            BL  printf
            add r8, r8, #4
            B   LOOP
outTST:     ldr r0, =stringTST
            BL  printf
            add r8, r8, #4
            B   LOOP
outTEQ:     ldr r0, =stringTEQ
            BL  printf
            add r8, r8, #4
            B   LOOP
outCMP:     ldr r0, =stringCMP
            BL  printf
            add r8, r8, #4
            B   LOOP
outCMN:     ldr r0, =stringCMN
            BL  printf
            add r8, r8, #4
            B   LOOP
outORR:     ldr r0, =stringORR
            BL  printf
            add r8, r8, #4
            B   LOOP
outMOV:     ldr r0, =stringMOV
            BL  printf
            add r8, r8, #4
            B   LOOP
outBIC:     ldr r0, =stringBIC
            BL  printf
            add r8, r8, #4
            B   LOOP
outMVN:     ldr r0, =stringMVN
            BL  printf
            add r8, r8, #4
            B   LOOP

outSTR:     ldr r0, =stringSTR
            BL  printf
            add r8, r8, #4
            B   LOOP
outSTRB:    ldr r0, =stringSTRB
            BL  printf
            add r8, r8, #4
            B   LOOP
outLDR:     ldr r0, =stringLDR
            BL  printf
            add r8, r8, #4
            B   LOOP
outLDRB:    ldr r0, =stringLDRB
            BL  printf
            add r8, r8, #4
            B   LOOP

outB:       ldr r5, =0x00800000
            and r5, r4, r5
            cmp r5, #0x00000000
            orrgt r6, #0xff000000
            add r5, r10 ,#4
            add r6, r5, r6, lsl #2

            ldr r0, =stringB
            BL  printf
            mov r1, r6
            ldr r0, =string2
            BL  printf
            ldr r0, =stringNewline
            BL  printf
            add r8, r8, #4
            B   LOOP

outBL:      ldr r5, =0x00800000
            and r5, r4, r5
            cmp r5, #0x00000000
            orrgt r6, #0xff000000
            add r5, r10 ,#4
            mov r14, r5
            add r6, r5 ,r6, lsl #2

            ldr r0, =stringBL
            BL  printf
            mov r1, r6
            ldr r0, =string2
            BL  printf
            ldr r0, =stringNewline
            BL  printf
            add r8, r8, #4
            B   LOOP

Undef:  ldr r0, =stringUndef
        BL  printf
        add r8, r8, #4
        B LOOP

EXIT:   sub sp, fp, #4
        ldmfd   sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
        bx  lr
string1:
    .asciz "PC\tcondition\tinstruction\n"
string2:
    .asciz "%d\t"
stringEQ:
    .asciz "EQ\t\t"
stringNE:
    .asciz "NE\t\t"  
stringCSHS:
    .asciz "CS/HS\t\t"
stringCCLO:
    .asciz "CC/LO\t\t"
stringMI:
    .asciz "MI\t\t"
stringPL:
    .asciz "PL\t\t"
stringVS:
    .asciz "VS\t\t" 
stringVC:
    .asciz "VC\t\t"
stringHI:
    .asciz "HI\t\t"
stringLS:
    .asciz "LS\t\t"
stringGE:
    .asciz "GE\t\t"
stringLT:
    .asciz "LT\t\t"
stringGT:
    .asciz "GT\t\t"
stringLE:
    .asciz "LE\t\t"
stringAL:
    .asciz "AL\t\t"
stringNV:
    .asciz "NV\t\t"

stringAND:
    .asciz "AND\n"
stringEOR:
    .asciz "EOR\n"
stringSUB:
    .asciz "SUB\n"
stringRSB:
    .asciz "RSB\n"
stringADD:
    .asciz "ADD\n"
stringADC:
    .asciz "ADC\n"
stringSBC:
    .asciz "SBC\n"
stringRSC:
    .asciz "RSC\n"
stringTST:
    .asciz "TST\n"
stringTEQ:
    .asciz "TEQ\n"
stringCMP:
    .asciz "CMP\n"
stringCMN:
    .asciz "CMN\n"
stringORR:
    .asciz "ORR\n"
stringMOV:
    .asciz "MOV\n"
stringBIC:
    .asciz "BIC\n"
stringMVN:
    .asciz "MVN\n"

stringSTR:
    .asciz "STR\n"
stringSTRB:
    .asciz "STRB\n"
stringLDR:
    .asciz "LDR\n"
stringLDRB:
    .asciz "LDRB\n"

stringB:
    .asciz "B\t"
stringBL:
    .asciz "BL\t"
stringNewline:
    .asciz "\n"

stringUndef:
    .asciz "UND\n"
    
.end