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

    [bits 32]
start_prot_mode:
    mox ax, DATA_SEG32
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

end:
    hlt
    jmp end

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
    
stage2_msg: db "Hello from stage2", 13, 10, 0

%include "include/gdt32.s"