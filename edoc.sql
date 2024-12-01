-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 01, 2024 at 01:06 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edoc`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `aemail` varchar(255) NOT NULL,
  `apassword` varchar(255) DEFAULT NULL,
  UNIQUE KEY `aemail` (`aemail`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`aemail`, `apassword`) VALUES
('bikashkhanalgg@gmail.com', '123'),
('info.doctorappointmentsystem@gmail.com', 'nep123');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `appoid` int NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL,
  `apponum` int DEFAULT NULL,
  `scheduleid` int DEFAULT NULL,
  `appodate` date DEFAULT NULL,
  PRIMARY KEY (`appoid`),
  KEY `pid` (`pid`),
  KEY `scheduleid` (`scheduleid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appoid`, `pid`, `apponum`, `scheduleid`, `appodate`) VALUES
(1, 1, 1, 1, '2022-06-03'),
(3, 10, 2, 1, '2024-11-08'),
(4, 1, 1, 9, '2024-11-08'),
(5, 12, 2, 9, '2024-11-08'),
(6, 9, 1, 11, '2024-11-08'),
(10, 27, 1, 12, '2024-11-19'),
(12, 30, 3, 1, '2024-11-28');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
CREATE TABLE IF NOT EXISTS `doctor` (
  `docid` int NOT NULL AUTO_INCREMENT,
  `docemail` varchar(255) DEFAULT NULL,
  `docname` varchar(255) DEFAULT NULL,
  `docpassword` varchar(255) DEFAULT NULL,
  `docnic` varchar(15) DEFAULT NULL,
  `doctel` varchar(15) DEFAULT NULL,
  `specialties` int DEFAULT NULL,
  PRIMARY KEY (`docid`),
  KEY `specialties` (`specialties`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`docid`, `docemail`, `docname`, `docpassword`, `docnic`, `doctel`, `specialties`) VALUES
(1, 'doctor@edoc.com', 'Test Doctor', '123', '000000000', '0110000000', 1),
(6, 'niruregmi957@gmail.com', 'Dr. Neeru Regmi ', '123', '888888888', '9849954506', 10),
(3, 'asmitapant@yopmail.com', 'Asmita Pant', '123', '1111111', '9840089419', 19),
(5, 'bipul@gmail.com', 'Dr.Bipul Regmi ', 'bipul', '7886868686868', '9849954506', 10);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pemail` varchar(255) DEFAULT NULL,
  `pname` varchar(255) DEFAULT NULL,
  `ppassword` varchar(255) DEFAULT NULL,
  `paddress` varchar(255) DEFAULT NULL,
  `pnic` varchar(15) DEFAULT NULL,
  `pdob` date DEFAULT NULL,
  `ptel` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`pid`, `pemail`, `pname`, `ppassword`, `paddress`, `pnic`, `pdob`, `ptel`) VALUES
