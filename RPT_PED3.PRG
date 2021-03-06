PARAMETER m.nropedido

pcLocal = "A & A IMPORTACIONES S.R.L."

SELECT cabepedc
LOCATE FOR nropedido = m.nropedido
IF FOUND() THEN
   m.nropedido  = nropedido
   m.fecha      = fecha
   m.hora       = hora
   m.serieot    = serieot
   m.nroot      = nroot
   m.id_cliente = cliente
   m.id_vend    = vendedor
   m.condicion  = condicion
   m.porcdesc   = porcdesc
   m.importdesc = importdesc
   m.estado     = IIF(facturado, "FACTURADO", "PENDIENTE DE FACTURACION")
   m.id_plazo   = plazo
ELSE
   WAIT "EL PEDIDO N� " + ALLTRIM(STR(m.nropedido)) + " NO EXISTE." WINDOW
   RETURN
ENDIF

dbf_file = "tmp" + RIGHT(SYS(2015), 5)

CREATE TABLE (dbf_file) (;
   nropedido N(10),;
   fecha D(8),;
   hora C(8),;
   serieot C(1),;
   nroot N(10),;
   id_cliente N(5),;
   cliente C(56),;
   direccion C(60),;
   localidad C(100),;
   telefono C(30),;
   fax C(30),;
   ruc C(15),;
   id_vend N(5),;
   vendedor C(30),;
   condicion N(1),;
   id_product C(15),;
   cod_origen C(15),;
   cod_altern C(15),;
   ubicacion C(10),;
   producto C(50),;
   cantidad N(9,2),;
   precio N(9),;
   porc_iva N(6,2),;
   porcdesc N(8,4),;
   importdesc N(9),;
   estado C(24),;
   stock_cen N(9,2),;
   stock_dep N(9,2);
)

SELECT clientes
LOCATE FOR codigo = m.id_cliente
IF FOUND() THEN
   m.cliente   = nombre
   m.direccion = direc1
   m.telefono  = telefono
   m.fax       = fax
   m.ruc       = ruc
ELSE
   m.cliente   = ""
   m.direccion = ""
   m.telefono  = ""
   m.fax       = ""
   m.ruc       = ""
ENDIF

SELECT plazos
LOCATE FOR codigo = m.id_plazo
IF FOUND() THEN
   m.plazo = nombre
ELSE
   m.plazo = ""
ENDIF

SELECT vendedor
LOCATE FOR codigo = m.id_vend
IF FOUND() THEN
   m.vendedor = nombre
ELSE
   m.vendedor = ""
ENDIF

IF m.id_cliente = 1 THEN
   m.localidad = ""
ELSE
   SELECT ciudades
   SET ORDER TO 1
   SEEK clientes.ciudad

   SELECT depar
   SET ORDER TO 1
   SEEK clientes.departamen

   m.localidad = ALLTRIM(ciudades.nombre) + " � Dpto.: " + ALLTRIM(depar.nombre)
ENDIF

SELECT detapedc
SET ORDER TO 1
IF SEEK(m.nropedido) THEN
   SCAN WHILE nropedido = m.nropedido
      m.id_product = articulo
      m.descr_trab = descr_trab
      m.cantidad   = cantidad
      m.precio     = precio
      m.porc_iva   = porc_iva

      SELECT maesprod
      SET ORDER TO 1
      IF SEEK(m.id_product) THEN
         m.producto   = IIF(EMPTY(m.descr_trab), nombre, m.descr_trab)
         m.cod_altern = codigo2
         m.cod_origen = codorig
         m.ubicacion  = ubicacion
      ELSE
         m.producto   = m.descr_trab
         m.cod_altern = ""
         m.cod_origen = ""
         m.ubicacion  = ""
      ENDIF

      INSERT INTO (dbf_file) FROM MEMVAR
   ENDSCAN
ENDIF

*--BOF: Deposito --*
SELECT (dbf_file)
SCAN ALL
   m.id_product = id_product
   SELECT maesprod
   SET ORDER TO 1
   IF SEEK(m.id_product)THEN
      SELECT (dbf_file)
      REPLACE stock_cen WITH maesprod.stock_actu - maesprod.stock_ot
   ENDIF
ENDSCAN

IF !USED("maesprod2") THEN
   USE SYS(5) + "\turtle\aya\integrad.001\maesprod" IN 0 AGAIN ORDER 1 SHARED ALIAS maesprod2
ENDIF

