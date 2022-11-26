;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       BOTÃO E LED - EX1                         *
;*												                                  *
;*       DESENVOLVIDO POR PAULO RICARDO VANZELLA                   *
;*      VERSÃO: 1.0                             DATA: 26/11/22     *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                      DESCRIÇÃO DO ARQUIVO                       *
;*-----------------------------------------------------------------*
;*  SISTEMA QUE ATIVA LEDS EM CIMA DE NOTAS MUSICAIS               *
;*  PARA TOCAR DO-RÉ-MI-FÁ.                                        *
;*                                                                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINIÇÕES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

#INCLUDE <P16F628A.INC>		;ARQUIVO PADRÃO MICROCHIP PARA 16F628A
	__CONFIG  _BODEN_ON & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _XT_OSC

; _BOREN_ON : Brown-out Reset Enable Bit (BOREN): Este bit habilita o circuito de 
;	Brown-out Reset. Este circuito é responsável por geral um sinal
;	de Reset para a CPU quando a tensão de alimentação cai abaixo de
;	um limite definido como VBOR=4,0V por um período superior a TBOR=100uS
; _CP_OFF : Code Protection Bit (CP) : Este bit é responsável por habilitar a proteção de código.
;                 	     Uma vez habilitado, a memória Flash (memória de programa)
;			     estará protegida contra cópia e não poderá ser lida.
; _PWRTE_ON : Este bit habilita o Power-up Timer. Esse circuito é responsável por manter o núcleo
;		em estado de reset por um período após o circuito ser ser alimentado (Power-up)
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINAÇÃO DE MEMÓRIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINIÇÃO DE COMANDOS DE USUÁRIO PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA

#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAMÓRIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARIÁVEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20		;ENDEREÇO INICIAL DA MEMÓRIA DE USUÁRIO
	CONTADOR1 EQU .5
	CONTADOR2 EQU .5 
	CONTADOR3 EQU .5
	CONTADOR4 EQU .5
	CONTADOR5 EQU .5
	CONTADOR6 EQU .5
	CONTADOR7 EQU .5
	CONTADOR8 EQU .5
	CONTADOR9 EQU .5
	CONTADOR10 EQU .5
	CONTADOR11 EQU .5
	CONTADOR12 EQU .5
	CONTADOR13 EQU .5
	CONTADOR14 EQU .5
	CONTADOR15 EQU .5
	CONTADOR16 EQU .5
	CONTADOR17 EQU .5
	CONTADOR18 EQU .5
	CONTADOR19 EQU .5

	ENDC			;FIM DO BLOCO DE MEMÓRIA		

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

#DEFINE	BOTAO	PORTA,2	;PORTA DO BOTÃO
			; 0 -> PRESSIONADO
			; 1 -> LIBERADO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SAÍDAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

#DEFINE	LED1	PORTB,0	;PORTA DO LED
			; 0 -> APAGADO
			; 1 -> ACESO
#DEFINE	LED2	PORTB,1	;PORTA DO LED
			; 0 -> APAGADO
			; 1 -> ACESO
#DEFINE	LED3	PORTB,2	;PORTA DO LED
			; 0 -> APAGADO
			; 1 -> ACESO
#DEFINE	LED4	PORTB,3	;PORTA DO LED
			; 0 -> APAGADO
			; 1 -> ACESO

#DEFINE	LED5	PORTB,4	;PORTA DO LED
			; 0 -> APAGADO
			; 1 -> ACESO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00	;ENDEREÇO INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    INÍCIO DA INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AS INTERRUPÇÕES NÃO SERÃO UTILIZADAS, POR ISSO PODEMOS SUBSTITUIR
; TODO O SISTEMA EXISTENTE NO ARQUIVO MODELO PELO APRESENTADO ABAIXO
; ESTE SISTEMA NÃO É OBRIGATÓRIO, MAS PODE EVITAR PROBLEMAS FUTUROS

	ORG	0x04		;ENDEREÇO INICIAL DA INTERRUPÇÃO
	RETFIE			;RETORNA DA INTERRUPÇÃO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	CLRF	PORTA		;LIMPA O PORTA
	CLRF	PORTB		;LIMPA O PORTB

	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000100'
	MOVWF	TRISA		;DEFINE RA2 COMO ENTRADA E DEMAIS
				;COMO SAÍDAS
	MOVLW	B'00000000'
	MOVWF	TRISB		;DEFINE TODO O PORTB COMO SAÍDA
	MOVLW	B'10000000'
	MOVWF	OPTION_REG	;PRESCALER 1:2 NO TMR0
				;PULL-UPS DESABILITADOS
				;AS DEMAIS CONFG. SÃO IRRELEVANTES
	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUPÇÕES DESLIGADAS
	BANK0			;ALTERA PARA O BANCO 0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN

	BTFSC	BOTAO		;O BOTÃO ESTÁ PRESSIONADO?
	GOTO	BOTAO_LIB	;NÃO, ENTÃO TRATA BOTÃO LIBERADO
	GOTO	BOTAO_PRES	;SIM, ENTÃO TRATA BOTÃO PRESSIONADO

