; LAB 4
; NATHAN YOUNG
; 4 MAY 2016 --- MAY THE FOURTH BE WITH YOU

INCLUDE Irvine32.inc                                
.data
PrintAnd		BYTE " and ",0					; Prints dialog
PrintMessage	BYTE " have a GCD of: ",0		; Prints dialog
PrintEndLine	BYTE " ",0dh,0ah,0				; Prints end of line
value1 DWORD 0									; Integer for GCD
value2 DWORD 0									; Integer for GCD
.code  
main PROC
mov value1, 1024								; first value to find GCD
mov value2, 32									; second value to find GCD
call DisplayGCD									; Calls DisplayGCD
call GCD										; Calls GCD
mov value1, 541									; first value to find GCD
mov value2, 24									; second value to find GCD
call DisplayGCD									; Calls DisplayGCD
call GCD										; Calls GCD
call Waitmsg
exit											; halts program
main ENDP										; end main
;----------------------------------------------------------
DisplayGCD PROC
mov eax, 0										; zeroes eax
mov edx, 0										; zeroes edx
mov eax, value1									; prepares to print integer
call WriteDec									; prints value1
mov edx, OFFSET PrintAnd						; prints "and"
call WriteString								; prints "and"
mov eax, value2									; prepares to print integer
call WriteDec									; prints value2
mov edx, OFFSET PrintMessage					; prints the message
call WriteString								; prints the message
ret												; returns
DisplayGCD ENDP									; marks the ends of the main procedure
;----------------------------------------------------------
GCD PROC
mov eax, value1									; moves dividend
cdq												; convert double to quad
mov ebx, value2									; moves divisor
cmp ebx, 0										;
JE ERROR
div ebx											; divides 
LOOP1:
cmp edx, 0										; if remainder 0, GCD is found
je GCDEND										; end GCD
mov ebx,edx										; Move remainder to divisor register
mov eax,value2									; Move value 2 to dividend
mov value2,ebx									; save previous remainder
cdq												; convert double to quad
div ebx											; divides
loop LOOP1										; loops until remainder is 0
GCDEND:
mov eax, value2									; moves remainder to eax
call WriteDec									; prints GCD to screen
mov edx, OFFSET PrintEndline					; Prints end line
call WriteString								; Prints end line
ret												; returns
ERROR:
GCD ENDP
END main