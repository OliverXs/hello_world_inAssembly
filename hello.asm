NULL              EQU 0                         
STD_OUTPUT_HANDLE EQU -11

extern GetStdHandle                            
extern WriteFile                                
extern ExitProcess

global Start                                   

section .data                                   
 Message        db "Hello World!!", 0 
 MessageLength  EQU $-Message                   

section .bss                                    
alignb 8
 StandardHandle resq 1
 Written        resq 1

section .text                                   
Start:
 sub   RSP, 8                                  

 sub   RSP, 15                                  
 mov   ECX, STD_OUTPUT_HANDLE
 call  GetStdHandle
 mov   qword [REL StandardHandle], RAX
 add   RSP, 15                                 

 sub   RSP, 15 + 8 + 8                          
                                                
 mov   RCX, qword [REL StandardHandle]          
 lea   RDX, [REL Message]                      
 mov   R8, MessageLength                       
 lea   R9, [REL Written]                       
 mov   qword [RSP + 4 * 8], NULL               
 call  WriteFile                               
 add   RSP, 31                                 
 xor   ECX, ECX
 call  ExitProcess