(1, 'patient@edoc.com', 'Test Patient', '123', 'Sri Lanka', '0000000000', '2000-01-01', '0120000000'),
(27, 'urtheonesp@gmail.com', 'Suraj  pandey', '$2y$10$O0Gn0Ex9Zlt3dQ7ikGBQduah22tpggrqxJmv3SifJgIwy0JB3aAGi', 'Galyang-3,Syangja', '000000000', '2024-11-21', '9848887456'),
(23, 'neeruregmi424@gmail.com', 'Nirmala Regmi', '$2y$10$NEIS0aCV0DRx5daCJiBka..tK2QigZMFIDO5OpoKw0m99ZvrWI1Ty', 'Galyang-3,Syangja', '888888888', '2024-11-14', '9811980767'),
(24, 'Bikashdigitalmarketing@protonmail.com', 'Bikash Khanal', '$2y$10$.Af9OphAxC/QR0LhDc1/LOf2heAah1e.ZYJlU/v/7BiCy0z3TnIOK', 'Ruphandehi, Bhairahawa, shantinagar-12', '888888888', '2024-11-27', '9849954534'),
(28, 'Khanalbk18@gmail.com', 'Bikash Khanal', '$2y$10$CRMXM1UVNspYc2CezvDNFeOsimhJjE/j2VZo/P0o/c7KmVrWMF6ea', 'Bouddha', '123123124', '2002-03-05', '9840089419'),
(29, 'bp@yopmail.com', 'Bikash Khanal', '$2y$10$h9kLTLf08YuHXrWvJcW/2uRociieLP8y4JZHsy28bIGgSINGuNEtK', 'Bouddha', '123123124', '2024-11-01', '9843804030'),
(30, 'bir@yopmail.com', 'Bir  Hospital', '$2y$10$bmqlDfkcjUGo0NBCPAHop.dla25FkiptWsJwlgFuB0t2pPhrPGZXa', 'Sundhaa', '123456780', '2024-11-01', '9812121217');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE IF NOT EXISTS `schedule` (
  `scheduleid` int NOT NULL AUTO_INCREMENT,
  `docid` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `scheduledate` date DEFAULT NULL,
  `scheduletime` time DEFAULT NULL,
  `nop` int DEFAULT NULL,
  PRIMARY KEY (`scheduleid`),
  KEY `docid` (`docid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`scheduleid`, `docid`, `title`, `scheduledate`, `scheduletime`, `nop`) VALUES
(1, '1', 'Test Session', '2050-01-01', '18:00:00', 50),
(2, '1', '1', '2022-06-10', '20:36:00', 1),
(3, '1', '12', '2022-06-10', '20:33:00', 1),
(4, '1', '1', '2022-06-10', '12:32:00', 1),
(5, '1', '1', '2022-06-10', '20:35:00', 1),
(6, '1', '12', '2022-06-10', '20:35:00', 1),
(7, '1', '1', '2022-06-24', '20:36:00', 1),
(8, '1', '12', '2022-06-10', '13:33:00', 1),
(9, '3', 'Ortho', '2024-11-15', '18:20:00', 5),
(11, '4', 'Cardiology', '2024-11-11', '08:00:00', 5),
(12, '6', 'Cardiology ', '2024-11-21', '07:00:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

DROP TABLE IF EXISTS `specialties`;
CREATE TABLE IF NOT EXISTS `specialties` (
  `id` int NOT NULL,
  `sname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `sname`) VALUES
(1, 'Accident and emergency medicine'),
(2, 'Allergology'),
(3, 'Anaesthetics'),
(4, 'Biological hematology'),
(5, 'Cardiology'),
(6, 'Child psychiatry'),
(7, 'Clinical biology'),
(8, 'Clinical chemistry'),
(9, 'Clinical neurophysiology'),
(10, 'Clinical radiology'),
(11, 'Dental, oral and maxillo-facial surgery'),
(12, 'Dermato-venerology'),
(13, 'Dermatology'),
(14, 'Endocrinology'),
(15, 'Gastro-enterologic surgery'),
(16, 'Gastroenterology'),
(17, 'General hematology'),
(18, 'General Practice'),
(19, 'General surgery'),
(20, 'Geriatrics'),
(21, 'Immunology'),
(22, 'Infectious diseases'),
(23, 'Internal medicine'),
(24, 'Laboratory medicine'),
(25, 'Maxillo-facial surgery'),
(26, 'Microbiology'),
(27, 'Nephrology'),
(28, 'Neuro-psychiatry'),
(29, 'Neurology'),
(30, 'Neurosurgery'),
(31, 'Nuclear medicine'),
(32, 'Obstetrics and gynecology'),
(33, 'Occupational medicine'),
(34, 'Ophthalmology'),
(35, 'Orthopaedics'),
(36, 'Otorhinolaryngology'),
(37, 'Paediatric surgery'),
(38, 'Paediatrics'),
(39, 'Pathology'),
(40, 'Pharmacology'),
(41, 'Physical medicine and rehabilitation'),
(42, 'Plastic surgery'),
(43, 'Podiatric Medicine'),
(44, 'Podiatric Surgery'),
(45, 'Psychiatry'),
(46, 'Public health and Preventive Medicine'),
(47, 'Radiology'),
(48, 'Radiotherapy'),
(49, 'Respiratory medicine'),
(50, 'Rheumatology'),
(51, 'Stomatology'),
(52, 'Thoracic surgery'),
(53, 'Tropical medicine'),
(54, 'Urology'),
(55, 'Vascular surgery'),
(56, 'Venereology');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tele` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `nic` int NOT NULL,
  `otp` varchar(6) NOT NULL,
  `verified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `tele`, `email`, `password`, `code`, `created_at`, `nic`, `otp`, `verified`) VALUES
