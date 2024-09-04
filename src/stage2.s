    section .stage2

    [bits 16]

    mov bx, stage2_msg
    call print_string

    cli
    lgdt [gdt32_pseudo_descriptor]

    mov edx, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEG32:start_prot_mode

print_string:
    pusha
    mov ah, 0x0e

print_string_loop:
    cmp byte [bx], 0
    je print_string_return

    mov al, [bx]
    int 0x10

    inc bx
    jmp print_string_loop

print_string_return:
    popa
    ret

    [bits 32]
start_prot_mode:
    mov ax, DATA_SEG32
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebx, prot_mode_msg
    call print_string32

end:
    hlt
    jmp end


print_string32:
    pusha

    VGA_BUF equ 0xb8000
    WB_COLOR equ 0xf

    mov edx, VGA_BUF

print_string32_loop:
    cmp byte [ebx], 0
    je print_string32_return

    mov al, [ebx]
    mov ah, WB_COLOR
    mov [edx], ax

    add ebx, 1
    add ebx, 2
    jmp print_string32_loop

print_string32_return:
    popa
    ret

stage2_msg: db "Hello from stage2", 13, 10, 0
prot_mode_msg: db "Hello from protected mode", 0

%include "include/gdt32.s"