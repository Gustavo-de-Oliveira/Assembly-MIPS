.data
	msg1: .asciiz "Digite um número: "
	msg2: .asciiz "Digite um número: "
	msg3: .asciiz "\nDigite o valor da operação:\n1-Soma\n2-Subtração\n3- Multiplicação\n4- Divisão\n5- Potencia\n6- Raiz Quadrada\n7- Tabuada\n8- Fatorial\n9- Fibonacci\n10- Sair\n"
	msg4: .asciiz "O resultado é: "
	msgTb1: .asciiz " * "
	msgTb2: .asciiz " = "
	msgTb3: .asciiz "\n"
	
	n1: .float 1.0
	n0: .float 0.0
	n11: .float 11.0	
	
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
	
		# Bloco para receber um float
		li $v0, 6
		syscall
		mov.s $f1, $f0
		
		# Os que recebem apenas um número vem primeiro, pois receberão nas suas "funções"
		beq $t3, 6, raiz
		lwc1 $f6, n1
		beq $t3, 7, tabuada
		lwc1 $f6, n1
		beq $t3, 8, fatorial
		beq $t3, 9, fibonacci
	
		# Bloco para impressão de uma string
		li $v0, 4
		la $a0, msg2
		syscall
	
		# Bloco para receber um float
		li $v0, 6
		syscall
		mov.s $f2, $f0
		
		beq $t3, 1, soma
		beq $t3, 2, subtracao
		beq $t3, 3, multiplicacao
		beq $t3, 4, divisao
		lwc1 $f6, n1
		beq $t3, 5, potencia
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
		
	soma:
		# Soma	
		add.s $f3, $f1, $f2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		jal main
	
	subtracao:
		# Subtracao	
		sub.s $f3, $f1, $f2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		jal main
	
	divisao:
		# divisao
		lwc1 $f7, n0
		c.eq.s $f2, $f7
		bc1t erroDiv
		
		div.s $f3, $f1, $f2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		jal main
	
	multiplicacao:
		# multiplicacao	
		mul.s $f3, $f1, $f2
	
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		jal main
	potencia:
		# multiplicacao	
		mul.s $f6, $f6, $f1
		
		# Subtracao
		lwc1 $f7, n1
		sub.s $f2, $f2, $f7
		
		#Se t2 não for 0
		lwc1 $f8, n0
		c.eq.s $f2, $f8
		bc1f potencia
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f6
		syscall
		
		jal main
		
	raiz:
		# Calcula a raiz quadrada do conteudo de $f4
		sqrt.s $f2, $f1
		
		# Bloco para imprimir mensagem
		li $v0, 4
		la $a0, msg4
		syscall
	
		# Bloco para imprimir raiz (float)
		li $v0, 2
		mov.d $f12, $f2
		syscall	
		
		jal main
	
	tabuada:	
		mul.s $f3, $f2, $f1
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f1
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb1
		syscall
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f2
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb2
		syscall
	
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		# Bloco para imprissão de uma string
		li $v0, 4
		la $a0, msgTb3
		syscall
		
		add.s $f2, $f2, $f6

		lwc1 $f7, n11
		c.eq.s $f2, $f7
		bc1f tabuada
		
		jal main
	
	fatorial:
		sub.s $f2, $f1, $f6
		mul.s $f3, $f2, $f1
			loop:
				sub.s $f2, $f2, $f6
				mul.s $f3, $f3, $f2
				
				lwc1 $f7, n1
				c.eq.s $f2, $f7
				bc1f loop
		
		# Bloco para impressão de um float
		li $v0, 2
		mov.s $f12, $f3
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
		
