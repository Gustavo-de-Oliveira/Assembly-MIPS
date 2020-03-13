.data
	msg1: .asciiz "Digite um número: "
	msg2: .asciiz "Digite um número: "
	msg3: .asciiz "Digite o valor da operação que quer realizar. 1-Soma, 2-Subtração, 3- Multiplicação, 4- Divisão: "
	msg4: .asciiz "O resultado é: "
	msgErroDiv: .asciiz "Não pode-se realizar divisão por 0"
	
.text
.globl main
	main:
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg1
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t1, 0($v0)
	
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg2
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t2, 0($v0)
	
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg3
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t3, 0($v0)
		
		beq $t3, 1, soma
		beq $t3, 2, subtracao
		beq $t3, 3, multiplicacao
		beq $t3, 4, divisao
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
		
	soma:
		# Soma	
		add $t3, $t1, $t2
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall
	
	subtracao:
		# Subtracao	
		sub $t3, $t1, $t2
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall
	
	divisao:
		# divisao
		beq $t2, 0, erroDiv
		div $t3, $t1, $t2
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall
	
	multiplicacao:
		# multiplicacao	
		mul $t3, $t1, $t2
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall
		
	erroDiv:
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msgErroDiv
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall
		