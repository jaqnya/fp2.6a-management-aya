*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �                MS-DOS Window definitions                �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

parameter cFileData

if not wexist("_0zl1egrny")
   define window _0zl1egrny ;
      from int((srow()-8)/2),int((scol()-55)/2) ;
      to int((srow()-8)/2)+7,int((scol()-55)/2)+54 ;
      title " RE-ORGANIZADOR " ;
      float ;
      noclose ;
      shadow ;
      nominimize ;
      double ;
      color scheme 13
endif


*       靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �               ALERTA/MS-DOS Screen Layout               �
*       �                                                         �
*       聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

#region 1
if wvisible("_0zl1egrny")
   activate window _0zl1egrny same
else
   activate window _0zl1egrny noshow
endif

@ 04,15 get nChoice ;
   picture "@*HT \!\<S�;\? \<No" ;
   size 01,06,11 ;
   default 1

@ 01,00 say padc([� La tabla "]+cFileData+[" se encuentra en uso !], 53, chr(32)) ;
   size 01,53,00 ;
   picture "@I"
	
@ 02,00 say padc([� Desea intentar reindexarlo de nuevo ?], 53, chr(32)) ;
   size 01,53,00 ;
   picture "@I"

@ 03,00 say replicate(chr(196),53)

if not wvisible("_0zl1egrny")
   activate window _0zl1egrny
endif

read cycle

release window _0zl1egrny
return nChoice
