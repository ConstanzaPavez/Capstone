-- Tabla usuarios_no_miembros
CREATE TABLE usuarios_no_miembros (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    email VARCHAR(255) NOT NULL
);

-- Tabla miembros
CREATE TABLE miembros (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    contacto VARCHAR(255),
    actividad_reciente VARCHAR(255),
    rut VARCHAR(20),
    apellido VARCHAR(255),
    email VARCHAR(255)
);

-- Tabla solicitudes_certificados
CREATE TABLE solicitudes_certificados (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    miembro_id BIGINT,
    tipo_certificado VARCHAR(255) NOT NULL,
    fecha_solicitud DATE,
    estado VARCHAR(50) DEFAULT 'pendiente',
    fecha_aprobacion DATE,
    comentarios TEXT,
    usuario_no_miembro_id BIGINT,
    nombre_busqueda VARCHAR(255),
    apellido_busqueda VARCHAR(255),
    rut_busqueda VARCHAR(20),
    email VARCHAR(255),
    FOREIGN KEY (miembro_id) REFERENCES miembros(id),
    FOREIGN KEY (usuario_no_miembro_id) REFERENCES usuarios_no_miembros(id)
);

-- Tabla certificados
CREATE TABLE certificados (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255) NOT NULL,
    fecha_emision DATE,
    digitalizado TINYINT(1) DEFAULT 0,
    solicitante_id BIGINT,
    estado VARCHAR(50),
    solicitud_id BIGINT,
    FOREIGN KEY (solicitante_id) REFERENCES miembros(id),
    FOREIGN KEY (solicitud_id) REFERENCES solicitudes_certificados(id)
);

-- Tabla certificados_bautismo
CREATE TABLE certificados_bautismo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    numero_libro INT,
    numero_pagina INT,
    nombre_bautizado VARCHAR(255),
    run VARCHAR(20),
    fecha_nacimiento DATE,
    lugar_bautizado VARCHAR(255),
    hijo_de VARCHAR(255),
    y_de VARCHAR(255),
    padrinos VARCHAR(255),
    doy_fe VARCHAR(255),
    notas TEXT,
    fecha_constancia DATE,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla certificados_confirmacion
CREATE TABLE certificados_confirmacion (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    numero_libro INT,
    numero_pagina INT,
    fecha_realizacion DATE,
    hacia_quien TEXT,
    realizado_por TEXT,
    hijo_de TEXT,
    y_de TEXT,
    padrino_madrina TEXT,
    notas TEXT,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla certificados_matrimonio
CREATE TABLE certificados_matrimonio (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    numero_libro INT,
    numero_pagina INT,
    parroquia TEXT,
    fecha_realizacion DATE,
    padre_encargado TEXT,
    persona_casada TEXT,
    natural_de TEXT,
    hijo_de TEXT,
    y_de TEXT,
    testigos TEXT,
    notas TEXT,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla certificados_encuentros_bautismales
CREATE TABLE certificados_encuentros_bautismales (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    padrino1 TEXT,
    padrino2 TEXT,
    ahijado TEXT,
    fecha_nacimiento DATE,
    run TEXT,
    nota TEXT,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla certificados_partida_bautismo
CREATE TABLE certificados_partida_bautismo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    numero_libro INT,
    numero_pagina INT,
    fecha_realizacion DATE,
    se_bautizo_el TEXT,
    rut TEXT,
    nacido_el DATE,
    lugar_nacimiento TEXT,
    hijo_de TEXT,
    y_de TEXT,
    padrinos TEXT,
    nota TEXT,
    fecha_emision DATE,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla padrinos
CREATE TABLE padrinos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    nombre TEXT,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla testigos
CREATE TABLE testigos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificado_id BIGINT,
    nombre TEXT,
    FOREIGN KEY (certificado_id) REFERENCES certificados(id)
);

-- Tabla historial_solicitudes_negadas
CREATE TABLE historial_solicitudes_negadas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    solicitud_id BIGINT,
    fecha_negacion DATE,
    motivo TEXT,
    FOREIGN KEY (solicitud_id) REFERENCES solicitudes_certificados(id)
);

-- Crear tabla de logs
CREATE TABLE logs_notificaciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    mensaje TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);