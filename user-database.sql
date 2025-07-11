-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2025 at 06:12 PM
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
-- Table structure for table `course_subjects`
--

CREATE TABLE `course_subjects` (
  `id` varchar(30) NOT NULL,
  `program_id` varchar(30) DEFAULT NULL,
  `department_id` varchar(30) DEFAULT NULL,
  `global_subject_id` varchar(30) DEFAULT NULL,
  `is_compulsory` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_subjects`
--

INSERT INTO `course_subjects` (`id`, `program_id`, `department_id`, `global_subject_id`, `is_compulsory`, `created_at`) VALUES
('cs/2025/001', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/001', 1, '2025-07-05 13:19:53'),
('cs/2025/002', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/002', 1, '2025-07-05 13:19:53'),
('cs/2025/003', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/003', 1, '2025-07-05 13:19:53'),
('cs/2025/004', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/004', 1, '2025-07-05 13:19:53'),
('cs/2025/005', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/005', 0, '2025-07-05 13:19:53'),
('cs/2025/006', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/006', 0, '2025-07-05 13:19:53'),
('cs/2025/007', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/007', 0, '2025-07-05 13:19:53'),
('cs/2025/008', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/008', 0, '2025-07-05 13:19:53'),
('cs/2025/009', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/009', 0, '2025-07-05 13:19:53'),
('cs/2025/010', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/010', 0, '2025-07-05 13:19:53'),
('cs/2025/011', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/011', 0, '2025-07-05 13:19:53'),
('cs/2025/012', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/012', 0, '2025-07-05 13:19:53'),
('cs/2025/013', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/013', 0, '2025-07-05 13:19:53'),
('cs/2025/014', 'program/2025/001', 'dept/2025/001', 'gsubject/2025/014', 0, '2025-07-05 13:19:53'),
('cs/2025/015', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/001', 1, '2025-07-05 13:19:53'),
('cs/2025/016', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/002', 1, '2025-07-05 13:19:53'),
('cs/2025/017', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/003', 1, '2025-07-05 13:19:53'),
('cs/2025/018', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/015', 1, '2025-07-05 13:19:53'),
('cs/2025/019', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/016', 0, '2025-07-05 13:19:53'),
('cs/2025/020', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/017', 0, '2025-07-05 13:19:53'),
('cs/2025/021', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/018', 0, '2025-07-05 13:19:53'),
('cs/2025/022', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/019', 0, '2025-07-05 13:19:53'),
('cs/2025/023', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/020', 0, '2025-07-05 13:19:53'),
('cs/2025/024', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/021', 0, '2025-07-05 13:19:53'),
('cs/2025/025', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/022', 0, '2025-07-05 13:19:53'),
('cs/2025/026', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/023', 0, '2025-07-05 13:19:53'),
('cs/2025/027', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/024', 0, '2025-07-05 13:19:53'),
('cs/2025/028', 'program/2025/001', 'dept/2025/002', 'gsubject/2025/025', 0, '2025-07-05 13:19:53'),
('cs/2025/029', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/001', 1, '2025-07-05 13:19:53'),
('cs/2025/030', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/002', 1, '2025-07-05 13:19:53'),
('cs/2025/031', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/003', 1, '2025-07-05 13:19:53'),
('cs/2025/032', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/026', 1, '2025-07-05 13:19:53'),
('cs/2025/033', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/027', 0, '2025-07-05 13:19:53'),
('cs/2025/034', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/028', 0, '2025-07-05 13:19:53'),
('cs/2025/035', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/029', 0, '2025-07-05 13:19:53'),
('cs/2025/036', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/030', 0, '2025-07-05 13:19:53'),
('cs/2025/037', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/031', 0, '2025-07-05 13:19:53'),
('cs/2025/038', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/032', 0, '2025-07-05 13:19:53'),
('cs/2025/039', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/033', 0, '2025-07-05 13:19:53'),
('cs/2025/040', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/034', 0, '2025-07-05 13:19:53'),
('cs/2025/041', 'program/2025/001', 'dept/2025/003', 'gsubject/2025/035', 0, '2025-07-05 13:19:53'),
('cs/2025/042', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/001', 1, '2025-07-05 13:34:06'),
('cs/2025/043', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/002', 0, '2025-07-05 13:34:06'),
('cs/2025/044', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/004', 0, '2025-07-05 13:34:06'),
('cs/2025/045', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/005', 0, '2025-07-05 13:34:06'),
('cs/2025/046', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/006', 0, '2025-07-05 13:34:06'),
('cs/2025/047', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/007', 0, '2025-07-05 13:34:06'),
('cs/2025/048', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/010', 0, '2025-07-05 13:34:06'),
('cs/2025/049', 'program/2025/002', 'dept/2025/001', 'gsubject/2025/008', 0, '2025-07-05 13:34:06'),
('cs/2025/050', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/001', 1, '2025-07-05 13:35:53'),
('cs/2025/051', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/015', 0, '2025-07-05 13:35:53'),
('cs/2025/052', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/016', 0, '2025-07-05 13:35:53'),
('cs/2025/053', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/017', 0, '2025-07-05 13:35:53'),
('cs/2025/054', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/018', 0, '2025-07-05 13:35:53'),
('cs/2025/055', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/019', 0, '2025-07-05 13:35:53'),
('cs/2025/056', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/009', 0, '2025-07-05 13:35:53'),
('cs/2025/057', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/021', 0, '2025-07-05 13:35:53'),
('cs/2025/058', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/020', 0, '2025-07-05 13:35:53'),
('cs/2025/059', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/022', 0, '2025-07-05 13:35:53'),
('cs/2025/060', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/023', 0, '2025-07-05 13:35:53'),
('cs/2025/061', 'program/2025/002', 'dept/2025/002', 'gsubject/2025/024', 0, '2025-07-05 13:35:53'),
('cs/2025/062', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/001', 1, '2025-07-05 13:37:23'),
('cs/2025/063', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/026', 0, '2025-07-05 13:37:23'),
('cs/2025/064', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/027', 0, '2025-07-05 13:37:23'),
('cs/2025/065', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/029', 0, '2025-07-05 13:37:23'),
('cs/2025/066', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/030', 0, '2025-07-05 13:37:23'),
('cs/2025/067', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/031', 0, '2025-07-05 13:37:23'),
('cs/2025/068', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/033', 0, '2025-07-05 13:37:23'),
('cs/2025/069', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/032', 0, '2025-07-05 13:37:23'),
('cs/2025/070', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/034', 0, '2025-07-05 13:37:23'),
('cs/2025/071', 'program/2025/002', 'dept/2025/003', 'gsubject/2025/035', 0, '2025-07-05 13:37:23'),
('cs/2025/072', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/001', 1, '2025-07-05 13:44:52'),
('cs/2025/073', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/002', 1, '2025-07-05 13:44:52'),
('cs/2025/074', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/004', 0, '2025-07-05 13:44:52'),
('cs/2025/075', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/005', 0, '2025-07-05 13:44:52'),
('cs/2025/076', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/006', 0, '2025-07-05 13:44:52'),
('cs/2025/077', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/007', 0, '2025-07-05 13:44:52'),
('cs/2025/078', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/012', 0, '2025-07-05 13:44:52'),
('cs/2025/079', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/009', 0, '2025-07-05 13:44:52'),
('cs/2025/080', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/011', 0, '2025-07-05 13:44:52'),
('cs/2025/081', 'program/2025/003', 'dept/2025/001', 'gsubject/2025/010', 0, '2025-07-05 13:44:52'),
('cs/2025/082', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/001', 1, '2025-07-05 13:48:04'),
('cs/2025/083', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/002', 1, '2025-07-05 13:48:04'),
('cs/2025/084', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/015', 0, '2025-07-05 13:48:04'),
('cs/2025/085', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/016', 0, '2025-07-05 13:48:04'),
('cs/2025/086', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/017', 0, '2025-07-05 13:48:04'),
('cs/2025/087', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/018', 0, '2025-07-05 13:48:04'),
('cs/2025/088', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/019', 0, '2025-07-05 13:48:04'),
('cs/2025/089', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/021', 0, '2025-07-05 13:48:04'),
('cs/2025/090', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/022', 0, '2025-07-05 13:48:04'),
('cs/2025/091', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/023', 0, '2025-07-05 13:48:04'),
('cs/2025/092', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/024', 0, '2025-07-05 13:48:04'),
('cs/2025/093', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/025', 0, '2025-07-05 13:48:04'),
('cs/2025/094', 'program/2025/003', 'dept/2025/002', 'gsubject/2025/020', 0, '2025-07-05 13:48:04'),
('cs/2025/095', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/001', 1, '2025-07-05 13:50:26'),
('cs/2025/096', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/002', 1, '2025-07-05 13:50:26'),
('cs/2025/097', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/026', 0, '2025-07-05 13:50:26'),
('cs/2025/098', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/027', 0, '2025-07-05 13:50:26'),
('cs/2025/099', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/028', 0, '2025-07-05 13:50:26'),
('cs/2025/100', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/029', 0, '2025-07-05 13:50:26'),
('cs/2025/101', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/030', 0, '2025-07-05 13:50:26'),
('cs/2025/102', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/031', 0, '2025-07-05 13:50:26'),
('cs/2025/103', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/032', 0, '2025-07-05 13:50:26'),
('cs/2025/104', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/033', 0, '2025-07-05 13:50:26'),
('cs/2025/105', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/034', 0, '2025-07-05 13:50:26'),
('cs/2025/106', 'program/2025/003', 'dept/2025/003', 'gsubject/2025/035', 0, '2025-07-05 13:50:26'),
('cs/2025/107', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/001', 1, '2025-07-05 14:17:30'),
('cs/2025/108', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/002', 1, '2025-07-05 14:17:30'),
('cs/2025/109', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/004', 1, '2025-07-05 14:17:30'),
('cs/2025/110', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/005', 1, '2025-07-05 14:17:30'),
('cs/2025/111', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/006', 0, '2025-07-05 14:17:30'),
('cs/2025/112', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/008', 0, '2025-07-05 14:17:30'),
('cs/2025/113', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/007', 0, '2025-07-05 14:17:30'),
('cs/2025/114', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/009', 0, '2025-07-05 14:17:30'),
('cs/2025/115', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/010', 0, '2025-07-05 14:17:30'),
('cs/2025/116', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/011', 0, '2025-07-05 14:17:30'),
('cs/2025/117', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/012', 0, '2025-07-05 14:17:30'),
('cs/2025/118', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/013', 0, '2025-07-05 14:17:30'),
('cs/2025/119', 'program/2025/004', 'dept/2025/001', 'gsubject/2025/014', 0, '2025-07-05 14:17:30'),
('cs/2025/120', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/001', 1, '2025-07-05 14:18:29'),
('cs/2025/121', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/015', 1, '2025-07-05 14:18:29'),
('cs/2025/122', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/016', 1, '2025-07-05 14:18:29'),
('cs/2025/123', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/002', 0, '2025-07-05 14:18:29'),
('cs/2025/124', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/017', 0, '2025-07-05 14:18:29'),
('cs/2025/125', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/018', 0, '2025-07-05 14:18:29'),
('cs/2025/126', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/019', 0, '2025-07-05 14:18:29'),
('cs/2025/127', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/020', 0, '2025-07-05 14:18:29'),
('cs/2025/128', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/021', 0, '2025-07-05 14:18:29'),
('cs/2025/129', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/022', 0, '2025-07-05 14:18:29'),
('cs/2025/130', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/023', 0, '2025-07-05 14:18:29'),
('cs/2025/131', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/024', 0, '2025-07-05 14:18:29'),
('cs/2025/132', 'program/2025/004', 'dept/2025/002', 'gsubject/2025/025', 0, '2025-07-05 14:18:29'),
('cs/2025/133', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/001', 1, '2025-07-05 14:20:14'),
('cs/2025/134', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/002', 1, '2025-07-05 14:20:14'),
('cs/2025/135', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/026', 1, '2025-07-05 14:20:14'),
('cs/2025/136', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/027', 1, '2025-07-05 14:20:14'),
('cs/2025/137', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/028', 0, '2025-07-05 14:20:14'),
('cs/2025/138', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/029', 0, '2025-07-05 14:20:14'),
('cs/2025/139', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/030', 0, '2025-07-05 14:20:14'),
('cs/2025/140', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/031', 0, '2025-07-05 14:20:14'),
('cs/2025/141', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/032', 0, '2025-07-05 14:20:14'),
('cs/2025/142', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/033', 0, '2025-07-05 14:20:14'),
('cs/2025/143', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/034', 0, '2025-07-05 14:20:14'),
('cs/2025/144', 'program/2025/004', 'dept/2025/003', 'gsubject/2025/035', 0, '2025-07-05 14:20:14'),
('cs/2025/145', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/001', 0, '2025-07-05 14:22:08'),
('cs/2025/146', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/002', 0, '2025-07-05 14:22:08'),
('cs/2025/147', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/003', 0, '2025-07-05 14:22:08'),
('cs/2025/148', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/004', 0, '2025-07-05 14:22:08'),
('cs/2025/149', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/005', 0, '2025-07-05 14:22:08'),
('cs/2025/150', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/006', 0, '2025-07-05 14:22:09'),
('cs/2025/151', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/007', 0, '2025-07-05 14:22:09'),
('cs/2025/152', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/008', 0, '2025-07-05 14:22:09'),
('cs/2025/153', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/009', 0, '2025-07-05 14:22:09'),
('cs/2025/154', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/010', 0, '2025-07-05 14:22:09'),
('cs/2025/155', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/011', 0, '2025-07-05 14:22:09'),
('cs/2025/156', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/012', 0, '2025-07-05 14:22:09'),
('cs/2025/157', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/013', 0, '2025-07-05 14:22:09'),
('cs/2025/158', 'program/2025/005', 'dept/2025/001', 'gsubject/2025/014', 0, '2025-07-05 14:22:09'),
('cs/2025/159', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/001', 0, '2025-07-05 14:22:54'),
('cs/2025/160', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/002', 0, '2025-07-05 14:22:54'),
('cs/2025/161', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/003', 0, '2025-07-05 14:22:54'),
('cs/2025/162', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/015', 0, '2025-07-05 14:22:54'),
('cs/2025/163', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/016', 0, '2025-07-05 14:22:54'),
('cs/2025/164', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/017', 0, '2025-07-05 14:22:54'),
('cs/2025/165', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/018', 0, '2025-07-05 14:22:54'),
('cs/2025/166', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/019', 0, '2025-07-05 14:22:54'),
('cs/2025/167', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/020', 0, '2025-07-05 14:22:54'),
('cs/2025/168', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/021', 0, '2025-07-05 14:22:54'),
('cs/2025/169', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/022', 0, '2025-07-05 14:22:54'),
('cs/2025/170', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/023', 0, '2025-07-05 14:22:54'),
('cs/2025/171', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/024', 0, '2025-07-05 14:22:54'),
('cs/2025/172', 'program/2025/005', 'dept/2025/002', 'gsubject/2025/025', 0, '2025-07-05 14:22:54'),
('cs/2025/173', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/001', 0, '2025-07-05 14:23:18'),
('cs/2025/174', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/002', 0, '2025-07-05 14:23:18'),
('cs/2025/175', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/003', 0, '2025-07-05 14:23:18'),
('cs/2025/176', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/026', 0, '2025-07-05 14:23:18'),
('cs/2025/177', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/027', 0, '2025-07-05 14:23:18'),
('cs/2025/178', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/028', 0, '2025-07-05 14:23:18'),
('cs/2025/179', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/029', 0, '2025-07-05 14:23:18'),
('cs/2025/180', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/030', 0, '2025-07-05 14:23:18'),
('cs/2025/181', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/031', 0, '2025-07-05 14:23:18'),
('cs/2025/182', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/032', 0, '2025-07-05 14:23:19'),
('cs/2025/183', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/033', 0, '2025-07-05 14:23:19'),
('cs/2025/184', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/034', 0, '2025-07-05 14:23:19'),
('cs/2025/185', 'program/2025/005', 'dept/2025/003', 'gsubject/2025/035', 0, '2025-07-05 14:23:19');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`) VALUES
('dept/2025/001', 'Science', '2025-07-05 12:35:59'),
('dept/2025/002', 'Art', '2025-07-05 12:35:59'),
('dept/2025/003', 'Commercial', '2025-07-05 12:35:59');

