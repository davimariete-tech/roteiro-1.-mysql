-- -----------------------------------------------------
-- Schema dbEvento
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbEvento` DEFAULT CHARACTER SET utf8 ;
USE `dbEvento` ;

-- -----------------------------------------------------
-- Table `dbEvento`.`EVENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`EVENTO` (
  `idEvento` INT NOT NULL,
  `nomeEvento` VARCHAR(45) NOT NULL,
  `dtEvento` DATE NOT NULL,
  `quantMaxIngressos` INT NOT NULL,
  `valor` FLOAT NOT NULL,
  `localEvento` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEvento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbEvento`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`CLIENTE` (
  `CPF` CHAR(11) NOT NULL,
  `nome` VARCHAR(25) NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `dtNascimento` DATE NOT NULL,
  `logradouro` VARCHAR(100) NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `ddd` CHAR(3) NOT NULL,
  `numTel` CHAR(9) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbEvento`.`EMPRESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`EMPRESA` (
  `CNPJ` VARCHAR(14) NOT NULL,
  `nomeEmpresa` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbEvento`.`TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`TELEFONE` (
  `ddd` CHAR(3) NOT NULL,
  `numTel` CHAR(9) NOT NULL,
  `EMPRESA_CNPJ` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`ddd`, `numTel`),
  INDEX `fk_TELEFONE_EMPRESA1_idx` (`EMPRESA_CNPJ` ASC),
  CONSTRAINT `fk_TELEFONE_EMPRESA1`
    FOREIGN KEY (`EMPRESA_CNPJ`)
    REFERENCES `dbEvento`.`EMPRESA` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbEvento`.`INGRESSO_VENDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`INGRESSO_VENDIDO` (
  `codIngresso` INT NOT NULL,
  `valorPago` FLOAT NOT NULL,
  `dtCompra` DATE NOT NULL,
  `CLIENTE_CPF` CHAR(11) NULL,
  `EVENTO_idEvento` INT NOT NULL,
  INDEX `fk_EVENTO_has_CLIENTE_CLIENTE1_idx` (`CLIENTE_CPF` ASC),
  INDEX `fk_EVENTO_has_CLIENTE_EVENTO_idx` (`EVENTO_idEvento` ASC),
  PRIMARY KEY (`codIngresso`),
  CONSTRAINT `fk_EVENTO_has_CLIENTE_EVENTO`
    FOREIGN KEY (`EVENTO_idEvento`)
    REFERENCES `dbEvento`.`EVENTO` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EVENTO_has_CLIENTE_CLIENTE1`
    FOREIGN KEY (`CLIENTE_CPF`)
    REFERENCES `dbEvento`.`CLIENTE` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbEvento`.`EVENTO_EMPRESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbEvento`.`EVENTO_EMPRESA` (
  `EVENTO_idEvento` INT NOT NULL,
  `EMPRESA_CNPJ` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`EVENTO_idEvento`, `EMPRESA_CNPJ`),
  INDEX `fk_EVENTO_has_EMPRESA_EMPRESA1_idx` (`EMPRESA_CNPJ` ASC),
  INDEX `fk_EVENTO_has_EMPRESA_EVENTO1_idx` (`EVENTO_idEvento` ASC),
  CONSTRAINT `fk_EVENTO_has_EMPRESA_EVENTO1`
    FOREIGN KEY (`EVENTO_idEvento`)
    REFERENCES `dbEvento`.`EVENTO` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EVENTO_has_EMPRESA_EMPRESA1`
    FOREIGN KEY (`EMPRESA_CNPJ`)
    REFERENCES `dbEvento`.`EMPRESA` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





-- JANELA/ARQUIVO: Script_Manipulacao_Dados.sql
USE `dbEvento`;

-- ============================================================================
-- l.a) INSERIR DADOS
-- ============================================================================

-- 1. Inserir 10 clientes (Regra B: Apenas logradouro pode ser NULL)
INSERT INTO `dbEvento`.`CLIENTE` (`CPF`, `nome`, `sobrenome`, `dtNascimento`, `logradouro`, `bairro`, `cidade`, `estado`, `ddd`, `numTel`) VALUES
('11122233344', 'Carlos', 'Silva', '1990-05-15', NULL, 'Centro', 'Salvador', 'BA', '071', '999991111'),
('22233344455', 'Ana', 'Oliveira', '1985-08-22', 'Rua das Flores, 12', 'Pituba', 'Salvador', 'BA', '071', '999992222'),
('33344455566', 'Bruno', 'Santos', '1993-11-02', NULL, 'Itaigara', 'Salvador', 'BA', '071', '999993333'),
('44455566677', 'Julia', 'Costa', '1998-01-30', 'Av. Sete, 450', 'Dois de Julho', 'Salvador', 'BA', '071', '999994444'),
('55566677788', 'Marcos', 'Pereira', '1975-04-12', 'Rua Chile, 5', 'Centro', 'Salvador', 'BA', '071', '999995555'),
('66677788899', 'Mariana', 'Almeida', '2000-09-18', NULL, 'Imbuí', 'Salvador', 'BA', '071', '999996666'),
('77788899900', 'Paulo', 'Ribeiro', '1988-12-25', 'Rua Pará, 88', 'Pituba', 'Salvador', 'BA', '071', '999997777'),
('88899900011', 'Fernanda', 'Lima', '1995-03-05', NULL, 'Cabula', 'Salvador', 'BA', '071', '999998888'),
('99900011122', 'Ricardo', 'Gomes', '1982-07-14', 'Av. ACM, 1000', 'Itaigara', 'Salvador', 'BA', '071', '999999999'),
('00011122233', 'Beatriz', 'Souza', '1997-10-21', 'Rua da Paz, 33', 'Graça', 'Salvador', 'BA', '071', '999990000');

