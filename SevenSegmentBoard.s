#Nome: José Renato Coutinho, RA: 238012

.data
numeros: .word 0b00111111, 0b110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01100111

.text
main:
addi sp, sp, -16
sw s0, 0(sp)
sw s1, 4(sp)
sw s2, 8(sp)
sw s3, 12(sp)

li s0, 99 
li s1, 0b01
li s2, 0b10
li s3, 4

la a3, numeros
mv a4, a3
li a5, -1

li a0, 0x122
ecall
beq a0, s1, decrementando
beq a0, s2, contando

contando:
li a0, 0x122
ecall
beq a0, s1, decrementando

li a1, 0b01
li a0, 0x121
ecall
beq a5, s0, recomeco_crescente
addi a5, a5, 1
call escreve_numero
li a0, 1000
call pausa
j contando

decrementando:
li a0, 0x122
ecall
beq a0, s2, contando

li a1, 0b10
li a0, 0x121
ecall

beq a5, zero, recomeco_decrescente
addi a5, a5, -1
call escreve_numero
li a0, 1000
call pausa
j decrementando

pausa:
addi a0, a0, -1
bne a0, zero, pausa
ret

escreve_numero:
mv a3, a4
#o parametro contendo o numero sera a5
#Primeiro guarda a unidade depois a dezena
add t1, zero, a5
li t2, 10
#valor da unidade guardado em t3
rem t3, t1, t2
mv t6, t3
mul t3, t3, s3
add a3, a3, t3
lw t4, 0(a3)
#voltando vetor pra posicao inicial
mv a3, a4
#valor da dezena guardado em t3 novamente
sub t1, t1, t6
div t3, t1, t2
mul t3, t3, s3
add a3, a3, t3
lw t5, 0(a3)
slli t5, t5, 8
or a1, t5, t4

li a0, 0x120
li a2, -1
ecall
ret

fim:
addi a0, zero, 10
ecall   # Encerra a execução do programa

recomeco_crescente:
li a5, -1
j contando

recomeco_decrescente:
li a5, 100
j decrementando




