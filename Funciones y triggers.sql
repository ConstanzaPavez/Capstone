-- Función para buscar y solicitar certificado
DELIMITER //
CREATE PROCEDURE buscar_y_solicitar_certificado(
    IN rut_busqueda TEXT,
    IN nombre_busqueda TEXT,
    IN apellido_busqueda TEXT,
    IN correo TEXT,
    IN tipo_certificado TEXT
)
BEGIN
    DECLARE id_miembro BIGINT;
    
    -- Buscar miembro por RUT
    SELECT id INTO id_miembro FROM miembros WHERE rut = rut_busqueda;
    IF id_miembro IS NULL THEN
        -- Buscar miembro por nombre y apellido
        SELECT id INTO id_miembro FROM miembros WHERE nombre = nombre_busqueda AND apellido = apellido_busqueda;
    END IF;

    IF id_miembro IS NOT NULL THEN
        -- Insertar solicitud si se encuentra el miembro
        INSERT INTO solicitudes_certificados (miembro_id, nombre_busqueda, apellido_busqueda, rut_busqueda, email, tipo_certificado, estado)
        VALUES (id_miembro, nombre_busqueda, apellido_busqueda, rut_busqueda, correo, tipo_certificado, 'pendiente');
    ELSE
        -- Manejar caso donde no se encuentra el miembro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontró un miembro con los detalles proporcionados.';
    END IF;
END //
DELIMITER ;

-- Trigger para notificar al administrador sobre nueva solicitud
DELIMITER //
CREATE TRIGGER notificar_admin_sobre_solicitud
AFTER INSERT ON solicitudes_certificados
FOR EACH ROW
BEGIN
    -- Lógica para notificar al administrador (por ejemplo, enviar correo o entrada de registro)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = CONCAT('Nueva solicitud de certificado de ', NEW.email);
END //
DELIMITER ;