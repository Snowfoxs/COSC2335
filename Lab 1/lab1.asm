; LAB 1
; NATHAN YOUNG
; 4/6/2016
INCLUDE Irvine32.inc
.data
prompt BYTE "Please enter an integer: ",0
sumMsg BYTE "The sum is: ",0
wArray SDWORD 2 DUP (?)
.code
main PROC
   mov ecx,3					; repeat question 3 times
POINT1:
   push ecx						; protect loop counter
   call Clrscr					; clears the screen
   mov dl,20					; moves to column near the middle of the screen
   mov dh,9						; moves to row near the middle of the screen
   call   Gotoxy				; places the cursor near the middle of the screen
   mov esi,OFFSET wArray		; Read the int values
   mov ecx,2					; Read two ints
   mov edi,OFFSET prompt		; prompt user for number
   call ReadIntArray			; reads the input
   mov eax,[esi]				; prepares for calculation
   add esi,4					; Point ESI to the next integer
   add eax,[esi]				; Adds values
   mov dl,20					; moves to column near the middle of the screen
   mov dh,14					; moves to row near the middle of the screen
   call   Gotoxy				; places the cursor near the middle of the screen
   mov edx,OFFSET sumMsg		; prepare for printing result
   call WriteString				; writes the message
   call WriteInt        ; writes results
   mov dl,20            ; Positions the press any key message
   mov dh,17			; Positions the press any key message
   call Gotoxy			; Positions the press any key message
   call WaitMsg         ; asks user to press a key to continue
   pop ecx				; removes protection from ecx
   loop POINT1			; loops to POINT1
   exit					; self explanatory 
main ENDP
ReadIntArray PROC 
   pushad				; Stores all general registers on stack 
POINT1:   
   mov edx,edi			; prepares for print
   call WriteString		; prompts for integer
   call ReadInt			; reads integer from keyboard
   mov [esi],eax		; stores int in array
   add esi,4			; points to next int to to read
   mov dl,20			; moves to column near the middle of the screen
   mov dh,10			; moves to row near the middle of the screen
   call   Gotoxy		; places the cursor near the middle of the screen
   loop POINT1			; continue to read ints until all ints are read
   popad				; pops all general registers from the stack
   ret					; Return to next instruction
ReadIntArray ENDP
END main