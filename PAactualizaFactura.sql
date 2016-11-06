create procedure actualiza_facturas
@id_producto int,
@cantidad int,
@numero_pedido int,
@num_fac int
AS
BEGIN
INSERT INTO [ventas].[dbo].[Lineas_facturas]
([numero_factura],[id_pedido],[id_producto],[cantidad_facturada],[descuento],[impuesto],[precio_unitario],[precio_total],[subtotal])


VALUES(@num_fac,
       @numero_pedido,
       @id_producto,
       @cantidad,
(select  descuento from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @numero_pedido and id_producto = @id_producto),
(select  impuesto from [ventas].[dbo].[Productos] where sku =  @id_producto),
(select precio_venta_unitario from [ventas].[dbo].[Productos] where sku = @id_producto),
((((select precio_venta_unitario from [ventas].[dbo].[Productos] where sku = @id_producto) * @cantidad) - (select descuento from [ventas].[dbo].[Lineas_pedidos] where numero_pedido = @numero_pedido))+(select impuesto from [ventas].[dbo].[Productos] where sku = @id_producto)),
(select precio_venta_unitario from [ventas].[dbo].[Productos] where sku = @id_producto) * @cantidad)
END