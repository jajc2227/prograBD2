create database ventas;

use ventas

create table clientes(
nombre_cliente varchar(60) NOT NULL,
id_cliente decimal(4,0) NOT NULL,
codigos_pais varchar(3) NOT NULL,
direccion_fisica varchar(180) NOT NULL,
direccio_entrega varchar(180) NOT NULL,
codigo_postal varchar(12) NOT NULL,
telefono_c decimal(8,0) NOT NULL,
correo_cliente varchar(60) NOT NULL,
inicio_rc date NOT NULL,
forma_pago varchar(40) NOT NULL,
limite_credito numeric(7,0) NOT NULL,
primary key(id_cliente))

create table  productos(
sku decimal(6,0) NOT NULL,
descripcion varchar(60) NOT NULL,
costo_unitario numeric(4,2) NOT NULL,
precio_venta_unitario numeric(4,2) NOT NULL,
unidades_disponibles decimal(6,0) NOT NULL,
impuesto numeric(4,2),
primary key(sku))


create table lineas_pedidos(
numero_pedido int NOT NULL,
linea_pedido int IDENTITY(1,1) NOT NULL,
fecha_regirstro date NOT NULL,
cond_pago varchar(40) NOT NULL,
fecha_estimada_entrega date NOT NULL,
id_cliente decimal(4,0) NOT NULL,
id_producto decimal(6,0) NOT NULL,
cantidad_pedida int NOT NULL,
descuento numeric(4,2) NOT NULL,
precio_unitario int NOT NULL,
impuesto numeric(4,2) NOT NULL,
precio_total numeric(8,2) NOT NULL,
condicion varchar(100) NOT NULL,
estado varchar(100) NOT NULL,
descripcion varchar(120) NOT NULL,

primary key(numero_pedido)
--foreign key(cond_pago reference clientes(forma_pago),
--id_cliente reference clientes(id_clientes),
--id_produto reference producto(sku),
--precio_unitario reference producto(precio_unitario),
--impuesto reference producto(impuesto),
--))))
)

create table lineas_facturas(
numero_factura decimal(8,0) NOT NULL,
linea_factura int NOT NULL,
fecha_factura date NOT NULL,
fecha_vencimiento date NOT NULL,
cond_pago varchar(40) NOT NULL,
id_cliente int NOT NULL,
id_producto int NOT NULL,
cantidad_facturada int NOT NULL,
descuento numeric(4,2) NOT NULL,
precio_unitario int NOT NULL,
impuesto numeric(4,2) NOT NULL,
precio_total numeric(8,2) NOT NULL,
condicion varchar(100) NOT NULL,
estado varchar(100) NOT NULL,
descripcion varchar(120) NOT NULL,
primary key(numero_factura)
--foreign key(cond_pago reference clientes(forma_pago),
--id_cliente reference clientes(id_clientes),
--id_produto reference producto(sku),
--precio_unitario reference producto(precio_unitario,
--impuesto reference producto(impuesto,
--))))
)

--select id_cliente from cliente where nombre = var
create table pedidos(
numero_pedido int IDENTITY(1,1) NOT NULL,
id_empleado decimal(4,0) NOT NULL,
fecha_pedido date NOT NULL,
id_cliente decimal(4,0) NOT NULL,
primary key(numero_pedido)
--foreign key()
)

create table factura(
numero_factura decimal(8,0) NOT NULL,
id_empleado decimal(4,0) NOT NULL,
fecha_factura date NOT NULL,
id_cliente decimal(4,0) NOT NULL,
primary key(numero_factura) 
--foreign key()
)

create table CuentasxCobrar(
numero_factura int NOT NULL,
fecha_factura date NOT NULL,
modo_pago char(40) NOT NULL,
fecha_vencimiento date NOT NULL,
id_cliente decimal(4,0) NOT NULL,
total_pagado int NOT NULL,
impuesto numeric(4,2) NOT NULL,
primary key(numero_factura)
-- todas foraneas
)

create table personal(
id_empleado decimal(4,0) NOT NULL,
nombre_empleado char(20) NOT NULL,
apellido1 char(20) NOT NULL,
apellido2 char(20) NOT NULL,
telefono decimal(8,0) NOT NULL,
correo char(120) NOT NULL,
lugar_residencia char(60) NOT NULL,
puesto char(4) NOT NULL,
fecha_nacimiento date NOT NULL,
fecha_ingreso date NOT NULL,
fecha_retiro date,
empresa char(60) NOT NULL,
id_jefe int NOT NULL)

--lineas de pedidos fk

alter table lineas_pedidos
add constraint lineas_pedidos_fk foreign key(cond_pago)
references clientes(forma_pago);

alter table lineas_pedidos
add constraint id_cliente_fk foreign key(id_cliente)
references clientes(id_cliente);

alter table lineas_pedidos
add constraint id_producto_sku_fk foreign key(id_producto)
references productos(sku);

alter table lineas_pedidos
add constraint precio_unitario_fk foreign key(precio_unitario)
references producto(precio_unitario);

alter table lineas_pedidos
add constraint impuesto_fk foreign key(impuesto)
references producto(impuesto);

-- lineas_facturas fk
alter table lineas_facturas
add constraint cond_pago_forma_pago_fk foreign key(cond_pago)
references clientes(forma_pago);

alter table lineas_facturas
add constraint id_cliente_fk foreign key(id_cliente)
references clientes(id_clientes);

alter table lineas_facturas
add constraint id_producto_sku_fk foreign key(id_producto)
references producto(sku);

alter table lineas_facturas
add constraint precio_unitario_fk foreign key(precio_unitario)
references producto(precio_unitario);

alter table lineas_facturas
add constraint impuesto_fk foreign key(impuesto)
references producto(impuesto);

-- facturas fk
alter table facturas
add constraint id_cliente_fk foreign key(id_cliente)
references clientes(id_cliente);

alter table facturas
add constraint id_empleado_fk foreign key(id_empleado)
references personal(id_empleado);

-- pedidos fk
alter table pedidos
add constraint id_cliente_fk foreign key(id_cliente)
references clientes(id_cliente);

alter table pedidos
add constraint id_empleado_fk foreign key(id_empleado)
references personal(id_empleado);

-- cuentasXcobrar fk
alter table CuentasxCobrar
add constraint numero_factura_fk foreign key(numero_factura)
references lineas_facturas(numero_factura);

alter table CuentasxCobrar
add constraint fecha_factura_fk foreign key(fecha_factura)
references lineas_facturas(fecha_factura);

alter table CuentasxCobrar
add constraint modo_pago_fk foreign key(modo_pago)
references lineas_pedidos(cond_pago);

alter table CuentasxCobrar
add constraint fecha_vencimiento_fk foreign key(fecha_vencimiento)
references lineas_facturas(fecha_vencimiento);

alter table CuentasxCobrar
add constraint id_cliente_fk foreign key(id_cliente)
references clientes(id_cliente);

alter table CuentasxCobrar
add constraint total_pagado_fk foreign key(total_pagado)
references lineas_pedidos(precio_total);

alter table CuentasxCobrar
add constraint impuestos_fk foreign key(impuesto)
references lineas_pedidos(impuesto);

