DROP DATABASE IF EXISTS vet_medical;
CREATE DATABASE vet_medical;
USE vet_medical;

CREATE TABLE vendedores (
	id INTEGER AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,    
    apellido VARCHAR (20) NOT NULL,
    dni VARCHAR(10) NOT NULL UNIQUE,    
    telefono VARCHAR (15) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (id)
    );

CREATE TABLE clientes (
	id INTEGER AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,    
    apellido VARCHAR (30) NOT NULL,
	dni VARCHAR(10) NOT NULL UNIQUE,
	direccion VARCHAR(30) NOT NULL,
    altura INTEGER NOT NULL,
	telefono VARCHAR (15) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
    vendedor_id INTEGER NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)
);

CREATE TABLE laboratorios (
id INTEGER AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE medicamentos (
	id INTEGER AUTO_INCREMENT,
    nombre 	VARCHAR(40) NOT NULL,
    precio DECIMAL(11,2) NOT NULL,
    laboratorio_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (laboratorio_id) REFERENCES laboratorios(id)
);

CREATE TABLE pedidos (
	id INTEGER AUTO_INCREMENT,
    fecha DATE NOT NULL,
    vendedor_id INTEGER NOT NULL,
    cliente_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)        
);

CREATE TABLE detalle_pedido (
	id INTEGER AUTO_INCREMENT,   
    pedido_id INTEGER NOT NULL,
    medicamento_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (medicamento_id) REFERENCES medicamentos(id)    
);

CREATE TABLE facturas (
	id INTEGER AUTO_INCREMENT,
    fecha DATE NOT NULL,
    valor_total DECIMAL (13,2) UNSIGNED NOT NULL,
    pedido_id INTEGER NOT NULL,
    cliente_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)    
);

CREATE TABLE despachos (
	id INTEGER AUTO_INCREMENT,    
    fecha_despacho DATE NOT NULL,
    entrega_realizada ENUM('SI', 'NO') DEFAULT 'NO' NOT NULL,
    factura_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (factura_id) REFERENCES facturas(id)  
);


-- Insercion de datos en tablas

INSERT INTO vendedores (id, nombre, apellido, dni, telefono, email)
VALUES 	(1, 'Jorge', 'Besada', '31456371', '1145657692', 'Jorgebe86@gmail.com'),
		(2, 'Fernando', 'Cabrera', '34862123', '1134758891', 'Cabrera1989@hotmail.com');

INSERT INTO clientes (id, nombre, apellido, dni, direccion, altura, telefono, email, vendedor_id)
VALUES 	(1, 'Juan','Stafforini','26843246','Compostella', 2344, '1165346519','vetdelcampo@gmail.com', 2),
		(2, 'Pedro','Picapiedra','19352749','Santa Maria', 592, '1123564461','clinicamarmol@yahoo.com', 1),
		(3,'Valentina','Stanley','28431702','Monroe', 4227, '1186475207','patitasveterinaria@gmail.com', 1),
		(4,'Karen','Mendieta','30632127','Rodriguez Peña', 1768, '1189651140','vetbonny@gmail.com', 2);

INSERT INTO laboratorios (id, nombre)
VALUES 	(1, 'Holliday'),
		(2, 'Kualcos'),
		(3, 'Janvier'),
		(4, 'Brouwer');

INSERT INTO medicamentos (id, nombre, precio, laboratorio_id)
VALUES 	(1, 'Cardial B5 mg', 6800 , 1 ),
		(2, 'Total full CG susp.', 3800 , 1 ),
		(3, 'Endectocida x 10 comp.', 7900 , 1 ),
		(4, 'Acedan gotas', 2500 , 1 ),
		(5, 'Ecthol 5 x 120 ml', 5600 , 1 ),
		(6, 'Otovier NF', 2900 , 2 ),
		(7, 'Pimoden 10 mg x 10 comp.', 4600 , 2 ),
		(8, 'Emulsion Oftalmica', 4300 , 2 ),
		(9, 'Ketoconazol crema', 6100 , 2 ),
		(10, 'Odontolimp', 7200 , 2 ),
		(11, 'Parmax susp.', 3100 , 3 ),
		(12, 'Fentel susp.', 3900 , 3 ),
		(13, 'Doxiciclina 100mg x 10 comp.', 4200 , 3 ),
		(14, 'Perfos multidosis perros', 15300 , 3 ),
		(15, 'Prednisolona 20 mg x 10 comp.', 2400 , 3 ),
		(16, 'Fenobarbital PG', 8250 , 4 ),
		(17, 'Artrin x 30 comp.', 13500 , 4 ),
		(18, 'Meltra spot on gato', 4100 , 4 ),
		(19, 'Ocuflox colirio', 6800 , 4 ),
		(20, 'Euthanyle iny.', 23000 , 4 );

