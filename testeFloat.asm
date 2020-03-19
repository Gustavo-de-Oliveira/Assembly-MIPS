.text
.globl main
	main:
		# Bloco para receber um float
		li $v0, 6 # Avisa que será a leitura de um float
		syscall
		mov.s $f2, $f0 # Move o float lido de f0 para f2
		
		# Bloco para impressão de um float
		li $v0, 2 # Avisa que imprimirá um float
		mov.s $f12, $f2 # Move de f2, para f12, onde será printado
		syscall