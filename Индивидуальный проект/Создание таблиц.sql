-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema train_station
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema train_station
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `train_station` DEFAULT CHARACTER SET utf8 ;
USE `train_station` ;

-- -----------------------------------------------------
-- Table `train_station`.`t_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_departments` (
  `idt_departments` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idt_departments`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_brigades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_brigades` (
  `idt_brigades` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `t_departments_idt_departments` INT NOT NULL,
  PRIMARY KEY (`idt_brigades`, `t_departments_idt_departments`),
  INDEX `fk_t_brigades_t_departments1_idx` (`t_departments_idt_departments` ASC),
  CONSTRAINT `fk_t_brigades_t_departments1`
    FOREIGN KEY (`t_departments_idt_departments`)
    REFERENCES `train_station`.`t_departments` (`idt_departments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_workers` (
  `idt_workers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `experience` DOUBLE NULL,
  `children` INT NULL,
  `sex` CHAR(1) NULL,
  `salary` DOUBLE NULL,
  `t_departments_idt_departments` INT NOT NULL,
  `t_brigades_idt_brigades` INT NOT NULL,
  PRIMARY KEY (`idt_workers`, `t_departments_idt_departments`, `t_brigades_idt_brigades`),
  INDEX `fk_t_workers_t_departments_idx` (`t_departments_idt_departments` ASC),
  INDEX `fk_t_workers_t_brigades1_idx` (`t_brigades_idt_brigades` ASC),
  CONSTRAINT `fk_t_workers_t_departments`
    FOREIGN KEY (`t_departments_idt_departments`)
    REFERENCES `train_station`.`t_departments` (`idt_departments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_workers_t_brigades1`
    FOREIGN KEY (`t_brigades_idt_brigades`)
    REFERENCES `train_station`.`t_brigades` (`idt_brigades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_heads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_heads` (
  `idt_heads` INT NOT NULL AUTO_INCREMENT,
  `t_workers_idt_workers` INT NOT NULL,
  PRIMARY KEY (`idt_heads`, `t_workers_idt_workers`),
  INDEX `fk_t_heads_t_workers1_idx` (`t_workers_idt_workers` ASC),
  CONSTRAINT `fk_t_heads_t_workers1`
    FOREIGN KEY (`t_workers_idt_workers`)
    REFERENCES `train_station`.`t_workers` (`idt_workers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_locomotives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_locomotives` (
  `idt_locomotives` INT NOT NULL,
  `plan_check` DATE NULL,
  `on_repair` TINYINT NULL,
  `on_flight` TINYINT NULL,
  `num_of_repairs` INT NULL,
  `num_of_flights` INT NULL,
  `num_of_flight_before_repair` INT NULL,
  `age` INT NULL,
  `t_brigades_idt_brigades` INT NOT NULL,
  PRIMARY KEY (`idt_locomotives`, `t_brigades_idt_brigades`),
  INDEX `fk_t_locomotives_t_brigades1_idx` (`t_brigades_idt_brigades` ASC),
  CONSTRAINT `fk_t_locomotives_t_brigades1`
    FOREIGN KEY (`t_brigades_idt_brigades`)
    REFERENCES `train_station`.`t_brigades` (`idt_brigades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_locomotive_drivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_locomotive_drivers` (
  `idt_locomotive_drivers` INT NOT NULL,
  `last_medical_check` DATE NULL,
  `t_workers_idt_workers` INT NOT NULL,
  PRIMARY KEY (`idt_locomotive_drivers`, `t_workers_idt_workers`),
  INDEX `fk_t_locomotive_drivers_t_workers1_idx` (`t_workers_idt_workers` ASC),
  CONSTRAINT `fk_t_locomotive_drivers_t_workers1`
    FOREIGN KEY (`t_workers_idt_workers`)
    REFERENCES `train_station`.`t_workers` (`idt_workers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_routes` (
  `idt_routes` INT NOT NULL,
  `start_route` VARCHAR(45) NULL,
  `finish_route` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  `distance` INT NULL,
  PRIMARY KEY (`idt_routes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_trains`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_trains` (
  `idt_trains` VARCHAR(10) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `departure_date` DATE NULL,
  `departure_time` TIME(0) NULL,
  `arrival_date` DATE NULL,
  `arrival_time` TIME(0) NULL,
  `t_routes_idt_routes` INT NOT NULL,
  PRIMARY KEY (`idt_trains`, `t_routes_idt_routes`),
  INDEX `fk_t_trains_t_routes1_idx` (`t_routes_idt_routes` ASC),
  CONSTRAINT `fk_t_trains_t_routes1`
    FOREIGN KEY (`t_routes_idt_routes`)
    REFERENCES `train_station`.`t_routes` (`idt_routes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_tickets` (
  `idt_tickets` INT NOT NULL,
  `t_trains_idt_trains` VARCHAR(10) NOT NULL,
  `ticket_cost` DOUBLE NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`idt_tickets`, `t_trains_idt_trains`),
  INDEX `fk_t_tickets_t_trains1_idx` (`t_trains_idt_trains` ASC),
  CONSTRAINT `fk_t_tickets_t_trains1`
    FOREIGN KEY (`t_trains_idt_trains`)
    REFERENCES `train_station`.`t_trains` (`idt_trains`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_statuses` (
  `idt_statuses` INT NOT NULL,
  `t_trains_idt_trains` VARCHAR(10) NOT NULL,
  `status_name` VARCHAR(45) NULL,
  `cause` VARCHAR(45) NULL,
  PRIMARY KEY (`idt_statuses`, `t_trains_idt_trains`),
  INDEX `fk_t_statuses_t_trains1_idx` (`t_trains_idt_trains` ASC),
  CONSTRAINT `fk_t_statuses_t_trains1`
    FOREIGN KEY (`t_trains_idt_trains`)
    REFERENCES `train_station`.`t_trains` (`idt_trains`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `train_station`.`t_passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `train_station`.`t_passengers` (
  `idt_passengers` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `sex` CHAR(1) NULL,
  `age` VARCHAR(45) NULL,
  `baggage` TINYINT NULL,
  `t_tickets_idt_tickets` INT NOT NULL,
  PRIMARY KEY (`idt_passengers`, `t_tickets_idt_tickets`),
  INDEX `fk_t_passengers_t_tickets1_idx` (`t_tickets_idt_tickets` ASC),
  CONSTRAINT `fk_t_passengers_t_tickets1`
    FOREIGN KEY (`t_tickets_idt_tickets`)
    REFERENCES `train_station`.`t_tickets` (`idt_tickets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
