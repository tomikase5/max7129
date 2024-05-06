;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _display
	.globl _milis
	.globl _init_milis
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _CLK_HSIPrescalerConfig
	.globl _init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int _TRAP_IRQHandler ; trap
	int _TLI_IRQHandler ; int0
	int _AWU_IRQHandler ; int1
	int _CLK_IRQHandler ; int2
	int _EXTI_PORTA_IRQHandler ; int3
	int _EXTI_PORTB_IRQHandler ; int4
	int _EXTI_PORTC_IRQHandler ; int5
	int _EXTI_PORTD_IRQHandler ; int6
	int _EXTI_PORTE_IRQHandler ; int7
	int _CAN_RX_IRQHandler ; int8
	int _CAN_TX_IRQHandler ; int9
	int _SPI_IRQHandler ; int10
	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
	int _TIM1_CAP_COM_IRQHandler ; int12
	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
	int _TIM2_CAP_COM_IRQHandler ; int14
	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
	int _TIM3_CAP_COM_IRQHandler ; int16
	int _UART1_TX_IRQHandler ; int17
	int _UART1_RX_IRQHandler ; int18
	int _I2C_IRQHandler ; int19
	int _UART3_TX_IRQHandler ; int20
	int _UART3_RX_IRQHandler ; int21
	int _ADC2_IRQHandler ; int22
	int _TIM4_UPD_OVF_IRQHandler ; int23
	int _EEPROM_EEC_IRQHandler ; int24
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./src/main.c: 19: void init(void) {
; genLabel
;	-----------------------------------------
;	 function init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init:
;	./src/main.c: 20: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); // taktovani MCU na 16MHz
; genSend
	clr	a
; genCall
	call	_CLK_HSIPrescalerConfig
;	./src/main.c: 21: GPIO_Init(DIN_PORT, DIN_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 22: GPIO_Init(CLK_PORT, CLK_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 23: GPIO_Init(CS_PORT, CS_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
; genIPush
	push	#0xd0
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 25: init_milis();
; genCall
	jp	_init_milis
; genLabel
00101$:
;	./src/main.c: 26: }
; genEndFunction
	ret
;	./src/main.c: 28: void display(uint8_t address, uint8_t data) {
; genLabel
;	-----------------------------------------
;	 function display
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 2 bytes.
_display:
	pushw	x
; genReceive
	ld	(0x01, sp), a
;	./src/main.c: 31: LOW(CS); // začátek přenosu
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
;	./src/main.c: 36: mask = 0b10000000;
; genAssign
	ld	a, #0x80
	ld	(0x02, sp), a
;	./src/main.c: 37: while (mask) {
; genLabel
00104$:
; genIfx
	tnz	(0x02, sp)
	jrne	00157$
	jp	00106$
00157$:
;	./src/main.c: 38: if (address & mask) {
; genAnd
	ld	a, (0x01, sp)
	and	a, (0x02, sp)
; genIfx
	tnz	a
	jrne	00158$
	jp	00102$
00158$:
;	./src/main.c: 39: HIGH(DIN);
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
; genGoto
	jp	00103$
; genLabel
00102$:
;	./src/main.c: 42: LOW(DIN);
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genLabel
00103$:
;	./src/main.c: 44: HIGH(CLK);
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 45: mask = mask >> 1;
; genRightShiftLiteral
	srl	(0x02, sp)
;	./src/main.c: 46: LOW(CLK);
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genGoto
	jp	00104$
; genLabel
00106$:
;	./src/main.c: 50: mask = 0b10000000;
; genAssign
	ld	a, #0x80
	ld	(0x02, sp), a
;	./src/main.c: 51: while (mask) {
; genLabel
00110$:
; genIfx
	tnz	(0x02, sp)
	jrne	00159$
	jp	00112$
00159$:
;	./src/main.c: 52: if (data & mask) {
; genAnd
	ld	a, (0x05, sp)
	and	a, (0x02, sp)
; genIfx
	tnz	a
	jrne	00160$
	jp	00108$
00160$:
;	./src/main.c: 53: HIGH(DIN);
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
; genGoto
	jp	00109$
; genLabel
00108$:
;	./src/main.c: 56: LOW(DIN);
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genLabel
00109$:
;	./src/main.c: 58: HIGH(CLK);
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 59: mask = mask >> 1;
; genRightShiftLiteral
	srl	(0x02, sp)
;	./src/main.c: 60: LOW(CLK);
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genGoto
	jp	00110$
; genLabel
00112$:
;	./src/main.c: 63: HIGH(CS); // konec přenosu
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
; genLabel
00113$:
;	./src/main.c: 64: }
; genEndFunction
	popw	x
	popw	x
	pop	a
	jp	(x)
;	./src/main.c: 66: int main(void) {
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 13 bytes.
_main:
	sub	sp, #13
;	./src/main.c: 68: uint32_t time = 0;
; genAssign
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	./src/main.c: 71: init();
; genCall
	call	_init
;	./src/main.c: 73: display(DECODE_MODE, 0b11111111);
; genIPush
	push	#0xff
; genSend
	ld	a, #0x09
; genCall
	call	_display
;	./src/main.c: 74: display(SCAN_LIMIT, 7);
; genIPush
	push	#0x07
; genSend
	ld	a, #0x0b
; genCall
	call	_display
;	./src/main.c: 75: display(INTENSITY, 0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x0a
; genCall
	call	_display
;	./src/main.c: 76: display(DISPLAY_TEST, DISPLAY_TEST_OFF);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x0f
; genCall
	call	_display
;	./src/main.c: 77: display(SHUTDOWN, SHUTDOWN_ON);
; genIPush
	push	#0x01
; genSend
	ld	a, #0x0c
; genCall
	call	_display
;	./src/main.c: 78: display(DIGIT1,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x02
; genCall
	call	_display
;	./src/main.c: 79: display(DIGIT2,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x03
; genCall
	call	_display
;	./src/main.c: 80: display(DIGIT3,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x04
; genCall
	call	_display
;	./src/main.c: 81: display(DIGIT4,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x05
; genCall
	call	_display
;	./src/main.c: 82: display(DIGIT5,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x06
; genCall
	call	_display
;	./src/main.c: 83: display(DIGIT6,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x07
; genCall
	call	_display
;	./src/main.c: 84: display(DIGIT7,0xF);
; genIPush
	push	#0x0f
; genSend
	ld	a, #0x08
; genCall
	call	_display
;	./src/main.c: 88: while (1) {
; genAssign
	clr	(0x0d, sp)
; genLabel
00104$:
;	./src/main.c: 89: if (milis() - time > 333) {
; genCall
	call	_milis
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
; genMinus
	ldw	x, (0x07, sp)
	subw	x, (0x03, sp)
	ldw	(0x0b, sp), x
	ld	a, (0x06, sp)
	sbc	a, (0x02, sp)
	ld	(0x0a, sp), a
	ld	a, (0x05, sp)
	sbc	a, (0x01, sp)
	ld	(0x09, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x014d
	cpw	x, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	clr	a
	sbc	a, (0x09, sp)
	jrc	00122$
	jp	00104$
00122$:
; skipping generated iCode
;	./src/main.c: 90: time = milis();
; genCall
	call	_milis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	./src/main.c: 91: display(DIGIT0, number++);
; genAssign
	ld	a, (0x0d, sp)
; genPlus
	inc	(0x0d, sp)
; genIPush
	push	a
; genSend
	ld	a, #0x01
; genCall
	call	_display
; genGoto
	jp	00104$
; genLabel
00106$:
;	./src/main.c: 94: }
; genEndFunction
	addw	sp, #13
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
