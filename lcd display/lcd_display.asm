//interfacing lcd display with 8051

ORG 3000H
WORD1 : DB 'IIITN', 00H

ORG 3100H
WORD2 : DB 'ECE DEPT.', 00H
	
	
ORG 0000H ; Set the origin address to 0000H
SJMP MAIN ; Skip to the MAIN label
ORG 0040H ; Set the origin address to 0040H
MAIN: 	MOV P1, #00H ; Initialize Port 1 to 00H
		MOV P2, #00H ; Initialize Port 2 to 00H
		
		MOV A, #38H ; Load A with 38H
		ACALL CMD ; Call the COMMAND subroutine
		MOV A, #0FH ; Load A with 0FH
		ACALL CMD ; Call the COMMAND subroutine
		
		MOV A, #80H ; Load A with 80H
		ACALL CMD ; Call the COMMAND subroutine
		MOV A, #01H ; Load A with 01H
		ACALL CMD ; Call the COMMAND subroutine
		
		MOV DPTR, #WORD1 ; Load DPTR with the address of WORD1
		MOV A, #085H ; Load A with 085H
		ACALL CMD ; Call the COMMAND subroutine
		REPEAT: MOV A, #00H ; Load A with 00H
				MOVC A, @A+DPTR ; Load A with the value at the address pointed to by DPTR
				JZ FINISH1 ; If A is zero, jump to FINISH1
				ACALL VALUE ; Call the DATA1 subroutine
				INC DPTR ; Increment DPTR
				SJMP REPEAT ; Jump back to REPEAT
		FINISH1:
				MOV DPTR, #WORD2 ; Load DPTR with the address of WORD2
				MOV A, #0C4H ; Load A with 0C4H
				ACALL CMD ; Call the COMMAND subroutine
		REPEAT1:MOV A, #00H ; Load A with 00H
				MOVC A, @A+DPTR ; Load A with the value at the address pointed to by DPTR
				JZ FINISH ; If A is zero, jump to FINISH
				ACALL VALUE ; Call the DATA1 subroutine
				INC DPTR ; Increment DPTR
				SJMP REPEAT1 ; Jump back to REPEAT1
		FINISH: SJMP FINISH ; Jump to FINISH
RET

ORG 0200H
VALUE : ACALL DELAY
		MOV P1, A
		SETB P2.0;  P2.0=RS
		SETB P2.1; P2.1=ENABLE
		CLR P2.1
RET

ORG 0300H
CMD : ACALL DELAY
	  MOV P1, A
	  CLR P2.0
	  SETB P2.1
	  CLR P2.1
RET

ORG 0400H
DELAY : MOV R3, #0FFH
AGAIN1 :MOV R4, #0FFH
AGAIN2 :MOV R5, #7
AGAIN3 :DJNZ R5, AGAIN3
        DJNZ R4, AGAIN2
		DJNZ R3, AGAIN1
RET
END