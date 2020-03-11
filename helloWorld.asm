.data
	msg: .asciiz "Hello World" #Comando para criar string
	
.text
	li $v0, 4 #Avisa que quer printar uma string
	la $a0, msg #Diz qual printar
	syscall #Manda fazer
	
	li $v0, 10 #Avisa que quer finalizar
	syscall
	