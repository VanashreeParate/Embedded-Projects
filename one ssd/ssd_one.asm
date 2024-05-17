//ssd common cathode
//interfacing seven segment display with 8051
ORG 3000H
DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH

ORG 0000H
SJMP START
ORG 0036H
START : MOV P2, #00H
MAIN  :	MOV DPTR, #3000H
		MOV R1, #10
LOOP1 :	MOV A, #00H
		MOVC A, @A+DPTR
		MOV P2, A
		INC DPTR
		ACALL DELAY
		DJNZ R1, LOOP1
		JMP MAIN
RET

ORG 0200H
DELAY : MOV R3, #0FFH
AGAIN3 :MOV R4, #0FFH
AGAIN2 :MOV R5, #7
AGAIN1 :DJNZ R5, AGAIN1
		DJNZ R4, AGAIN2
		DJNZ R3, AGAIN3
RET
END