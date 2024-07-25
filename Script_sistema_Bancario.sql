-- Database: SISTEMA_BANCARIO

CREATE DATABASE SISTEMA_BANCARIO
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--CREACION DE TABLAS
CREATE TABLE CLIENTES(
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(200),
	telefono VARCHAR(100),
	correo_electronico VARCHAR(200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado VARCHAR(200) NOT NULL CHECK (estado in ('activo','inactivo'))
);

CREATE TABLE cuentas_bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(cliente_id)  NOT NULL,
    numero_cuenta VARCHAR(100) UNIQUE NOT NULL,
	tipo_cuenta VARCHAR(20) NOT NULL CHECK (tipo_cuenta in ('corriente','ahorro')),
	saldo MONEY NOT NULL,
	fecha_apertura TIMESTAMP NOT NULL,
	estado VARCHAR(20) NOT NULL CHECK (estado in ('activa','inactiva'))
);

CREATE TABLE Transacciones(
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id)  NOT NULL,
	tipo_transaccion VARCHAR(20) NOT NULL CHECK (tipo_transaccion in ('deposito','retiro','transferencia')),
	monto_trans MONEY NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL,
	descripcion VARCHAR(1000) NOT NULL
);

CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	telefono VARCHAR(200) NOT NULL
);

CREATE TABLE EMPLEADOS(
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(200),
	telefono VARCHAR(100),
	correo_electronico VARCHAR(200) UNIQUE NOT NULL,
	fecha_contratacion TIMESTAMP NOT NULL,
	posicion VARCHAR(200) NOT NULL,
	salario MONEY NOT NULL,
	sucursal_id INTEGER REFERENCES sucursales(sucursal_id)  NOT NULL	
);



CREATE TABLE productos_financieros (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR(200) UNIQUE NOT NULL,
	tipo_producto VARCHAR(50) NOT NULL CHECK (tipo_producto IN('prestamo','tarjeta de crédito','seguro')),
	descripcion VARCHAR(1000) NOT NULL,
	tasa_interes INTEGER NOT NULL
);

CREATE TABLE PRESTAMOS(
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id)  NOT NULL,	
	monto INTEGER UNIQUE NOT NULL,
	tasa_interes INTEGER NOT NULL,
	fecha_inicio TIMESTAMP NOT NULL,
	fecha_fin TIMESTAMP NOT NULL,
	estado VARCHAR(20) NOT NULL CHECK (estado in ('activa','pagado'))

);

CREATE TABLE Tarjeta_credito(
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id)  NOT NULL,	
	numero_tarjeta VARCHAR(50) UNIQUE NOT NULL,
	limite_credito MONEY NOT NULL,
	saldo_actual MONEY NOT NULL,
	fecha_emision TIMESTAMP NOT NULL,
	fecha_vencimiento TIMESTAMP NOT NULL,
	estado VARCHAR(20) NOT NULL CHECK (estado in ('activa','inactiva'))

);

CREATE TABLE RELACION_CLIENTES(
	cliente_id INTEGER REFERENCES clientes(cliente_id),
	producto_id INTEGER REFERENCES productos_financieros(producto_id),
	fecha_adquisicion TIMESTAMP NOT NULL,
	PRIMARY KEY (cliente_id, producto_id)
);

--insercion de registros	
INSERT INTO CLIENTES(NOMBRE,APELLIDO,DIRECCION, TELEFONO,CORREO_ELECTRONICO,FECHA_NACIMIENTO,ESTADO)
VALUES ('Maria', 'toro', 'CALL 121','311 4334433','Maria@gmail.com', '2000-01-01','activo');
INSERT INTO CLIENTES(NOMBRE,APELLIDO,DIRECCION, TELEFONO,CORREO_ELECTRONICO,FECHA_NACIMIENTO,ESTADO)
VALUES ('Luis', 'mejia', 'CALL 122','300 4334433','Luis@gmail.com', '2000-01-01','inactivo');
INSERT INTO CLIENTES(NOMBRE,APELLIDO,DIRECCION, TELEFONO,CORREO_ELECTRONICO,FECHA_NACIMIENTO,ESTADO)
VALUES ('Ana', 'perez', 'CALL 112','312 4334433','Ana@gmail.com', '2000-01-01','activo');
INSERT INTO CLIENTES(NOMBRE,APELLIDO,DIRECCION, TELEFONO,CORREO_ELECTRONICO,FECHA_NACIMIENTO,ESTADO)
VALUES ('Karen', 'orozco', 'CALL 212','300 4334433','Karen@gmail.com', '2000-01-01','inactivo');
INSERT INTO CLIENTES(NOMBRE,APELLIDO,DIRECCION, TELEFONO,CORREO_ELECTRONICO,FECHA_NACIMIENTO,ESTADO)
VALUES ('Mely', 'choles', 'CALL 312','310 5334433','Mely@gmail.com', '2000-01-01','activo');


INSERT INTO cuentas_bancarias(cliente_id,numero_cuenta,tipo_cuenta, saldo,fecha_apertura,estado)
VALUES ('1', '233435454', 'corriente',3000000, '2024-01-01','activa');	
INSERT INTO cuentas_bancarias(cliente_id,numero_cuenta,tipo_cuenta, saldo,fecha_apertura,estado)
VALUES ('2', '765443', 'ahorro',30000000, '2024-01-01','inactiva');	
INSERT INTO cuentas_bancarias(cliente_id,numero_cuenta,tipo_cuenta, saldo,fecha_apertura,estado)
VALUES ('3', '65673423', 'ahorro',5000000, '2024-01-01','activa');	
INSERT INTO cuentas_bancarias(cliente_id,numero_cuenta,tipo_cuenta, saldo,fecha_apertura,estado)
VALUES ('4', '56776765', 'corriente',70000000, '2024-01-01','inactiva');	

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto_trans, fecha_transaccion, descripcion) 
VALUES
(1, 'deposito', 1000.00, '2024-07-24 10:00:00', 'Depósito inicial'),
(2, 'retiro', 500.00, '2024-07-24 11:00:00', 'Retiro para compra'),
(3, 'transferencia', 200.00, '2024-07-24 12:00:00', 'Transferencia a cuenta de ahorro'),
(4, 'deposito', 300.00, '2024-07-24 13:00:00', 'Depósito mensual');

INSERT INTO Sucursales (nombre, direccion, telefono) 
VALUES
('Sucursal Central', 'Avenida Principal 123', '555-0001'),
('Sucursal Norte', 'Calle Norte 456', '555-0002'),
('Sucursal Sur', 'Boulevard Sur 789', '555-0003'),
('Sucursal Este', 'Carretera Este 101', '555-0004');

INSERT INTO EMPLEADOS (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) 
VALUES
('Juan', 'Pérez', 'Calle Falsa 123', '555-1234', 'juan.perez@example.com', '2024-01-15 09:00:00', 'Gerente', 5000.00, 1),
('María', 'Gómez', 'Avenida Siempre Viva 456', '555-5678', 'maria.gomez@example.com', '2024-02-01 10:00:00', 'Asistente Administrativa', 3000.00, 2),
('Carlos', 'Rodríguez', 'Boulevard Central 789', '555-9101', 'carlos.rodriguez@example.com', '2024-03-01 11:00:00', 'Contador', 4000.00, 1),
('Ana', 'Martínez', 'Pasaje Los Álamos 101', '555-1122', 'ana.martinez@example.com', '2024-04-01 12:00:00', 'Secretaria', 2500.00, 3);


INSERT INTO productos_financieros (nombre_producto, tipo_producto, descripcion, tasa_interes) 
VALUES
('Préstamo Personal', 'prestamo', 'Préstamo personal a tasa fija', 12),
('Tarjeta de Crédito Platino', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios exclusivos', 18),
('Seguro de Vida', 'seguro', 'Cobertura completa de seguro de vida', 5),
('Préstamo Hipotecario', 'prestamo', 'Préstamo hipotecario a largo plazo', 8);

INSERT INTO PRESTAMOS (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) 
VALUES
(1, 50000, 5, '2023-01-01 00:00:00', '2028-01-01 00:00:00', 'activa'),
(2, 20000, 6, '2022-06-15 00:00:00', '2027-06-15 00:00:00', 'activa'),
(3, 30000, 4, '2021-03-01 00:00:00', '2026-03-01 00:00:00', 'pagado'),
(4, 15000, 7, '2023-07-24 00:00:00', '2028-07-24 00:00:00', 'activa');

INSERT INTO Tarjeta_credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) 
VALUES
(1, '1234-5678-9012-3456', 10000.00, 2500.00, '2021-01-01 00:00:00', '2025-01-01 00:00:00', 'activa'),
(2, '2345-6789-0123-4567', 15000.00, 5000.00, '2022-02-01 00:00:00', '2026-02-01 00:00:00', 'activa'),
(3, '3456-7890-1234-5678', 20000.00, 7500.00, '2023-03-01 00:00:00', '2027-03-01 00:00:00', 'inactiva'),
(4, '4567-8901-2345-6789', 25000.00, 10000.00, '2024-04-01 00:00:00', '2028-04-01 00:00:00', 'activa');


INSERT INTO RELACION_CLIENTES (cliente_id, producto_id, fecha_adquisicion) 
VALUES
(1, 1, '2023-01-10 09:00:00'),  
(2, 2, '2023-02-15 10:00:00'),  
(3, 3, '2023-03-20 11:00:00'),  
(4, 4, '2023-04-25 12:00:00');  