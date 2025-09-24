# Base de Datos

## Descripción general
La base de datos **BD** está diseñada en **MySQL** para gestionar un sistema de inventario
con productos, categorías, ventas y un historial de eventos. Su objetivo es brindar
una solución robusta para controlar el stock, registrar ventas y mantener auditoría.

---

## Características principales
- Gestión de categorías con descripción y control de duplicados.  
- Control de productos con estado (ACTIVO/INACTIVO).  
- Registro de ventas con separación en encabezado y detalle.  
- Auditoría mediante historial de eventos.  
- Uso de claves foráneas con reglas de integridad referencial.  

---

## Estructura de la Base de Datos

### 1. Tabla `categorias`
| Campo          | Tipo               | Descripción                  |
|----------------|--------------------|------------------------------|
| id             | INT (PK)           | Identificador único          |
| nombre         | VARCHAR(150), UNIQUE | Nombre de la categoría     |
| descripcion    | TEXT               | Detalle de la categoría      |
| fecha_creacion | TIMESTAMP          | Fecha de registro            |

### 2. Tabla `productos`
| Campo          | Tipo                         | Descripción                         |
|----------------|------------------------------|-------------------------------------|
| id             | INT (PK)                     | Identificador único                 |
| nombre         | VARCHAR(150)                 | Nombre del producto                 |
| descripcion    | TEXT                         | Descripción del producto            |
| precio         | DECIMAL(10,2)                | Precio unitario                     |
| stock          | INT                          | Cantidad en inventario              |
| estado         | ENUM('ACTIVO','INACTIVO')    | Estado del producto                 |
| categoria_id   | INT (FK)                     | Relación con categorias(id)         |
| fecha_creacion | TIMESTAMP                    | Fecha de creación                   |

### 3. Tabla `ventas`
| Campo | Tipo        | Descripción            |
|-------|-------------|------------------------|
| id    | INT (PK)    | Identificador único    |
| fecha | TIMESTAMP   | Fecha de la venta      |
| total | DECIMAL(10,2) | Monto total de la venta |

### 4. Tabla `items_venta`
| Campo         | Tipo           | Descripción                                  |
|---------------|----------------|----------------------------------------------|
| id            | INT (PK)       | Identificador único                          |
| venta_id      | INT (FK)       | Relación con ventas(id)                      |
| producto_id   | INT (FK)       | Relación con productos(id)                   |
| cantidad      | INT            | Número de productos vendidos                 |
| precio_unitario | DECIMAL(10,2) | Precio del producto al momento de la venta   |
| subtotal      | DECIMAL(10,2)  | cantidad * precio_unitario                   |

### 5. Tabla `historial`
| Campo      | Tipo                        | Descripción               |
|------------|-----------------------------|---------------------------|
| id         | INT (PK)                    | Identificador único       |
| fecha      | TIMESTAMP                   | Fecha del evento          |
| tipo_evento| ENUM('PRODUCTO','VENTA')    | Tipo de acción registrada |
| detalle    | TEXT                        | Descripción del evento    |

---

## Uso básico
1. Insertar categorías antes de productos.  
2. Insertar productos asignándolos a una categoría existente.  
3. Registrar una venta en la tabla `ventas`.  
4. Agregar los productos vendidos en `items_venta`.  
5. El total de la venta se calcula como la suma de subtotales.  
6. Cada operación relevante se registra en `historial`.  

---

## Notas
- El esquema usa **InnoDB** para soportar claves foráneas.
- Se recomienda el uso de **transacciones** para registrar ventas y actualizar stock en forma segura.
