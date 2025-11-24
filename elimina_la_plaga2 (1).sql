-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-11-2025 a las 14:24:30
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `elimina_la_plaga2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_clientes` ()   BEGIN
  SELECT id_clientes, nombre, email
  FROM clientes
  ORDER BY nombre;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_clientes` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `metros_cuadrados` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_clientes`, `nombre`, `direccion`, `telefono`, `email`, `metros_cuadrados`) VALUES
(1, 'Yo', 'Mi Casa', '66666666', 'yo@yo.com', 50),
(2, 'Otro', 'Aqui', '223223223', 'otro@otro.com', 120),
(3, 'Pepe', 'Av.Pepe', '3434354433', 'pepe@pepe.com', 130),
(4, 'Paco', 'Av.Paco', '3432324433', 'paco@paco.com', 830),
(5, 'Marga', 'MargaCity', '444555533', 'marga@marga.com', 960);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `consulta_entre_200_y_800`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `consulta_entre_200_y_800` (
`metros_cuadrados` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plagas`
--

CREATE TABLE `plagas` (
  `id_plagas` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `infestacion` int(11) DEFAULT NULL,
  `localizacion` varchar(100) DEFAULT NULL,
  `id_clientes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plagas`
--

INSERT INTO `plagas` (`id_plagas`, `nombre`, `infestacion`, `localizacion`, `id_clientes`) VALUES
(2, 'cucaracha americana', 100, 'falso techo', 1),
(3, 'cucaracha alemana', 80, 'cocina', 2),
(4, 'avispa papelera', 50, 'tejado', 3),
(5, 'termitas', 80, 'vigas de madera techo', 4),
(6, 'ratas', 60, 'falsos techos', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuestos`
--

CREATE TABLE `presupuestos` (
  `id_presupuestos` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_plagas` int(11) NOT NULL,
  `id_tratamientos` int(11) NOT NULL,
  `id_clientes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `presupuestos`
--

INSERT INTO `presupuestos` (`id_presupuestos`, `fecha`, `precio`, `id_plagas`, `id_tratamientos`, `id_clientes`) VALUES
(5, '2025-11-21', 181.50, 3, 5, 1),
(6, '2025-11-24', 360.00, 4, 7, 3),
(7, '2025-11-27', 3500.00, 5, 8, 4),
(8, '0000-00-00', 220.00, 3, 6, 2),
(9, '0000-00-00', 360.00, 4, 7, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `relacion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `relacion` (
`plagas` varchar(100)
,`clientes` varchar(100)
,`tratamientos` varchar(100)
,`revisiones` int(11)
,`tiempo_trabajo_minutos` int(11)
,`precio_€` decimal(10,2)
,`plazo_seguridad` varchar(2)
,`precio_por_trabajo_€` decimal(11,2)
,`precio_por_minuto_€` decimal(11,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `id_tratamientos` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `plazo_seguridad` tinyint(1) DEFAULT NULL,
  `duracion` int(11) NOT NULL,
  `repeticiones` int(11) NOT NULL,
  `id_plagas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamientos`
--

INSERT INTO `tratamientos` (`id_tratamientos`, `nombre`, `descripcion`, `plazo_seguridad`, `duracion`, `repeticiones`, `id_plagas`) VALUES
(5, 'nebulización', 'pulverización eléctrica aérea', 1, 90, 2, 2),
(6, 'cebo alimentario', 'tratamiento con cebo en gel', 0, 90, 2, 3),
(7, 'pulverización', 'pulverización en el tejado', 1, 90, 1, 4),
(8, 'cebo termitas', 'tratamiento con cebo envenenado con juvenoides contra termitas', 0, 200, 10, 5),
(9, 'cebo rodenticida', 'tratamiento con cebo rodendicita con anticoagulantes', 0, 60, 1, 6);

-- --------------------------------------------------------

--
-- Estructura para la vista `consulta_entre_200_y_800`
--
DROP TABLE IF EXISTS `consulta_entre_200_y_800`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `consulta_entre_200_y_800`  AS SELECT `clientes`.`metros_cuadrados` AS `metros_cuadrados` FROM `clientes` WHERE `clientes`.`metros_cuadrados` > 200 AND `clientes`.`metros_cuadrados` < 800 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `relacion`
--
DROP TABLE IF EXISTS `relacion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Relacion_entre_tablas`@`%` SQL SECURITY DEFINER VIEW `relacion`  AS SELECT `plagas`.`nombre` AS `plagas`, `clientes`.`nombre` AS `clientes`, `tratamientos`.`nombre` AS `tratamientos`, `tratamientos`.`repeticiones` AS `revisiones`, `tratamientos`.`duracion` AS `tiempo_trabajo_minutos`, `presupuestos`.`precio` AS `precio_€`, CASE WHEN `tratamientos`.`plazo_seguridad` = 1 THEN 'Sí' ELSE 'No' END AS `plazo_seguridad`, round(`presupuestos`.`precio` / `tratamientos`.`repeticiones`,2) AS `precio_por_trabajo_€`, round(`presupuestos`.`precio` / `tratamientos`.`duracion`,2) AS `precio_por_minuto_€` FROM (((`presupuestos` join `clientes` on(`presupuestos`.`id_clientes` = `clientes`.`id_clientes`)) join `plagas` on(`presupuestos`.`id_plagas` = `plagas`.`id_plagas`)) join `tratamientos` on(`presupuestos`.`id_tratamientos` = `tratamientos`.`id_tratamientos`)) ORDER BY round(`presupuestos`.`precio` / `tratamientos`.`repeticiones`,2) DESC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_clientes`);

--
-- Indices de la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD PRIMARY KEY (`id_plagas`),
  ADD KEY `id_clientes` (`id_clientes`);

--
-- Indices de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  ADD PRIMARY KEY (`id_presupuestos`),
  ADD KEY `id_tratamientos` (`id_tratamientos`),
  ADD KEY `id_plaga` (`id_plagas`),
  ADD KEY `id_cliente` (`id_clientes`) USING BTREE;

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id_tratamientos`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `plagas`
--
ALTER TABLE `plagas`
  MODIFY `id_plagas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  MODIFY `id_presupuestos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  MODIFY `id_tratamientos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD CONSTRAINT `id_clientes` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`);

--
-- Filtros para la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  ADD CONSTRAINT `id_cliente` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`),
  ADD CONSTRAINT `id_plaga` FOREIGN KEY (`id_plagas`) REFERENCES `plagas` (`id_plagas`),
  ADD CONSTRAINT `id_plagas` FOREIGN KEY (`id_plagas`) REFERENCES `plagas` (`id_plagas`),
  ADD CONSTRAINT `id_tratamientos` FOREIGN KEY (`id_tratamientos`) REFERENCES `tratamientos` (`id_tratamientos`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
