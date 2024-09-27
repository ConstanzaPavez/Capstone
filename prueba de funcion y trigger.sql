-- Datos de prueba en la tabla miembros
INSERT INTO miembros (nombre, contacto, actividad_reciente, rut, apellido, email)
VALUES ('Juan', '123456789', 'Actividad reciente', '12345678-9', 'Pérez', 'juan.perez@example.com');

-- Probar la función buscar_y_solicitar_certificado
CALL buscar_y_solicitar_certificado('12345678-9', 'Juan', 'Pérez', 'juan.perez@example.com', 'Bautismo');

-- Verificar el contenido de la tabla solicitudes_certificados
SELECT * FROM solicitudes_certificados;

-- Verificar el contenido de la tabla logs_notificaciones
SELECT * FROM logs_notificaciones;