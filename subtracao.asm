.data
	msg1: .asciiz "Digite um número: "
	msg2: .asciiz "Digite um número: "
	msg3: .asciiz "O resultado é: "
	
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
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg3
		syscall

		# Subtracao	
		sub $t3, $t1, $t2
	
		# Bloco para impressão de um inteiro
		li $v0, 1
		la $a0, ($t3)
		syscall
	
		# Bloco de fim
		li $v0, 10
		syscall