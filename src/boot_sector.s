    section .boot_sector
    global __start

    [bits 16]

__start:
    mov bx, hello_msg
    call print_string

    mov si, disk_address_packet
    mov ah, 0x42
    mov dl, 0x80
    int 0x13
    jc error_reading_disk

ignore_disk_read_error:
    SND_STAGE_ADDR equ (BOOT_LOAD_ADDR + SECTOR_SIZE)
    jmp 0:SND_STAGE_ADDR

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

hello_msg: db "Hello, world!", 0
