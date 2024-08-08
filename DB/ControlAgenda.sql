CREATE DATABASE ControlAgenda;
GO

USE ControlAgenda;
GO

CREATE TABLE AccesoUsuarios (
    IdAccesoUsuario INT IDENTITY(1,1),
    CorreoElectronico VARCHAR(80) UNIQUE NOT NULL,
    ContrasenaHash VARCHAR(255) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdAccesoUsuario)
);
GO

CREATE TABLE PerfilUsuarios (
    IdPerfilUsuario INT IDENTITY(1,1),
    
    Nombre VARCHAR(60) NOT NULL,
    Apellidos VARCHAR(60) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    IdAccesoUsuario INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdPerfilUsuario)
);
GO

CREATE TABLE SedesDeFormacion (
    IdSedeFormacion INT IDENTITY(1,1),
    Nombre VARCHAR(150) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdSedeFormacion)
);
GO

CREATE TABLE ProgramasDeFormacion (
    IdPrograma INT IDENTITY(1,1),
    ProgramaDeFormacion VARCHAR(80) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdPrograma)
);
GO

CREATE TABLE FichasFormacion (
    NumeroFicha INT IDENTITY(1,1),
    LugarFormacion VARCHAR(100),
    FechaInicioFormacion DATE,
    FechaInicioProductiva DATE,
    FechaFinalizacionFormacion DATE,
    JornadaFormacion VARCHAR(15),
    IdPrograma INT NOT NULL,
    IdSedeFormacion INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (NumeroFicha)
);
GO

CREATE TABLE FichasFormacion_PerfilUsuarios (
    NumeroFicha INT,
    IdPerfilUsuario INT,
    EsLider TINYINT,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (NumeroFicha, IdPerfilUsuario)
);
GO

CREATE TABLE Calendario (
    IdCalendario INT IDENTITY(1,1),
    NumeroFicha INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdCalendario)
);
GO

CREATE TABLE EstadosEvento (
    IdEstadoEvento INT IDENTITY(1,1),
    NombreEstado VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdEstadoEvento)
);
GO

CREATE TABLE Eventos (
    IdEvento INT IDENTITY(1,1),
    Competencia VARCHAR(200) NOT NULL,
    ResultadoAprendizaje VARCHAR(200) NOT NULL,
    Anotacion VARCHAR(200) NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    IdEstadoEvento INT NOT NULL,
    IdCalendario INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdEvento)
);
GO

-- Foreign Keys
ALTER TABLE PerfilUsuarios
ADD CONSTRAINT FK_PerfilUsuarios_AccesoUsuarios 
FOREIGN KEY (IdAccesoUsuario) REFERENCES AccesoUsuarios(IdAccesoUsuario) ON DELETE CASCADE;
GO

ALTER TABLE FichasFormacion
ADD CONSTRAINT FK_FichasFormacion_ProgramasDeFormacion 
FOREIGN KEY (IdPrograma) REFERENCES ProgramasDeFormacion(IdPrograma),
CONSTRAINT FK_FichasFormacion_SedesDeFormacion 
FOREIGN KEY (IdSedeFormacion) REFERENCES SedesDeFormacion(IdSedeFormacion);
GO

ALTER TABLE FichasFormacion_PerfilUsuarios
ADD CONSTRAINT FK_FichasFormacion_PerfilUsuarios_FichasFormacion 
FOREIGN KEY (NumeroFicha) REFERENCES FichasFormacion(NumeroFicha) ON DELETE CASCADE,
CONSTRAINT FK_FichasFormacion_PerfilUsuarios_PerfilUsuarios 
FOREIGN KEY (IdPerfilUsuario) REFERENCES PerfilUsuarios(IdPerfilUsuario) ON DELETE CASCADE;
GO

ALTER TABLE Calendario
ADD CONSTRAINT FK_Calendario_FichasFormacion 
FOREIGN KEY (NumeroFicha) REFERENCES FichasFormacion(NumeroFicha) ON DELETE CASCADE;
GO

ALTER TABLE Eventos
ADD CONSTRAINT FK_Eventos_Calendario 
FOREIGN KEY (IdCalendario) REFERENCES Calendario(IdCalendario) ON DELETE CASCADE,
CONSTRAINT FK_Eventos_EstadosEvento 
FOREIGN KEY (IdEstadoEvento) REFERENCES EstadosEvento(IdEstadoEvento);
GO

-- Índices para optimizar las consultas
CREATE INDEX idx_FichasFormacion_PerfilUsuarios_NumeroFicha ON FichasFormacion_PerfilUsuarios(NumeroFicha);
CREATE INDEX idx_FichasFormacion_PerfilUsuarios_IdPerfilUsuario ON FichasFormacion_PerfilUsuarios(IdPerfilUsuario);
CREATE INDEX idx_Eventos_IdCalendario ON Eventos(IdCalendario);
CREATE INDEX idx_Eventos_FechaInicio ON Eventos(FechaInicio);
GO

-- Trigger
CREATE TRIGGER create_calendar_after_insert_course
AFTER INSERT ON cursos
FOR EACH ROW
BEGIN
  CALL create_calendar_for_course(NEW.id);
END;

-- Procedimiento almacenado
CREATE PROCEDURE create_calendar_for_course(IN course_id INT)
BEGIN
  INSERT INTO calendarios (curso_id) VALUES (course_id);
  -- Enviar notificación al frontend (por ejemplo, usando un evento en un sistema de mensajes)
END;
