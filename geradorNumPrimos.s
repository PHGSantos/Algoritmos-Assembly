##################################################
# Gerador de n�meros primos
#
# Alunos:
# 	Camile
# 	Pedro Henrique Gomes
# 	Sarah Pereira
##################################################

.equ limite_inferior, r12
.equ dividendo, r11
.equ divisor, r6
.equ resto, r7
.equ metade_dividendo, r8
.equ dois, r9
.equ espaco, r20 #32
.equ enter,  r19 #10

.data
	

.text



main:


	inicializacao:
		add dividendo,r0,r6				#Guarda o limite superior em r3
		#addi limite_inferior,r0,2			#Guarda o limite inferior em r2
		addi dois, r0,2
		add divisor,r0, dois 				#Inicia o divisor em 2
		div metade_dividendo, dividendo, dois		#Pega a metade do dividendo
	
	verifica_se_primo:
	
		div resto,dividendo,divisor		#Pega o quociente da divisao
		mul resto,resto,divisor			#Multiplica o quociente da divis�o pelo divisor
		sub resto,dividendo,resto		#Subtrai o dividendo pela multiplica��o do quociente pelo divisor, para pega o valor do resto
		bne resto,r0, atualiza_divisor		#Se o resto for diferente de 0 atualiza o divisor
		br atualizar_dividendo			#O n�mero n�o � primo, atualiza do dividendo
		
		
	atualiza_divisor:
		addi divisor, divisor, 1				#Aumenta dividor
		bgt metade_dividendo, divisor, verifica_se_primo		#Verifica se o divisor � menor ou igual a metade do dividendo
									#OBS: UM N�MERO N�O � DIVISIVEL POR N�MEROS MAIOR QUE SUA METADE
						

		#bgt dividendo,divisor, verifica_se_primo #Verifica se o dividendo � maior que o divisor/contado
		
		br impressao
		
	impressao: 
		mov r4, dividendo
		movia r15,UART0	
		call nr_uart_txhex
		
		movi r4, 0x2C
		movia r15,UART0	
		call nr_uart_txchar
		
		
		call atualizar_dividendo					#Atualiza do dividendo
	
	
	atualizar_dividendo:

		addi dividendo,dividendo, -1				#Diminui o dividendo
		beq dividendo, dois, impressao
		
		addi divisor,r0,2					#Reseta o divisor
		div metade_dividendo, dividendo,dois			#Atualiza a metade do dividendo
		
		bgt dois, dividendo, fim
		bgt dividendo,limite_inferior,verifica_se_primo		#Se o dividendo � maior que o limite inferior, continua a busca por mais n�meros primos
	
	
	
	fim:
		.end
		
		
	
	