INSERT INTO pedidos (id, fecha, vendedor_id, cliente_id) 
VALUES	(1, '2023-03-14', 1, 2),
		(2, '2023-04-24', 2, 1),
		(3, '2023-05-12', 1, 3),
		(4, '2023-06-23', 1, 2),
		(5, '2023-07-05', 1, 3),
		(6, '2023-08-19', 2, 1),
		(7, '2023-09-17', 1, 2),
		(8, '2023-10-01', 1, 3),
		(9, '2023-11-05', 2, 4),
		(10, '2024-01-15', 1, 2),
		(11, '2024-01-30', 1, 3),
		(12, '2024-02-11', 2, 1),
		(13, '2024-02-25', 2, 4),
		(14, '2024-03-04', 2, 1),
		(15, '2024-03-24', 2, 4),
		(16, '2024-04-21', 2, 1),
		(17, '2024-04-28', 2, 4),
		(18, '2024-05-06', 2, 1),
		(19, '2024-05-18', 2, 4),
		(20, '2024-06-01', 1, 2);

INSERT INTO detalle_pedido (id, pedido_id, medicamento_id, cantidad)
VALUES	(1, 1, 1, 3),
		(2, 1, 3, 2),
		(3, 2, 2, 1),
		(4, 2, 4, 4),
		(5, 2, 6, 2),
		(6, 3, 1, 2),
		(7, 3, 5, 3),
		(8, 4, 7, 2),
		(9, 4, 9, 1),
		(10, 5, 10, 4),
		(11, 6, 12, 3),
		(12, 7, 13, 2),
		(13, 8, 15, 1),
		(14, 9, 17, 2),
		(15, 10, 19, 3),
		(16, 11, 1, 1),
		(17, 11, 2, 1),
		(18, 12, 3, 2),
		(19, 12, 4, 1),
		(20, 13, 5, 3),
		(21, 14, 6, 2),
		(22, 14, 7, 1),
		(23, 15, 8, 3),
		(24, 15, 9, 2),
		(25, 16, 10, 1),
		(26, 17, 11, 2),
		(27, 17, 12, 2),
		(28, 18, 13, 3),
		(29, 18, 14, 1),
		(30, 19, 15, 2),
		(31, 20, 16, 3);

INSERT INTO facturas (id, fecha, valor_total, pedido_id, cliente_id)
VALUES
		(1, '2023-03-15', 31400.00, 1, 2),
		(2, '2023-04-27', 19300.00, 2, 1),
		(3, '2023-05-15', 22700.00, 3, 3),
		(4, '2023-06-26', 17000.00, 4, 2),
		(5, '2023-07-08', 22500.00, 5, 3),
		(6, '2023-08-20', 11800.00, 6, 1),
		(7, '2023-09-18', 13700.00, 7, 2),
		(8, '2023-10-02', 18100.00, 8, 3),
		(9, '2023-11-06', 12200.00, 9, 4),
		(10, '2024-01-16', 14700.00, 10, 2),
		(11, '2024-01-31', 12100.00, 11, 3),
		(12, '2024-02-12', 13000.00, 12, 1),
		(13, '2024-02-26', 16100.00, 13, 4),
		(14, '2024-03-05', 12600.00, 14, 1),
		(15, '2024-03-25', 15500.00, 15, 4),
		(16, '2024-04-22', 13100.00, 16, 1),
		(17, '2024-04-29', 9800.00, 17, 4),
		(18, '2024-05-07', 16700.00, 18, 1),
		(19, '2024-05-19', 15400.00, 19, 4),
		(20, '2024-06-02', 12000.00, 20, 2);

