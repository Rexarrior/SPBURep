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
-- Table `cyberlife`.`words`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`words` (
  `word_id` INT NOT NULL AUTO_INCREMENT,
  `map` MULTIPOINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`word_id`),
  UNIQUE INDEX `word_id_UNIQUE` (`word_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`word_lifeform_sets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`word_lifeform_sets` (
  `lifeform_set_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  `name` VARCHAR(45) NOT NULL,
  `word_id_fk` INT NOT NULL,
  PRIMARY KEY (`lifeform_set_id`, `word_id_fk`),
  UNIQUE INDEX `lifeform_set_id_UNIQUE` (`lifeform_set_id` ASC) ,
  INDEX `fk_word_lifeform_sets_words1_idx` (`word_id_fk` ASC) ,
  CONSTRAINT `fk_word_lifeform_sets_words1`
    FOREIGN KEY (`word_id_fk`)
    REFERENCES `cyberlife`.`words` (`word_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`lifeforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`lifeforms` (
  `lifeform_id` INT NOT NULL AUTO_INCREMENT,
  `point` POINT NOT NULL,
  `genom` VARCHAR(45) NOT NULL,
  `word_id_fk` INT NOT NULL,
  `lifeform_set_id_fk` INT NOT NULL,
  PRIMARY KEY (`lifeform_id`, `word_id_fk`, `lifeform_set_id_fk`),
  UNIQUE INDEX `lifeform_id_UNIQUE` (`lifeform_id` ASC) ,
  INDEX `fk_lifeforms_words1_idx` (`word_id_fk` ASC) ,
  INDEX `fk_lifeforms_word_lifeform_sets1_idx` (`lifeform_set_id_fk` ASC) ,
  CONSTRAINT `fk_lifeforms_words1`
    FOREIGN KEY (`word_id_fk`)
    REFERENCES `cyberlife`.`words` (`word_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lifeforms_word_lifeform_sets1`
    FOREIGN KEY (`lifeform_set_id_fk`)
    REFERENCES `cyberlife`.`word_lifeform_sets` (`lifeform_set_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`states` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_type` VARCHAR(45) NULL DEFAULT 'double',
  `description` MULTILINESTRING NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`),
  UNIQUE INDEX `state_id_UNIQUE` (`state_id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`phenomens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`phenomens` (
  `phenomen_id` INT NOT NULL AUTO_INCREMENT,
  `effect` DOUBLE NOT NULL,
  `description` VARCHAR(45) NULL,
  `state_id_fk` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phenomen_id`, `state_id_fk`),
  UNIQUE INDEX `phenomen_id_UNIQUE` (`phenomen_id` ASC) ,
  INDEX `fk_phenomens_states1_idx` (`state_id_fk` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  CONSTRAINT `fk_phenomens_states1`
    FOREIGN KEY (`state_id_fk`)
    REFERENCES `cyberlife`.`states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`lifeform_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`lifeform_states` (
  `value` DOUBLE NOT NULL DEFAULT 0,
  `state_id_fk` INT NOT NULL,
  `lifeform_id_fk` INT NOT NULL,
  PRIMARY KEY (`state_id_fk`, `lifeform_id_fk`),
  INDEX `fk_lifeform_states_lifeforms1_idx` (`lifeform_id_fk` ASC) ,
  CONSTRAINT `fk_lifeform_states_states`
    FOREIGN KEY (`state_id_fk`)
    REFERENCES `cyberlife`.`states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lifeform_states_lifeforms1`
    FOREIGN KEY (`lifeform_id_fk`)
    REFERENCES `cyberlife`.`lifeforms` (`lifeform_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyberlife`.`word_phenomens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyberlife`.`word_phenomens` (
  `area` MULTIPOINT NOT NULL,
  `gradient_factor` DOUBLE NULL,
  `power_factor` DOUBLE NOT NULL,
  `phenomen_id_fk` INT NOT NULL,
  `state_id_fk` INT NOT NULL,
  `word_id_fk` INT NOT NULL,
  `status` BIT NOT NULL,
  `period` INT NULL,
  PRIMARY KEY (`phenomen_id_fk`, `state_id_fk`, `word_id_fk`),
  INDEX `fk_word_phenomens_words1_idx` (`word_id_fk` ASC) ,
  CONSTRAINT `fk_word_phenomens_phenomens1`
    FOREIGN KEY (`phenomen_id_fk` , `state_id_fk`)
    REFERENCES `cyberlife`.`phenomens` (`phenomen_id` , `state_id_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_word_phenomens_words1`
    FOREIGN KEY (`word_id_fk`)
    REFERENCES `cyberlife`.`words` (`word_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

