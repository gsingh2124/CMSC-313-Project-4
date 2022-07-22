;Gurjinder Singh
;Dinora Blanco
;CMSC313 Project 4
;Spring 2022
;main.asm
;This program is a blend of c and assembly and pain

 
    
    
    section .data

    ;Array indexes
message0 db "This is the original message.", 10, 0
message1 db "This is the original message.", 10, 0
message2 db "This is the original message.", 10, 0
message3 db "This is the original message.", 10, 0
message4 db "This is the original message.", 10, 0
message5 db "This is the original message.", 10, 0
message6 db "This is the original message.", 10, 0
message7 db "This is the original message.", 10, 0
message8 db "This is the original message.", 10, 0
message9 db "This is the original message.", 10, 0

    ;array declaration
array:
    dq message0
    dq message1
    dq message2
    dq message3
    dq message4
    dq message5
    dq message6
    dq message7
    dq message8
    dq message9

    ;printf formats

format_num: db "%d", 0

format_char: db "%c", 0

format_string: db "%s", 0
    ;-Menu messages-

prompt_program_name: db 10,"Encryption menu options: ", 10
len_pn equ $ - prompt_program_name

prompt_s: db "s - show current messages ", 10
len_s equ $ - prompt_s

prompt_r: db "r - read new message ", 10
len_r equ $ - prompt_r

prompt_c: db "c - caesar cipher ", 10
len_c equ $ - prompt_c

prompt_f: db "f - frequency decrypt ", 10
len_f equ $ - prompt_f

prompt_q: db "q - quit program ", 10
len_q equ $ - prompt_q

prompt_user_menu_input: db "enter option letter -> ", 0
len_umi equ $ - prompt_user_menu_input

prompt_invalid_input: db "invalid option, try again", 10
len_ii equ $ - prompt_invalid_input

    ;-read new message messages-

prompt_r_new_message: db "Enter new message: ", 0
len_rnm equ $ - prompt_r_new_message

prompt_r_invalid_message: db "invalid message, keeping current", 10
len_rim equ $ - prompt_r_invalid_message

    ;-caesar cipher messages-

prompt_c_DNF: db "Not implemented :(", 10
len_cDNF equ $ - prompt_c_DNF

    ;-frequency decrypt messages-

prompt_f_input: db "Enter string location: ", 0
len_fi equ $ - prompt_f_input

    ;-quit message-

prompt_q_message: db "Goodye!", 10
len_qm equ $ - prompt_q_message


    ;-EE-
prompt_EE: db "There is no easter egg, only pain. Why assembly...WHY.", 10
len_EE equ $ - prompt_EE

    section .bss
counter     resb 1
menu_in     resb 1

    ;used for keeping track of array pointer

    ;assign label array to store all message addresses

    section .text

    global main

    ;imports
;extern printf
;extern scanf
extern printArray
extern putMessage
extern freeup
extern getchar
extern fflush

main:
    
        xor r8, r8
        xor rax, rax
        ;initilize array pointers
        ;mov rdi, format_string
        ;mov rsi, [stringarr0]
        ;mov rax, 0
        ;call printf
        ;main menu code
        ;call print_menu
        call print_menu
        ret

print_menu:
        ;implement menu printing
        ;program prompt

    mov     rax, 1              
    mov     rdi, 1
    mov     rsi, prompt_program_name
    mov     rdx, len_pn
    syscall

    mov     rax, 1              
    mov     rdi, 1
    mov     rsi, prompt_s
    mov     rdx, len_s
    syscall

    mov     rax, 1              
    mov     rdi, 1
    mov     rsi, prompt_r
    mov     rdx, len_r
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_c
    mov     rdx, len_c
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_f
    mov     rdx, len_f
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_q
    mov     rdx, len_q
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_user_menu_input
    mov     rdx, len_umi
    syscall

    jmp get_user_input


get_user_input:
    ;implement getting user input
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, menu_in
    mov     rdx, 1
    syscall

    mov    rax, menu_in
    ;call getchar

    jmp check_user_input


check_user_input:
    ;implement checking user input
    ;redirects based on correct input
    cmp [rax], BYTE'z'
    inc r9
    cmp [rax], BYTE's'
    je call_s
    cmp [rax], BYTE'r'
    je call_r
    cmp [rax], BYTE'c'
    je call_c
    cmp [rax], BYTE'f'
    je call_f
    cmp [rax], BYTE'q'
    cmp r9, 4
    je ee
    je call_q
    jne invalid_input

    xor rax, rax

    jmp print_menu

ee:     ;easter egg that wont work due to assembly gods
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_EE
    mov     rdx, len_EE
    syscall


inc_ee: ;increments counter for ee
    inc r9


reset_ee:;resets ee counter
    xor r9, r9


invalid_input:
        ;Lets user know they entered an invalid input
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_invalid_input
    mov     rdx, len_ii
    syscall
        ;reset user input for safety
    xor rax, rax
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx

    jmp print_menu


call_c:
    ;call caesar cipher that doesnt exist
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_c_DNF
    mov     rdx, len_cDNF
    syscall

    jmp print_menu



call_f:
    ;call frequency decrypt
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_f_input
    mov     rdx, len_fi
    syscall

    jmp print_menu




call_q:
    ;call quit routine
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt_q_message
    mov     rdx, len_qm
    syscall

    jmp exit


exit:
    ;exit program
    call freeup
    mov     rax, 60
    xor     rdi, rdi
    syscall

call_r:
    call clear_in
        ;uses r8 to keep track of where to store new message
        ;passes array and index to putMessage
        ;gets user input, WIP need to validate input
    mov rdi, [array]
    mov rsi, r8
    call putMessage
        ;check to see if user input is valid to increment counter
    cmp rax, 1
    je inc_counter

    jmp print_menu


    ;increment counter for next message to stor
inc_counter:
    inc r8


    ;prints all elements of array
call_s:
    mov rdi, array
    call printArray

    xor rax, rax

    jmp print_menu

clear_in:
    ;clears registers
    xor rax, rax
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
