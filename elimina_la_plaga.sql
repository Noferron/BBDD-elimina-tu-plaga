-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-11-2025 a las 14:05:51
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
-- Base de datos: `elimina_la_plaga`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_clientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `metros_cuadrados` INT(11) NOT NULL,
  PRIMARY KEY (`id_clientes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_clientes`, `nombre`, `direccion`, `telefono`, `email`, `metros_cuadrados`) VALUES
(1, 'Yo', 'Mi Casa', '66666666', 'yo@yo.com', 50),
(2, 'Otro', 'Aqui', '223223223', 'otro@otro.com', 120);

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
(3, 'cucaracha alemana', 80, 'cocina', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuestos`
--

CREATE TABLE `presupuestos` (
  `id_presupuestos` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_plagas` int(11) NOT NULL,
  `id_clientes` int(11) NOT NULL,
  `id_tratamientos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `presupuestos`
--

INSERT INTO `presupuestos` (`id_presupuestos`, `fecha`, `precio`, `id_plagas`, `id_clientes`, `id_tratamientos`) VALUES
(2, '2025-11-20', 160.90, 2, 1, 5);

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
(6, 'cebo alimentario', 'tratamiento con cebo en gel', 0, 90, 2, 3);

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
  ADD KEY `id_plagas` (`id_plagas`),
  ADD KEY `id_clientes` (`id_clientes`),
  ADD KEY `id_tratamientos` (`id_tratamientos`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id_tratamientos`),
  ADD KEY `id_plagas` (`id_plagas`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `plagas`
--
ALTER TABLE `plagas`
  MODIFY `id_plagas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  MODIFY `id_presupuestos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  MODIFY `id_tratamientos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD CONSTRAINT `plagas_ibfk_1` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`);

--
-- Filtros para la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  ADD CONSTRAINT `presupuestos_ibfk_1` FOREIGN KEY (`id_plagas`) REFERENCES `plagas` (`id_plagas`),
  ADD CONSTRAINT `presupuestos_ibfk_2` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`),
  ADD CONSTRAINT `presupuestos_ibfk_3` FOREIGN KEY (`id_tratamientos`) REFERENCES `tratamientos` (`id_tratamientos`);

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`id_plagas`) REFERENCES `plagas` (`id_plagas`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