(22, 2147483647, 'yoyo@yopmail.com', '$2y$10$B7GV5KMDXrnu7NaG.XsrZumysV83Np6tE2cYNkYDr5dhG.gajWyfG', 'e9698ab67a42b2381ae7aa06ddc8c7f3', '2024-11-15 04:06:30', 123123145, '322123', 1),
(21, 2147483647, 'abc@yopmail.com', '$2y$10$nwPv/z7Pxri7N/YIHujL1eX/QwdFtrU7tWFuHrHp2PX3cuA/Eksga', '931d8e3f60d4c96c5a724714a17f1e23', '2024-11-15 03:57:28', 123456789, '883047', 1),
(20, 1234567890, 'yopayp@yopmail.com', '202cb962ac59075b964b07152d234b70', '64ba266dbfac7174ce9ef1c98519c791', '2024-11-15 03:38:17', 123121212, '325365', 0),
(19, 2147483647, 'yopayo@yopmail.com', '202cb962ac59075b964b07152d234b70', 'f63161fce8996266c33ba1b432e2add7', '2024-11-15 03:30:41', 123123121, '848487', 0),
(18, 2147483647, 'yopa@yopmail.com', '202cb962ac59075b964b07152d234b70', 'dc17c4a26fa70a5e148ac3992e68cf95', '2024-11-15 03:19:37', 123123124, '104187', 0),
(23, 2147483647, 'abc@hari.com', '$2y$10$AKFAEucZZzfYix9hllNgo.XVu12n00K2/L0TsolEQHkrNF9ZvlPnS', 'cb78de23a1ec05a049901923177145de', '2024-11-15 04:15:45', 123456789, '415414', 0),
(24, 2147483647, 'khanalbk19@gmail.com', '$2y$10$fKR4HgCTHfHmeJ44G/JEauqry/IlgTurbK6BcLutpbacCvGkORXv6', 'ec9c0914b64a2b7560ac773e249f14d6', '2024-11-15 04:16:30', 123456789, '616764', 1),
(25, 2147483647, 'pasang@yopmail.com', '$2y$10$mNMM2N3hvG8p41M9TqpQ2ugI5FQF5sGrmaSYxwU3G3hvrl/RMlt6u', 'dfcbccc68d6e7c05d12a9988d4fc2448', '2024-11-15 06:46:33', 121212121, '909525', 1),
(26, 2147483647, 'harig@yopmail.com', '$2y$10$JfjouUwVD.F6/3zdpkrf5uDSII5XVRMedGOrjUp0A94O.jv6UFpha', 'f26a0ecefdd5671e834c262aae94d94c', '2024-11-15 06:51:09', 888888888, '433640', 1),
(27, 2147483647, 'dhiraj@yopmail.com', '$2y$10$sAdwBfEwQ3miYgGBHYWCku5mw.ZUP5/.lwktWtp1kyHGi9KTpmPYa', '52a1f9eb880c50710f208f9fdc439857', '2024-11-15 07:00:07', 123456789, '563655', 1),
(28, 2147483647, 'diru@yopmail.com', '$2y$10$ROtzoaA.E1Op.X6AMP8ea.eXUB1i7YGFbF4sA4xiMdo/UamnV1hIO', '31c7804824a971f075066a0b26cae9c8', '2024-11-15 07:02:29', 123123123, '155949', 1),
(29, 2147483647, 'niruregmi957@gmail.com', '$2y$10$gin/A6Ihz2TksPxqmwgNWuXd4L9O/LshUNoAYKRzh/Lr3LCQI94Ya', '22948b5c3623e3197d507780c12b17b8', '2024-11-15 07:06:40', 122122122, '831831', 1),
(30, 2147483647, 'diruj@yopmail.com', '$2y$10$218.sMVObxuBCziRhkvS1uPh4AdGYX9/naR10hwPuMV7jmDTsoemK', 'fdd2a599d0bc4f9d5ffaaacb6c80229a', '2024-11-15 07:11:05', 123123121, '954848', 1),
(35, 2147483647, 'Bikashdigitalmarketing@protonmail.com', '$2y$10$.Af9OphAxC/QR0LhDc1/LOf2heAah1e.ZYJlU/v/7BiCy0z3TnIOK', '84a53393961f5a40b54404375f1e7b47', '2024-11-18 04:57:13', 888888888, '544245', 1),
(39, 2147483647, 'Khanalbk18@gmail.com', '$2y$10$CRMXM1UVNspYc2CezvDNFeOsimhJjE/j2VZo/P0o/c7KmVrWMF6ea', '59cc85b68072090a1fd6edc27ee18a1d', '2024-11-25 02:46:29', 123123124, '571656', 0),
(36, 2147483647, 'pandey.suraj686@abc.com', '$2y$10$.K0hWMW4ZWHkLwwaNOhqIulQAqQftMnnTSSQoLtNfZIJGxSIe1cfi', 'dfd17ac596aaa2f1837aa7ff4ea9a1b6', '2024-11-19 08:09:18', 888888888, '253540', 0),
(37, 2147483647, 'pandey.suraj686@gmail.com', '$2y$10$EquEtTwJWZDy1xFJrG1CfuzL5bWpytw0bdwQzKX57gdniPNha2M8m', '5ab0bde2b17a0daba10a4d6eccccf5d6', '2024-11-19 08:10:40', 888888888, '866672', 1),
(38, 2147483647, 'urtheonesp@gmail.com', '$2y$10$O0Gn0Ex9Zlt3dQ7ikGBQduah22tpggrqxJmv3SifJgIwy0JB3aAGi', '8a0864fbe6d7811a8973149cec971fc8', '2024-11-19 08:26:37', 0, '160616', 1),
(40, 2147483647, 'bp@yopmail.com', '$2y$10$h9kLTLf08YuHXrWvJcW/2uRociieLP8y4JZHsy28bIGgSINGuNEtK', 'f7307b51c40fda055d30e5d5c65b8e0a', '2024-11-25 02:55:58', 123123124, '921472', 0),
(41, 2147483647, 'bir@yopmail.com', '$2y$10$bmqlDfkcjUGo0NBCPAHop.dla25FkiptWsJwlgFuB0t2pPhrPGZXa', 'c2f5449b3c0a9dbc9d27cf856f403058', '2024-11-28 11:07:31', 123456780, '640357', 1);

