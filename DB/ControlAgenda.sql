-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-08-2024 a las 19:39:03
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `controlagenda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesousuarios`
--

CREATE TABLE `accesousuarios` (
  `IdAccesoUsuario` int(11) NOT NULL,
  `CorreoElectronico` varchar(80) NOT NULL,
  `Contrasena` varbinary(80) NOT NULL,
  `PerfilUsuarios_IdPerfilUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario`
--

CREATE TABLE `calendario` (
  `IdCalendario` int(11) NOT NULL,
  `FichasFormacion_NumeroFicha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calendario`
--

INSERT INTO `calendario` (`IdCalendario`, `FichasFormacion_NumeroFicha`) VALUES
(2, 2895636);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competenciasaprendizaje`
--

CREATE TABLE `competenciasaprendizaje` (
  `NumeroCompetencia` int(11) NOT NULL,
  `NombreCompetencia` text NOT NULL,
  `DiasDuracion` int(11) NOT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFinal` date DEFAULT NULL,
  `ProgramasDeFormacion_IdPrograma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `competenciasaprendizaje`
--

INSERT INTO `competenciasaprendizaje` (`NumeroCompetencia`, `NombreCompetencia`, `DiasDuracion`, `FechaInicio`, `FechaFinal`, `ProgramasDeFormacion_IdPrograma`) VALUES
(1, 'Analisis de Requerimientos', 20, '2024-08-26', '2024-08-30', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoeventos`
--

CREATE TABLE `estadoeventos` (
  `IdEstado` int(11) NOT NULL,
  `Estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estadoeventos`
--

INSERT INTO `estadoeventos` (`IdEstado`, `Estado`) VALUES
(1, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapadeformacion`
--

CREATE TABLE `etapadeformacion` (
  `IdEtapaFormacion` int(11) NOT NULL,
  `Etapa` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `etapadeformacion`
--

INSERT INTO `etapadeformacion` (`IdEtapaFormacion`, `Etapa`) VALUES
(1, 'Lectiva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `IdEvento` int(11) NOT NULL,
  `FechaInicio` datetime NOT NULL,
  `FechaFin` datetime NOT NULL,
  `Calendario_IdCalendario` int(11) NOT NULL,
  `EstadoEventos_IdEstado` int(11) NOT NULL,
  `PerfilUsuarios_IdPerfilUsuario` int(11) NOT NULL,
  `ResultadosAprendizaje_NumeroResultado` int(11) NOT NULL,
  `CompetenciasAprendizaje_NumeroCompetencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`IdEvento`, `FechaInicio`, `FechaFin`, `Calendario_IdCalendario`, `EstadoEventos_IdEstado`, `PerfilUsuarios_IdPerfilUsuario`, `ResultadosAprendizaje_NumeroResultado`, `CompetenciasAprendizaje_NumeroCompetencia`) VALUES
(2, '2024-08-26 17:09:13', '2024-08-26 17:09:13', 2, 1, 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventosarchivados`
--

CREATE TABLE `eventosarchivados` (
  `IdEvento` int(11) NOT NULL,
  `FechaInicio` datetime NOT NULL,
  `FechaFin` datetime NOT NULL,
  `Calendario_IdCalendario` int(11) NOT NULL,
  `EstadoEventos_IdEstado` int(11) NOT NULL,
  `PerfilUsuarios_IdPerfilUsuario` int(11) NOT NULL,
  `ResultadosAprendizaje_NumeroResultado` int(11) NOT NULL,
  `CompetenciasAprendizaje_NumeroCompetencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichasformacion`
--

CREATE TABLE `fichasformacion` (
  `NumeroFicha` int(11) NOT NULL,
  `FechaInicioFormacion` date NOT NULL,
  `FechaInicioProductiva` date NOT NULL,
  `FechaFinalizacionFormacion` date NOT NULL,
  `IdPrograma` int(11) NOT NULL,
  `SedesDeFormacion_IdSedeFormacion` int(11) NOT NULL,
  `JornadaFormacion_IdJornadaFormacion` int(11) NOT NULL,
  `EtapaDeFormacion_IdEtapaFormacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fichasformacion`
--

INSERT INTO `fichasformacion` (`NumeroFicha`, `FechaInicioFormacion`, `FechaInicioProductiva`, `FechaFinalizacionFormacion`, `IdPrograma`, `SedesDeFormacion_IdSedeFormacion`, `JornadaFormacion_IdJornadaFormacion`, `EtapaDeFormacion_IdEtapaFormacion`) VALUES
(2895636, '2024-08-26', '2024-08-30', '2024-09-04', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichasformacion_perfilusuarios`
--

CREATE TABLE `fichasformacion_perfilusuarios` (
  `NumeroFicha` int(11) NOT NULL,
  `IdPerfilUsuario` int(11) NOT NULL,
  `EsLider` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jornadaformacion`
--

CREATE TABLE `jornadaformacion` (
  `IdJornadaFormacion` int(11) NOT NULL,
  `JornadaFormacion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jornadaformacion`
--

INSERT INTO `jornadaformacion` (`IdJornadaFormacion`, `JornadaFormacion`) VALUES
(1, 'Diurna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfilusuarios`
--

CREATE TABLE `perfilusuarios` (
  `IdPerfilUsuario` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellidos` varchar(60) NOT NULL,
  `Telefono` bigint(20) NOT NULL,
  `Roles_IdRol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perfilusuarios`
--

INSERT INTO `perfilusuarios` (`IdPerfilUsuario`, `Nombre`, `Apellidos`, `Telefono`, `Roles_IdRol`) VALUES
(2, 'Juan Felipe', 'Usme', 3116405286, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programasdeformacion`
--

CREATE TABLE `programasdeformacion` (
  `IdPrograma` int(11) NOT NULL,
  `ProgramDeFormacion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `programasdeformacion`
--

INSERT INTO `programasdeformacion` (`IdPrograma`, `ProgramDeFormacion`) VALUES
(1, 'ADSO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultadosaprendizaje`
--

CREATE TABLE `resultadosaprendizaje` (
  `NumeroResultado` int(11) NOT NULL,
  `NombreResultado` text NOT NULL,
  `CompetenciasAprendizaje_NumeroCompetencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resultadosaprendizaje`
--

INSERT INTO `resultadosaprendizaje` (`NumeroResultado`, `NombreResultado`, `CompetenciasAprendizaje_NumeroCompetencia`) VALUES
(1, 'Analisis de los requerimientos funcionales del cliente para la contruccion del software', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `IdRol` int(11) NOT NULL,
  `Rol` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`IdRol`, `Rol`) VALUES
(1, 'Instructor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedesdeformacion`
--

CREATE TABLE `sedesdeformacion` (
  `IdSedeFormacion` int(11) NOT NULL,
  `SedesDeFormacion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedesdeformacion`
--

INSERT INTO `sedesdeformacion` (`IdSedeFormacion`, `SedesDeFormacion`) VALUES
(1, 'Remington');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewevento`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewevento` (
`NombreCompetencia` text
,`NombreResultado` text
,`NombreUsuario` varchar(60)
,`FechaInicio` datetime
,`FechaFin` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vieweventoarchivado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vieweventoarchivado` (
`NombreCompetencia` text
,`NombreResultado` text
,`NombreUsuario` varchar(60)
,`FechaInicio` datetime
,`FechaFin` datetime
);

-- --------------------------------------------------------

--
-- Estructura para la vista `viewevento`
--
DROP TABLE IF EXISTS `viewevento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewevento`  AS SELECT `c`.`NombreCompetencia` AS `NombreCompetencia`, `r`.`NombreResultado` AS `NombreResultado`, `u`.`Nombre` AS `NombreUsuario`, `e`.`FechaInicio` AS `FechaInicio`, `e`.`FechaFin` AS `FechaFin` FROM (((`eventos` `e` join `perfilusuarios` `u` on(`e`.`PerfilUsuarios_IdPerfilUsuario` = `u`.`IdPerfilUsuario`)) join `competenciasaprendizaje` `c` on(`e`.`CompetenciasAprendizaje_NumeroCompetencia` = `c`.`NumeroCompetencia`)) join `resultadosaprendizaje` `r` on(`e`.`ResultadosAprendizaje_NumeroResultado` = `r`.`NumeroResultado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vieweventoarchivado`
--
DROP TABLE IF EXISTS `vieweventoarchivado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vieweventoarchivado`  AS SELECT `c`.`NombreCompetencia` AS `NombreCompetencia`, `r`.`NombreResultado` AS `NombreResultado`, `u`.`Nombre` AS `NombreUsuario`, `e`.`FechaInicio` AS `FechaInicio`, `e`.`FechaFin` AS `FechaFin` FROM (((`eventosarchivados` `e` join `perfilusuarios` `u` on(`e`.`PerfilUsuarios_IdPerfilUsuario` = `u`.`IdPerfilUsuario`)) join `competenciasaprendizaje` `c` on(`e`.`CompetenciasAprendizaje_NumeroCompetencia` = `c`.`NumeroCompetencia`)) join `resultadosaprendizaje` `r` on(`e`.`ResultadosAprendizaje_NumeroResultado` = `r`.`NumeroResultado`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesousuarios`
--
ALTER TABLE `accesousuarios`
  ADD PRIMARY KEY (`IdAccesoUsuario`),
  ADD UNIQUE KEY `CorreoElectronico_UNIQUE` (`CorreoElectronico`),
  ADD KEY `fk_AccesoUsuarios_PerfilUsuarios1_idx` (`PerfilUsuarios_IdPerfilUsuario`);

--
-- Indices de la tabla `calendario`
--
ALTER TABLE `calendario`
  ADD PRIMARY KEY (`IdCalendario`),
  ADD KEY `fk_Calendario_FichasFormacion1_idx` (`FichasFormacion_NumeroFicha`);

--
-- Indices de la tabla `competenciasaprendizaje`
--
ALTER TABLE `competenciasaprendizaje`
  ADD PRIMARY KEY (`NumeroCompetencia`),
  ADD KEY `fk_CompetenciasAprendizaje_ProgramasDeFormacion1_idx` (`ProgramasDeFormacion_IdPrograma`);

--
-- Indices de la tabla `estadoeventos`
--
ALTER TABLE `estadoeventos`
  ADD PRIMARY KEY (`IdEstado`);

--
-- Indices de la tabla `etapadeformacion`
--
ALTER TABLE `etapadeformacion`
  ADD PRIMARY KEY (`IdEtapaFormacion`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`IdEvento`),
  ADD KEY `fk_Eventos_Calendario1_idx` (`Calendario_IdCalendario`),
  ADD KEY `fk_Eventos_EstadoEventos1_idx` (`EstadoEventos_IdEstado`),
  ADD KEY `fk_Eventos_PerfilUsuarios1_idx` (`PerfilUsuarios_IdPerfilUsuario`),
  ADD KEY `fk_Eventos_ResultadosAprendizaje1_idx` (`ResultadosAprendizaje_NumeroResultado`),
  ADD KEY `fk_Eventos_CompetenciasAprendizaje1_idx` (`CompetenciasAprendizaje_NumeroCompetencia`);

--
-- Indices de la tabla `eventosarchivados`
--
ALTER TABLE `eventosarchivados`
  ADD PRIMARY KEY (`IdEvento`),
  ADD KEY `fk_EventosArchivados_Calendario1_idx` (`Calendario_IdCalendario`),
  ADD KEY `fk_EventosArchivados_EstadoEventos1_idx` (`EstadoEventos_IdEstado`),
  ADD KEY `fk_EventosArchivados_PerfilUsuarios1_idx` (`PerfilUsuarios_IdPerfilUsuario`),
  ADD KEY `fk_EventosArchivados_ResultadosAprendizaje1_idx` (`ResultadosAprendizaje_NumeroResultado`),
  ADD KEY `fk_EventosArchivados_CompetenciasAprendizaje1_idx` (`CompetenciasAprendizaje_NumeroCompetencia`);

--
-- Indices de la tabla `fichasformacion`
--
ALTER TABLE `fichasformacion`
  ADD PRIMARY KEY (`NumeroFicha`),
  ADD KEY `fk_FichasFormacion_ProgramasDeFormacion_idx` (`IdPrograma`),
  ADD KEY `fk_FichasFormacion_SedesDeFormacion1_idx` (`SedesDeFormacion_IdSedeFormacion`),
  ADD KEY `fk_FichasFormacion_JornadaFormacion1_idx` (`JornadaFormacion_IdJornadaFormacion`),
  ADD KEY `fk_FichasFormacion_EtapaDeFormacion1_idx` (`EtapaDeFormacion_IdEtapaFormacion`);

--
-- Indices de la tabla `fichasformacion_perfilusuarios`
--
ALTER TABLE `fichasformacion_perfilusuarios`
  ADD PRIMARY KEY (`NumeroFicha`,`IdPerfilUsuario`),
  ADD KEY `fk_FichasFormacion_has_PerfilUsuarios_PerfilUsuarios1_idx` (`IdPerfilUsuario`),
  ADD KEY `fk_FichasFormacion_has_PerfilUsuarios_FichasFormacion1_idx` (`NumeroFicha`);

--
-- Indices de la tabla `jornadaformacion`
--
ALTER TABLE `jornadaformacion`
  ADD PRIMARY KEY (`IdJornadaFormacion`);

--
-- Indices de la tabla `perfilusuarios`
--
ALTER TABLE `perfilusuarios`
  ADD PRIMARY KEY (`IdPerfilUsuario`),
  ADD KEY `fk_PerfilUsuarios_Roles1_idx` (`Roles_IdRol`);

--
-- Indices de la tabla `programasdeformacion`
--
ALTER TABLE `programasdeformacion`
  ADD PRIMARY KEY (`IdPrograma`);

--
-- Indices de la tabla `resultadosaprendizaje`
--
ALTER TABLE `resultadosaprendizaje`
  ADD PRIMARY KEY (`NumeroResultado`),
  ADD KEY `fk_ResultadosAprendizaje_CompetenciasAprendizaje1_idx` (`CompetenciasAprendizaje_NumeroCompetencia`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`IdRol`);

--
-- Indices de la tabla `sedesdeformacion`
--
ALTER TABLE `sedesdeformacion`
  ADD PRIMARY KEY (`IdSedeFormacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesousuarios`
--
ALTER TABLE `accesousuarios`
  MODIFY `IdAccesoUsuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calendario`
--
ALTER TABLE `calendario`
  MODIFY `IdCalendario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `competenciasaprendizaje`
--
ALTER TABLE `competenciasaprendizaje`
  MODIFY `NumeroCompetencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `estadoeventos`
--
ALTER TABLE `estadoeventos`
  MODIFY `IdEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `etapadeformacion`
--
ALTER TABLE `etapadeformacion`
  MODIFY `IdEtapaFormacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `IdEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `eventosarchivados`
--
ALTER TABLE `eventosarchivados`
  MODIFY `IdEvento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fichasformacion`
--
ALTER TABLE `fichasformacion`
  MODIFY `NumeroFicha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2895637;

--
-- AUTO_INCREMENT de la tabla `jornadaformacion`
--
ALTER TABLE `jornadaformacion`
  MODIFY `IdJornadaFormacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `perfilusuarios`
--
ALTER TABLE `perfilusuarios`
  MODIFY `IdPerfilUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `programasdeformacion`
--
ALTER TABLE `programasdeformacion`
  MODIFY `IdPrograma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `IdRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sedesdeformacion`
--
ALTER TABLE `sedesdeformacion`
  MODIFY `IdSedeFormacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accesousuarios`
--
ALTER TABLE `accesousuarios`
  ADD CONSTRAINT `fk_AccesoUsuarios_PerfilUsuarios1` FOREIGN KEY (`PerfilUsuarios_IdPerfilUsuario`) REFERENCES `perfilusuarios` (`IdPerfilUsuario`);

--
-- Filtros para la tabla `calendario`
--
ALTER TABLE `calendario`
  ADD CONSTRAINT `fk_Calendario_FichasFormacion1` FOREIGN KEY (`FichasFormacion_NumeroFicha`) REFERENCES `fichasformacion` (`NumeroFicha`);

--
-- Filtros para la tabla `competenciasaprendizaje`
--
ALTER TABLE `competenciasaprendizaje`
  ADD CONSTRAINT `fk_CompetenciasAprendizaje_ProgramasDeFormacion1` FOREIGN KEY (`ProgramasDeFormacion_IdPrograma`) REFERENCES `programasdeformacion` (`IdPrograma`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `fk_Eventos_Calendario1` FOREIGN KEY (`Calendario_IdCalendario`) REFERENCES `calendario` (`IdCalendario`),
  ADD CONSTRAINT `fk_Eventos_CompetenciasAprendizaje1` FOREIGN KEY (`CompetenciasAprendizaje_NumeroCompetencia`) REFERENCES `competenciasaprendizaje` (`NumeroCompetencia`),
  ADD CONSTRAINT `fk_Eventos_EstadoEventos1` FOREIGN KEY (`EstadoEventos_IdEstado`) REFERENCES `estadoeventos` (`IdEstado`),
  ADD CONSTRAINT `fk_Eventos_PerfilUsuarios1` FOREIGN KEY (`PerfilUsuarios_IdPerfilUsuario`) REFERENCES `perfilusuarios` (`IdPerfilUsuario`),
  ADD CONSTRAINT `fk_Eventos_ResultadosAprendizaje1` FOREIGN KEY (`ResultadosAprendizaje_NumeroResultado`) REFERENCES `resultadosaprendizaje` (`NumeroResultado`);

--
-- Filtros para la tabla `eventosarchivados`
--
ALTER TABLE `eventosarchivados`
  ADD CONSTRAINT `fk_EventosArchivados_Calendario1` FOREIGN KEY (`Calendario_IdCalendario`) REFERENCES `calendario` (`IdCalendario`),
  ADD CONSTRAINT `fk_EventosArchivados_CompetenciasAprendizaje1` FOREIGN KEY (`CompetenciasAprendizaje_NumeroCompetencia`) REFERENCES `competenciasaprendizaje` (`NumeroCompetencia`),
  ADD CONSTRAINT `fk_EventosArchivados_EstadoEventos1` FOREIGN KEY (`EstadoEventos_IdEstado`) REFERENCES `estadoeventos` (`IdEstado`),
  ADD CONSTRAINT `fk_EventosArchivados_PerfilUsuarios1` FOREIGN KEY (`PerfilUsuarios_IdPerfilUsuario`) REFERENCES `perfilusuarios` (`IdPerfilUsuario`),
  ADD CONSTRAINT `fk_EventosArchivados_ResultadosAprendizaje1` FOREIGN KEY (`ResultadosAprendizaje_NumeroResultado`) REFERENCES `resultadosaprendizaje` (`NumeroResultado`);

--
-- Filtros para la tabla `fichasformacion`
--
ALTER TABLE `fichasformacion`
  ADD CONSTRAINT `fk_FichasFormacion_EtapaDeFormacion1` FOREIGN KEY (`EtapaDeFormacion_IdEtapaFormacion`) REFERENCES `etapadeformacion` (`IdEtapaFormacion`),
  ADD CONSTRAINT `fk_FichasFormacion_JornadaFormacion1` FOREIGN KEY (`JornadaFormacion_IdJornadaFormacion`) REFERENCES `jornadaformacion` (`IdJornadaFormacion`),
  ADD CONSTRAINT `fk_FichasFormacion_ProgramasDeFormacion` FOREIGN KEY (`IdPrograma`) REFERENCES `programasdeformacion` (`IdPrograma`),
  ADD CONSTRAINT `fk_FichasFormacion_SedesDeFormacion1` FOREIGN KEY (`SedesDeFormacion_IdSedeFormacion`) REFERENCES `sedesdeformacion` (`IdSedeFormacion`);

--
-- Filtros para la tabla `fichasformacion_perfilusuarios`
--
ALTER TABLE `fichasformacion_perfilusuarios`
  ADD CONSTRAINT `fk_FichasFormacion_has_PerfilUsuarios_FichasFormacion1` FOREIGN KEY (`NumeroFicha`) REFERENCES `fichasformacion` (`NumeroFicha`),
  ADD CONSTRAINT `fk_FichasFormacion_has_PerfilUsuarios_PerfilUsuarios1` FOREIGN KEY (`IdPerfilUsuario`) REFERENCES `perfilusuarios` (`IdPerfilUsuario`);

--
-- Filtros para la tabla `perfilusuarios`
--
ALTER TABLE `perfilusuarios`
  ADD CONSTRAINT `fk_PerfilUsuarios_Roles1` FOREIGN KEY (`Roles_IdRol`) REFERENCES `roles` (`IdRol`);

--
-- Filtros para la tabla `resultadosaprendizaje`
--
ALTER TABLE `resultadosaprendizaje`
  ADD CONSTRAINT `fk_ResultadosAprendizaje_CompetenciasAprendizaje1` FOREIGN KEY (`CompetenciasAprendizaje_NumeroCompetencia`) REFERENCES `competenciasaprendizaje` (`NumeroCompetencia`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