-- 2. Inserir 5 empresas responsáveis
INSERT INTO `dbEvento`.`EMPRESA` (`CNPJ`, `nomeEmpresa`, `logradouro`, `bairro`, `cidade`, `estado`) VALUES
('12345678000101', 'Show Time Produções', 'Av. Tancredo Neves, 150', 'Caminho das Árvores', 'Salvador', 'BA'),
('23456789000102', 'Bahia Eventos S.A.', 'Av. Centenário, 200', 'Chame-Chame', 'Salvador', 'BA'),
('34567890000103', 'Pega Leve Produções', 'Rua Sergipe, 45', 'Pituba', 'Salvador', 'BA'),
('45678901000104', 'Vibe Entretenimento', 'Av. Paralela, 4000', 'Imbuí', 'Salvador', 'BA'),
('56789012000105', 'Cultural Produções', 'Rua Chile, 10', 'Centro', 'Salvador', 'BA');

-- 3. Inserir 10 eventos (idEvento gera automaticamente devido ao AUTO_INCREMENT)
INSERT INTO `dbEvento`.`EVENTO` (`nomeEvento`, `dtEvento`, `quantMaxIngressos`, `valor`, `localEvento`) VALUES
('Festival de Verão', '2026-01-20', 50000, 180.00, 'Parque de Exposições'),
('Carnaval Antecipado', '2026-02-10', 30000, 250.00, 'Circuito Barra-Ondina'),
('Rock na Praça', '2026-03-15', 5000, 0.00, 'Praça da Sé'),
('Sinfonia da Bahia', '2026-04-05', 1500, 80.00, 'Teatro Castro Alves'),
('Arraiá da Capital', '2026-06-22', 20000, 50.00, 'Pelourinho'),
('Samba Prime', '2026-07-18', 10000, 120.00, 'Arena Fonte Nova'),
('Stand Up Comedy Night', '2026-08-12', 800, 60.00, 'Centro de Convenções'),
('Festival de Jazz', '2026-09-05', 3000, 150.00, 'Solar do Unhão'),
('Feira de Tecnologia', '2026-10-22', 15000, 20.00, 'Centro de Convenções'),
('Show da Virada', '2026-12-31', 60000, 300.00, 'Arena Daniela Mercury');

-- 4. Associar Empresas aos Eventos (Garantindo o critério exigido de vínculos):
-- 4 eventos com 1 empresa responsável (Eventos 1, 2, 3, 4)
-- 4 eventos com 2 empresas responsáveis (Eventos 5, 6, 7, 8)
-- 2 eventos com 3 empresas responsáveis (Eventos 9, 10)
INSERT INTO `dbEvento`.`EVENTO_EMPRESA` (`EVENTO_idEvento`, `EMPRESA_CNPJ`) VALUES
(1, '12345678000101'),
(2, '23456789000102'),
(3, '34567890000103'),
(4, '45678901000104'),
-- Evento 5 (2 empresas)
(5, '12345678000101'), (5, '56789012000105'),
-- Evento 6 (2 empresas)
(6, '23456789000102'), (6, '34567890000103'),
-- Evento 7 (2 empresas)
(7, '45678901000104'), (7, '56789012000105'),
-- Evento 8 (2 empresas)
(8, '12345678000101'), (8, '34567890000103'),
-- Evento 9 (3 empresas)
(9, '23456789000102'), (9, '45678901000104'), (9, '56789012000105'),
-- Evento 10 (3 empresas)
(10, '12345678000101'), (10, '23456789000102'), (10, '34567890000103');

-- 5. Carga extra necessária para testar as deleções (Ingressos Vendidos)
INSERT INTO `dbEvento`.`INGRESSO_VENDIDO` (`codIngresso`, `valorPago`, `dtCompra`, `CLIENTE_CPF`, `EVENTO_idEvento`) VALUES
(101, 180.00, '2026-01-05', '11122233344', 1),
(102, 250.00, '2026-01-10', '22233344455', 2),
(103, 50.00, '2026-05-20', '33344455566', 5);


-- ============================================================================
-- l.b) ALTERAR DADOS
-- ============================================================================

-- Alterar a Data de Nascimento de um cliente
UPDATE `dbEvento`.`CLIENTE` 
SET `dtNascimento` = '1991-05-15' 
WHERE `CPF` = '11122233344';

