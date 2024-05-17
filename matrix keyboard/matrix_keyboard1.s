ORG 3000H;         SSD lookup table
DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH, 77H, 7CH, 39H, 5EH, 79H, 71H ; common cathode
	
ORG 0000H
SJMP START
ORG 0035H
START : MOV P1, #0F0H
		MOV P2, #00H
		MOV DPTR, #3000H
BACK :	CLR P1.0
		CLR P1.1
		CLR P1.2
		CLR P1.3
		MOV R1, P1
		CJNE R1, #0F0H, LOOP1
		MOV P2, #03FH
		JMP BACK
		LOOP1 : CLR P1.0
				SETB P1.1
				SETB P1.2
				SETB P1.3
				MOV A, #00H
				JNB P1.4, NEXT
				INC A
				JNB P1.5, NEXT
				INC A
				JNB P1.6, NEXT
				INC A
				JNB P1.7, NEXT
		LOOP2 : SETB P1.0
				CLR P1.1
				SETB P1.2
				SETB P1.3
				INC A
				JNB P1.4, NEXT
				INC A
				JNB P1.5, NEXT
				INC A
				JNB P1.6, NEXT
				INC A
				JNB P1.7, NEXT
		LOOP3 : SETB P1.0
				SETB P1.1
				CLR P1.2
				SETB P1.3
				INC A
				JNB P1.4, NEXT
				INC A
				JNB P1.5, NEXT
				INC A
				JNB P1.6, NEXT
				INC A
				JNB P1.7, NEXT
		LOOP4 : SETB P1.0
				SETB P1.1
				SETB P1.2
				CLR P1.3
				INC A
				JNB P1.4, NEXT
				INC A
				JNB P1.5, NEXT
				INC A
				JNB P1.6, NEXT
				INC A
				JNB P1.7, NEXT

		NEXT : MOVC A, @A+DPTR
			   MOV P2,A
END