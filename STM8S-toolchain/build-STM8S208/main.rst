                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _display
                                     13 	.globl _milis
                                     14 	.globl _init_milis
                                     15 	.globl _GPIO_WriteLow
                                     16 	.globl _GPIO_WriteHigh
                                     17 	.globl _GPIO_Init
                                     18 	.globl _CLK_HSIPrescalerConfig
                                     19 	.globl _init
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; Stack segment in internal ram
                                     30 ;--------------------------------------------------------
                                     31 	.area SSEG
      0085F3                         32 __start__stack:
      0085F3                         33 	.ds	1
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; interrupt vector
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
      008000                         52 __interrupt_vect:
      008000 82 00 80 6F             53 	int s_GSINIT ; reset
      008004 82 00 82 F9             54 	int _TRAP_IRQHandler ; trap
      008008 82 00 82 FA             55 	int _TLI_IRQHandler ; int0
      00800C 82 00 82 FB             56 	int _AWU_IRQHandler ; int1
      008010 82 00 82 FC             57 	int _CLK_IRQHandler ; int2
      008014 82 00 82 FD             58 	int _EXTI_PORTA_IRQHandler ; int3
      008018 82 00 82 FE             59 	int _EXTI_PORTB_IRQHandler ; int4
      00801C 82 00 82 FF             60 	int _EXTI_PORTC_IRQHandler ; int5
      008020 82 00 83 00             61 	int _EXTI_PORTD_IRQHandler ; int6
      008024 82 00 83 01             62 	int _EXTI_PORTE_IRQHandler ; int7
      008028 82 00 83 02             63 	int _CAN_RX_IRQHandler ; int8
      00802C 82 00 83 03             64 	int _CAN_TX_IRQHandler ; int9
      008030 82 00 83 04             65 	int _SPI_IRQHandler ; int10
      008034 82 00 83 05             66 	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
      008038 82 00 83 06             67 	int _TIM1_CAP_COM_IRQHandler ; int12
      00803C 82 00 83 07             68 	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
      008040 82 00 83 08             69 	int _TIM2_CAP_COM_IRQHandler ; int14
      008044 82 00 83 09             70 	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
      008048 82 00 83 0A             71 	int _TIM3_CAP_COM_IRQHandler ; int16
      00804C 82 00 83 0B             72 	int _UART1_TX_IRQHandler ; int17
      008050 82 00 83 0C             73 	int _UART1_RX_IRQHandler ; int18
      008054 82 00 83 0D             74 	int _I2C_IRQHandler ; int19
      008058 82 00 83 0E             75 	int _UART3_TX_IRQHandler ; int20
      00805C 82 00 83 0F             76 	int _UART3_RX_IRQHandler ; int21
      008060 82 00 83 10             77 	int _ADC2_IRQHandler ; int22
      008064 82 00 83 11             78 	int _TIM4_UPD_OVF_IRQHandler ; int23
      008068 82 00 83 2B             79 	int _EEPROM_EEC_IRQHandler ; int24
                                     80 ;--------------------------------------------------------
                                     81 ; global & static initialisations
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area GSINIT
                                     85 	.area GSFINAL
                                     86 	.area GSINIT
      00806F CD 84 3D         [ 4]   87 	call	___sdcc_external_startup
      008072 4D               [ 1]   88 	tnz	a
      008073 27 03            [ 1]   89 	jreq	__sdcc_init_data
      008075 CC 80 6C         [ 2]   90 	jp	__sdcc_program_startup
      008078                         91 __sdcc_init_data:
                                     92 ; stm8_genXINIT() start
      008078 AE 00 00         [ 2]   93 	ldw x, #l_DATA
      00807B 27 07            [ 1]   94 	jreq	00002$
      00807D                         95 00001$:
      00807D 72 4F 00 00      [ 1]   96 	clr (s_DATA - 1, x)
      008081 5A               [ 2]   97 	decw x
      008082 26 F9            [ 1]   98 	jrne	00001$
      008084                         99 00002$:
      008084 AE 00 04         [ 2]  100 	ldw	x, #l_INITIALIZER
      008087 27 09            [ 1]  101 	jreq	00004$
      008089                        102 00003$:
      008089 D6 80 94         [ 1]  103 	ld	a, (s_INITIALIZER - 1, x)
      00808C D7 00 00         [ 1]  104 	ld	(s_INITIALIZED - 1, x), a
      00808F 5A               [ 2]  105 	decw	x
      008090 26 F7            [ 1]  106 	jrne	00003$
      008092                        107 00004$:
                                    108 ; stm8_genXINIT() end
                                    109 	.area GSFINAL
      008092 CC 80 6C         [ 2]  110 	jp	__sdcc_program_startup
                                    111 ;--------------------------------------------------------
                                    112 ; Home
                                    113 ;--------------------------------------------------------
                                    114 	.area HOME
                                    115 	.area HOME
      00806C                        116 __sdcc_program_startup:
      00806C CC 82 17         [ 2]  117 	jp	_main
                                    118 ;	return from main will return to caller
                                    119 ;--------------------------------------------------------
                                    120 ; code
                                    121 ;--------------------------------------------------------
                                    122 	.area CODE
                                    123 ;	./src/main.c: 19: void init(void) {
                                    124 ; genLabel
                                    125 ;	-----------------------------------------
                                    126 ;	 function init
                                    127 ;	-----------------------------------------
                                    128 ;	Register assignment is optimal.
                                    129 ;	Stack space usage: 0 bytes.
      008160                        130 _init:
                                    131 ;	./src/main.c: 20: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); // taktovani MCU na 16MHz
                                    132 ; genSend
      008160 4F               [ 1]  133 	clr	a
                                    134 ; genCall
      008161 CD 84 5B         [ 4]  135 	call	_CLK_HSIPrescalerConfig
                                    136 ;	./src/main.c: 21: GPIO_Init(DIN_PORT, DIN_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
                                    137 ; genIPush
      008164 4B C0            [ 1]  138 	push	#0xc0
                                    139 ; genSend
      008166 A6 04            [ 1]  140 	ld	a, #0x04
                                    141 ; genSend
      008168 AE 50 05         [ 2]  142 	ldw	x, #0x5005
                                    143 ; genCall
      00816B CD 83 2C         [ 4]  144 	call	_GPIO_Init
                                    145 ;	./src/main.c: 22: GPIO_Init(CLK_PORT, CLK_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
                                    146 ; genIPush
      00816E 4B C0            [ 1]  147 	push	#0xc0
                                    148 ; genSend
      008170 A6 10            [ 1]  149 	ld	a, #0x10
                                    150 ; genSend
      008172 AE 50 05         [ 2]  151 	ldw	x, #0x5005
                                    152 ; genCall
      008175 CD 83 2C         [ 4]  153 	call	_GPIO_Init
                                    154 ;	./src/main.c: 23: GPIO_Init(CS_PORT, CS_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
                                    155 ; genIPush
      008178 4B D0            [ 1]  156 	push	#0xd0
                                    157 ; genSend
      00817A A6 08            [ 1]  158 	ld	a, #0x08
                                    159 ; genSend
      00817C AE 50 05         [ 2]  160 	ldw	x, #0x5005
                                    161 ; genCall
      00817F CD 83 2C         [ 4]  162 	call	_GPIO_Init
                                    163 ;	./src/main.c: 25: init_milis();
                                    164 ; genCall
      008182 CC 82 D8         [ 2]  165 	jp	_init_milis
                                    166 ; genLabel
      008185                        167 00101$:
                                    168 ;	./src/main.c: 26: }
                                    169 ; genEndFunction
      008185 81               [ 4]  170 	ret
                                    171 ;	./src/main.c: 28: void display(uint8_t address, uint8_t data) {
                                    172 ; genLabel
                                    173 ;	-----------------------------------------
                                    174 ;	 function display
                                    175 ;	-----------------------------------------
                                    176 ;	Register assignment is optimal.
                                    177 ;	Stack space usage: 2 bytes.
      008186                        178 _display:
      008186 89               [ 2]  179 	pushw	x
                                    180 ; genReceive
      008187 6B 01            [ 1]  181 	ld	(0x01, sp), a
                                    182 ;	./src/main.c: 31: LOW(CS); // začátek přenosu
                                    183 ; genSend
      008189 A6 08            [ 1]  184 	ld	a, #0x08
                                    185 ; genSend
      00818B AE 50 05         [ 2]  186 	ldw	x, #0x5005
                                    187 ; genCall
      00818E CD 84 31         [ 4]  188 	call	_GPIO_WriteLow
                                    189 ;	./src/main.c: 36: mask = 0b10000000;
                                    190 ; genAssign
      008191 A6 80            [ 1]  191 	ld	a, #0x80
      008193 6B 02            [ 1]  192 	ld	(0x02, sp), a
                                    193 ;	./src/main.c: 37: while (mask) {
                                    194 ; genLabel
      008195                        195 00104$:
                                    196 ; genIfx
      008195 0D 02            [ 1]  197 	tnz	(0x02, sp)
      008197 26 03            [ 1]  198 	jrne	00157$
      008199 CC 81 CE         [ 2]  199 	jp	00106$
      00819C                        200 00157$:
                                    201 ;	./src/main.c: 38: if (address & mask) {
                                    202 ; genAnd
      00819C 7B 01            [ 1]  203 	ld	a, (0x01, sp)
      00819E 14 02            [ 1]  204 	and	a, (0x02, sp)
                                    205 ; genIfx
      0081A0 4D               [ 1]  206 	tnz	a
      0081A1 26 03            [ 1]  207 	jrne	00158$
      0081A3 CC 81 B1         [ 2]  208 	jp	00102$
      0081A6                        209 00158$:
                                    210 ;	./src/main.c: 39: HIGH(DIN);
                                    211 ; genSend
      0081A6 A6 04            [ 1]  212 	ld	a, #0x04
                                    213 ; genSend
      0081A8 AE 50 05         [ 2]  214 	ldw	x, #0x5005
                                    215 ; genCall
      0081AB CD 85 5D         [ 4]  216 	call	_GPIO_WriteHigh
                                    217 ; genGoto
      0081AE CC 81 B9         [ 2]  218 	jp	00103$
                                    219 ; genLabel
      0081B1                        220 00102$:
                                    221 ;	./src/main.c: 42: LOW(DIN);
                                    222 ; genSend
      0081B1 A6 04            [ 1]  223 	ld	a, #0x04
                                    224 ; genSend
      0081B3 AE 50 05         [ 2]  225 	ldw	x, #0x5005
                                    226 ; genCall
      0081B6 CD 84 31         [ 4]  227 	call	_GPIO_WriteLow
                                    228 ; genLabel
      0081B9                        229 00103$:
                                    230 ;	./src/main.c: 44: HIGH(CLK);
                                    231 ; genSend
      0081B9 A6 10            [ 1]  232 	ld	a, #0x10
                                    233 ; genSend
      0081BB AE 50 05         [ 2]  234 	ldw	x, #0x5005
                                    235 ; genCall
      0081BE CD 85 5D         [ 4]  236 	call	_GPIO_WriteHigh
                                    237 ;	./src/main.c: 45: mask = mask >> 1;
                                    238 ; genRightShiftLiteral
      0081C1 04 02            [ 1]  239 	srl	(0x02, sp)
                                    240 ;	./src/main.c: 46: LOW(CLK);
                                    241 ; genSend
      0081C3 A6 10            [ 1]  242 	ld	a, #0x10
                                    243 ; genSend
      0081C5 AE 50 05         [ 2]  244 	ldw	x, #0x5005
                                    245 ; genCall
      0081C8 CD 84 31         [ 4]  246 	call	_GPIO_WriteLow
                                    247 ; genGoto
      0081CB CC 81 95         [ 2]  248 	jp	00104$
                                    249 ; genLabel
      0081CE                        250 00106$:
                                    251 ;	./src/main.c: 50: mask = 0b10000000;
                                    252 ; genAssign
      0081CE A6 80            [ 1]  253 	ld	a, #0x80
      0081D0 6B 02            [ 1]  254 	ld	(0x02, sp), a
                                    255 ;	./src/main.c: 51: while (mask) {
                                    256 ; genLabel
      0081D2                        257 00110$:
                                    258 ; genIfx
      0081D2 0D 02            [ 1]  259 	tnz	(0x02, sp)
      0081D4 26 03            [ 1]  260 	jrne	00159$
      0081D6 CC 82 0B         [ 2]  261 	jp	00112$
      0081D9                        262 00159$:
                                    263 ;	./src/main.c: 52: if (data & mask) {
                                    264 ; genAnd
      0081D9 7B 05            [ 1]  265 	ld	a, (0x05, sp)
      0081DB 14 02            [ 1]  266 	and	a, (0x02, sp)
                                    267 ; genIfx
      0081DD 4D               [ 1]  268 	tnz	a
      0081DE 26 03            [ 1]  269 	jrne	00160$
      0081E0 CC 81 EE         [ 2]  270 	jp	00108$
      0081E3                        271 00160$:
                                    272 ;	./src/main.c: 53: HIGH(DIN);
                                    273 ; genSend
      0081E3 A6 04            [ 1]  274 	ld	a, #0x04
                                    275 ; genSend
      0081E5 AE 50 05         [ 2]  276 	ldw	x, #0x5005
                                    277 ; genCall
      0081E8 CD 85 5D         [ 4]  278 	call	_GPIO_WriteHigh
                                    279 ; genGoto
      0081EB CC 81 F6         [ 2]  280 	jp	00109$
                                    281 ; genLabel
      0081EE                        282 00108$:
                                    283 ;	./src/main.c: 56: LOW(DIN);
                                    284 ; genSend
      0081EE A6 04            [ 1]  285 	ld	a, #0x04
                                    286 ; genSend
      0081F0 AE 50 05         [ 2]  287 	ldw	x, #0x5005
                                    288 ; genCall
      0081F3 CD 84 31         [ 4]  289 	call	_GPIO_WriteLow
                                    290 ; genLabel
      0081F6                        291 00109$:
                                    292 ;	./src/main.c: 58: HIGH(CLK);
                                    293 ; genSend
      0081F6 A6 10            [ 1]  294 	ld	a, #0x10
                                    295 ; genSend
      0081F8 AE 50 05         [ 2]  296 	ldw	x, #0x5005
                                    297 ; genCall
      0081FB CD 85 5D         [ 4]  298 	call	_GPIO_WriteHigh
                                    299 ;	./src/main.c: 59: mask = mask >> 1;
                                    300 ; genRightShiftLiteral
      0081FE 04 02            [ 1]  301 	srl	(0x02, sp)
                                    302 ;	./src/main.c: 60: LOW(CLK);
                                    303 ; genSend
      008200 A6 10            [ 1]  304 	ld	a, #0x10
                                    305 ; genSend
      008202 AE 50 05         [ 2]  306 	ldw	x, #0x5005
                                    307 ; genCall
      008205 CD 84 31         [ 4]  308 	call	_GPIO_WriteLow
                                    309 ; genGoto
      008208 CC 81 D2         [ 2]  310 	jp	00110$
                                    311 ; genLabel
      00820B                        312 00112$:
                                    313 ;	./src/main.c: 63: HIGH(CS); // konec přenosu
                                    314 ; genSend
      00820B A6 08            [ 1]  315 	ld	a, #0x08
                                    316 ; genSend
      00820D AE 50 05         [ 2]  317 	ldw	x, #0x5005
                                    318 ; genCall
      008210 CD 85 5D         [ 4]  319 	call	_GPIO_WriteHigh
                                    320 ; genLabel
      008213                        321 00113$:
                                    322 ;	./src/main.c: 64: }
                                    323 ; genEndFunction
      008213 85               [ 2]  324 	popw	x
      008214 85               [ 2]  325 	popw	x
      008215 84               [ 1]  326 	pop	a
      008216 FC               [ 2]  327 	jp	(x)
                                    328 ;	./src/main.c: 66: int main(void) {
                                    329 ; genLabel
                                    330 ;	-----------------------------------------
                                    331 ;	 function main
                                    332 ;	-----------------------------------------
                                    333 ;	Register assignment might be sub-optimal.
                                    334 ;	Stack space usage: 13 bytes.
      008217                        335 _main:
      008217 52 0D            [ 2]  336 	sub	sp, #13
                                    337 ;	./src/main.c: 68: uint32_t time = 0;
                                    338 ; genAssign
      008219 5F               [ 1]  339 	clrw	x
      00821A 1F 03            [ 2]  340 	ldw	(0x03, sp), x
      00821C 1F 01            [ 2]  341 	ldw	(0x01, sp), x
                                    342 ;	./src/main.c: 71: init();
                                    343 ; genCall
      00821E CD 81 60         [ 4]  344 	call	_init
                                    345 ;	./src/main.c: 73: display(DECODE_MODE, 0b11111111);
                                    346 ; genIPush
      008221 4B FF            [ 1]  347 	push	#0xff
                                    348 ; genSend
      008223 A6 09            [ 1]  349 	ld	a, #0x09
                                    350 ; genCall
      008225 CD 81 86         [ 4]  351 	call	_display
                                    352 ;	./src/main.c: 74: display(SCAN_LIMIT, 7);
                                    353 ; genIPush
      008228 4B 07            [ 1]  354 	push	#0x07
                                    355 ; genSend
      00822A A6 0B            [ 1]  356 	ld	a, #0x0b
                                    357 ; genCall
      00822C CD 81 86         [ 4]  358 	call	_display
                                    359 ;	./src/main.c: 75: display(INTENSITY, 0xF);
                                    360 ; genIPush
      00822F 4B 0F            [ 1]  361 	push	#0x0f
                                    362 ; genSend
      008231 A6 0A            [ 1]  363 	ld	a, #0x0a
                                    364 ; genCall
      008233 CD 81 86         [ 4]  365 	call	_display
                                    366 ;	./src/main.c: 76: display(DISPLAY_TEST, DISPLAY_TEST_OFF);
                                    367 ; genIPush
      008236 4B 00            [ 1]  368 	push	#0x00
                                    369 ; genSend
      008238 A6 0F            [ 1]  370 	ld	a, #0x0f
                                    371 ; genCall
      00823A CD 81 86         [ 4]  372 	call	_display
                                    373 ;	./src/main.c: 77: display(SHUTDOWN, SHUTDOWN_ON);
                                    374 ; genIPush
      00823D 4B 01            [ 1]  375 	push	#0x01
                                    376 ; genSend
      00823F A6 0C            [ 1]  377 	ld	a, #0x0c
                                    378 ; genCall
      008241 CD 81 86         [ 4]  379 	call	_display
                                    380 ;	./src/main.c: 78: display(DIGIT1,0xF);
                                    381 ; genIPush
      008244 4B 0F            [ 1]  382 	push	#0x0f
                                    383 ; genSend
      008246 A6 02            [ 1]  384 	ld	a, #0x02
                                    385 ; genCall
      008248 CD 81 86         [ 4]  386 	call	_display
                                    387 ;	./src/main.c: 79: display(DIGIT2,0xF);
                                    388 ; genIPush
      00824B 4B 0F            [ 1]  389 	push	#0x0f
                                    390 ; genSend
      00824D A6 03            [ 1]  391 	ld	a, #0x03
                                    392 ; genCall
      00824F CD 81 86         [ 4]  393 	call	_display
                                    394 ;	./src/main.c: 80: display(DIGIT3,0xF);
                                    395 ; genIPush
      008252 4B 0F            [ 1]  396 	push	#0x0f
                                    397 ; genSend
      008254 A6 04            [ 1]  398 	ld	a, #0x04
                                    399 ; genCall
      008256 CD 81 86         [ 4]  400 	call	_display
                                    401 ;	./src/main.c: 81: display(DIGIT4,0xF);
                                    402 ; genIPush
      008259 4B 0F            [ 1]  403 	push	#0x0f
                                    404 ; genSend
      00825B A6 05            [ 1]  405 	ld	a, #0x05
                                    406 ; genCall
      00825D CD 81 86         [ 4]  407 	call	_display
                                    408 ;	./src/main.c: 82: display(DIGIT5,0xF);
                                    409 ; genIPush
      008260 4B 0F            [ 1]  410 	push	#0x0f
                                    411 ; genSend
      008262 A6 06            [ 1]  412 	ld	a, #0x06
                                    413 ; genCall
      008264 CD 81 86         [ 4]  414 	call	_display
                                    415 ;	./src/main.c: 83: display(DIGIT6,0xF);
                                    416 ; genIPush
      008267 4B 0F            [ 1]  417 	push	#0x0f
                                    418 ; genSend
      008269 A6 07            [ 1]  419 	ld	a, #0x07
                                    420 ; genCall
      00826B CD 81 86         [ 4]  421 	call	_display
                                    422 ;	./src/main.c: 84: display(DIGIT7,0xF);
                                    423 ; genIPush
      00826E 4B 0F            [ 1]  424 	push	#0x0f
                                    425 ; genSend
      008270 A6 08            [ 1]  426 	ld	a, #0x08
                                    427 ; genCall
      008272 CD 81 86         [ 4]  428 	call	_display
                                    429 ;	./src/main.c: 88: while (1) {
                                    430 ; genAssign
      008275 0F 0D            [ 1]  431 	clr	(0x0d, sp)
                                    432 ; genLabel
      008277                        433 00104$:
                                    434 ;	./src/main.c: 89: if (milis() - time > 333) {
                                    435 ; genCall
      008277 CD 82 B8         [ 4]  436 	call	_milis
      00827A 1F 07            [ 2]  437 	ldw	(0x07, sp), x
      00827C 17 05            [ 2]  438 	ldw	(0x05, sp), y
                                    439 ; genMinus
      00827E 1E 07            [ 2]  440 	ldw	x, (0x07, sp)
      008280 72 F0 03         [ 2]  441 	subw	x, (0x03, sp)
      008283 1F 0B            [ 2]  442 	ldw	(0x0b, sp), x
      008285 7B 06            [ 1]  443 	ld	a, (0x06, sp)
      008287 12 02            [ 1]  444 	sbc	a, (0x02, sp)
      008289 6B 0A            [ 1]  445 	ld	(0x0a, sp), a
      00828B 7B 05            [ 1]  446 	ld	a, (0x05, sp)
      00828D 12 01            [ 1]  447 	sbc	a, (0x01, sp)
      00828F 6B 09            [ 1]  448 	ld	(0x09, sp), a
                                    449 ; genCmp
                                    450 ; genCmpTnz
      008291 AE 01 4D         [ 2]  451 	ldw	x, #0x014d
      008294 13 0B            [ 2]  452 	cpw	x, (0x0b, sp)
      008296 4F               [ 1]  453 	clr	a
      008297 12 0A            [ 1]  454 	sbc	a, (0x0a, sp)
      008299 4F               [ 1]  455 	clr	a
      00829A 12 09            [ 1]  456 	sbc	a, (0x09, sp)
      00829C 25 03            [ 1]  457 	jrc	00122$
      00829E CC 82 77         [ 2]  458 	jp	00104$
      0082A1                        459 00122$:
                                    460 ; skipping generated iCode
                                    461 ;	./src/main.c: 90: time = milis();
                                    462 ; genCall
      0082A1 CD 82 B8         [ 4]  463 	call	_milis
      0082A4 1F 03            [ 2]  464 	ldw	(0x03, sp), x
      0082A6 17 01            [ 2]  465 	ldw	(0x01, sp), y
                                    466 ;	./src/main.c: 91: display(DIGIT0, number++);
                                    467 ; genAssign
      0082A8 7B 0D            [ 1]  468 	ld	a, (0x0d, sp)
                                    469 ; genPlus
      0082AA 0C 0D            [ 1]  470 	inc	(0x0d, sp)
                                    471 ; genIPush
      0082AC 88               [ 1]  472 	push	a
                                    473 ; genSend
      0082AD A6 01            [ 1]  474 	ld	a, #0x01
                                    475 ; genCall
      0082AF CD 81 86         [ 4]  476 	call	_display
                                    477 ; genGoto
      0082B2 CC 82 77         [ 2]  478 	jp	00104$
                                    479 ; genLabel
      0082B5                        480 00106$:
                                    481 ;	./src/main.c: 94: }
                                    482 ; genEndFunction
      0082B5 5B 0D            [ 2]  483 	addw	sp, #13
      0082B7 81               [ 4]  484 	ret
                                    485 	.area CODE
                                    486 	.area CONST
                                    487 	.area INITIALIZER
                                    488 	.area CABS (ABS)
