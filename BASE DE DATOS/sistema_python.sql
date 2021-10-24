-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-10-2021 a las 23:13:37
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_python`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id` int(10) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `foto` varchar(5000) NOT NULL,
  `estado` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `correo`, `foto`, `estado`) VALUES
(1, 'Adrian Villamar', 'villamar6002@gmail.com', 'ajshjsdfhsjkfnsklvjnvsdv6565656', 'INACTIVO'),
(2, 'Alondra Ruvalcaba', 'alondra@gmail.com', 'asdnaksdnasd5afs4a5ds45ad4a5s', 'INACTIVO'),
(4, 'Nadia', 'Moreira', 'dend082-c975d94b-dd7f-44db-832b-ac814f7e189a.jpg', 'INACTIVO'),
(13, 'modificado', '  cado cado', '2021171427rica.jpg', 'INACTIVO'),
(16, 'Nuevo', 'insertado@insertado.com', 'insertadeishon', 'INACTIVO'),
(19, 'Nuevo', 'insertado@insertado.com', 'insertadeishon', 'INACTIVO'),
(20, 'BEIDOU', 'MI AMOR', '2021225301sample-02f9d78b1975583291f8a73adad3ca36.jpg', 'INACTIVO'),
(21, 'BEIDOU', 'MI AMOR', '2021225342sample-02f9d78b1975583291f8a73adad3ca36.jpg', 'INACTIVO'),
(22, 'ufff', 'mamacita', '202122544531aa357bb4280f3f4402d2719c2e39a4.jpg', 'INACTIVO'),
(23, 'Mapa', 'Mundi', '2021151020Mapamundi-continentes.jpg', 'ACTIVO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
