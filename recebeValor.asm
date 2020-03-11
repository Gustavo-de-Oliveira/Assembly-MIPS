.data
	msg: .asciiz "Digite um número"
.text
.globl main
	
	main:
		li $v0, 4
		la $a0, msg
		syscall
	
		li $v0, 5# Pede p/ ler inteiro
		syscall  # chama para ler
		
		la  $t1, 0($v0)  # carrega o inteiro lido em $t1

		li $v0, 1	# código para imprimir um inteiro
		la $a0, ($t1)	# avisa para imprimir
		syscall		# executa a chamado do SO para imprimir

		li $v0, 10	# código para encerrar o programa
		syscall		# executa a chamada do SO para encerrar