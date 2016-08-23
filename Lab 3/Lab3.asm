; LAB 3
; NATHAN YOUNG
; 19 APRIL 2016

INCLUDE Irvine32.inc
.data
	caseTable	byte '1'			; lookup value
	dword		Process_1			; Address of procedure
	entrySize = ($ - caseTable)		; Entry size
				byte '2'			; Lookup value	
				dword Process_2		; Address of procedure
				byte '3'			; lookup value
				dword Process_3		; Address of procedure
				byte '4'			; Lookup value
				dword Process_4		; Address of procedure
				byte '5'			; Lookup value
				dword Process_5		; Address of procedure
	numberEntries = 5				; Number of entries
	introMessage	byte "### BOOLEAN CALCULATOR ###",0dh,0ah	; The menu message
	selmessage	byte "### BOOLEAN CALCULATOR ###",0dh,0ah		; The menu message
				byte "1. x AND y",0dh,0ah						; The menu message
				byte "2. x OR y",0dh,0ah						; The menu message	
				byte "3. NOT x",0dh,0ah							; The menu message
				byte "4. x XOR y",0dh,0ah						; The menu message
				byte "5. Exit Program",0dh,0ah					; The menu message
				byte "Please enter selection 1,2,3,4 or 5: ",0	; The menu message
	message1		byte "You chose 1 (x AND y)",0dh,0ah,0		; User choice message
	message2		byte "You chose 2 (x OR y)",0dh,0ah,0		; User choice message
	message3		byte "You chose 3 (NOT x)",0dh,0ah,0		; User choice message
	message4		byte "You chose 4 (x XOR y)",0dh,0ah,0		; User choice message
	message5		byte "You chose 5 (Exit)",0dh,0ah,0			; User choice message
.code
main PROC
	mov edx,OFFSET introMessage	; Writes intro message
	call WriteString			; Writes intro message
	call Clrscr					; Clear screen
	call Menu					; menu procedure
ExitProg::exit					; Global Exit
main ENDP

Menu PROC
	mov  edx,OFFSET selmessage	; Prompt for input
	call WriteString			; Prompt for input
	call ReadChar				; read one character
    mov  ebx,OFFSET caseTable	; point EBX to the table
	mov  ecx,numberEntries	; loop counter
L1:
	cmp  al,[ebx]				; check for a match
	jne  L2						; if not, continue
	call NEAR PTR [ebx + 1]		; yes, call the procedure
	call WriteString			; display message
	call Crlf					; Next output line
	call Waitmsg				; pause message
	call Clrscr					; clear screen
	jmp  L3					    ; exit the search
L2:
	add  ebx,5					; point to the next entry
	loop L1						; repeat until the ECX = 0
L3:
	jmp Menu					; Go back to the menu
Menu EndP

Process_1 PROC
	mov edx,OFFSET message1		; Display message1
	call Crlf					; Display message1
	call Crlf					; Display message1
	ret							; Returns
Process_1 ENDP

Process_2 PROC
	mov  edx,OFFSET message2	; Display message2
	call Crlf					; Display message2
	call Crlf					; Display message2
	ret							; Returns
Process_2 ENDP

Process_3 PROC
	mov  edx,OFFSET message3	; Display message3
	call Crlf					; Display message3
	call Crlf					; Display message3
	ret							; Returns
Process_3 ENDP

Process_4 PROC
	mov  edx,OFFSET message4	; Display message4
	call Crlf					; Display message4
	call Crlf					; Display message4
	ret							; Returns
Process_4 ENDP

Process_5 PROC
	mov  edx,OFFSET message5	; Display message5
	call Crlf					; Display message5
	call Crlf					; Display message5
	call WriteString			; Display message5
	call Crlf					; Display message5
	stc							; set carry flag
	jc ExitProg    				; if CF=1 then jump to ExitProg
Process_5 ENDP
END main