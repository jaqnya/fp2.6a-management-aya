*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � 04/13/04             ORDEN02.PRG               09:35:34 �
*       �                                                         �
*       픔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � Author's Name                                           �
*       �                                                         �
*       � Copyright (c) 2004 Company Name                         �
*       � Address                                                 �
*       � City,     Zip                                           �
*       �                                                         �
*       � Description:                                            �
*       � This program was automatically generated by GENSCRN.    �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�


#REGION 0
REGIONAL m.currarea, m.talkstat, m.compstat

IF SET("TALK") = "ON"
	SET TALK OFF
	m.talkstat = "ON"
ELSE
	m.talkstat = "OFF"
ENDIF
m.compstat = SET("COMPATIBLE")
SET COMPATIBLE FOXPLUS

m.currarea = SELECT()


*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �                MS-DOS Window definitions                �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

IF NOT WEXIST("_17o0kk6ne")
	DEFINE WINDOW _17o0kk6ne ;
		FROM INT((SROW()-8)/2),INT((SCOL()-27)/2) ;
		TO INT((SROW()-8)/2)+7,INT((SCOL()-27)/2)+26 ;
		TITLE " ORDENAR POR " ;
		NOFLOAT ;
		NOCLOSE ;
		SHADOW ;
		NOMINIMIZE ;
        COLOR ",,GR+/B,GR+/B,,,,,,+"
ENDIF


*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �          ORDEN02/MS-DOS Setup Code - SECTION 2          �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

#REGION 1
PUSH KEY CLEAR

IF EOF()
   DO WHILE .T.
      WAIT WINDOW "    LA TABLA SE ENCUENTRA VACIA" + CHR(13) + "� DESEA AGREGAR UN NUEVO REGISTRO ? [S/N]" TO pcAppend
      IF UPPER(pcAppend) = "S"
         DO maesprod.prg WITH "Add"
         EXIT DO
      ENDIF
      IF UPPER(pcAppend) = "N"
         EXIT DO
      ENDIF
   ENDDO
   POP KEY
   RETURN
ENDIF

PRIVATE paOrder, pnChoice

DIMENSION paOrder(4)

paOrder(1)  = "1. CODIGO"
paOrder(2)  = "2. NOMBRE"
paOrder(3)  = "3. CODIGO ALTERNATIVO"
paOrder(4)  = "4. CODIGO ORIGINAL"

*:*********************************************************************
*: ESQUEMA PARA PANTALLA COLOR
*: 袴袴袴袴袴袴袴袴袴袴袴袴袴�
*: Definici줻 de ventana: COLOR ",,GR+/B,GR+/B,,,,,,+"
*: Cuadro de lista......: COLOR "B/W,N/W,B/W,,,BG+/B"
*:*********************************************************************

*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �              ORDEN02/MS-DOS Screen Layout               �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

#REGION 1
IF WVISIBLE("_17o0kk6ne")
	ACTIVATE WINDOW _17o0kk6ne SAME
ELSE
	ACTIVATE WINDOW _17o0kk6ne NOSHOW
ENDIF
@ 0,0 GET pnChoice ;
 	PICTURE "@&T" ;
	FROM paOrder ;
	SIZE 6,25 ;
	DEFAULT 1 ;
	VALID _17o0kk6nq() ;
    COLOR "B/W,N/W,B/W,,,BG+/B"

IF NOT WVISIBLE("_17o0kk6ne")
	ACTIVATE WINDOW _17o0kk6ne
ENDIF


*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �     MS-DOSREAD contains clauses from SCREEN orden02     �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

READ CYCLE ;
	MODAL COLOR , W+/BG

RELEASE WINDOW _17o0kk6ne
SELECT (m.currarea)


#REGION 0
IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF


*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �               ORDEN02/MS-DOS Cleanup Code               �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

#REGION 1
POP KEY

*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _17O0KK6NQ           pnChoice VALID                     �
*       �                                                         �
*       � Function Origin:                                        �
*       �                                                         �
*       � From Platform:       MS-DOS                             �
*       � From Screen:         ORDEN02,     Record Number:    2   �
*       � Variable:            pnChoice                           �
*       � Called By:           VALID Clause                       �
*       � Object Type:         List                               �
*       � Snippet Number:      1                                  �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _17o0kk6nq     &&  pnChoice VALID
#REGION 1
DO CASE
   CASE pnChoice = 1
      SET ORDER TO TAG indice1
   CASE pnChoice = 2
      SET ORDER TO TAG indice2
   CASE pnChoice = 3
      SET ORDER TO TAG indice6
   CASE pnChoice = 4
      SET ORDER TO TAG indice7
ENDCASE