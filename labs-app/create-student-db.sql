SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+01:00";

CREATE DATABASE IF NOT EXISTS students;
USE students;

CREATE TABLE IF NOT EXISTS `students` (
  `user_arn` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `user_sort` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `server_ip` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `email` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `access_key` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `secret_key` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `server_test` tinyint(1) DEFAULT '0',
  PRIMARY KEY (user_arn)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `students` (`user_arn`, `user_sort`, `server_ip`, `email`, `access_key`, `secret_key`, `external_id`, `server_test`) VALUES
('user-test', 'user-test', '127.0.0.1', 'test@local.local', 'xxxx-xxx', 'xxxx-xxx', 'xxxx-xxx', '0');
COMMIT;