INSERT INTO despachos (id, fecha_despacho, entrega_realizada, factura_id)
VALUES
		(1, '2023-03-16', 'SI', 1),
		(2, '2023-04-28', 'SI', 2),
		(3, '2023-05-16', 'SI', 3),
		(4, '2023-06-27', 'SI', 4),
		(5, '2023-07-09', 'SI', 5),
		(6,'2023-08-21', 'SI', 6),
		(7, '2023-09-19', 'SI', 7),
		(8, '2023-10-03', 'SI', 8),
		(9, '2023-11-07', 'SI', 9),
		(10, '2024-01-17', 'SI', 10),
		(11, '2024-02-01', 'SI', 11),
		(12, '2024-02-13', 'SI', 12),
		(13, '2024-02-27', 'SI', 13),
		(14, '2024-03-06', 'SI', 14),
		(15, '2024-03-26', 'SI', 15),
		(16, '2024-04-23', 'SI', 16),
		(17, '2024-04-30', 'SI', 17),
		(18, '2024-05-08', 'SI', 18),
		(19, '2024-05-20', 'SI', 19),
		(20, '2024-06-03', 'NO', 20);

-- Vista 1, listado de los medicamentos agrupados por laboratorio y orden alfabetico y luego por orden alfabetico del medicamento con su precio y codigo.

CREATE VIEW vw_lista_productos AS
SELECT 
	medicamentos.id AS Codigo,
    laboratorios.nombre AS Laboratorio,
    medicamentos.nombre AS Medicamento, 
    medicamentos.precio AS Precio    
FROM medicamentos
JOIN laboratorios ON medicamentos.laboratorio_id = laboratorios.id
ORDER BY laboratorios.nombre ASC, medicamentos.nombre ASC;

-- Vista 2, listado de los clients con los pedidos realizados con su fecha y el valor de la factura.

CREATE VIEW vw_resumen_pedidos_clientes AS
SELECT 
	clientes.id AS codigo_cliente, 
	CONCAT(clientes.apellido, ' ', clientes.nombre) AS nombre_cliente, 
    pedidos.id As pedido_Numero, facturas.fecha AS Fecha,
	facturas.valor_total AS monto_factura  
FROM clientes
JOIN pedidos ON clientes.id = pedidos.cliente_id 
JOIN facturas ON pedidos.id = facturas.pedido_id;

-- Vista 3, Lista de los medicamentos correspondientes a cada pedido. Para funcionamiento interno, por ejemplo: el armado del pedido.

CREATE VIEW vw_detalle_pedido AS
SELECT 
	pedidos.id AS numero_pedido, 
	medicamentos.nombre AS medicamento, 
    detalle_pedido.cantidad AS cantidad
FROM pedidos
JOIN detalle_pedido ON pedidos.id = detalle_pedido.pedido_id
JOIN medicamentos ON detalle_pedido.medicamento_id = medicamentos.id
ORDER BY numero_pedido ASC;

-- SELECT * FROM vw_detalle_pedido WHERE numero_pedido = 3;

-- Vista 4, Lista con el valor de las ventas totales de cada vendedor.

CREATE VIEW vw_resumen_ventas_vendedores AS
SELECT 
    vendedores.id AS vendedor_id,
    CONCAT(vendedores.nombre, ' ', vendedores.apellido) AS vendedor,
    COUNT(pedidos.id) AS ventas_totales,
    SUM(detalle_pedido.cantidad * medicamentos.precio) AS valor_total_ventas
FROM vendedores
JOIN pedidos ON vendedores.id = pedidos.vendedor_id
JOIN detalle_pedido ON pedidos.id = detalle_pedido.pedido_id
JOIN medicamentos ON detalle_pedido.medicamento_id = medicamentos.id
GROUP BY vendedores.id;

-- Vista 5, Lista de las ventas totales por laboratorio, con la cantidad de medicamentos vendidos de cada uno.

CREATE VIEW vw_ventas_totales_por_laboratorio AS
SELECT 
	laboratorios.nombre As laboratorio,
	SUM(detalle_pedido.cantidad * medicamentos.precio) AS valor_total_ventas,
    SUM(detalle_pedido.cantidad) AS total_medicamentos_vendidos
FROM laboratorios
JOIN medicamentos ON laboratorios.id = medicamentos.laboratorio_id
JOIN detalle_pedido ON MEDICAMENTOS.id = detalle_pedido.medicamento_id
JOIN pedidos ON detalle_pedido.pedido_id = pedidos.id
GROUP BY laboratorios.nombre;

-- Funcion 1,  Se usa para obtener el valor total de compras de un cliente, se ingresa cocmo parametro el id del cliente.

