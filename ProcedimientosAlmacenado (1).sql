create procedure actualizar_pedidos
@id_pedido int,
@Ncantidad int,
@idprod int
AS
BEGIN 
UPDATE [ventas].[dbo].[Lineas_pedidos]
set [cantidad_pedida] = (select cantidad_pedida from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido and id_producto = @idprod) - @Ncantidad,
[precio_total] = (select precio_unitario from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido and id_producto = @idprod) *  (select cantidad_pedida from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido and id_producto = @idprod)
where [numero_pedido] = @id_pedido and [id_producto] = @idprod
UPDATE [ventas].[dbo].[Productos] 
set [unidades_disponibles] = @Ncantidad
where [sku] = @idprod
UPDATE [ventas].[dbo].[Lineas_pedidos]
set  [precio_total] = (select precio_unitario from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido and id_producto = @idprod) *  (select cantidad_pedida from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @id_pedido and id_producto = @idprod)
where [numero_pedido] = @id_pedido and [id_producto] = @idprod
END



--drop procedure actualizar_pedidos;
--exec actualizar_pedidos 4,4,3;-- prueba del procedimiento;

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
[precio_total] = (select precio_total from Lineas_pedidos where numero_pedido = @numero_pedido and id_producto = @id_producto)
where [numero_pedido] = @numero_pedido
END
*/
