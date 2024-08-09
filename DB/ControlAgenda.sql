CREATE DATABASE ControlAgenda;
GO

USE ControlAgenda;
GO

CREATE TABLE AccesoUsuarios (
    IdAccesoUsuario INT IDENTITY(1,1),
    CorreoElectronico VARCHAR(80) UNIQUE NOT NULL,
    ContrasenaHash VARCHAR(255) NOT NULL,
    PRIMARY KEY (IdAccesoUsuario)
);
GO
-- Create a new relational table with 3 columns

CREATE TABLE Roles(
  IdRol INT IDENTITY(1,1),
  Rol VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdRol)
);

CREATE TABLE PerfilUsuarios (
    IdPerfilUsuario INT IDENTITY(1,1),
    Nombre VARCHAR(60) NOT NULL,
    Apellidos VARCHAR(60) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    IdAccesoUsuario INT NOT NULL,
    IdRol INT NOT NULL,
    PRIMARY KEY (IdPerfilUsuario)
);
GO

CREATE TABLE SedesDeFormacion (
    IdSedeFormacion INT IDENTITY(1,1),
    Nombre VARCHAR(150) NOT NULL,
    PRIMARY KEY (IdSedeFormacion)
);
GO

CREATE TABLE EtapaFormacion(
    IdEtapaFormacion INT IDENTITY(1,1),
    EtapaFormacion VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdEtapaFormacion)
);
GO;

CREATE TABLE JornadaFormacion(
    IdJornadaFormacion INT IDENTITY(1,1),
    Jornada VARCHAR(15) NOT NULL,
    PRIMARY KEY (IdJornada)
)

CREATE TABLE ProgramasDeFormacion (
    IdPrograma INT IDENTITY(1,1),
    ProgramaDeFormacion VARCHAR(80) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdPrograma)
);
GO

CREATE TABLE FichasFormacion (
    NumeroFicha INT IDENTITY(1,1),
    IdPrograma INT NOT NULL,
    IdJornadaFormacion INT NOT NULL,
    IdSedeFormacion INT NOT NULL,
    IdEtapaFormacion INT NOT NULL,
    FechaInicioFormacion DATE NOT NULL,
    FechaInicioProductiva DATE NOT NULL,
    FechaFinalizacionFormacion DATE NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (NumeroFicha)
);
GO

CREATE TABLE FichasFormacion_PerfilUsuarios (
    NumeroFicha INT,
    IdPerfilUsuario INT,
    EsLider TINYINT,
    PRIMARY KEY (NumeroFicha, IdPerfilUsuario)
);
GO

CREATE TABLE Calendario (
    IdCalendario INT IDENTITY(1,1),
    NumeroFicha INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
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
    Competencia TEXT NOT NULL,
    ResultadoAprendizaje TEXT NOT NULL,
    Anotacion TEXT NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    IdEstadoEvento INT NOT NULL,
    IdCalendario INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdEvento)
);
GO

CREATE TABLE EventosArchivados (
    IdEventoArchivado INT IDENTITY(1,1),
    IdEventoOriginal INT NOT NULL,
    Competencia TEXT NOT NULL,
    ResultadoAprendizaje TEXT NOT NULL,
    Anotacion TEXT NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    IdEstadoEvento INT NOT NULL,
    IdCalendario INT NOT NULL,
    FechaArchivado DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (IdEventoArchivado)
);


-- Foreign Keys
ALTER TABLE PerfilUsuarios
ADD CONSTRAINT FK_PerfilUsuarios_AccesoUsuarios 
FOREIGN KEY (IdAccesoUsuario) REFERENCES AccesoUsuarios(IdAccesoUsuario) ON DELETE CASCADE,
CONSTRAINT FK_PerfilUsuario_Roles
FOREIGN KEY (IdRol) REFERENCES Roles(IdRol) ON DELETE CASCADE;
GO

ALTER TABLE FichasFormacion
ADD CONSTRAINT FK_FichasFormacion_ProgramasDeFormacion 
FOREIGN KEY (IdPrograma) REFERENCES ProgramasDeFormacion(IdPrograma),
CONSTRAINT FK_FichasFormacion_SedesDeFormacion 
FOREIGN KEY (IdSedeFormacion) REFERENCES SedesDeFormacion(IdSedeFormacion),
CONSTRAINT Fk_FichasFormacion_JornadaFormacion
FOREIGN KEY (IdJornadaFormacion) REFERENCES JornadaFormacion(IdJornadaFormacion),
CONSTRAINT Fk_FichasFormacion_EtapaFormacion
FOREIGN KEY (IdEtapaFormacion) REFERENCES EtapaFormacion(IdEtapaFormacion);
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

ALTER TABLE EventosArchivados
ADD CONSTRAINT FK_EventosArchivados_EstadosEvento 
FOREIGN KEY (IdEstadoEvento) REFERENCES EstadosEvento(IdEstadoEvento),
CONSTRAINT FK_EventosArchivados_Calendario 
FOREIGN KEY (IdCalendario) REFERENCES Calendario(IdCalendario);;

-- Índices para optimizar las consultas
CREATE INDEX idx_FichasFormacion_PerfilUsuarios_NumeroFicha ON FichasFormacion_PerfilUsuarios(NumeroFicha);
CREATE INDEX idx_FichasFormacion_PerfilUsuarios_IdPerfilUsuario ON FichasFormacion_PerfilUsuarios(IdPerfilUsuario);
CREATE INDEX idx_Eventos_IdCalendario ON Eventos(IdCalendario);
CREATE INDEX idx_Eventos_FechaInicio ON Eventos(FechaInicio);
CREATE INDEX idx_EventosArchivados_FechaInicio ON EventosArchivados(FechaInicio);
CREATE INDEX idx_EventosArchivados_IdEventoOriginal ON EventosArchivados(IdEventoOriginal);

GO

-- Trigger
CREATE TRIGGER create_calendar_after_insert_ficha
AFTER INSERT ON FichasFormacion
FOR EACH ROW
BEGIN
  CALL create_calendar_for_ficha(NEW.NumeroFicha);
END;

-- Procedimiento almacenado
CREATE PROCEDURE create_calendar_for_ficha(IN ficha_id INT)
BEGIN
  INSERT INTO Calendario (NumeroFicha) VALUES (NEW.ficha_id);
  -- Enviar notificación al frontend (por ejemplo, usando un evento en un sistema de mensajes)
END;
END;
GO