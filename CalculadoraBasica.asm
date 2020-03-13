.data
	msg1: .asciiz "Digite um número: "
	msg2: .asciiz "Digite um número: "
	msg3: .asciiz "\nDigite o valor da operação:\n1-Soma\n2-Subtração\n3- Multiplicação\n4- Divisão\n5- Potencia\n6- Raiz Quadrada\n7- Tabuada\n8- Fatorial\n9- Fibonacci\n10- Sair\n"
	msg4: .asciiz "O resultado é: "
	msgTb1: .asciiz " * "
	msgTb2: .asciiz " = "
	msgTb3: .asciiz "\n"
	
	msgErroDiv: .asciiz "Não pode-se realizar divisão por 0\n"
	
.text
.globl main
	main:
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg3
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t3, 0($v0)
		
		beq $t3, 10, sair
		
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg1
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t1, 0($v0)
		
		# Os que recebem apenas um número vem primeiro, pois receberão nas suas "funções"
		beq $t3, 6, raiz
		beq $t3, 7, tabuada
		beq $t3, 8, fatorial
		beq $t3, 9, fibonacci
	
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg2
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t2, 0($v0)
		li $t4, 1
		
		beq $t3, 1, soma
		beq $t3, 2, subtracao
		beq $t3, 3, multiplicacao
		beq $t3, 4, divisao
		beq $t3, 5, potencia
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
		
	soma:
		# Soma	
		add $t3, $t1, $t2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
		
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		jal main
	
	subtracao:
		# Subtracao	
		sub $t3, $t1, $t2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		jal main
	
	divisao:
		# divisao
		beq $t2, 0, erroDiv
		div $t3, $t1, $t2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		jal main
	
	multiplicacao:
		# multiplicacao	
		mul $t3, $t1, $t2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		jal main
	potencia:
		# multiplicacao	
		mul $t4, $t4, $t1
		
		# Subtracao	
		sub $t2, $t2, 1
		
		#Se t2 for 0
		bne $t2, 0, potencia
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t4)
		syscall
		
		jal main
		
	raiz:
	
	tabuada:	
		mul $t3, $t2, $t1
		
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t1)
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb1
		syscall
		
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t2)
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb2
		syscall
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb3
		syscall
		
		add $t2, $t2, 1
		bne $t2, 11, tabuada
		
		jal main
	
	fatorial:
		sub $t2, $t1, 1
		mul $t3, $t2, $t1
			loop:
				sub $t2, $t2, 1
				mul $t3, $t3, $t2
				bne $t2, 1, loop
		
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
		
		jal main
	
	fibonacci:
	
	sair:
		# Bloco de fim
		li $v0, 10
		syscall
		
	erroDiv:
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msgErroDiv
		syscall
	
		jal main
		
