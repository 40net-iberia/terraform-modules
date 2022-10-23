SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+01:00";

CREATE DATABASE IF NOT EXISTS students;
USE students;
DROP TABLE IF EXISTS students;
CREATE TABLE `students` (
  `user_id` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `user_sort` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `server_ip` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `email` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `access_key` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `secret_key` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `server_test` tinyint(1) DEFAULT '0',
  `server_check` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
