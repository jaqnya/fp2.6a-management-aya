CLEAR ALL

SET CENTURY ON
SET DATE    BRITISH
SET DELETED ON
SET EXACT   ON

USE cabemovi IN 0 SHARED
USE detamovi IN 0 SHARED

CREATE CURSOR tm_detamovi(;
   articulo VARCHAR(15),;
   entrada NUMERIC(9,2),;
   salida NUMERIC(9,2);
)

* obtiene la suma de las cantidades que fueron objeto de ajuste de ENTRADA.
SELECT;
   articulo,;
   SUM(cantidad) AS cantidad;
FROM;
   detamovi;
WHERE;
   INLIST(tipobole, 1, 3);
GROUP BY;
   articulo;
INTO CURSOR;
   tm_entrada

* obtiene la suma de las cantidades que fueron objeto de ajuste de SALIDA.
SELECT;
   articulo,;
   SUM(cantidad) AS cantidad;
FROM;
   detamovi;
WHERE;
   INLIST(tipobole, 2, 4);
GROUP BY;
   articulo;
INTO CURSOR;
   tm_salida

* carga los datos de ENTRADA en el cursor 'tm_detamovi'.
n_contador = 0
SELECT tm_entrada
SCAN ALL
   n_contador = n_contador + 1
   WAIT "Procesando [ENTRADA]... " + ALLTRIM(STR(n_contador)) + "/" + ALLTRIM(STR(RECCOUNT())) WINDOW NOWAIT

   * obtiene datos del archivo.
   c_articulo = articulo
   n_cantidad = cantidad

   SELECT tm_detamovi
   LOCATE FOR articulo = c_articulo
   IF FOUND() THEN
      REPLACE entrada WITH entrada + n_cantidad
   ELSE
      INSERT INTO tm_detamovi (articulo, entrada);
         VALUES (c_articulo, n_cantidad)
   ENDIF
ENDSCAN

* carga los datos de SALIDA en el cursor 'tm_detamovi'.
n_contador = 0
SELECT tm_salida
SCAN ALL
   n_contador = n_contador + 1
   WAIT "Procesando [SALIDA]... " + ALLTRIM(STR(n_contador)) + "/" + ALLTRIM(STR(RECCOUNT())) WINDOW NOWAIT

   * obtiene datos del archivo.
   c_articulo = articulo
   n_cantidad = cantidad

   SELECT tm_detamovi
   LOCATE FOR articulo = c_articulo
   IF FOUND() THEN
      REPLACE salida WITH salida + n_cantidad
   ELSE
      INSERT INTO tm_detamovi (articulo, salida);
         VALUES (c_articulo, n_cantidad)
   ENDIF
ENDSCAN

* filtra solamente los registros cuya ENTRADA sea igual a la SALIDA.
SELECT * FROM tm_detamovi WHERE entrada = salida INTO CURSOR tm_filtrado
SELECT * FROM tm_filtrado INTO CURSOR tm_detamovi

* borra los registro cuya ENTRADA sea igual a la SALIDA.
n_contador = 0
SELECT tm_detamovi
SCAN FOR entrada = salida
   n_contador = n_contador + 1
   WAIT "Borrando registros donde [ENTRADA = SALIDA]... " + ALLTRIM(STR(n_contador)) + "/" + ALLTRIM(STR(RECCOUNT())) WINDOW NOWAIT

   * obtiene los datos del archivo.
   c_articulo = articulo

   SELECT detamovi
   DELETE FOR articulo = c_articulo
ENDSCAN

* selecciona los registros de la cabecera que no tengan detalle.
SELECT;
   tipobole,;
   nrobole;
FROM;
   cabemovi;
WHERE;
   NOT EXIST (SELECT * FROM detamovi WHERE cabemovi.tipobole = detamovi.tipobole AND cabemovi.nrobole = detamovi.nrobole);
INTO CURSOR;
   tm_cabemovi

* elimina los registros de la cebecera que no tengan detalle.
n_contador = 0
SELECT tm_cabemovi
SCAN ALL
   n_contador = n_contador + 1
   WAIT "Borrado cabeceras de ajuste sin detalle... " + ALLTRIM(STR(n_contador)) + "/" + ALLTRIM(STR(RECCOUNT())) WINDOW NOWAIT

   * obtiene datos del archivo de cabecera.
   n_tipobole = tipobole
   n_nrobole = nrobole

   SELECT cabemovi
   DELETE FOR tipobole = n_tipobole AND nrobole = n_nrobole
ENDSCAN

WAIT CLEAR
MESSAGEBOX("Proceso de depuración concluido.", 0+48, "Aviso")