-- Alterar o CPF de um cliente (Testa a Regra F: Cascata na tabela INGRESSO_VENDIDO)
UPDATE `dbEvento`.`CLIENTE` 
SET `CPF` = '11122233399' 
WHERE `CPF` = '11122233344';

-- Alterar o endereço de uma empresa responsável
UPDATE `dbEvento`.`EMPRESA` 
SET `logradouro` = 'Av. Tancredo Neves, 5000', `bairro` = 'Caminho das Árvores' 
WHERE `CNPJ` = '12345678000101';

-- Alterar o local e a data de um evento
UPDATE `dbEvento`.`EVENTO` 
SET `localEvento` = 'Centro de Convenções Salvador', `dtEvento` = '2026-01-25' 
WHERE `idEvento` = 1;


-- ============================================================================
-- l.c) EXCLUIR DADOS
-- ============================================================================

-- Excluir um cliente específico (Testa a Regra G: Muda para NULL o CPF no ingresso 102)
DELETE FROM `dbEvento`.`CLIENTE` 
WHERE `CPF` = '22233344455';

-- Excluir ingressos vendidos de um evento (Deleta o ingresso do evento 5 de forma manual)
DELETE FROM `dbEvento`.`INGRESSO_VENDIDO` 
WHERE `EVENTO_idEvento` = 5;

-- Excluir eventos de uma determinada empresa responsável
-- Nota de Integridade: Devido à regra C (RESTRICT), para poder excluir os eventos de uma empresa, 
-- removemos primeiro a associação dessa empresa na tabela intermediária EVENTO_EMPRESA.
DELETE FROM `dbEvento`.`EVENTO_EMPRESA` 
WHERE `EMPRESA_CNPJ` = '56789012000105';

-- Agora apagamos os eventos que eram de responsabilidade exclusiva dela (Ex: Evento 7 que sobrou)
DELETE FROM `dbEvento`.`EVENTO` 
WHERE `idEvento` = 7;




INSERT INTO `dbEvento`.`INGRESSO_VENDIDO` (`codIngresso`, `valorPago`, `dtCompra`, `CLIENTE_CPF`, `EVENTO_idEvento`) VALUES
-- Evento 1 (Festival de Verão) - R$ 180.00
(201, 180.00, '2026-01-02', '11122233399', 1),
(202, 180.00, '2026-01-03', '33344455566', 1),
(203, 180.00, '2026-01-05', '44455566677', 1),

-- Evento 2 (Carnaval Antecipado) - R$ 250.00
(204, 250.00, '2026-01-15', '55566677788', 2),
(205, 250.00, '2026-01-16', '66677788899', 2),

-- Evento 3 (Rock na Praça) - Gratuito (R$ 0.00)
(206, 0.00, '2026-03-01', '77788899900', 3),
(207, 0.00, '2026-03-02', NULL, 3), -- Venda sem CPF (Permitido pela Regra B)

-- Evento 4 (Sinfonia da Bahia) - R$ 80.00
(208, 80.00, '2026-03-20', '88899900011', 4),
(209, 80.00, '2026-03-22', '99900011122', 4),

-- Evento 6 (Samba Prime) - R$ 120.00
(210, 120.00, '2026-06-10', '00011122233', 6),
(211, 120.00, '2026-06-11', '11122233399', 6),

-- Evento 8 (Festival de Jazz) - R$ 150.00
(212, 150.00, '2026-06-15', NULL, 8), -- Outra venda sem CPF identificador
(213, 150.00, '2026-06-16', '33344455566', 8),

-- Evento 10 (Show da Virada) - R$ 300.00
(214, 300.00, '2026-06-18', '44455566677', 10),
(215, 300.00, '2026-06-19', '55566677788', 10);









-- JANELA/ARQUIVO: Script_Alterar_Valor_Evento.sql
USE `dbEvento`;

-- ============================================================================
-- e) ALTERAR O VALOR BASE DE UM DETERMINADO EVENTO
-- ============================================================================

UPDATE `dbEvento`.`EVENTO`
SET `valor` = 200.00
WHERE `idEvento` = 1;









INNER JOIN `dbEvento`.`INGRESSO_VENDIDO` i ON e.`idEvento` = i.`EVENTO_idEvento`
GROUP BY e.`idEvento`, e.`nomeEvento`
HAVING COUNT(i.`codIngresso`) >= 100;


-- 4. Quantidade de ingressos vendidos para um determinado cliente identificado pelo CPF
SELECT 
    i.`CLIENTE_CPF`,
    COUNT(i.`codIngresso`) AS `quantidadeIngressosComprados`
FROM `dbEvento`.`INGRESSO_VENDIDO` i
WHERE i.`CLIENTE_CPF` = '33344455566'
GROUP BY i.`CLIENTE_CPF`;




-- 6. O valor arrecadado com os ingressos vendidos para um determinado evento
SELECT 
    i.`EVENTO_idEvento`,
    SUM(i.`valorPago`) AS `totalFaturado`
FROM `dbEvento`.`INGRESSO_VENDIDO` i
WHERE i.`EVENTO_idEvento` = 1
GROUP BY i.`EVENTO_idEvento`;
