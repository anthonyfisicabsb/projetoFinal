-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `rg` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `endereco` VARCHAR(200) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`rg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Simulado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Simulado` (
  `idSimulado` INT NOT NULL,
  PRIMARY KEY (`idSimulado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questao` (
  `idQuestão` INT NOT NULL,
  `enunciado` VARCHAR(400) NOT NULL,
  `itemA` VARCHAR(400) NOT NULL,
  `itemB` VARCHAR(400) NOT NULL,
  `itemC` VARCHAR(400) NOT NULL,
  `itemD` VARCHAR(400) NOT NULL,
  `itemE` VARCHAR(400) NOT NULL,
  `resposta` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `qtdAcertos` INT NOT NULL,
  `qtdTentativas` INT NOT NULL,
  PRIMARY KEY (`idQuestão`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rl_Simulado_Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rl_Simulado_Questao` (
  `Simulado_idSimulado` INT NOT NULL,
  `Questao_idQuestão` INT NOT NULL,
  INDEX `fk_Rl_Simulado_Questao_Simulado_idx` (`Simulado_idSimulado` ASC) VISIBLE,
  INDEX `fk_Rl_Simulado_Questao_Questao1_idx` (`Questao_idQuestão` ASC) VISIBLE,
  PRIMARY KEY (`Simulado_idSimulado`, `Questao_idQuestão`),
  CONSTRAINT `fk_Rl_Simulado_Questao_Simulado`
    FOREIGN KEY (`Simulado_idSimulado`)
    REFERENCES `mydb`.`Simulado` (`idSimulado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rl_Simulado_Questao_Questao1`
    FOREIGN KEY (`Questao_idQuestão`)
    REFERENCES `mydb`.`Questao` (`idQuestão`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rl_Cliente_Simulado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rl_Cliente_Simulado` (
  `Simulado_idSimulado` INT NOT NULL,
  `Cliente_rg` VARCHAR(20) NOT NULL,
  INDEX `fk_Rl_Cliente_Simulado_Simulado1_idx` (`Simulado_idSimulado` ASC) VISIBLE,
  INDEX `fk_Rl_Cliente_Simulado_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  PRIMARY KEY (`Simulado_idSimulado`, `Cliente_rg`),
  CONSTRAINT `fk_Rl_Cliente_Simulado_Simulado1`
    FOREIGN KEY (`Simulado_idSimulado`)
    REFERENCES `mydb`.`Simulado` (`idSimulado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rl_Cliente_Simulado_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Apostila`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Apostila` (
  `idApostila` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `qtdPags` INT NOT NULL,
  PRIMARY KEY (`idApostila`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `quantidade` VARCHAR(45) NOT NULL,
  `pago` TINYINT NOT NULL,
  `valorTotal` DECIMAL(10,2) NOT NULL,
  `dataCompra` DATETIME NOT NULL,
  `Apostila_idApostila` INT NOT NULL,
  `Cliente_rg` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Apostila1_idx` (`Apostila_idApostila` ASC) VISIBLE,
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Apostila1`
    FOREIGN KEY (`Apostila_idApostila`)
    REFERENCES `mydb`.`Apostila` (`idApostila`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Embarcacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Embarcacao` (
  `chassi` VARCHAR(30) NOT NULL,
  `comprimento` FLOAT NOT NULL,
  `tipo` VARCHAR(20) NOT NULL,
  `boca` FLOAT NOT NULL,
  `pontal` FLOAT NOT NULL,
  `tripulantes` INT NOT NULL,
  `passageiros` INT NOT NULL,
  `matCasco` VARCHAR(30) NOT NULL,
  `arqBruta` FLOAT NOT NULL,
  `arqLiquida` FLOAT NOT NULL,
  `motor` VARCHAR(50) NOT NULL,
  `potencia` INT NOT NULL,
  `foto` BLOB NOT NULL,
  `Cliente_rg` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`chassi`),
  INDEX `fk_Embarcacao_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  CONSTRAINT `fk_Embarcacao_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoServico` (
  `idTipoServico` INT NOT NULL,
  `tipoServico` VARCHAR(30) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idTipoServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rl_Cliente_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rl_Cliente_Servico` (
  `Cliente_rg` VARCHAR(20) NOT NULL,
  `valorTot` DECIMAL(10,2) NOT NULL,
  `pago` TINYINT NOT NULL,
  `TipoServico_idTipoServico` INT NOT NULL,
  INDEX `fk_Rl_Cliente_Servico_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  PRIMARY KEY (`Cliente_rg`, `TipoServico_idTipoServico`),
  INDEX `fk_Rl_Cliente_Servico_TipoServico1_idx` (`TipoServico_idTipoServico` ASC) VISIBLE,
  CONSTRAINT `fk_Rl_Cliente_Servico_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rl_Cliente_Servico_TipoServico1`
    FOREIGN KEY (`TipoServico_idTipoServico`)
    REFERENCES `mydb`.`TipoServico` (`idTipoServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prova` (
  `Cliente_rg` VARCHAR(20) NOT NULL,
  `dataProva` DATE NOT NULL,
  `aprovado` TINYINT NOT NULL,
  INDEX `fk_Prova_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  PRIMARY KEY (`Cliente_rg`),
  CONSTRAINT `fk_Prova_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoAula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoAula` (
  `idTipoAula` INT NOT NULL,
  `tipoAula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idTipoAula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aula` (
  `dataAula` DATE NOT NULL,
  `local` VARCHAR(30) NOT NULL,
  `TipoAula_idTipoAula` INT NOT NULL,
  PRIMARY KEY (`dataAula`),
  INDEX `fk_Aula_TipoAula1_idx` (`TipoAula_idTipoAula` ASC) VISIBLE,
  CONSTRAINT `fk_Aula_TipoAula1`
    FOREIGN KEY (`TipoAula_idTipoAula`)
    REFERENCES `mydb`.`TipoAula` (`idTipoAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rl_Cliente_Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rl_Cliente_Aula` (
  `Cliente_rg` VARCHAR(20) NOT NULL,
  `Aula_dataAula` DATE NOT NULL,
  INDEX `fk_Rl_Cliente_Aula_Cliente1_idx` (`Cliente_rg` ASC) VISIBLE,
  PRIMARY KEY (`Cliente_rg`, `Aula_dataAula`),
  INDEX `fk_Rl_Cliente_Aula_Aula1_idx` (`Aula_dataAula` ASC) VISIBLE,
  CONSTRAINT `fk_Rl_Cliente_Aula_Cliente1`
    FOREIGN KEY (`Cliente_rg`)
    REFERENCES `mydb`.`Cliente` (`rg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rl_Cliente_Aula_Aula1`
    FOREIGN KEY (`Aula_dataAula`)
    REFERENCES `mydb`.`Aula` (`dataAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
