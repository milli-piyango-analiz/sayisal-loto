-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 07, 2016 at 08:15 AM
-- Server version: 5.7.11
-- PHP Version: 5.6.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `milli_piyango`
--

-- --------------------------------------------------------

--
-- Table structure for table `loto_history`
--

CREATE TABLE `loto_history` (
  `id` int(11) NOT NULL,
  `json` text COLLATE utf8_turkish_ci NOT NULL,
  `date` date NOT NULL,
  `week` int(11) NOT NULL,
  `oid` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  `success_3_count` int(11) NOT NULL,
  `success_4_count` int(11) NOT NULL,
  `success_5_count` int(11) NOT NULL,
  `success_6_count` int(11) NOT NULL,
  `success_3_amount` decimal(10,2) NOT NULL,
  `success_4_amount` decimal(10,2) NOT NULL,
  `success_5_amount` decimal(10,2) NOT NULL,
  `success_6_amount` decimal(10,2) NOT NULL,
  `cycle_count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loto_jackpot`
--

CREATE TABLE `loto_jackpot` (
  `id` int(11) NOT NULL,
  `loto_history_id` int(11) NOT NULL,
  `city` varchar(200) COLLATE utf8_turkish_ci NOT NULL,
  `district` varchar(200) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `loto_jackpot`
--

-- --------------------------------------------------------

--
-- Table structure for table `loto_numbers`
--

CREATE TABLE `loto_numbers` (
  `id` int(11) NOT NULL,
  `loto_history_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `loto_numbers`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `loto_history`
--
ALTER TABLE `loto_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loto_jackpot`
--
ALTER TABLE `loto_jackpot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loto_history_id` (`loto_history_id`);

--
-- Indexes for table `loto_numbers`
--
ALTER TABLE `loto_numbers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loto_history_id` (`loto_history_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `loto_history`
--
ALTER TABLE `loto_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `loto_jackpot`
--
ALTER TABLE `loto_jackpot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `loto_numbers`
--
ALTER TABLE `loto_numbers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `loto_jackpot`
--
ALTER TABLE `loto_jackpot`
  ADD CONSTRAINT `loto_jackpot_ibfk_1` FOREIGN KEY (`loto_history_id`) REFERENCES `loto_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `loto_numbers`
--
ALTER TABLE `loto_numbers`
  ADD CONSTRAINT `loto_numbers_ibfk_1` FOREIGN KEY (`loto_history_id`) REFERENCES `loto_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
