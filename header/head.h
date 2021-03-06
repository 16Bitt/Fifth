	[BITS 16]
	[ORG 0x8100]

%include "header/asm.h"
%define LASTVAL FLBL0

ENTRYPOINT:
	STI
	JMP STARTEXEC

DBG_PRINT:
	PUSHA
	MOV AH, 0xE
DP_LOOP:
	LODSB
	OR AL, AL
	JZ DP_END
	INT 0x10
	JMP DP_LOOP
DP_END:
	POPA
	RET

CPUSHF:
	FPUSH AX
	NEXT

STARTEXEC:
	MOV BP, STACK
	MOV AX, HEAP
	MOV WORD [HERE_VAL], AX
	CALL 0:UPDATELASTVAL
	CALL 0:MAIN
	CLI
	HLT

END_STRING: DB "'Main' reached end of execution."
