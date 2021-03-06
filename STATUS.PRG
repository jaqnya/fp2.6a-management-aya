*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
*�  Funci줻...: Status.                                                   �         
*�  Parametros: <expC>                                                    �      
*�  Prop쥀ito.: Verificar si la tabla especificada se encuentra en uso.   �
*�  Valores                                                               �
*�  Devueltos.: 0 = La tabla no est� en uso.                              �
*�              1 = La tabla esta en uso.                                 �
*�              2 = Error.                                                �
*쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
*�                     �  Descripci줻 de Parametros  �                    �       
*�                     袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�                    �
*�  <expC>.: Nombre de la Tabla.                                          �       
*쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
*�                              �  Ejemplo �                              �       
*�                              袴袴袴袴袴袴                              �
*�  a) do Status with 'C:\TABLAS\TABLA1.DBF'                              �
*�                                                                        �
*�  b) =Status('TABLA1.DBF')                                              �
*�                                                                        �
*쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
*�  Creado....: 08/06/2003.                                               �
*�  Modificado: 08/06/2003.                                               �
*쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
*�  Autor.....: Turtle Software Paraguay S.R.L.                           �
*�              Jos� Avilio Acu쨅 Acosta.                                 �
*읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

PARAMETERS pcTable

pnStatus = 0

IF TYPE("pcTable") # "C"
   WAIT WINDOW "� FUNCION  STATUS : TIPO DE PARAMETRO INCORRECTO !"
   pnStatus = 2
ELSE
   IF !FILE(pcTable)
      WAIT WINDOW [� LA TABLA "]+pcTable+[" NO EXISTE O FUE REMOVIDA !]
      pnStatus = 2
   ENDIF
ENDIF

IF pnStatus = 0
   pnIdFile = FOPEN(pcTable, 12)
   =FCLOSE(pnIdFile)
   pnStatus = IIF(pnIdFile # -1, 0, 1)
ENDIF

RETURN (pnStatus)