.686
.model flat,stdcall
.stack 100h
.data
	;X dw 0FC6Ah
	;Y dw 0F639h
	Z dw 6132h
	M dw ?
	R dw ?
	L dw ?;
	W dw ?;
	K dw ?;
	ans dw ?
	tmp1 dw ? ; X'
	tmp2 dw ? ; Y'
	tmp3 dw ? ; Z'
	tmp4 dw ? ; Q'
	arr dw 00F00h, 0F639h
	array dw 60961, 17049, 38212, 21594
.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov eax, 0
mov ebx, 0

mov ecx, 1
a1:
mov ax, array[0]; x'
SUB ax,1
mov tmp1, ax
mov array[0], ax

mov ax, 0

mov ax, array[2]; y'
SUB ax,1
mov tmp2, ax
mov array[2],ax

mov ax, 0

mov ax, array[4]; z'
SUB ax,1
mov tmp3, ax
mov array[4], ax


mov ax, 0

mov ax, array[6]; q'
SUB ax,1
mov tmp4, ax
mov array[6], ax

mov ax, 0

loop a1


; Task 2
; Calc M
mov ax, tmp1
and ax, tmp3 ; X' & Z'
mov bx, tmp2
xor bx, tmp4 ; Y' xor Q'
or ax, bx
mov M, ax
; Comparison
cmp M, 0
jl P1 ; -
jmp P2 ;+

P1:
	mov dx, 0
	mov ax, M
	mov bx, 2
	idiv bx
	add ax, 1344
	mov R, ax
	jmp T3
P2:
	mov ax, M
	mov bx,2
	mul bx
	sub ax, 2348
	mov R, ax
	jmp T3

; Task 3
T3:
	cmp R, 12728
	jle L3 ; >
	jmp L2 ; <
L2:
	call fun_1
	jmp exit
L3:
	call fun_2
	jmp exit

fun_1:
	mov ax, R
	mov bx, 8731
	add ax, bx
	mov ans, ax
	ret

fun_2:
	mov ax, R
	xor ax, 37180
	mov ans, ax
	ret

exit:
Invoke ExitProcess,1
End Start