-- --------------------------------------------------------

--
-- Table structure for table `global_subjects`
--

CREATE TABLE `global_subjects` (
  `global_subject_id` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `global_subjects`
--

INSERT INTO `global_subjects` (`global_subject_id`, `name`) VALUES
('gsubject/2025/001', 'English Language'),
('gsubject/2025/002', 'Mathematics'),
('gsubject/2025/003', 'Civic Education'),
('gsubject/2025/004', 'Biology'),
('gsubject/2025/005', 'Chemistry'),
('gsubject/2025/006', 'Physics'),
('gsubject/2025/007', 'Agricultural Science'),
('gsubject/2025/008', 'Further Mathematics'),
('gsubject/2025/009', 'Geography'),
('gsubject/2025/010', 'Technical Drawing'),
('gsubject/2025/011', 'Health Education'),
('gsubject/2025/012', 'Computer Studies'),
('gsubject/2025/013', 'Food and Nutrition'),
('gsubject/2025/014', 'Home Management'),
('gsubject/2025/015', 'Literature in English'),
('gsubject/2025/016', 'Government'),
('gsubject/2025/017', 'Christian Religious Studies (CRS)'),
('gsubject/2025/018', 'Islamic Religious Studies (IRS)'),
('gsubject/2025/019', 'History'),
('gsubject/2025/020', 'Music'),
('gsubject/2025/021', 'Visual Arts'),
('gsubject/2025/022', 'French'),
('gsubject/2025/023', 'Arabic'),
('gsubject/2025/024', 'Yoruba'),
('gsubject/2025/025', 'Clothing and Textiles'),
('gsubject/2025/026', 'Economics'),
('gsubject/2025/027', 'Commerce'),
('gsubject/2025/028', 'Financial Accounting'),
('gsubject/2025/029', 'Business Management'),
('gsubject/2025/030', 'Office Practice'),
('gsubject/2025/031', 'Marketing'),
('gsubject/2025/032', 'Store Management'),
('gsubject/2025/033', 'Insurance'),
('gsubject/2025/034', 'Book Keeping'),
('gsubject/2025/035', 'Data Processing');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `name`, `created_at`) VALUES
('program/2025/001', 'WAEC', '2025-07-05 12:55:30'),
('program/2025/002', 'JAMB', '2025-07-05 12:55:30'),
('program/2025/003', 'NECO', '2025-07-05 12:55:30'),
('program/2025/004', 'GCE', '2025-07-05 12:55:30'),
('program/2025/005', 'Post-UTME', '2025-07-05 12:55:30');

