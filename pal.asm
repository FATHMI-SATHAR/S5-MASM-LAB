data segment
        msg1 db 0ah,09h,"Enter the string: $"
        msg2 db 0ah,09h,"is a palindome $"
        msg3 db 0ah,09h,"is not a palindrome $"
        n db 09h dup(?)
data ends
code segment
        assume cs:code,ds:data
        start: mov ax,data
               mov ds,ax
               
               mov si,offset n
               mov di,offset n
               
               lea dx,msg1
               mov ah,09h
               int 21h
               
               mov cl,00h
               
         scan: mov ah,01h
               int 21h
               cmp al,0dh
               jz ended
               mov [si],al
               inc cl
               inc si
               jmp scan
               
        ended: dec si
               mov bl,[si]
               cmp [di],bl
               jnz notpalin
               inc di
               dec cl
               jnz ended
        palin:
               lea dx,msg2
               mov ah,09h
               int 21h
               jmp stop
      notpalin:
               lea dx,msg3
               mov ah,09h
               int 21h
         stop:
               mov ah,4ch
               int 21h
code ends
end start
               
                               
                      
              
               
