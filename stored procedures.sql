-- procedimiento almacenado para un nuevo cliente
DELIMITER $$
CREATE PROCEDURE sp_NuevoCliente(
    nombrex varchar(20),
    apellidox varchar(20),
    creditox int
) BEGIN 
	INSERT INTO Cliente(nombre, apellido, credito) VALUES(nombrex, apellidox, creditox);
END $$
DELIMITER ;

-- procedimiento que inserte un proveedor
DELIMITER $$
CREATE PROCEDURE sp_NuevoProveedor(
    codProveedorx char(2),
    nombrex varchar(50),
    direccionx varchar(500)
) BEGIN 
	INSERT INTO Proveedor(codProveedor, nombre, direccion) VALUES(codProveedorx, nombrex, direccionx);
END $$
DELIMITER ;

-- procedimiento para insertar un articulo
DELIMITER $$
CREATE PROCEDURE sp_NuevoArticulo(
   codArticulox char(3),
    nombrex varchar(30),
    preciox decimal(5,2),
    pesox int,
    codProveedorx char(2)
) BEGIN 
	INSERT INTO Articulo(codArticulo, nombre, precio, peso, codProveedor) VALUES(codArticulox, nombrex, preciox, pesox, codProveedorx);
END $$
DELIMITER ;

-- procedimiento para insertar un pedido
DELIMITER $$
CREATE PROCEDURE sp_NuevoPedido(
    fechax date, 
    horax time,
    cantidadArticulosx int,
    costox decimal(10,2),
    ivax int,
    descuentox int,
    costoTotalx decimal(10,2),
    codClientex int
) BEGIN 
	insert into Pedido(fecha, hora, cantidadArticulos, costo, iva, descuento, costoTotal, codCliente) values(fechax, horax, cantidadArticulosx, costox, ivax, descuentox, costoTotalx, codClientex);
END $$
DELIMITER ;



-- procedimiento de la tabla relacion
DELIMITER $$
CREATE PROCEDURE sp_NuevaRelacionPedidoArticulo(
    codArticulox char(3),
    idPedidox int
) BEGIN 
	insert into PedidoArticulo(codArticulo, idPedido) values(codArticulox, idPedidox);
END $$
DELIMITER ;


-- procedimiento que registra un nuevo usuario
delimiter $$
create procedure sp_NuevoUsuario(
	usuariox varchar(20),
    clavex varchar(10),
    tipoDeUsuariox varchar(13)
) begin 
	insert into Acceso(usuario, clave, tipoDeUsuario) values(usuariox, clavex, tipoDeUsuariox);
end $$ 

delimiter ;



-- color azul [73,133,172]








