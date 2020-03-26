.data
	msg0: .asciiz "Programa calcula numeros de fibonacci no intervalo [a,b]\n"
	msg1: .asciiz "Digite o numero a : "
	msg2: .asciiz "Digite o numero b : "
	msg3: .asciiz "Intervalo escolhido: ["
	msg4: .asciiz ", "
	msg5: .asciiz "]\n"
	msg6: .asciiz " "
.text
.globl main
	
	main:
		li $v0, 4
		la $a0, msg0
		syscall
		
		li $v0, 4
		la $a0, msg1
		syscall
	
		li $v0, 5# Pede p/ ler inteiro
		syscall  # chama para ler
		
		la  $t1, 0($v0)  # carrega o inteiro lido em $t1

		li $v0, 4
		la $a0, msg2
		syscall
	
		li $v0, 5# Pede p/ ler inteiro
		syscall  # chama para ler
		
		la  $t2, 0($v0)  # carrega o inteiro lido em $t2
		
		
		# Imprime msg3
		li $v0, 4
		la $a0, msg3
		syscall

		#imprime a
		li $v0, 1	# código para imprimir um inteiro
		la $a0, ($t1)	# avisa para imprimir
		syscall		# executa a chamado do SO para imprimir
		
		# Imprime msg4
		li $v0, 4
		la $a0, msg4
		syscall
		
		#imprime b
		li $v0, 1	# código para imprimir um inteiro
		la $a0, ($t2)	# avisa para imprimir
		syscall		# executa a chamado do SO para imprimir
		
		# Imprime msg5
		li $v0, 4
		la $a0, msg5
		syscall 
		
		
		#int fib0 = 0;
		li $t3, 0
		
		#int fib1 = 1; 
		li $t4, 1
		
		#int aux = 0; 
		li $t5, 0
		
		fibo_loop:
		blt $t2, $t4, end_fibo_loop # se b > fib0 o laço acaba
	
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
			la $a0, msg6
			syscall
			j fibo_loop # Volta ao topo
			
		end_fibo_loop:
		li $v0, 10	# código para encerrar o programa
		syscall		# executa a chamada do SO para encerrar