BOTAO_LIB

	GOTO 	MAIN		;RETORNA AO LOOP PRINCIPAL

BOTAO_PRES
	
	GOTO		DO



DO
	BSF	LED1		;ACENDE O LED
	DECFSZ	CONTADOR1,F
	GOTO 	DO	;RETORNA 
	BCF	LED1
	GOTO RE
RE
	BSF	LED2		;ACENDE O LED
	DECFSZ	CONTADOR2,F
	GOTO 	RE	;RETORNA 
	BCF	LED2
	GOTO MI
MI
	BSF	LED3		;ACENDE O LED
	DECFSZ	CONTADOR3,F
	GOTO 	MI	;RETORNA
	BCF	LED3
	GOTO FA
FA
	BSF	LED4		;ACENDE O LED
	DECFSZ	CONTADOR4,F
	GOTO 	FA	;RETORNA
	BCF	LED4
	GOTO FA2
FA2
	BSF	LED4		;ACENDE O LED
	DECFSZ	CONTADOR5,F
	GOTO 	FA2	;RETORNA 
	BCF	LED4
	GOTO FA3
FA3
	BSF	LED4		;ACENDE O LED
	DECFSZ	CONTADOR6,F
	GOTO 	FA3	;RETORNA 
	BCF	LED4
	GOTO DO2;

DO2
	BSF	LED1		;ACENDE O LED
	DECFSZ	CONTADOR7,F
	GOTO 	DO2	;RETORNA 
	BCF	LED1
	GOTO RE2

RE2
	BSF	LED2		;ACENDE O LED
	DECFSZ	CONTADOR8,F
	GOTO 	RE2	;RETORNA 
	BCF	LED2
	GOTO DO3

DO3
	BSF	LED1		;ACENDE O LED
	DECFSZ	CONTADOR9,F
	GOTO 	DO3	;RETORNA 
	BCF	LED1
	GOTO RE3
RE3
	BSF	LED2		;ACENDE O LED
	DECFSZ	CONTADOR10,F
	GOTO 	RE3	;RETORNA 
	BCF	LED2
	GOTO RE4
RE4
	BSF	LED2		;ACENDE O LED
	DECFSZ	CONTADOR11,F
	GOTO 	RE4	;RETORNA 
	BCF	LED2
	GOTO RE5
RE5
	BSF	LED2		;ACENDE O LED
	DECFSZ	CONTADOR12,F
	GOTO 	RE5	;RETORNA 
	BCF	LED2
	GOTO DO3

DO4
	BSF	LED1		;ACENDE O LED
	DECFSZ	CONTADOR13,F
	GOTO 	DO4	;RETORNA 
	BCF	LED1
	GOTO SOL
SOL 
	BSF	LED5	;ACENDE O LED
	DECFSZ	CONTADOR14,F
	GOTO 	SOL	;RETORNA 
	BCF	LED5
	GOTO FA4
FA4
	BSF	LED4		;ACENDE O LED
	DECFSZ	CONTADOR15,F
	GOTO 	FA4	;RETORNA 
	BCF	LED4
	GOTO MI2;
MI2
	BSF	LED3		;ACENDE O LED
	DECFSZ	CONTADOR16,F
	GOTO 	MI2	;RETORNA
	BCF	LED3
	GOTO MI3
MI3
	BSF	LED3		;ACENDE O LED
	DECFSZ	CONTADOR17,F
	GOTO 	MI3	;RETORNA
	BCF	LED3
	GOTO MI4
MI4
	BSF	LED3		;ACENDE O LED
	DECFSZ	CONTADOR18,F
	GOTO 	MI4	;RETORNA
	BCF	LED3
	GOTO MI3
MI5
	BSF	LED3		;ACENDE O LED
	DECFSZ	CONTADOR19,F
	GOTO 	MI5	;RETORNA
	BCF	LED3
	GOTO MAIN
INCREMENTADOR 
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END			;OBRIGATÓRIO

