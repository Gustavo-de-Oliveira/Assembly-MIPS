.data
	msg1: .asciiz "Digite um n�mero: "
	msg2: .asciiz "Digite um n�mero: "
	msg3: .asciiz "O resultado �: "
	
.text
.globl main
	main:
		# Bloco para impress�o de uma string
		li $v0, 4
		la $a0, msg1
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t1, 0($v0)
	
		# Bloco para impress�o de uma string
		li $v0, 4
		la $a0, msg2
		syscall
	
		# Bloco para receber um inteiro
		li $v0, 5
		syscall
		la $t2, 0($v0)
	
		# Bloco para impriss�o de uma string
		li $v0, 4
		la $a0, msg3
		syscall

		# Subtracao	
		sub $t3, $t1, $t2
	
		# Bloco para impress�o de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall