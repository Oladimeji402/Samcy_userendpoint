-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2025 at 11:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user-database`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `maritalStatus` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `state` varchar(100) NOT NULL,
  `localGovt` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `nin` varchar(20) NOT NULL,
  `department` varchar(100) NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `role` enum('admin','instructor','student','parent') NOT NULL,
  `privacyPolicy` tinyint(1) NOT NULL DEFAULT 0,
  `first_login` tinyint(1) NOT NULL DEFAULT 1,
  `reset_token` varchar(100) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `phone`, `password`, `maritalStatus`, `dob`, `state`, `localGovt`, `address`, `nationality`, `nin`, `department`, `gender`, `role`, `privacyPolicy`, `first_login`, `reset_token`, `reset_token_expires`, `created_at`) VALUES
('samcy2025-001', 'bello', 'zainab', 'mailtest6543@gmail.com', '0705289244', '$2y$10$zi1aLCBxs3ckjTKoPD8a5O/t81UcpFGLCecbxY50i.vVqD1qALnAq', 'single', '2002-01-15', 'Ogun', 'Ijebu Ode', '15 Olu Street', 'Nigerian', '7085443211', 'Science', 'male', 'student', 1, 0, 'ee5e56c0bb74f678131961d4c3b1e245c21ade5948cb2cfc2a266f736a26f375', '2025-07-03 08:16:54', '2025-07-03 06:06:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `nin` (`nin`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
