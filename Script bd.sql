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
CALL sp_NuevoCliente('Javier','Zamora',200);
CALL sp_NuevoCliente('Aline','Gress',150);
CALL sp_NuevoCliente('Mariana','Martinez',100);
CALL sp_NuevoCliente('Marcos','Jimenez',200);
CALL sp_NuevoCliente('Raul','Gonzalez',100);
CALL sp_NuevoCliente('Uriel','Ibañez',100);

select codCliente, nombre, apellido, credito from Cliente;

-- calcula el ultimo codigo de cliente

select codCliente, nombre, apellido, credito from Cliente where codCliente = ?;

DELETE FROM Cliente WHERE codCliente = ?;

-- Delete: Borra todos los registros deseados pero NO resetea el id auto_increment
-- Truncate: Borra todos los registros deseados pero SI resetea el id auto_increment

CREATE TABLE Proveedor(
	codProveedor char(2) not null,
    nombre varchar(50) not null,
    direccion varchar(500),
    primary key(codProveedor)
);
CALL sp_NuevoProveedor('CC','CocaCola','CDMX');
CALL sp_NuevoProveedor('RS','Radios','CDMX');
select * from Proveedor;
select codProveedor from proveedor;


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
use Tienda;
select curtime();
call sp_NuevoPedido(CURDATE(), curtime(), 2, 14.99, 5, 0, 15.17, 2);
select * from Pedido;
Select max(idPedido) as ultimo from Pedido;

select * from cliente;
select nombre from Cliente;
delete from cliente where codCliente between 1 and 50;
delete from Pedido where idPedido = 2;

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
DELETE FROM Articulo WHERE codArticulo = ?;

call sp_NuevoArticulo('RF','Refresco', 15.99, 2, 'CC');
call sp_NuevoArticulo('PL','Paleta', 2.99, 0, 'CC');
call sp_NuevoArticulo('PN','Pan', 3.15, 1, 'CC');
call sp_NuevoArticulo('CP','Comida para perro', 10.99, 1, 'CC');
call sp_NuevoArticulo('CG','Comida para gato', 10.99, 1, 'CC');

select codArticulo, nombre, precio from Articulo;


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




