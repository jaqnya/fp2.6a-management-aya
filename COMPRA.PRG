clear
define window detalle from 08,00  to 18,79 title 'Detalle' panel color scheme 20
store 0 to var_mem
set color to gr+/b
@ 01,00 say '旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커'
@ 02,00 say '�                                                                              �'
@ 03,00 say '�                                                                              �'
@ 04,00 say '�                                                                              �'
@ 05,00 say '�                                                                              �'
@ 06,00 say '쳐Descripci줻컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡Cantidad컫횾recio Un.컴쩡Importe컴�'
@ 07,00 say '�                                          �          �             �          �'
@ 08,00 say '�                                          �          �             �          �'
@ 09,00 say '�                                          �          �             �          �'
@ 10,00 say '�                                          �          �             �          �'
@ 11,00 say '�                                          �          �             �          �'
@ 12,00 say '�                                          �          �             �          �'
@ 13,00 say '�                                          �          �             �          �'
@ 14,00 say '�                                          �          �             �          �'
@ 15,00 say '�                                          �          �             �          �'
@ 16,00 say '�                                          �          �             �          �'
@ 17,00 say '�                                          �          �             �          �'
@ 18,00 say '쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴좔컴컴컴컴컴컴좔컴컴컴컴캑'
@ 19,00 say '�                                                                              �'
@ 20,00 say '�                                                                              �'
@ 21,00 say '�                                                                              �'
@ 22,00 say '�                                                                              �'
@ 23,00 say '읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸'

set color to bg+/b
@ 02,02 say "Documento:                           N�:                F.Compra:"

@ 04,02 say "Proveedor:"

@ 19,02 say 'Rubro...:                                            SUB-TOTALES:'
@ 20,02 say 'Gravado.:                                            % DESCUENTO:'
@ 21,02 say 'S.Actual                                                  I.V.A.:' 
@ 22,02 say '                                                   TOTAL GENERAL:' 

@ 02,13 get var_mem picture ' ' && Documento


@ 02,43 get var_mem picture '           '

@ 02,68 get var_mem picture '  /  /    '   && Fecha Documento

@ 04,13 get var_mem picture '99,999'    && Cliente

@ 20,48 get var_mem picture '      '       && Descuento
@ 19,68 get var_mem picture '           '  && Sub-Total
@ 20,68 get var_mem picture '           '  && Descuento
@ 21,68 get var_mem picture '           '  && I.V.A.   
@ 22,68 get var_mem picture '           '  && Total General

@ 07,02 get var_mem picture '                                        ' && Detalle - Descripci줻
@ 07,44 get var_mem picture '          '      && Cantidad
@ 07,55 get var_mem picture '             '   && Precio Un.
@ 07,69 get var_mem picture '          '      && Importe

wait window ''
*define window detalle from 08,00  to 18,79 title 'Detalle' panel color scheme 6
activate window detalle
use detavent
browse
release window detalle
