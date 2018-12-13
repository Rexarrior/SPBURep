-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cyberlife
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cyberlife
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cyberlife` DEFAULT CHARACTER SET latin1 ;
USE `cyberlife` ;

-- -----------------------------------------------------
-- Table `cyberlife`.`worlds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`worlds` (
  `world_id` INT(11) NOT NULL AUTO_INCREMENT,
  `map` MULTIPOINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`world_id`),
  UNIQUE INDEX `world_id_UNIQUE` (`world_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`world_lifeform_sets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`world_lifeform_sets` (
  `lifeform_set_id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  `world_id_fk` INT(11) NOT NULL,
  PRIMARY KEY (`lifeform_set_id`, `world_id_fk`),
  UNIQUE INDEX `lifeform_set_id_UNIQUE` (`lifeform_set_id` ASC) ,
  INDEX `fk_world_lifeform_sets_worlds1_idx` (`world_id_fk` ASC) ,
  CONSTRAINT `fk_world_lifeform_sets_worlds1`
    FOREIGN KEY (`world_id_fk`)
    REFERENCES `cyberlife`.`worlds` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`lifeforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`lifeforms` (
  `lifeform_id` INT(11) NOT NULL AUTO_INCREMENT,
  `point` POINT NOT NULL,
  `genom` VARCHAR(1000) NOT NULL,
  `world_id_fk` INT(11) NOT NULL,
  `lifeform_set_id_fk` INT(11) NOT NULL,
  PRIMARY KEY (`lifeform_id`, `world_id_fk`, `lifeform_set_id_fk`),
  UNIQUE INDEX `lifeform_id_UNIQUE` (`lifeform_id` ASC) ,
  INDEX `fk_lifeforms_worlds1_idx` (`world_id_fk` ASC) ,
  INDEX `fk_lifeforms_world_lifeform_sets1_idx` (`lifeform_set_id_fk` ASC) ,
  CONSTRAINT `fk_lifeforms_worlds1`
    FOREIGN KEY (`world_id_fk`)
    REFERENCES `cyberlife`.`worlds` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lifeforms_world_lifeform_sets1`
    FOREIGN KEY (`lifeform_set_id_fk`)
    REFERENCES `cyberlife`.`world_lifeform_sets` (`lifeform_set_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`states` (
  `state_id` INT(11) NOT NULL AUTO_INCREMENT,
  `state_type` VARCHAR(45) NULL DEFAULT 'double',
  `description` MULTILINESTRING NULL DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`),
  UNIQUE INDEX `state_id_UNIQUE` (`state_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`lifeform_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`lifeform_states` (
  `value` DOUBLE NOT NULL DEFAULT '0',
  `lifeform_id_fk` INT(11) NOT NULL,
  `state_id_fk` INT(11) NOT NULL,
  PRIMARY KEY (`lifeform_id_fk`, `state_id_fk`),
  INDEX `fk_lifeform_states_states1_idx` (`state_id_fk` ASC) ,
  CONSTRAINT `fk_lifeform_states_lifeforms1`
    FOREIGN KEY (`lifeform_id_fk`)
    REFERENCES `cyberlife`.`lifeforms` (`lifeform_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lifeform_states_states1`
    FOREIGN KEY (`state_id_fk`)
    REFERENCES `cyberlife`.`states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`phenomens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`phenomens` (
  `phenomen_id` INT(11) NOT NULL AUTO_INCREMENT,
  `effect` DOUBLE NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `state_id_fk` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phenomen_id`, `state_id_fk`),
  UNIQUE INDEX `phenomen_id_UNIQUE` (`phenomen_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_phenomens_states1_idx` (`state_id_fk` ASC) ,
  CONSTRAINT `fk_phenomens_states1`
    FOREIGN KEY (`state_id_fk`)
    REFERENCES `cyberlife`.`states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cyberlife`.`world_phenomens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`world_phenomens` (
  `area` MULTIPOINT NOT NULL,
  `gradient_factor` DOUBLE NULL DEFAULT NULL,
  `power_factor` DOUBLE NOT NULL,
  `status` BIT(1) NOT NULL,
  `period` INT(11) NULL DEFAULT NULL,
  `instance_id` INT NOT NULL AUTO_INCREMENT,
  `world_id_fk` INT(11) NOT NULL,
  `phenomen_id_fk` INT(11) NOT NULL,
  PRIMARY KEY (`instance_id`, `world_id_fk`, `phenomen_id_fk`),
  UNIQUE INDEX `instance_id_UNIQUE` (`instance_id` ASC) ,
  INDEX `fk_world_phenomens_worlds1_idx` (`world_id_fk` ASC) ,
  INDEX `fk_world_phenomens_phenomens1_idx` (`phenomen_id_fk` ASC) ,
  CONSTRAINT `fk_world_phenomens_worlds1`
    FOREIGN KEY (`world_id_fk`)
    REFERENCES `cyberlife`.`worlds` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_world_phenomens_phenomens1`
    FOREIGN KEY (`phenomen_id_fk`)
    REFERENCES `cyberlife`.`phenomens` (`phenomen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

