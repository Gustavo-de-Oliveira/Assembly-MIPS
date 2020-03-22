.data
menuInicial:  .asciiz "Digite sua primeira opção(M|C):  " 
str1:  .asciiz "\nOpção Escolhida (M|C):  " 
menu1:  .asciiz "\nDigite a operação:  "
strN1: .asciiz "\nDigite o primeiro numero: "
strN2: .asciiz "Digite o segundo numero: "
strResultado: .asciiz "O resultado: "


teste:  .asciiz " STRING DE TESTE !"
strAdicao:  .asciiz "\nEstá é uma operação de soma !"
strPotencia:  .asciiz "\nEstá é uma operação de potencia !"
strSubtracao:  .asciiz "\nEstá é uma operação de subtração !"
strDivisao:  .asciiz "\nEstá é uma operação de divisao !"
strMultiplicacao: .asciiz "\nEstá é uma operação de multiplicação !"
strRaiz: .asciiz "\n Está é uma operação de Raiz: "
strFat: .asciiz "\n Está é uma operação de Fatorial: "
strErrorDiv: .asciiz "\nNão pode dividir por 0 !"
strErrorRaiz: .asciiz "Número < 0 !"


n0: .float 0.0
n1: .float 1.0

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
	beq $t1, 'R', RAIZ
	beq $t1, 'P', POTENCIA
	beq $t1, 'F', FATORIAL
	
	j fim 
	
ADICAO: 
	la $a0, strAdicao # operação de soma
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	la $a0, strN2
	jal printStr
	
	#leitura segundo num
	jal leituraFloat
	mov.s $f2, $f0
	add.s $f3, $f1, $f2
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j fim
		
	
SUBTRACAO: 
	la $a0, strSubtracao # operação de soma
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	la $a0, strN2
	jal printStr
	
	#leitura segundo num
	jal leituraFloat
	mov.s $f2, $f0
	sub.s $f3, $f1, $f2
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j fim
	
DIVISAO: 
	la $a0, strDivisao # operação de soma
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	la $a0, strN2
	jal printStr
	
	#leitura segundo num
	jal leituraFloat
	mov.s $f2, $f0
	
	lwc1 $f8, n0
	c.eq.s $f2, $f8
	bc1t  errorDiv
	
	div.s $f3, $f1, $f2
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j fim
	
	
POTENCIA: 
	la $a0, strPotencia # operação de soma
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	la $a0, strN2
	jal printStr
	
	#leitura segundo num
	jal leituraFloat
	mov.s $f2, $f0
	
	
	
		
	lwc1 $f3, n1
	lwc1 $f7, n1
	lwc1 $f8, n0
	
	
	c.eq.s $f2, $f8	
	bc1t fimPotencia
	

		loop_potencia:
			# multiplicacao	
			mul.s $f3, $f3, $f1 #f3 -> 2 * 2 * 2
			sub.s $f2, $f2, $f7 #f2 ->  0
		
			#Se t2 n�o for 0
		
			c.eq.s $f2, $f8	
		bc1f loop_potencia

	fimPotencia:
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j fim
	
	
errorDiv:
	la $a0, strErrorDiv
	jal printStr
	j fim
	
	
MUTIPLICACAO:
	la $a0, strMultiplicacao 
	jal printStr # print
	j fim
	
RAIZ: 
	la $a0, strRaiz # operação de soma
	jal printStr # print	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	#if (F1 < 0)
	lwc1 $f7, n0
	c.lt.s $f1, $f7
	bc1t  errorRaiz
	
	sqrt.s $f3, $f1	
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j fim
	
FATORIAL:
	la $a0, strFat # operação de fatorial
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr
	
	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0

	lwc1 $f6, n1
	sub.s $f2, $f1, $f6
	mul.s $f3, $f2, $f1
			loop:
				sub.s $f2, $f2, $f6
				mul.s $f3, $f3, $f2
				
				lwc1 $f7, n1
				c.eq.s $f2, $f7
				bc1f loop
		
		
	la $a0, strResultado
	jal printStr
	jal printFloat
		
	j fim
	
errorRaiz:
	la $a0, strErrorRaiz
	jal printStr
	j fim
	

leitura1char:
	li $v0, 12 # 8 -> leitura de caracter syscall
 	syscall
 	move $t1, $v0 #move de volta o char para A0
 	jr $ra 
 
#leitura de float no $F0
leituraFloat:
	li $v0, 6
 	syscall
 	jr $ra 
 	
 #print do que tem no registrador $F12	
printFloat:
	mov.s $f12, $f3
	li $v0, 2
	syscall 
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
	
	
