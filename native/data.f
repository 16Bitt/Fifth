{ @
T FPOP BX
NT MOV AX, WORD [BX]
NT FPUSH AX }

{ C@
T FPOP BX
NT XOR AX, AX
NT MOV AL, BYTE [BX]
NT FPUSH AX }

{ !
T FPOP BX
NT FPOP AX
NT MOV WORD [BX], AX }

{ C!
T FPOP BX
NT FPOP AX
NT AND AX, 0xFF
NT MOV BYTE [BX], AL }
