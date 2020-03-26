.data
menuInicial:  .asciiz "\nDigite sua primeira opção(M|C):  " 
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
strTab: .asciiz "\n Está é uma operação de Tabuada: "
strFibo: .asciiz "\n Está é uma operação de Fibonacci: "
strErrorDiv: .asciiz "\nNão pode dividir por 0 !"
strErrorRaiz: .asciiz "Número < 0 !"
msg: .asciiz " "
msgTb1: .asciiz " * "
msgTb2: .asciiz " = "
msgTb3: .asciiz "\n"

n0: .float 0.0
n1: .float 1.0
n11: .float 11.0

.text
.globl main

main:
 	 
 	# MENU inicial #################################################
 	MENU_INICIAL:
 	la $a0, menuInicial #primeiro menu
 	jal printStr 
 	jal leitura1char #retorna o char lido em t1
 	
 	la $a0, str1 # print opção escolhida
 	jal printStr 
 	move $a0, $t1 #move de volta o char para A0
 	jal printChar # print do CHAR digitado
 	
 	
 	# MENU 1 #################################################
 	MENU_OPERACAO:
 	la $a0, menu1 # Primeiro Menu
 	jal printStr 
 	jal leitura1char #retorna o char lido em t1
 		
 	la $a0, str1 # print opção escolhida
 	jal printStr 
 	move $a0, $t1 #move o que esta em T1 para A0
 	jal printChar # print do CHAR digitado
 	
 	jal ifMenu1 # print do CHAR digitado
 	
 	j FIM
 	

#Podemos comparar o valor de $v0 com algum caracter


ifMenu1:
	beq $t1, '+', ADICAO
	beq $t1, '-', SUBTRACAO
	beq $t1, '/', DIVISAO
	beq $t1, '*', MUTIPLICACAO
	beq $t1, 'R', RAIZ
	beq $t1, 'P', POTENCIA
	beq $t1, 'F', FATORIAL
	beq $t1, 'T', TABUADA
	beq $t1, 'I', FIBONACCI
	beq $t1, 'X', FIM
	beq $t1, 'V', MENU_INICIAL
	
	j FIM
	
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
	
	j MENU_INICIAL
		
	
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
	
	j MENU_INICIAL
	
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
	
	j MENU_INICIAL
	
	
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
		
			#Se t2 não for 0
		
			c.eq.s $f2, $f8	
		bc1f loop_potencia

	fimPotencia:
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j MENU_INICIAL
	
	
errorDiv:
	la $a0, strErrorDiv
	jal printStr
	j DIVISAO
	
	
MUTIPLICACAO:
	la $a0, strMultiplicacao 
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
	
	mul.s $f3, $f1, $f2
	
	la $a0, strResultado
	jal printStr
	jal printFloat
	
	j MENU_INICIAL
	
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
	
	j MENU_INICIAL
		
	
errorRaiz:
	la $a0, strErrorRaiz
	jal printStr
	j MENU_OPERACAO
	
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
		
	j MENU_INICIAL
	
	
TABUADA:
	la $a0, strTab # operação de tabuada
	jal printStr # print	
	
	
	la $a0, strN1
	jal printStr

	#leitura primeiro num
	jal leituraFloat
	mov.s $f1, $f0
	
	lwc1 $f6, n1
	loop_tab:
		mul.s $f3, $f2, $f1
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f1
		syscall
		
		# Bloco para imprissão de uma string
		la $a0,msgTb1
		jal printStr
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f2
		syscall
		
		# Bloco para imprissão de uma string
		la $a0,msgTb2
		jal printStr
	
		# Bloco para impressão de um float
		jal printFloat
		
		# Bloco para imprissão de uma string
		la $a0,msgTb3
		jal printStr
		
		add.s $f2, $f2, $f6

		lwc1 $f7, n11
		c.eq.s $f2, $f7
		bc1f loop_tab
		
	j MENU_INICIAL

FIBONACCI:
	li $v0, 4
		la $a0, strFibo
		syscall
		
		li $v0, 4
		la $a0, strN1
		syscall
	
		li $v0, 5# Pede p/ ler inteiro
		syscall  # chama para ler
		
		la  $t1, 0($v0)  # carrega o inteiro lido em $t1

		li $v0, 4
		la $a0, strN2
		syscall
	
		li $v0, 5# Pede p/ ler inteiro
		syscall  # chama para ler
		
		la  $t2, 0($v0)  # carrega o inteiro lido em $t2
		
		#int fib0 = 0;
		li $t3, 0
		
		#int fib1 = 1; 
		li $t4, 1
		
		#int aux = 0; 
		li $t5, 0
		
		fibo_loop:
		blt $t2, $t4, MENU_INICIAL # se b > fib0 o laço acaba
	
		la $t5, ($t4)     # aux = fib1
		add $t4, $t4, $t3 # fib1 = fib1 + fib0
		la $t3, ($t5)     # fib0 = aux
	
		bge $t3, $t1, if 
	
		j fibo_loop # jump back to the top

		if:
			#imprime fib0
			li $v0, 1	# código para imprimir um inteiro
			la $a0, ($t3)	# avisa para imprimir
			syscall		# executa a chamado do SO para imprimir
			li $v0, 4
			la $a0, msg
			syscall
			j fibo_loop # Volta ao topo
			

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
	
FIM:
	li $v0, 10
	syscall
	
	