-- --------------------------------------------------------

--
-- Table structure for table `webuser`
--

DROP TABLE IF EXISTS `webuser`;
CREATE TABLE IF NOT EXISTS `webuser` (
  `email` varchar(255) NOT NULL,
  `usertype` char(1) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `webuser`
--

INSERT INTO `webuser` (`email`, `usertype`) VALUES
('admin@edoc.com', 'a'),
('doctor@edoc.com', 'd'),
('patient@edoc.com', 'p'),
('emhashenudara@gmail.com', 'p'),
('hari@yopmail.com', 'p'),
('bk@yopmail.com', 'p'),
('yk@yopmail.com', 'p'),
('Khanalbk18@gmail.com', 'p'),
('neeruregmi957@gmail.com', 'd'),
('unique@yopmail.com', 'p'),
('asmita@yopmail.com', 'p'),
('harilal@yopmail.com', 'p'),
('asmitapant@yopmail.com', 'd'),
('pasang@yopmail.com', 'p'),
('Neeru@hospital.com', 'd'),
('harig@yopmail.com', 'p'),
('dhiraj@yopmail.com', 'p'),
('diru@yopmail.com', 'p'),
('niruregmi957@gmail.com', 'd'),
('diruj@yopmail.com', 'p'),
('bipul@gmail.com', 'd'),
('neeruregmi424@gmail.com', 'p'),
('Bikashdigitalmarketing@protonmail.com', 'p'),
('pandey.suraj686@abc.com', 'p'),
('urtheonesp@gmail.com', 'p'),
('bp@yopmail.com', 'p'),
('bikashkhanalgg@gmail.com', 'a'),
('', 'a'),
('info.doctorappointmentsystem@gmail.com', 'a'),
('bir@yopmail.com', 'p');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
