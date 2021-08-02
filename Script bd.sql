CREATE DATABASE Tienda;
USE Tienda;


CREATE TABLE Cliente(
	codCliente int not null auto_increment primary key,
    nombre varchar(20) not null,
    apellido varchar(20) not null,
    -- credito <= 200
    credito int not null,
    check(credito <= 200)
);

-- probando sp
CALL sp_NuevoCliente('Paola','Martinez',100);
select * from Cliente;

CREATE TABLE Proveedor(
	codProveedor char(2) not null,
    nombre varchar(50) not null,
    direccion varchar(500),
    primary key(codProveedor)
);
CALL sp_NuevoProveedor('CC','CocaCola','CDMX');
select * from Proveedor;


CREATE TABLE Pedido(
	idPedido int not null auto_increment PRIMARY KEY,
    fecha date not null, -- yyyy-MM-dd
    hora time not null, -- HH:mm:ss:mmm 20:25:45:123 o HH:mm:ss 20:25:45
    cantidadArticulos int not null,
    costo decimal(10,2), -- 123.14 1236547.21 Error: 452.123
    iva int not null,
    descuento int not null,
    costoTotal decimal(10,2),
    codCliente int not null,
	foreign key(codCliente) REFERENCES Cliente(codCliente) ON DELETE CASCADE ON UPDATE CASCADE
);
select curtime();
call sp_NuevoPedido(CURDATE(), curtime(), 2, 14.99, 5, 0, 15.17, 1);
select * from Pedido;
Select max(idPedido) as ultimo from Pedido;



CREATE TABLE Articulo(
	codArticulo char(3) not null,
    nombre varchar(30) not null,
    precio decimal(5,2) not null,
    check(precio < 1000),
    peso int not null,
    codProveedor char(2) not null,
    PRIMARY KEY(codArticulo),
    FOREIGN KEY(codProveedor) REFERENCES Proveedor(codProveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

call sp_NuevoArticulo('RF','Refresco', 15.99, 2, 'CC');
select * from Articulo;


-- tabla relacion
CREATE TABLE PedidoArticulo(
	codArticulo char(3) not null,
    idPedido int not null,
    foreign key(codArticulo) references Articulo(codArticulo) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(idPedido) references Pedido(idPedido) ON DELETE CASCADE ON UPDATE CASCADE
);

call sp_NuevaRelacionPedidoArticulo('RF',1);
select * from PedidoArticulo;


-- tabla de acceso
CREATE TABLE Acceso(
	usuario varchar(20) not null,
    clave varchar(10) not null,
    tipoDeUsuario varchar(13) not null,
    primary key(usuario, clave)
);

call sp_NuevoUsuario('Julia','12345','Administrador');
call sp_NuevoUsuario('Manuel','12345','Trabajador');
call sp_NuevoUsuario('Paola','54321','Trabajador');
call sp_NuevoUsuario('Oscar','12345','Trabajador');
call sp_NuevoUsuario('Alejandro', 'abc', 'Administrador');
call sp_NuevoUsuario('Alejandra', 'bca', 'Trabajador');

delete from Acceso where usuario = 'Alejandro' and clave = 'abc';
delete from Acceso where usuario = ? and clave = ?;

select * from Acceso;
select usuario, clave, tipoDeUsuario from Acceso;




