/* LOS PROCEDIMIENTOS DE ALMACENADO TIENEN QUE IR UNO POR QUERY
SINO NO SIRVEN ADEMAS EN ACTUALIZAR_FACTURAS HAY VARIAS QUE NO LO QUE VA
HAY QUE VER QUE ERA Y AGREGARLO


create procedure actualizar_pedidos
@id_pedido int,
@Ncantidad int
AS
BEGIN 
UPDATE [ventas].[dbo].[Lineas_pedidos]
set [cantidad_pedida] = (select cantidad_pedida from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido) - @Ncantidad,
[precio_total] = (select precio_unitario from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido) * @Ncantidad
where [numero_pedido] = @id_pedido
END


--exec actualizar_pedidos 1,2; prueba del procedimiento


create procedure crear_factura
@id_pedido int,
@fecha_factura date,
@fecha_ven date
AS
BEGIN
insert into [ventas].[dbo].[Facturas]
([fecha_factura],[id_pedido],[fecha_ven])
VALUES	  
(@fecha_factura,@id_pedido,@fecha_ven)
END

--exec crear_factura 2,'2018-11-5','2018-11-5';

/*
create procedure actualizar_facturas
@id_producto int,
@cantidad int,
@numero_pedido int
AS
BEGIN
UPDATE [ventas].[dbo].[Lineas_facturas]
set 
[id_producto] = @id_producto,
[cantidad_facturada] = @cantidad,
[cond_pago] = (select cond_pago from Pedidos where numero_pedido = @numero_pedido),
[descuento] = (select  descuento from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto),
[precio_unitario] = (select precio_unitario from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto),
[impuesto] = (select  impuesto from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto),
[precio_total] = (select precio_total from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto),
[condicion] = ??,
[estado] = ??,
[descripcion] = (select  descripcion from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto)
-- los que tienen ?? nose que eran eso serian los procedimientos que hay que hacer
where [numero_pedido] = @numero_pedido
END
*/