SELECT (dbf_file)
SCAN ALL
   m.id_product = id_product
   SELECT maesprod2
   SET ORDER TO 1
   IF SEEK(m.id_product) THEN
      SELECT (dbf_file)
      REPLACE stock_dep WITH maesprod2.stock_actu - maesprod2.stock_ot
   ENDIF
ENDSCAN

IF USED("maesprod2") THEN
   SELECT maesprod2
   USE
ENDIF

dbf_file2 = "tmp" + RIGHT(SYS(2015), 5)

CREATE TABLE (dbf_file2) (;
   nropedido N(10),;
   fecha D(8),;
   hora C(8),;
   serieot C(1),;
   nroot N(10),;
   id_cliente N(5),;
   cliente C(56),;
   direccion C(60),;
   telefono C(30),;
   fax C(30),;
   ruc C(15),;
   id_vend N(5),;
   vendedor C(30),;
   condicion N(1),;
   id_product C(15),;
   cod_origen C(15),;
   cod_altern C(15),;
   ubicacion C(10),;
   producto C(50),;
   cantidad N(9,2),;
   precio N(9),;
   porc_iva N(6,2),;
   porcdesc N(8,4),;
   importdesc N(9),;
   estado C(24),;
   almacen C(20);
)
INDEX ON almacen TAG almacen

SELECT (dbf_file)
SCAN ALL
   SCATTER MEMVAR MEMO

   DO CASE
      CASE m.cantidad <= m.stock_cen
         m.almacen = "CASA CENTRAL"
         INSERT INTO (dbf_file2) FROM MEMVAR
      CASE m.cantidad > m.stock_cen AND m.cantidad <= m.stock_dep
         m.almacen = "DEPOSITO"
         INSERT INTO (dbf_file2) FROM MEMVAR
      CASE m.cantidad <= (m.stock_dep + m.stock_cen)
         m.almacen = "CASA CENTRAL"
         xcantidad = m.cantidad
         m.cantidad = m.stock_cen
         INSERT INTO (dbf_file2) FROM MEMVAR
         m.almacen = "DEPOSITO"
         m.cantidad = xcantidad - m.stock_cen
         INSERT INTO (dbf_file2) FROM MEMVAR
      CASE m.cantidad > (m.stock_cen + m.stock_dep)
         m.faltante = m.cantidad - (m.stock_cen + m.stock_dep)

         IF m.stock_cen > 0 THEN
            m.almacen = "CASA CENTRAL"
            m.cantidad = m.stock_cen
            INSERT INTO (dbf_file2) FROM MEMVAR
         ENDIF

         IF m.stock_dep > 0 THEN
            m.almacen = "DEPOSITO"
            m.cantidad = m.stock_dep
            INSERT INTO (dbf_file2) FROM MEMVAR
         ENDIF

         m.almacen = "SIN EXISTENCIA"
         m.cantidad = m.faltante
         INSERT INTO (dbf_file2) FROM MEMVAR         
      CASE INLIST(ALLTRIM(m.id_product), "99013", "99014", "99015", "99016", "10001")
         m.almacen = "CASA CENTRAL"
         INSERT INTO (dbf_file2) FROM MEMVAR
   ENDCASE
*!*	   DO CASE
*!*	      CASE m.cantidad <= m.stock_dep
*!*	         m.almacen = "DEPOSITO"
*!*	         INSERT INTO (dbf_file2) FROM MEMVAR
*!*	      CASE m.cantidad > m.stock_dep AND m.cantidad <= m.stock_cen
*!*	         m.almacen = "CASA CENTRAL"
*!*	         INSERT INTO (dbf_file2) FROM MEMVAR
*!*	      CASE m.cantidad <= (m.stock_cen + m.stock_dep)
*!*	         m.almacen = "DEPOSITO"
*!*	         xcantidad = m.cantidad
*!*	         m.cantidad = m.stock_dep
*!*	         INSERT INTO (dbf_file2) FROM MEMVAR
*!*	         m.almacen = "CASA CENTRAL"
*!*	         m.cantidad = xcantidad - m.stock_dep
*!*	         INSERT INTO (dbf_file2) FROM MEMVAR
*!*	   ENDCASE
ENDSCAN
*--EOF: Deposito --*

SELECT (dbf_file)
USE
DELETE FILE (dbf_file + ".dbf")

SELECT (dbf_file2)
REPORT FORM rpt_ped3 TO PRINTER NOCONSOLE
*REPORT FORM rpt_ped3 PREVIEW 
USE
DELETE FILE (dbf_file2 + ".dbf")
DELETE FILE (dbf_file2 + ".cdx")