DELIMITER //
CREATE FUNCTION fn_compras_totales_cliente(p_codigo_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT 
        SUM(monto_factura) 
    INTO 
        total
    FROM 
        vw_resumen_pedidos_clientes
    WHERE 
        codigo_cliente = p_codigo_cliente;
    
    RETURN total;
END//

-- SELECT fn_compras_totales_cliente(1);

-- Funcion 2, Se usa para obtener el precio de un medicamento aplicando un porcentaje de descuento, pasando como parametro el id del medicamento y el porcentaje de descuento deseado.

DELIMITER //
CREATE FUNCTION fn_calcular_precio_con_descuento(
    p_medicamento_id INT,
    p_descuento DECIMAL(5,2) 
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_precio_original DECIMAL(10, 2);
    DECLARE v_precio_descuento DECIMAL(10, 2);
   
    SELECT precio INTO v_precio_original
    FROM medicamentos
    WHERE id = p_medicamento_id;
    
    SET v_precio_descuento = v_precio_original - (v_precio_original * p_descuento / 100);
   
    RETURN v_precio_descuento;
END;//

-- SELECT fn_calcular_precio_con_descuento(2, 15);


-- Stored Procedure para actualizar cualquier dato de un cliente.

CREATE PROCEDURE sp_modificar_datos_cliente(
    IN p_cliente_id INT,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_dni VARCHAR(10),
    IN p_direccion VARCHAR(30),
    IN p_altura INT,
    IN p_telefono VARCHAR(15),
    IN p_email VARCHAR(30),
    IN p_vendedor_id INT
)
BEGIN
    UPDATE clientes
    SET 
        nombre = p_nombre,
        apellido = p_apellido,
        dni = p_dni,
        direccion = p_direccion,
        altura = p_altura,
        telefono = p_telefono,
        email = p_email,
        vendedor_id = p_vendedor_id
    WHERE id = p_cliente_id;
END;

-- CALL sp_modificar_datos_cliente(2, (SELECT nombre FROM clientes WHERE id = 2), (SELECT apellido FROM clientes WHERE id = 2), (SELECT dni FROM clientes WHERE id = 2), 'Avenida Siempre Viva', 742, (SELECT telefono FROM clientes WHERE id = 2), (SELECT email FROM clientes WHERE id = 2), (SELECT vendedor_id FROM clientes WHERE id = 2));

-- SELECT * FROM clientes WHERE id = 2;


-- Stored Procedure 2, actualiza el estado de la entrega en la tabla despachos de su default a 'SI', tiene por paramentro el id del despacho.

CREATE PROCEDURE sp_actualizar_estado_entrega(IN p_factura_id INT)
BEGIN
    UPDATE despachos
    SET entrega_realizada = 'SI'
    WHERE factura_id = p_factura_id;
END;

-- CALL sp_actualizar_estado_entrega(20);

-- SELECT * FROM despachos WHERE id = 20;

-- Trigger 1, Borra los registros de las tablas asociadas cuando se quiere cancelar o borrar un pedido.

CREATE TRIGGER tr_borrar_pedido
BEFORE DELETE ON pedidos
FOR EACH ROW
BEGIN
	DELETE FROM despachos WHERE factura_id = OLD.id;
    DELETE FROM facturas WHERE pedido_id = OLD.id;
    DELETE FROM detalle_pedido WHERE pedido_id = OLD.id;   
END;

-- DELETE FROM pedidos WHERE id = 2;
-- SELECT * FROM pedidos;
-- SELECT * FROM facturas;

-- Creacion de la tabla de Auditoria de clientes, para el respaldo de informacion modificada.

CREATE TABLE auditoria_clientes (
    log_id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    old_nombre VARCHAR(30) NOT NULL,
    old_apellido VARCHAR(30) NOT NULL,
    old_dni VARCHAR(10) NOT NULL,
    old_direccion VARCHAR(30) NOT NULL,
    old_altura INT NOT NULL,
    old_telefono VARCHAR(15) NOT NULL,
    old_email VARCHAR(30) NOT NULL,
    old_vendedor_id INT NOT NULL,
    fecha_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (log_id)
);

-- Trigger 2, Se utiliza para mantener una copia completa de los datos viejos de los clientes despues de una actualizacion con la fecha de cambio.

CREATE TRIGGER tr_actualizacion_datos_cliente
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_clientes (
        cliente_id, old_nombre, old_apellido, old_dni, old_direccion, old_altura, old_telefono, old_email, old_vendedor_id, fecha_update
    )
    VALUES (
        OLD.id, OLD.nombre, OLD.apellido, OLD.dni, OLD.direccion, OLD.altura, OLD.telefono, OLD.email, OLD.vendedor_id, NOW()
    );
END;

-- SELECT * FROM auditoria_clientes;





