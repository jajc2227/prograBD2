

--create database ventas;

use ventas

create table Clientes(
id_cliente numeric(4,0) NOT NULL primary key,
nombre_cliente varchar(60) NOT NULL,
codigos_pais varchar(3) NOT NULL,
direccion_fisica varchar(180) NOT NULL,
direccio_entrega varchar(180) NOT NULL,
codigo_postal varchar(12) NOT NULL,
telefono_c numeric(8,0) NOT NULL,
correo_cliente varchar(60) NOT NULL,
inicio_rc date NOT NULL,
forma_pago varchar(40) NOT NULL,
limite_credito numeric(7,0) NOT NULL,
)

create table  Productos(
sku numeric(6,0) NOT NULL primary key,
descripcion varchar(60) NOT NULL,
costo_unitario numeric(4,0) NOT NULL,
precio_venta_unitario numeric(4,0) NOT NULL,
unidades_disponibles numeric(6,0) NOT NULL,
impuesto numeric(4,0),
)


create table Pedidos(
numero_pedido int IDENTITY(1,1) NOT NULL primary key,
id_empleado numeric(4,0) NOT NULL,
fecha_pedido date NOT NULL,
id_cliente numeric(4,0) NOT NULL,
estado varchar(100) NOT NULL,
confirmacion varchar(100) NOT NULL,
cond_pago varchar(40),--cliente 
fecha_estimada_entrega date NOT NULL,
)


create table Lineas_pedidos(
linea_pedido int IDENTITY(1,1) NOT NULL,
numero_pedido int NOT NULL,
id_producto numeric(6,0) NOT NULL primary key(linea_pedido, numero_pedido,id_producto),
cantidad_pedida int NOT NULL,
descuento numeric(4,2),
precio_unitario int, -- unirlo en select de producto
impuesto numeric(4,2) not null,
precio_total numeric(8,2),  -- sumarlo
descripcion varchar(120)
);

create table Facturas(
numero_factura int IDENTITY(1,1) NOT NULL primary key,
id_empleado numeric(4,0),
numero_pedido int,-- cosas que hay que pedir
fecha_factura date,--cosas que hay que pedir
id_cliente numeric(4,0),
fecha_vencimiento date,--cosas que hay que pedir
cond_pago varchar(40),
direccion_entrega varchar(180) 
)



create table Lineas_facturas(
numero_linea_factura int IDENTITY(1,1) NOT NULL primary key,
numero_factura int,
id_pedido int,
descripcion varchar(120),
id_producto numeric(6,0),
cantidad_facturada int, --menor o igual a existencias
descuento numeric(4,2),
precio_unitario int,
subtotal int, --(unidades * precio)
impuesto numeric(4,2),
precio_total numeric(8,2),
)


create table CuentasxCobrar(
numero_factura int NOT NULL primary key ,
fecha_factura date NOT NULL,
modo_pago varchar(40) NOT NULL,
fecha_vencimiento date NOT NULL,
id_cliente numeric(4,0) NOT NULL,
total_pagado int NOT NULL,
impuesto numeric(4,2) NOT NULL,
)

create table Personal(
id_empleado numeric(4,0) NOT NULL primary key,
nombre_empleado varchar(20) NOT NULL,
apellido1 varchar(20) NOT NULL,
apellido2 varchar(20) NOT NULL,
telefono numeric(8,0) NOT NULL,
correo varchar(120) NOT NULL,
lugar_residencia varchar(60) NOT NULL,
puesto varchar(4) NOT NULL,
fecha_nacimiento date NOT NULL,
fecha_ingreso date NOT NULL,
fecha_retiro date,
empresa varchar(60) NOT NULL,
id_jefe int NOT NULL)


--lineas de pedidos fk

alter table Lineas_pedidos
add constraint numero_pedido_fk foreign key(numero_pedido)
references Pedidos(numero_pedido);

/*alter table Lineas_pedidos
add constraint id_cliente_fk foreign key(id_cliente)
references Clientes(id_cliente);*/

alter table Lineas_pedidos
add constraint id_producto_sku_fk foreign key(id_producto)
references Productos(sku);



-- lineas_facturas fk


alter table Lineas_facturas
add constraint id_num_factura_fk foreign key(numero_factura)
references Facturas(numero_factura);


alter table Lineas_facturas
add constraint id_num_pedido_fk foreign key(id_pedido)
references Pedidos(numero_pedido);


alter table Lineas_facturas
add constraint id_producto_sku_factura_fk foreign key(id_producto)
references Productos(sku);




-- facturas fk
alter table Facturas 
add constraint id_cliente_facturafactura_fk foreign key(id_cliente)
references Clientes(id_cliente);
use ventas
alter table Facturas
add constraint id_empleado_facturafactura_fk foreign key(id_empleado)
references Personal(id_empleado);

-- pedidos fk

alter table Pedidos
add constraint id_cliente_pedidospedidos_fk foreign key(id_cliente)
references Clientes(id_cliente);

alter table Pedidos
add constraint id_empleado_pedidospedidos_fk foreign key(id_empleado)
references Personal(id_empleado);

alter table Pedidos
add constraint default_estado 
default 'Registrado' for estado;

alter table Pedidos
add constraint default_confirmacion
default 'Reprocesar' for confirmacion;



use ventas
-- cuentasXcobrar fk
alter table CuentasxCobrar
add constraint numero_factura_cuentasXcobrar_fk foreign key(numero_factura)
references Facturas(numero_factura);

alter table CuentasxCobrar
add constraint id_cliente_cuentasXcobrar_fk foreign key(id_cliente)
references Clientes(id_cliente);

use ventas
insert  into Clientes
values(0001,'Juan','crc','los santos','ITCR','codpostal1',88888888,'j@pff','2008-11-11','15 dias',10000);

insert  into Clientes
values(0002,'Juanjr','crc','los santosjr','ITCR','codpostal2',88888888,'jjr@pff','2008-11-11','15 dias',20000);

insert  into Clientes
values(0003,'Rita','crc','los ririo','ITCR','codposta33',88888888,'kev@pff','2008-11-11','contado',20000);

insert  into Clientes
values(0004,'Ora','crc','los santillos','ITCR','codposta4',88888888,'ori@pff','2008-11-11','credito',20000);



insert into Productos
values(000001,'atun',1111,1111,111111,1111);

insert into Productos
values(000002,'salmon',1111,1111,111111,1111);

insert into Personal
values(0001,'chloe','grace','moretz',88888888,'chloe@','usa','1234','2008-11-11','2008-11-11','2008-11-11','paramont',01);

insert into Personal
values(0002,'melisa','grace','moretz',88888888,'chloe@','mexico','1234','2008-11-11','2008-11-11','2008-11-11','matise',02);


/*
create proc insertaPedido
(
@numero_pedido int,
@id_empleado numeric,
@fecha_pedido date,
@id_cliente numeric,
@estado varchar(100),
@confirmacion varchar(100),
@cond_pago varchar(40),--cliente 
@fecha_estimada_entrega date
)
as
insert into Pedidos
(cond_pago)
values(@numero_pedido,@id_empleado,@fecha_pedido,@id_cliente,@estado,@confirmacion,@cond_pago,@fecha_estimada_entrega)
*/

