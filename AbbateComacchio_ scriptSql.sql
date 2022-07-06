drop database CentroEsami;
CREATE DATABASE IF NOT EXISTS CentroEsami;
USE CentroEsami;

CREATE TABLE Dottore(
id_dottore INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(20) NOT NULL,
cognome VARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE Reparto(
id_reparto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(20) NOT NULL,
descrizione VARCHAR(100),
id_dottore INT NOT NULL,
FOREIGN KEY (id_dottore) REFERENCES Dottore(id_dottore) ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE Paziente(
    id_paziente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    ddn date,
    recapito VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    telefono VARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE Accoglie(
id_paziente INT,
id_reparto INT,
PRIMARY KEY (id_paziente, id_reparto),
FOREIGN KEY (id_reparto) REFERENCES Reparto(id_reparto) ON UPDATE CASCADE,
FOREIGN KEY (id_paziente) REFERENCES Paziente(id_paziente) ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE Esame(
id_esame INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
descrizione VARCHAR(100),
id_reparto INT NOT NULL,
FOREIGN KEY (id_reparto) REFERENCES Reparto(id_reparto) ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE Prenotazione(
id_prenotazione INT PRIMARY KEY AUTO_INCREMENT,
giorno DATE NOT NULL,
fascia_oraria VARCHAR(20) NOT NULL,
id_paziente INT NOT NULL, 
FOREIGN KEY (id_paziente) REFERENCES Paziente(id_paziente) ON UPDATE CASCADE,
id_esame INT NOT NULL,
FOREIGN KEY (id_esame) REFERENCES Esame(id_esame) ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE Prescrizione(
id_prescrizione INT PRIMARY KEY AUTO_INCREMENT,
descrizione VARCHAR(100),
id_dottore INT NOT NULL,
FOREIGN KEY (id_dottore) REFERENCES Dottore(id_dottore) ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE Farmaco(
id_farmaco INT PRIMARY KEY AUTO_INCREMENT,
descrizione VARCHAR(100)
) ENGINE=INNODB;

CREATE TABLE Ordina(
id_farmaco INT,
id_prescrizione INT,
primary key(id_farmaco,id_prescrizione),
FOREIGN KEY (id_farmaco) REFERENCES Farmaco(id_farmaco) ON UPDATE CASCADE,
FOREIGN KEY (id_prescrizione) REFERENCES Prescrizione(id_prescrizione) ON UPDATE CASCADE
)ENGINE=INNODB;


### INSERT ###

INSERT INTO Dottore (nome,cognome) VALUES 
('Giulio','Mari'),
('Salvo','Giusti'),
('Stefano','Bogani'),
('Marco','Marchi'),
('Giorgio','Bello');

INSERT INTO Reparto (nome, descrizione,id_dottore) VALUES
('Cardiologia','','1'),
('Dermatologia','','2'),
('Ematologia','','3'),
('Neurologia','','4'),
('Radiologia','','5');

INSERT INTO Paziente (nome, cognome, ddn, recapito, email, telefono) VALUES
('Paolo','Rossi', '1965-02-15' ,'via roma 23','paolorossi@gmail.com','3276612237'),
('Marco','Bianchi', '1972-05-12', 'Via Bindo 37','bianchimarco@yahoo.it','3391265343'),
('Paola','Blu', '1973-12-10', 'Via Domiziano 4','blublu@gmail.com','3358266243'),
('Sara','Verdi', '1990-03-03', 'Borgo Gennaro 32','sarina90@gmail.com','3278766788'),
('Alice','Rossi','1988-06-24', 'Via Guastone 95', 'rossi1988@alice.it','3445448733'),
('Marta','Neri','1993-11-23', 'Strada Degrassi 2','marta93neri@hotmail.com','3229829399'),
('Filippo','Blu','1992-06-10', 'Via Masiero 5','fillo1006@alice.it','334786528'),
('Massimo','Rossi','1995-07-15', 'Via Luciani 78','max95rossi@yahoo.it','33176291182');

INSERT INTO Esame (nome, descrizione, id_reparto) VALUES
('TAC cardiaca','esame non invasivo','1'),						-- 1
('Risonanza magnetica cardiaca','esame non invasivo','1'),		-- 2
('Pacemaker','esame invasivo','1'),								-- 3
('Epiluminescenza','esame non invasivo','2'),					-- 4
('Visita Dermatologica','esame non invasivo','2'),				-- 5
('Visita Ematologica','esame non invasivo','3'),				-- 6
('Visita Neurologica','esame non invasivo','4'),				-- 7
('Eelettroencefalogramma','esame non invasivo','4'),			-- 8
('Radiografia','esame non invasivo','5');		

INSERT INTO Prenotazione (giorno, fascia_oraria, id_paziente, id_esame) VALUES
('2021-06-07','1','1','1'),
('2021-06-07','2','2','9'),
('2021-06-07','3','1','2'),
('2021-06-08','1','8','3'),
('2021-06-08','2','3','6'),
('2021-06-08','3','4','8'),
('2021-06-06','4','7','4'),
('2021-06-09','4','5','5');

INSERT INTO Accoglie (id_reparto, id_paziente) VALUES
('1','1'),
('5','2'),
('1','8'),
('3','2'),
('3','3'),
('4','4'),
('2','7'),
('2','5');

INSERT INTO Farmaco (descrizione) VALUES
('Gentanibeta'),
('Tachipirina'),
('Brufen'),
('Buscofen'),
('Imodium'),
('Cortisone'),
('Nurofen');
INSERT INTO Prescrizione (descrizione,id_dottore) VALUES
('da prendere una volta al giorno','1'),
('mezza pasticca al di','1'),
('due volte al giorno','2'),
('due volte al giorno','2'),
('da diluire','3');
INSERT INTO Ordina (id_farmaco, id_prescrizione) VALUES
('1','5'),
('6','3'),
('5','1'),
('3','2'),
('4','4');

### VIEWS ###
CREATE OR REPLACE VIEW n_prenotazioni_oggi AS 
SELECT count(id_prenotazione) FROM Prenotazione WHERE giorno=CURRENT_DATE();

CREATE OR REPLACE VIEW viste_richieste AS 
SELECT pr.id_prenotazione, p.nome, p.cognome, pr.giorno FROM Paziente p, Prenotazione pr WHERE pr.id_paziente=p.id_paziente;

CREATE OR REPLACE VIEW n_farmaci_prescritti_daDott_MarcoMarchi AS 
SELECT count(id_prescrizione) FROM Prescrizione p, Dottore d WHERE d.id_dottore = '4' and d.id_dottore=p.id_dottore;

CREATE OR REPLACE VIEW n_prenotazioni_giornoSpecifico AS 
SELECT count(id_prenotazione) FROM Prenotazione WHERE giorno=DATE(2021-06-08);



### delete svuota tabelle ###
#delete from Paziente where id_paziente;     
     

DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_maxGiornaliereRepartoCardiologia
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE msg VARCHAR(255);
    set msg = concat('Inserimento non possibile: superato il limite massimo giornaliero di richieste di prenotazione per questo reparto');
    select count(id_prenotazione) into x from Prenotazione WHERE giorno = new.giorno AND id_esame in 
    (select id_esame from esame e where e.id_reparto = '1');
        IF x >= 5 THEN
            signal sqlstate '45000' set message_text = msg;
        END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_maxGiornaliereRepartoDermatologia
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE msg VARCHAR(255);
    set msg = concat('Inserimento non possibile: superato il limite massimo giornaliero di richieste di prenotazione per questo reparto');
    select count(id_prenotazione) into x from Prenotazione WHERE giorno = new.giorno AND id_esame in 
    (select id_esame from esame e where e.id_reparto = '2');
        IF x >= 5 THEN
            signal sqlstate '45000' set message_text = msg;
        END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_maxGiornaliereRepartoEmatologia
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE msg VARCHAR(255);
    set msg = concat('Inserimento non possibile: superato il limite massimo giornaliero di richieste di prenotazione per questo reparto');
    select count(id_prenotazione) into x from Prenotazione WHERE giorno = new.giorno AND id_esame in 
    (select id_esame from esame e where e.id_reparto = '3');
        IF x >= 5 THEN
            signal sqlstate '45000' set message_text = msg;
        END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_maxGiornaliereRepartoNeurologia
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE msg VARCHAR(255);
    set msg = concat('Inserimento non possibile: superato il limite massimo giornaliero di richieste di prenotazione per questo reparto');
    select count(id_prenotazione) into x from Prenotazione WHERE giorno = new.giorno AND id_esame in 
    (select id_esame from esame e where e.id_reparto = '4');
        IF x >= 5 THEN
            signal sqlstate '45000' set message_text = msg;
        END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_maxGiornaliereRepartoRadiologia
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
    DECLARE x INT;
    DECLARE msg VARCHAR(255);
    set msg = concat('Inserimento non possibile: superato il limite massimo giornaliero di richieste di prenotazione per questo reparto');
    select count(id_prenotazione) into x from Prenotazione WHERE giorno = new.giorno AND id_esame in 
    (select id_esame from esame e where e.id_reparto = '5');
        IF x >= 5 THEN
            signal sqlstate '45000' set message_text = msg;
        END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER trigger_fasceOrarie
BEFORE INSERT
ON Prenotazione
FOR EACH ROW
BEGIN
	DECLARE fascia  VARCHAR(20);
    DECLARE msg VARCHAR(255);
	set msg = concat('Inserimento non possibile: fascia oraria gia prenotata');
	SELECT fascia_oraria INTO fascia FROM Prenotazione WHERE fascia_oraria=new.fascia_oraria 
		and giorno=new.giorno;
	IF fascia != '' THEN
		signal sqlstate '45000' set message_text = msg;
   END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER trigger_n_prenotazioni_passate
	BEFORE INSERT
	ON Prenotazione
	FOR EACH ROW
	BEGIN
		DECLARE s VARCHAR(20);
		 DECLARE msg VARCHAR(255);
		set msg = concat('Inserimento non possibile: giorno ormai passato');		
		SELECT giorno INTO s FROM Prenotazione WHERE giorno=new.giorno;
		IF s < CURRENT_DATE() THEN
			signal sqlstate '45000' set message_text = msg;	END IF;
	END$$
DELIMITER ;

### PROCEDURA ###
DELIMITER $$
CREATE PROCEDURE dati_paziente(id int(20), nome VARCHAR(20), cognome VARCHAR(20), ddn DATE, recapito VARCHAR(50), email VARCHAR(50), tel VARCHAR(20))
BEGIN
 IF (id NOT IN (SELECT id_paziente FROM Paziente p WHERE id_paziente = id))
 THEN
	INSERT INTO Paziente (id_paziente,nome,cognome,ddn,recapito,email,telefono) VALUES (id,nome,cognome,ddn,recapito, email,tel);
	ELSE UPDATE Paziente p SET p.nome=nome, p.cognome=cognome, p.ddn=ddn,  p.recapito=recapito, p.email=email, p.telefono=tel WHERE id_paziente=id;
 END IF;
SELECT * FROM Paziente WHERE id_paziente = id;
END $$
DELIMITER ;




### alcuni controlli gia pronti ###

### SELECT ###
-- select * from Dottore;
-- select * from Paziente;
-- select * from Prenotazione WHERE giorno=date('2021-06-07');
-- select * from n_prenotazioni_oggi;
-- select * from Prenotazione;
-- select * from Esame;
-- select * from Accoglie;
-- SELECT * from viste_richieste;
-- SELECT count(id_prenotazione) FROM Prenotazione WHERE giorno=CURRENT_DATE();
     
### controllo trigger ###
-- INSERT INTO Prenotazione (giorno, fascia_oraria, id_paziente, id_esame) VALUES ('2021-06-07','6','1','1');
-- SELECT fascia_oraria  FROM Prenotazione WHERE fascia_oraria='1' and giorno='2021-06-07';

### controllo procedura ###
-- call CentroEsami.dati_paziente(2, 'Marco', 'Bianchini', '1972-05-12', 'Via Bindo 37', 'bianchimarco@yahoo.it', '3391265343');
