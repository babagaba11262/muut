-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema crawltietokanta
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema crawltietokanta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crawltietokanta` DEFAULT CHARACTER SET utf8 ;
USE `crawltietokanta` ;

-- -----------------------------------------------------
-- Table `crawltietokanta`.`table_kaupat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crawltietokanta`.`table_kaupat` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Nimi` VARCHAR(45) NULL DEFAULT NULL,
  `URL` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `crawltietokanta`.`table_tuote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crawltietokanta`.`table_tuote` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `hinta` FLOAT NULL DEFAULT NULL,
  `KPL` INT(11) NULL DEFAULT NULL COMMENT 'tulevaisuuden varalle',
  `nimi` VARCHAR(80) NULL DEFAULT NULL,
  `URL` TEXT NULL DEFAULT NULL,
  `Valmistusvuosi` INT(11) NULL DEFAULT NULL,
  `ID_kauppa` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `kauppa_idx` (`ID_kauppa` ASC),
  CONSTRAINT `kauppa`
    FOREIGN KEY (`ID_kauppa`)
    REFERENCES `crawltietokanta`.`table_kaupat` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `crawltietokanta`.`table_sarja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crawltietokanta`.`table_sarja` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `nimi` VARCHAR(80) NULL DEFAULT NULL,
  `ID_tuote` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `tuote_idx` (`ID_tuote` ASC),
  CONSTRAINT `tuote`
    FOREIGN KEY (`ID_tuote`)
    REFERENCES `crawltietokanta`.`table_tuote` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `crawltietokanta`.`table_valmistaja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crawltietokanta`.`table_valmistaja` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Nimi` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `crawltietokanta`.`table_komponentti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crawltietokanta`.`table_komponentti` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_Valmistaja` INT(11) NULL DEFAULT NULL,
  `ID_Sarja` INT(11) NULL DEFAULT NULL,
  `Komponentti_tyyppi` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Tähän onko osa esim. prosessori vai RAM.',
  PRIMARY KEY (`ID`),
  INDEX `valmistaja_idx` (`ID_Valmistaja` ASC),
  INDEX `sarja_idx` (`ID_Sarja` ASC),
  CONSTRAINT `sarja`
    FOREIGN KEY (`ID_Sarja`)
    REFERENCES `crawltietokanta`.`table_sarja` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `valmistaja`
    FOREIGN KEY (`ID_Valmistaja`)
    REFERENCES `crawltietokanta`.`table_valmistaja` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
