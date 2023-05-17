CREATE DATABASE IF NOT EXISTS `adventure`
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS
  'adventure'@'localhost'
  IDENTIFIED BY 'adventure'
  FAILED_LOGIN_ATTEMPTS 3
  PASSWORD_LOCK_TIME 7;
GRANT ALL ON `adventure`.* TO 'adventure'@'localhost';

USE `adventure`;
