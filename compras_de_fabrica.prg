CLEAR
CLEAR ALL

SET CENTURY ON
SET DATE BRITISH
SET DELETED ON
SET EXACT ON

USE cabecomp IN 0 SHARED
USE detacomp IN 0 SHARED
USE maesprod IN 0 SHARED
USE proveedo IN 0 SHARED

LOCAL n_anyo AS INTEGER
n_anyo = 2011

*!*	SELECT;
*!*	   IIF(a.tipodocu = 7, "FACTURA CONTADO", IIF(a.tipodocu = 8, "FACTURA CREDITO", "UNKNOWN        ")) AS documento,;
*!*	   a.nrodocu AS numero,;
*!*	   a.fechadocu AS fecha,;
*!*	   d.nombre AS proveedor,;
*!*	   b.articulo,;
*!*	   c.nombre AS producto,;
*!*	   b.cantidad,;
*!*	   b.precio,;
*!*	   ROUND(b.precio * b.cantidad, 4) AS total;
*!*	FROM;
*!*	   cabecomp a,;
*!*	   detacomp b,;
*!*	   maesprod c,;
*!*	   proveedo d;
*!*	WHERE;
*!*	   a.tipodocu = b.tipodocu AND;
*!*	   a.nrodocu = b.nrodocu AND;
*!*	   a.proveedor = b.proveedor AND;
*!*	   b.articulo = c.codigo AND;
*!*	   a.proveedor = d.codigo AND;
*!*	   YEAR(a.fechadocu) = n_anyo AND;
*!*	   a.moneda = 2 AND;
*!*	   a.proveedor = 2;
*!*	ORDER BY;
*!*	   a.fechadocu,;
*!*	   d.nombre,;
*!*	   documento,;
*!*	   numero,;
*!*	INTO CURSOR;
*!*	   tm_importacion

*!*	SELECT tm_importacion
*!*	EXPORT TO c:\importaciones TYPE xl5

SELECT;
   IIF(a.tipodocu = 7, "FACTURA CONTADO", IIF(a.tipodocu = 8, "FACTURA CREDITO", "UNKNOWN        ")) AS documento,;
   a.nrodocu AS numero,;
   a.fechadocu AS fecha,;
   d.nombre AS proveedor,;
   a.monto_fact;
FROM;
   cabecomp a,;
   proveedo d;
WHERE;
   a.proveedor = d.codigo AND;
   YEAR(a.fechadocu) = n_anyo AND;
   a.moneda = 2 AND;
   a.proveedor = 2;
ORDER BY;
   a.fechadocu,;
   documento,;
   numero;
INTO CURSOR;
   tm_fapasisa

SELECT tm_fapasisa
EXPORT TO c:\fapasisa TYPE xl5

*!*	   IIF(a.nrodocu > 10000000, a.nrodocu - 10000000, a.nrodocu) AS numero,;
