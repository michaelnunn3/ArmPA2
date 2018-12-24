// Michael Nunn
// Programming Assignment 2
// 11/26/2018

.global _start
.section .text

_start:
// print message
mov x0, #1 // stdout
ldr x1, =message;
mov x2, #18
mov x8, #64
svc #0

// read input
mov x0, #0 // stdin
ldr x1, =strbuffer;
mov x2, #999  // read up to 999 characters
mov x8, #63 //  decimal 63 for read
svc #0 //do it!

add x1, x1, x0
mov x0, #0
strb w0, [x1]

//ASCII to I (atoi)
ldr x1, =strbuffer
mov x0, #0 //initialize counter

atoiLoop:
mov x2, #0 //preclear (all zero register)
ldrb w2, [x1] //loads ASCII byte
cmp x2, #0
beq gotNum
cmp x2, #10
beq gotNum
cmp x2, #13
beq gotNum
mov x3, #10
mul x0, x0, x3 //counter *= 10
sub x2, x2, #48 //converts ASCII byte to numeric value
add x0, x0, x2
add x1, x1, #1 //incriment x1
b atoiLoop

gotNum: //number user inputed is in x0
mov x3, #31 // loop counter counts down
ldr x1, =strbuffer
itoaLoop:
cmp x3, #-1
beq printBinary
lsr x4, x0, x3 //right shift
and x4, x4, #1 //isolates bit
add x4, x4, #48 //to ASCII
strb w4, [x1] //stores in buffer
add x1, x1, #1 //incriment buffer
sub x3, x3, #1 //dec x3
b itoaLoop
printBinary:
mov x11, x1

// print binary prompt
mov x0, #1 // stdout
ldr x1, =binaryPrompt;
mov x2, #18
mov x8, #64
svc #0

// print strbuffer
mov x0, #1 // stdout
ldr x1, =strbuffer;
sub x2, x11, x1
mov x8, #64
svc #0

// print newline
mov x0, #1 // stdout
ldr x1, =newline;
mov x2, #1
mov x8, #64
svc #0




//exit the program
mov x8, #93
mov x0, x2 // exit code
svc #0

ret

.section .data

message: .asciz "input an integer\n"
binaryPrompt: .asciz "binary equivalent\n"
newline: .asciz "\n"
strbuffer: .space 999
numbuffer: .asciz "999\n" // 3 digits, newline, null char
