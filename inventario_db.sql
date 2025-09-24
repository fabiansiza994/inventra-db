-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sistema_inventario
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE sistema_inventario;

-- ========================
-- Tabla de categorías
-- ========================
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ========================
-- Tabla de productos
-- ========================
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    estado ENUM('ACTIVO', 'INACTIVO') NOT NULL DEFAULT 'ACTIVO',
    categoria_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ========================
-- Tabla de ventas
-- ========================
CREATE TABLE IF NOT EXISTS ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- ========================
-- Tabla de items de venta
-- ========================
CREATE TABLE IF NOT EXISTS items_venta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES ventas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ========================
-- Tabla de historial
-- ========================
CREATE TABLE IF NOT EXISTS historial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_evento ENUM('CREACION', 'EDICION', 'PRODUCTO', 'VENTA') NOT NULL,
    detalle TEXT NOT NULL
) ENGINE=InnoDB;

-- ========================
-- Datos iniciales
-- ========================
INSERT IGNORE INTO categorias (nombre, descripcion) VALUES
('Electrónicos', 'Productos electrónicos y gadgets'),
('Hogar', 'Artículos para el hogar'),
('Oficina', 'Material de oficina'),
('Deportes', 'Accesorios deportivos'),
('Libros', 'Libros de diferentes géneros');

INSERT INTO productos (nombre, descripcion, precio, stock, estado, categoria_id) VALUES
('Laptop HP', 'Laptop HP Pavilion 15 pulgadas', 899.99, 10, 'ACTIVO', 1),
('Monitor LG', 'Monitor LG 24 pulgadas Full HD', 199.99, 15, 'ACTIVO', 1),
('Silla Ergonómica', 'Silla de oficina ergonómica con soporte lumbar', 149.99, 8, 'ACTIVO', 3),
('Mesa de Centro', 'Mesa de centro para sala moderna', 79.99, 5, 'ACTIVO', 2);