-- --------------------------------------------------------

--
-- Table structure for table `program_offerings`
--

CREATE TABLE `program_offerings` (
  `id` varchar(30) NOT NULL,
  `program_id` varchar(30) NOT NULL,
  `title` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `subject_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `program_offerings`
--

INSERT INTO `program_offerings` (`id`, `program_id`, `title`, `slug`, `description`, `price`, `image_url`, `tag`, `rating`, `duration`, `subject_count`, `created_at`) VALUES
('offer/2025/001', 'program/2025/001', 'WAEC Tutorial', 'waec-tutorial', 'Comprehensive lessons tailored to your WAEC preparation needs.', 10500, 'uploads/programs/waec-tutorial.jpg', 'Bestseller', 4.5, '6 Weeks', 9, '2025-07-06 05:56:18'),
('offer/2025/002', 'program/2025/001', 'WAEC Registration', 'waec-registration', 'Register now for the upcoming WAEC examinations and secure your future.', 30500, 'uploads/programs/waec-registration.jpg', NULL, 4.2, '1 Day', 0, '2025-07-06 05:56:18'),
('offer/2025/003', 'program/2025/001', 'WAEC Mock Exam', 'waec-mock-exam', 'Simulate the real WAEC exam and test your readiness.', 15500, 'uploads/programs/waec-mock.jpg', 'Hot', 4.4, '2 Hours', 0, '2025-07-06 05:56:18'),
('offer/2025/004', 'program/2025/002', 'JAMB Tutorial', 'jamb-tutorial', 'Comprehensive coaching to help you excel in your JAMB UTME.', 12000, 'uploads/programs/jamb-tutorial.jpg', 'Top Pick', 4.6, '5 Weeks', 4, '2025-07-06 05:56:53'),
('offer/2025/005', 'program/2025/002', 'JAMB Registration', 'jamb-registration', 'Register for the next JAMB UTME quickly and easily.', 28000, 'uploads/programs/jamb-registration.jpg', NULL, 4.3, '1 Day', 0, '2025-07-06 05:56:53'),
('offer/2025/006', 'program/2025/002', 'JAMB Mock Exam', 'jamb-mock-exam', 'Simulated exam to prepare you for the real UTME experience.', 13000, 'uploads/programs/jamb-mock.jpg', 'New', 4.2, '2 Hours', 0, '2025-07-06 05:56:53'),
('offer/2025/007', 'program/2025/003', 'NECO Tutorial', 'neco-tutorial', 'Interactive NECO lessons designed to improve understanding.', 10000, 'uploads/programs/neco-tutorial.jpg', 'Trending', 4.4, '6 Weeks', 7, '2025-07-06 05:56:53'),
('offer/2025/008', 'program/2025/003', 'NECO Registration', 'neco-registration', 'Seamlessly register for your NECO exams online.', 25000, 'uploads/programs/neco-registration.jpg', NULL, 4.0, '1 Day', 0, '2025-07-06 05:56:53'),
('offer/2025/009', 'program/2025/003', 'NECO Mock Exam', 'neco-mock-exam', 'Practice NECO exams to test your readiness and boost confidence.', 14000, 'uploads/programs/neco-mock.jpg', NULL, 4.1, '2 Hours', 0, '2025-07-06 05:56:53'),
('offer/2025/010', 'program/2025/004', 'GCE Intensive Lessons', 'gce-intensive', 'Special classes for private candidates preparing for GCE.', 13000, 'uploads/programs/gce-intensive.jpg', 'Premium', 4.5, '6 Weeks', 5, '2025-07-06 05:56:53'),
('offer/2025/011', 'program/2025/004', 'GCE Registration', 'gce-registration', 'Register for the General Certificate Examination (GCE).', 31000, 'uploads/programs/gce-registration.jpg', NULL, 4.2, '1 Day', 0, '2025-07-06 05:56:53'),
('offer/2025/012', 'program/2025/004', 'GCE Practice Exam', 'gce-practice', 'Take mock GCE exams to measure your level of preparedness.', 15000, 'uploads/programs/gce-practice.jpg', 'New', 4.3, '2 Hours', 0, '2025-07-06 05:56:53'),
('offer/2025/013', 'program/2025/005', 'Post-UTME Drill Class', 'postutme-drill', 'Score high in your Post-UTME with intensive coaching.', 11000, 'uploads/programs/postutme-drill.jpg', 'Best Value', 4.6, '4 Weeks', 4, '2025-07-06 05:56:53'),
('offer/2025/014', 'program/2025/005', 'Post-UTME Registration Guide', 'postutme-registration', 'Get guided help on how to register for your Post-UTME screenings.', 1000, 'uploads/programs/postutme-guide.jpg', NULL, 4.0, '30 Minutes', 0, '2025-07-06 05:56:53'),
('offer/2025/015', 'program/2025/005', 'Post-UTME Mock Test', 'postutme-mock', 'Prepare with real-like Post-UTME mock tests.', 9000, 'uploads/programs/postutme-mock.jpg', NULL, 4.2, '1.5 Hours', 0, '2025-07-06 05:56:53');

-- --------------------------------------------------------

--
-- Table structure for table `student_subjects`
--

CREATE TABLE `student_subjects` (
  `id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `program_id` varchar(30) NOT NULL,
  `course_subject_id` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subjects`
--

INSERT INTO `student_subjects` (`id`, `user_id`, `program_id`, `course_subject_id`, `created_at`) VALUES
(1, 'samcy2025-002', 'program/2025/001', 'cs/2025/001', '2025-07-07 10:08:35'),
(2, 'samcy2025-002', 'program/2025/001', 'cs/2025/002', '2025-07-07 10:08:35'),
(3, 'samcy2025-002', 'program/2025/001', 'cs/2025/003', '2025-07-07 10:08:35'),
(4, 'samcy2025-002', 'program/2025/001', 'cs/2025/004', '2025-07-07 10:08:35');

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
  `role` enum('admin','instructor','student') NOT NULL DEFAULT 'student',
  `privacyPolicy` tinyint(1) NOT NULL DEFAULT 0,
  `first_login` tinyint(1) NOT NULL DEFAULT 1,
  `reset_token` varchar(100) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `department_id` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `phone`, `password`, `maritalStatus`, `dob`, `state`, `localGovt`, `address`, `nationality`, `nin`, `department`, `gender`, `role`, `privacyPolicy`, `first_login`, `reset_token`, `reset_token_expires`, `created_at`, `department_id`) VALUES
('samcy2025-001', 'bello', 'zainab', 'mailtest6543@gmail.com', '0705289244', '$2y$10$zi1aLCBxs3ckjTKoPD8a5O/t81UcpFGLCecbxY50i.vVqD1qALnAq', 'single', '2002-01-15', 'Ogun', 'Ijebu Ode', '15 Olu Street', 'Nigerian', '7085443211', 'Science', 'male', 'student', 1, 0, 'ee5e56c0bb74f678131961d4c3b1e245c21ade5948cb2cfc2a266f736a26f375', '2025-07-03 08:16:54', '2025-07-03 06:06:40', NULL),
('samcy2025-002', 'bello', 'sulaimon', 'olamoney665@gmail.com', '09013799068', '$2y$10$CW2m/j17WUuoCZEB3YGSVeLj1/ZYCfwhIsYizcEZu9Emnz46rjtpC', 'single', '2002-01-15', 'Ogun', 'Ijebu Ode', '15 Olu Street', 'Nigerian', '9013799068', 'science', 'female', 'student', 1, 0, NULL, NULL, '2025-07-06 07:14:45', NULL),
('samcy2025-003', 'Oladimeji', 'bello', 'bellosulaimon177@gmail.com', '07047897839', '$2y$10$vJw7PrkzxAzjzzLDVvbZlum0Z8NSDdBI8gP9bCM2EFtv6IzVUhc/O', 'single', '2002-01-15', 'Ogun', 'Ijebu Ode', '15 Olu Street', 'Nigerian', '9013799168', 'science', 'female', 'student', 1, 1, NULL, NULL, '2025-07-07 14:17:08', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course_subjects`
--
ALTER TABLE `course_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `global_subject_id` (`global_subject_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `global_subjects`
--
ALTER TABLE `global_subjects`
  ADD PRIMARY KEY (`global_subject_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `program_offerings`
--
ALTER TABLE `program_offerings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_registration` (`user_id`,`program_id`,`course_subject_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `course_subject_id` (`course_subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `nin` (`nin`),
  ADD KEY `fk_users_department` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `student_subjects`
--
ALTER TABLE `student_subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course_subjects`
--
ALTER TABLE `course_subjects`
  ADD CONSTRAINT `course_subjects_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_subjects_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_subjects_ibfk_3` FOREIGN KEY (`global_subject_id`) REFERENCES `global_subjects` (`global_subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_offerings`
--
ALTER TABLE `program_offerings`
  ADD CONSTRAINT `program_offerings_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subjects_ibfk_3` FOREIGN KEY (`course_subject_id`) REFERENCES `course_subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
