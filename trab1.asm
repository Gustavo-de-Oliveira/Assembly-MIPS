.data
menuInicial:  .asciiz "Digite sua primeira opção(M|C):  " 
str1:  .asciiz "\nOpção Escolhida (M|C):  " 
menu1:  .asciiz "\nDigite a operação:  "

strAdicao:  .asciiz "\nEstá é uma operação de soma !"
strSubtracao:  .asciiz "\nEstá é uma operação de subtração !"
strDivisao:  .asciiz "\nEstá é uma operação de divisao !"
strMultiplicacao: .asciiz "\nEstá é uma operação de multiplicação !"

.text
.globl main

main:
 	 
 	# MENU inicial #################################################
 	la $a0, menuInicial #primeiro menu
 	jal printStr 
 	jal leitura1char #retorna o char lido em t1
 	
 	la $a0, str1 # print opção escolhida
 	jal printStr 
 	move $a0, $t1 #move de volta o char para A0
 	jal printChar # print do CHAR digitado
 	
 	
 	# MENU 1 #################################################
 	la $a0, menu1 # Primeiro Menu
 	jal printStr 
 	jal leitura1char #retorna o char lido em t1
 		
 	la $a0, str1 # print opção escolhida
 	jal printStr 
 	move $a0, $t1 #move o que esta em T1 para A0
 	jal printChar # print do CHAR digitado
 	
 	jal ifMenu1 # print do CHAR digitado
 	
 	j fim 
 	

#Podemos comparar o valor de $v0 com algum caracter
ifMenu1:
	beq $t1, '+', ADICAO
	beq $t1, '-', SUBTRACAO
	beq $t1, '/', DIVISAO
	beq $t1, '*', MUTIPLICACAO
	j fim 
	
ADICAO: 
	la $a0, strAdicao # Primeiro Menu
	jal printStr # print
	j fim
	
SUBTRACAO: 
	la $a0, strSubtracao # Primeiro Menu
	jal printStr # print
	j fim
	
DIVISAO: 
	la $a0, strDivisao # Primeiro Menu
	jal printStr # print
	j fim
	
MUTIPLICACAO:
	la $a0, strMultiplicacao # Primeiro Menu
	jal printStr # print
	j fim
	

leitura1char:
	li $v0, 12 # 8 -> leitura de caracter syscall
 	syscall
 	move $t1, $v0 #move de volta o char para A0
 	jr $ra 
 	
 	
 
 #print do que tem no registrador $a0	
printStr:
	li $v0, 4 
	syscall 
	jr $ra
	
 #print do que tem no registrador $a0	
printChar:
	li $v0, 11 
	syscall 
	jr $ra
	
	
#A0 -> t2
save$t2$a0:
	move $t2, $a0   
	jr $ra
	
	
# t2 -> a0	
save$a0$t2:
	move $a0, $t2   
	jr $ra
	
fim:
	li $v0, 10
	syscall
	
	
