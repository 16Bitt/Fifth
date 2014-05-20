	[BITS 16]
	[ORG 0x7C00]

	JMP 0:ENTRYPOINT
ENTRYPOINT:
	CLI
	XOR AX, AX
	MOV ES, AX
	MOV DS, AX
	MOV SS, AX
	MOV AX, 0x7C00
	MOV SP, AX
	STI

	MOV BYTE [ENTRYPOINT], DL
	MOV SI, STR
	CALL PUTS

	MOV BX, 0x7E00			;WRITE ADDRESS
	MOV AH, 2			;FLOPPY INTERRUPT
	MOV AL, 1			;NUMBER OF SECTORS TO LOAD
	MOV CH, 0			;TRACK
	MOV CL, 2			;SEGMENT
	MOV DH, 0			;DRIVE HEAD
LOAD_DISK:
	INT 0x13
	JC LOAD_DISK

	CLI
	JMP NEXT

PUTS:
	PUSHA
	MOV AH, 0xE
LOOP: 
	LODSB
	OR AL, AL
	JZ ENDPUTS
	INT 0x10
	JMP LOOP
ENDPUTS:
	POPA
	RET

STR:	DB ">MINIMAL DISK BOOTSTRAP STARTED", 13, 10, 0
	
	TIMES 510 - ($ - $$) DB 0
	DW 0xAA55

NEXT: