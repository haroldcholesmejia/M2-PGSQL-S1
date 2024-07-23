# Taller: Base de datos de un sistema bancario
## Objetivo

Desarrollar una base de datos con sus tablas, sus atributos y sus restricciones, utilizando pull request para la revisión de código.

## Entrega

Se debe subir un archivo .sql con el script de creación de la base de datos (incluyendo tablas) y con inserciones de registros en cada una de las tablas (mínimo 4 registros por tabla).

## Enunciado

Una compañía bancaria desea desarrollar un sistema de gestión de base de datos para administrar sus operaciones y datos de clientes. La base de datos debe contener información detallada sobre los clientes, cuentas bancarias, transacciones, empleados, sucursales, productos financieros, préstamos y tarjetas de crédito. Además, debe permitir gestionar la relación de muchos a muchos entre los clientes y los productos financieros. A continuación se presentan los requisitos específicos:

## Entidades y Atributos

### Clientes
- **cliente_id** (PK): Identificador único del cliente.
- **nombre**: Nombre del cliente.
- **apellido**: Apellido del cliente.
- **direccion**: Dirección del cliente.
- **telefono**: Teléfono del cliente.
- **correo_electronico**: Correo electrónico del cliente.
- **fecha_nacimiento**: Fecha de nacimiento del cliente.
- **estado**: Estado del cliente (activo, inactivo).

### Cuentas Bancarias
- **cuenta_id** (PK): Identificador único de la cuenta.
- **cliente_id** (FK): Identificador del cliente asociado.
- **numero_cuenta**: Número de cuenta (único).
- **tipo_cuenta**: Tipo de cuenta (corriente, ahorro).
- **saldo**: Saldo de la cuenta.
- **fecha_apertura**: Fecha de apertura de la cuenta.
- **estado**: Estado de la cuenta (activa, cerrada).

### Transacciones
- **transaccion_id** (PK): Identificador único de la transacción.
- **cuenta_id** (FK): Identificador de la cuenta asociada.
- **tipo_transaccion**: Tipo de transacción (depósito, retiro, transferencia).
- **monto**: Monto de la transacción.
- **fecha_transaccion**: Fecha de la transacción.
- **descripcion**: Descripción de la transacción.

### Empleados
- **empleado_id** (PK): Identificador único del empleado.
- **nombre**: Nombre del empleado.
- **apellido**: Apellido del empleado.
- **direccion**: Dirección del empleado.
- **telefono**: Teléfono del empleado.
- **correo_electronico**: Correo electrónico del empleado.
- **fecha_contratacion**: Fecha de contratación del empleado.
- **posicion**: Posición del empleado.
- **salario**: Salario del empleado.
- **sucursal_id** (FK): Identificador de la sucursal asignada.

### Sucursales
- **sucursal_id** (PK): Identificador único de la sucursal.
- **nombre**: Nombre de la sucursal.
- **direccion**: Dirección de la sucursal.
- **telefono**: Teléfono de la sucursal.

### Productos Financieros
- **producto_id** (PK): Identificador único del producto financiero.
- **nombre_producto**: Nombre del producto financiero.
- **tipo_producto**: Tipo de producto (préstamo, tarjeta de crédito, seguro).
- **descripcion**: Descripción del producto financiero.
- **tasa_interes**: Tasa de interés del producto financiero.

### Préstamos
- **prestamo_id** (PK): Identificador único del préstamo.
- **cuenta_id** (FK): Identificador de la cuenta asociada.
- **monto**: Monto del préstamo.
- **tasa_interes**: Tasa de interés del préstamo.
- **fecha_inicio**: Fecha de inicio del préstamo.
- **fecha_fin**: Fecha de fin del préstamo.
- **estado**: Estado del préstamo (activo, pagado).

### Tarjetas de Crédito
- **tarjeta_id** (PK): Identificador único de la tarjeta de crédito.
- **cuenta_id** (FK): Identificador de la cuenta asociada.
- **numero_tarjeta**: Número de tarjeta (único).
- **limite_credito**: Límite de crédito de la tarjeta.
- **saldo_actual**: Saldo actual de la tarjeta.
- **fecha_emision**: Fecha de emisión de la tarjeta.
- **fecha_vencimiento**: Fecha de vencimiento de la tarjeta.
- **estado**: Estado de la tarjeta (activa, bloqueada).

### Relación Clientes-Productos
- **cliente_id** (FK): Identificador del cliente.
- **producto_id** (FK): Identificador del producto financiero.
- **fecha_adquisicion**: Fecha de adquisición del producto financiero por el cliente.
#
> **Jacobo Garcés - Coach Técnico**
