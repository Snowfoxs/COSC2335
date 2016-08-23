; LAB 2
; NATHAN YOUNG
; 12 APRIL 2016

INCLUDE Irvine32.inc
.data
total			DWORD	0
numberOfTests	WORD	0
welcome			BYTE	"Welcome to the Grader",0dh,0ah			; THE WELCOME MESSAGE
			BYTE	"Enter an integer between 0 and 100",0dh,0ah	; THE WELCOME MESSAGE	
			BYTE	"Type -1 when you are finished",0dh,0ah		; THE WELCOME MESSAGE
error			BYTE	0dh,0ah						; THE ERROR MESSAGE
			BYTE	"ERROR: Incorrect Value entered",0dh,0ah	; THE ERROR MESSAGE
line			BYTE	0dh,0ah,0dh,0ah,0				; MAKES A BLANK LINE
point			BYTE	".",0						; MAKES A DECIMAL POINT
average			BYTE	"Average: ",0					; MAKES AVERAGE TEXT
tests			BYTE	" points with ",0				; MORE TEXT FOR LATER
tests2			BYTE	" grades.",0					; MORE TEXT FOR LATER
total1			BYTE	"Total Score: ",0				; MORE TEXT FOR LATER
letterGrade		BYTE	"Letter Grade: ",0				; MORE TEXT FOR LATER
letterGradeA	BYTE	"A",0dh,0ah,0						; MORE TEXT FOR LATER
letterGradeB	BYTE	"B",0dh,0ah,0						; MORE TEXT FOR LATER
letterGradeC	BYTE	"C",0dh,0ah,0						; MORE TEXT FOR LATER
letterGradeD	BYTE	"D",0dh,0ah,0						; MORE TEXT FOR LATER
letterGradeF	BYTE	"F",0dh,0ah,0						; MORE TEXT FOR LATER
averageGrade	BYTE	"Average: ",0						; MORE TEXT FOR LATER

.code
main PROC
mov edx,OFFSET welcome			; Prints the welcome message
call WriteString				; Prints the welcome message
XOR EAX, EAX					; Clears the registers we will use
XOR EBX, EBX					; Clears the registers we will use
XOR ECX, ECX					; Clears the registers we will use
XOR EDX, EDX					; Clears the registers we will use
MOV ECX, 1					; Moves 1 into ECX

MAINLOOP:					; The main loop location
call UserInput					; Starts user input procedure
cmp EAX, -1					; Compares EAX to -1
je WriteLine					; If equal, jumps out of the main loop
ADD total, EAX					; Adds EAX to the total
MOV EDX, total					; moves total to EDX
INC ECX						; Incremends ECX to start infinite loop
INC numberOfTests				; Increments number of tests
loop MAINLOOP					; Go back to MAINLOOP

WriteLine:					; Makes a blank line
MOV EDX, OFFSET line				; Makes a blank line
call WriteString				; Makes a blank line
MOV EAX, total					; Moves total to EAX
MOV EDX, OFFSET total1				; Writes some text
call WriteString				; Writes some text
call WriteDec					; Writes EAX
XOR EAX, EAX					; Clears EAX
MOV AX, numberOfTests				; Moves number of tests into AX
mov EDX,OFFSET tests				; Writes more text
call WriteString				; Writes more text
call WriteDec					; Writes EAX
MOV EDX,OFFSET tests2				; Writes even more text
call WriteString				; Writes even more text
MOV EDX,OFFSET line				; Writes a blank line
call WriteString				; Writes a blank line
XOR EDX,EDX 					; Clears EDX
MOV EDX,total					; Moves 'total' into EDX
XOR ECX,ECX 					; Clears ECX
XOR EAX,EAX					; Clears EAX
MOV CX,numberOfTests				; Moves numberOfTests to CX
mov AX,DX       				; Move least significant bits to AX
shr EDX,16      				; Shift most significant bits to DX
div CX            				; Divide DX:AX by CX
XOR BX, BX					; Clears BX
MOV CX, AX					; Moves AX to CX
MOV BX, DX					; Moves DX to BX
mov edx,OFFSET line				; Writes a blank line	
call WriteString				; Writes a blank line
mov edx,OFFSET average				; Writes the average
call WriteString				; Writes the average
call WriteDec					; Writes EAX (quotient)
mov edx,OFFSET point				; Writes Decimal		
call WriteString				; Writes Decimal
MOV AX,BX					; Moves BX to AX
call WriteDec					; Writes EAX (remainder)
mov edx,OFFSET line				; Writes a blank line	
call WriteString				; Writes a blank line
mov edx,OFFSET letterGrade			; Writes a letter grade			
call WriteString				; Writes a letter grade
XOR EDX,EDX					; Clears EDX
MOV DX, CX					; Moves CX to DX
CMP DX, 90					; Compares DX and 90
jb gradeB					; If below, jump to gradeB
mov edx,OFFSET letterGradeA			; Writes a letter grade A			
call WriteString				; Writes a letter grade A
Loop ExitOut					; Loop to ExitOut

gradeB:						; Grade B procedures
CMP DX, 80					; Compares DX to 80
jb gradeC					; If below, jump to gradeC
mov edx,OFFSET letterGradeB			; Writes a letter grade B	
call WriteString				; Writes a letter grade B
Loop ExitOut					; Loop to ExitOut

gradeC:						; Grade C procedures
CMP DX, 70					; Compares DX to 70
jb gradeD					; If below, jump to gradeD
mov edx,OFFSET letterGradeC			; Writes a letter grade C
call WriteString				; Writes a letter grade C
Loop ExitOut					; Loop to ExitOut

gradeD:						; Grade D procedures
CMP DX, 60					; Compares DX to 60
jb gradeF					; If below, jump to gradeF
mov edx,OFFSET letterGradeC			; Writes a letter grade D
call WriteString				; Writes a letter grade D
Loop ExitOut					; Loop to ExitOut

gradeF:						; Grade D procedures
mov edx,OFFSET letterGradeF			; Writes a letter grade F
call WriteString				; Writes a letter grade F

ExitOut:					; Procedures to exit
call WaitMsg					; Calls the WaitMsg
exit						; Exit
main ENDP					; Ends main
; **********************************************************
UserInput PROC					; Starts userinput procedure
call ReadInt					; Asks the user for input
cmp EAX, -1					; Compares EAX and -1
je After					; If equal, jump to After
cmp EAX, 0					; Compares EAX and 0
jb WrongInput					; If below, jump to WrongInput
cmp EAX, 100					; Compares EAX and 100
ja WrongInput					; If above, jump to WrongInput
jmp After					; Jumps to After
WrongInput:					; Labels this segment as WrongInput
mov edx,OFFSET error				; Writes an error message				
call WriteString				; Writes an error message
call ReadInt					; Reads an integer
cmp EAX, 0					; Compares EAX and 0
jb WrongInput					; If below, jump to WrongInput
cmp EAX, 100					; Compares EAX and 100
ja WrongInput					; If above, jump to WrongInput
After:						; The "After" seg
Ret						; Returns to the main procedure
UserInput endp					; Ends the UserInput procedure
END main					; Ends main