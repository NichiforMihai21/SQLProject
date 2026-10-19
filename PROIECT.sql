CREATE TABLE TariBanca
(codtara VARCHAR2(2) CONSTRAINT TaraPK PRIMARY KEY,
denumire VARCHAR2(30) NOT NULL,
continent VARCHAR2(20) CONSTRAINT VerifContinent check (continent IN ('Europa', 'Asia', 'Africa', 'America de Nord', 'America de Sud', 'Australia si Oceania')));

CREATE TABLE Sucursale 
(ID_Sucursala NUMBER(3) CONSTRAINT SucursalaPK PRIMARY KEY, 
oras VARCHAR2(30) NOT NULL,
strada VARCHAR2(30) NOT NULL,
numar NUMBER(3) NOT NULL, 
codtara VARCHAR2(2),
CONSTRAINT TaraFK FOREIGN KEY(codtara) REFERENCES TariBanca(codtara));

CREATE TABLE DepartamentBanca
(ID_Departament NUMBER(3) CONSTRAINT DepartamentPK PRIMARY KEY, 
nume_departament VARCHAR2(20), 
ID_Sucursala NUMBER(3),
CONSTRAINT SucursalaFK FOREIGN KEY(ID_Sucursala) REFERENCES Sucursale(ID_Sucursala));

CREATE TABLE AngajatiBanca
(ID_Angajat NUMBER(3) CONSTRAINT AngajatPK PRIMARY KEY,
Nume VARCHAR2(20) NOT NULL, 
Prenume VARCHAR2(20) NOT NULL, 
CNP NUMBER(13) NOT NULL, 
Email VARCHAR2(30),
Telefon VARCHAR2(10) NOT NULL,
Salariu NUMBER(8,2) NOT NULL,
Comision NUMBER(8,2),
Data_Angajare VARCHAR2(20) NOT NULL, 
ID_Departament NUMBER(3),
CONSTRAINT departamentFK FOREIGN KEY(ID_Departament) REFERENCES DepartamentBanca(ID_Departament));

CREATE TABLE ClientiBanca
(ID_Client NUMBER(3) CONSTRAINT ClientPK PRIMARY KEY,
Nume VARCHAR2(20) NOT NULL, 
Prenume VARCHAR2(20) NOT NULL, 
Email VARCHAR2(30),
Telefon VARCHAR2(10) NOT NULL,
Varsta NUMBER(3) CONSTRAINT VarstaCK CHECK (Varsta>=18),
ID_Angajat NUMBER(3),
CONSTRAINT angajatFK FOREIGN KEY(ID_Angajat) REFERENCES AngajatiBanca(ID_Angajat));

CREATE TABLE Carduri
(IBAN VARCHAR2(16) CONSTRAINT IBANPK PRIMARY KEY,
DataExpirare VARCHAR2(20) NOT NULL,
PIN NUMBER(4) NOT NULL,
NumarCard VARCHAR2(16) NOT NULL,
CodCVC NUMBER(3) NOT NULL,
ID_Client NUMBER(3),
CONSTRAINT clientFK FOREIGN KEY(ID_Client) REFERENCES ClientiBanca(ID_Client));

CREATE TABLE Tranzactii
(ID_Tranzactie NUMBER(8) CONSTRAINT TranzactiePK PRIMARY KEY,
Tip VARCHAR2(10) CONSTRAINT TranzactieCK CHECK (Tip IN ('Venit', 'Cheltuiala')),
Valoare NUMBER(9,2) NOT NULL,
DataTranzactie VARCHAR2(20) NOT NULL,
IBAN VARCHAR2(16),
CONSTRAINT IBANFK FOREIGN KEY(IBAN) REFERENCES Carduri(IBAN));

CREATE TABLE ContEconomii
(ID_Cont NUMBER(3) CONSTRAINT ID_ContPK PRIMARY KEY,
SumaDepusa NUMBER(9, 2),
Dobanda NUMBER (4, 2) NOT NULL,
ID_Client NUMBER(3),
CONSTRAINT client_economiiFK FOREIGN KEY(ID_Client) REFERENCES ClientiBanca(ID_Client));

CREATE TABLE Credit
(ID_Credite NUMBER(3) CONSTRAINT ID_CreditPK PRIMARY KEY,
SumaRamasaDeAchitat NUMBER(9),
Dobanda NUMBER (4, 2) NOT NULL,
ID_Client NUMBER(3),
CONSTRAINT client_creditFK FOREIGN KEY(ID_Client) REFERENCES ClientiBanca(ID_Client));

CREATE TABLE Asigurari
(ID_Asigurare NUMBER(3) CONSTRAINT ID_AsigurarePK PRIMARY KEY,
SumaAsigurata NUMBER(9) NOT NULL,
PrimaDePlata NUMBER(4) NOT NULL,
DespagubiriExistente NUMBER(9),
ID_Client NUMBER(3),
CONSTRAINT client_asigurariFK FOREIGN KEY(ID_Client) REFERENCES ClientiBanca(ID_Client));



INSERT INTO TariBanca (codtara, denumire, continent) VALUES ('RO', 'Romania', 'Europa');
INSERT INTO TariBanca (codtara, denumire, continent) VALUES ('IT', 'Italia', 'Europa');
INSERT INTO TariBanca (codtara, denumire, continent) VALUES ('AG', 'Argentina', 'America de Sud');
INSERT INTO TariBanca (codtara, denumire, continent) VALUES ('JP', 'Japonia', 'Asia');
INSERT INTO TariBanca (codtara, denumire, continent) VALUES ('US', 'SUA', 'America de Nord');

INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (1, 'Bucuresti', 'Iuliu Maniu', 70, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (2, 'Bucuresti', 'Magheru', 15, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (19, 'Ploiesti', 'Independentei', 30, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (22, 'Timisoara', 'Progresul', 44, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (27, 'Craiova', 'Victoriei', 111, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (100, 'Cluj-Napoca', 'Aleea Ardealului', 9, 'RO');
INSERT INTO Sucursale (id_sucursala, oras, strada, numar, codtara) VALUES (11, 'Ploiesti', 'Bd. Republicii', 45, 'RO');

SELECT * FROM TariBanca;

SELECT * FROM Sucursale;

INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (10, 'Relatii_Cu_Clienti', 1);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (11, 'Relatii_Cu_Clienti', 19);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (12, 'Relatii_Cu_Clienti', 11);

INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (20, 'Risk Management', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (21, 'Risk Management', 100);

INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (30, 'Trezorerie', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (40, 'IT', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (50, 'HR', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (60, 'Marketing', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (70, 'Audit', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (80, 'Investitii', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (90, 'Juridic', 11);
INSERT INTO DepartamentBanca (id_departament, nume_departament, id_sucursala) VALUES (100, 'Contabilitate', 11);

SELECT *
FROM departamentbanca;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (1, 'Nichifor', 'Mihai-Daniel', 5050512295919, 'nichiformihai21@gmail.com', '0751942986', 15000, '20-JUN-2024', 20);

SELECT *
FROM angajatibanca
WHERE id_angajat=1;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (10, 'Popescu', 'Octavian', 1987655443200, 'popescu.oct98@yahoo.com', '0723445555', 4000, '16-MAR-2017', 12);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (11, 'Popa', 'Adrian', 1885423424634, 'popadi88@yahoo.com', '0723445556', 5000, '11-JAN-2015', 12);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (12, 'Ionescu', 'Ana', 2937655443201, 'ionescu.ana93@yahoo.com', '0733445555', 4200, '25-SEP-2019', 12);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (13, 'Antonescu', 'Nicușor', 1927655443200, 'anto.nicusor92@yahoo.com', '0724445555', 6000, '18-MAR-2012', 12);

SELECT * FROM angajatibanca WHERE id_departament=10;

DELETE FROM angajatibanca
WHERE id_departament=10;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (20, 'Tănase', 'Cristian', 1997655443241, 'tanase.cristian@yahoo.com', '0750445555', 12000, '22-AUG-2017', 20);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (21, 'Popescu', 'Ovidiu', 1805444124634, 'popescu.ovidiu@yahoo.com', '0751445556', 10000, '13-DEC-2009', 20);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (22, 'Stan', 'Elena', 6027655443201, 'stan.elena@yahoo.com', '0738445555', 7000, '21-NOV-2024', 20);

SELECT * FROM angajatibanca WHERE id_departament=20;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (30, 'Dumitrescu', 'Alexandru', 1907655443241, 'dumitrescu.alexandru@yahoo.com', '0758445555', 8000, '07-JAN-2019', 30);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (31, 'Radu', 'Mihai', 1775444124634, 'radu.mihai@yahoo.com', '0756445556', 8500, '16-SEP-2015', 30);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (32, 'Marinescu', 'Ioana', 2857655443201, 'marinescu.ioana@yahoo.com', '0736445555', 8500, '30-JUL-2013', 30);

SELECT * FROM angajatibanca WHERE id_departament=30;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (40, 'Georgescu', 'Cristian', 5001104443241, 'georgescu.cristian@yahoo.com', '0758445555', 10000, '19-FEB-2024', 40);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (41, 'Petrescu', 'Vlad', 1811124124634, 'petrescu.vlad@yahoo.com', '0756445556', 18000, '25-OCT-2016', 40);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (42, 'Ilie', 'Daniela', 2850452443201, 'ilie.daniela@yahoo.com', '0736445555', 16500, '12-NOV-2021', 40);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (43, 'Dobre', 'Laura', 2900615443241, 'dobre.laura@yahoo.com', '0758445555', 17000, '10-MAY-2022', 40);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (44, 'Moraru', 'Daniel', 1790414124634, 'moraru.daniel@yahoo.com', '0756445556', 20000, '14-MAR-2013', 40);

SELECT * FROM angajatibanca WHERE id_departament=40;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (50, 'Niță', 'Teodora', 6001104443241, 'nita.teodora@yahoo.com', '0758445555', 5000, '22-APR-2022', 50);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (51, 'Bălan', 'Roxana', 2991124124634, 'balan.roxana@yahoo.com', '0756445556', 5500, '24-OCT-2021', 50);

SELECT * FROM angajatibanca WHERE id_departament=50;

DELETE FROM angajatibanca WHERE id_departament=50;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (60, 'Popa', 'Andreea', 2980412123456, 'popa.andreea@yahoo.com', '0758445556', 7000, '15-MAR-2021', 60);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (61, 'Ionescu', 'Radu', 1960625123457, 'ionescu.radu@yahoo.com', '0756445557', 10000, '08-JUL-2021', 60);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (62, 'Stoica', 'Alexandru', 1950301123459, 'stoica.alexandru@yahoo.com', '0758445558', 6000, '22-APR-2024', 60);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (63, 'Marin', 'Bianca', 2990918123458, 'marin.bianca@yahoo.com', '0756445559', 12500, '24-OCT-2016', 60);

SELECT * FROM angajatibanca WHERE id_departament=60;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (70, 'Pop', 'Sebastian', 1900412123456, 'pop.sebastian@yahoo.com', '0748445556', 8000, '23-MAR-2019', 70);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (71, 'Rusu', 'Diana', 2930625123457, 'rusu.diana@yahoo.com', '0746445557', 8000, '08-JUL-2018', 70);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (72, 'Sandu', 'Mihai', 1940301123459, 'sandu.mihai@yahoo.com', '0748445558', 7000, '27-OCT-2021', 70);

SELECT * FROM angajatibanca WHERE id_departament=70;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (80, 'Dobre', 'Adrian', 1960715123462, 'dobre.adrian@yahoo.com', '0738445556', 10000, '23-AUG-2016', 80);
INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (81, 'Antonescu', 'Irina', 2900412123456, 'antonescu.irina@yahoo.com', '0728445556', 9000, '13-APR-2019', 80);

SELECT * FROM angajatibanca WHERE id_departament=80;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (90, 'Andreescu', 'Paula', 2960515123462, 'andreescu.paula@gmail.com', '0731445556', 14000, '11-SEP-2013', 90);

SELECT * FROM angajatibanca WHERE id_departament=90;

INSERT INTO angajatibanca (id_angajat, nume, prenume, cnp, email, telefon, salariu, data_angajare, id_departament) 
VALUES (100, 'Sîrbu', 'Octavian', 1900415123456, 'sîrbu.octavian@gmail.com', '0722445556', 7000, '23-APR-2018', 100);

SELECT * FROM angajatibanca WHERE id_departament=100;

INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (1, 'Ronaldo', 'Cristiano', 0733777888, 41, 10);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (2, 'Neață', 'Marius', 0733777881, 30, 10);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (3, 'Popescu', 'Rafael', 0733777880, 25, 10);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (4, 'Vasilescu', 'Andrei', 0733777882, 19, 10);

INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (5, 'Alexandrescu', 'Ioana', 0733777883, 22, 11);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (6, 'Dumitrescu', 'Ilie', 0733777884, 60, 11);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (7, 'Olaru', 'Darius', 0733777885, 43, 11);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (8, 'Târnovanu', 'Ștefan', 0733777886, 49, 11);

INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (9, 'Stanciu', 'Nicolae', 0733777887, 70, 12);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (10, 'Constantinescu', 'Andreea', 0733777889, 21, 12);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (11, 'Dobre', 'Ștefania', 0733777808, 31, 12);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (12, 'Marinescu', 'Lucia', 0733777818, 52, 12);

INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (13, 'Miculescu', 'David', 0733777828, 40, 13);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (14, 'Crețu', 'Valentin', 0733777838, 45, 13);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (15, 'Coman', 'Florinel', 0733777848, 55, 13);
INSERT INTO clientibanca (id_client, nume, prenume, telefon, varsta, id_angajat) VALUES (16, 'Dică', 'Nicolae', 0733777858, 32, 13);

SELECT * FROM clientibanca;

INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO12RZBRA7F9K2M4', '15-MAY-2030', 4837, 4827395612847395, 418,2);
INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO13RZBRQ000R600', '05-MAY-2029', 1040, 4827395612847125, 343,7);
INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO15RZBRQ001R601', '01-NOV-2031', 3311, 4827395652847395, 254,7);
INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO11RZBRQ003R603', '11-FEB-2034', 4422, 4827377612847395, 271,9);
INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO51RZBRQ500R500', '20-OCT-2035', 5566, 4824395612847395, 616,10);
INSERT INTO carduri (IBAN, dataexpirare, PIN, numarcard, codcvc, id_client) VALUES ('RO41RZBRQ400R400', '23-MAY-2028', 7111, 4844395612847395, 112,15);

SELECT * FROM carduri;

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (1, 'Venit', 7500, '10-DEC-2025', 'RO12RZBRA7F9K2M4');
INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (2, 'Cheltuiala', 234, '23-DEC-2025', 'RO12RZBRA7F9K2M4');
INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (3, 'Venit', 611, '31-DEC-2025', 'RO12RZBRA7F9K2M4');

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (4, 'Cheltuiala', 10, '10-NOV-2025', 'RO13RZBRQ000R600');
INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (5, 'Cheltuiala', 435.50, '07-DEC-2025', 'RO13RZBRQ000R600');
INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (6, 'Cheltuiala', 8.50, '01-JAN-2026', 'RO13RZBRQ000R600');

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (7, 'Cheltuiala', 443.4, '10-NOV-2025', 'RO15RZBRQ001R601');
INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (8, 'Venit', 10000, '07-DEC-2025', 'RO15RZBRQ001R601');

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (9, 'Cheltuiala', 2500, '13-DEC-2025', 'RO11RZBRQ003R603');

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (10, 'Venit', 5000, '13-OCT-2025', 'RO51RZBRQ500R500');

INSERT INTO tranzactii (id_tranzactie, tip, valoare, datatranzactie, IBAN) VALUES (11, 'Cheltuiala', 500, '13-DEC-2025', 'RO41RZBRQ400R400');

SELECT * FROM tranzactii;

INSERT INTO conteconomii (id_cont, sumadepusa, dobanda, id_client) VALUES (110, 30000, 4.5, 11);
INSERT INTO conteconomii (id_cont, sumadepusa, dobanda, id_client) VALUES (111, 5000, 4.5, 11);
INSERT INTO conteconomii (id_cont, sumadepusa, dobanda, id_client) VALUES (60, 100000, 4.5, 6);
INSERT INTO conteconomii (id_cont, sumadepusa, dobanda, id_client) VALUES (140, 80000, 4.5, 14);
INSERT INTO conteconomii (id_cont, sumadepusa, dobanda, id_client) VALUES (160, 75000, 4.5, 16);

SELECT * FROM conteconomii;

INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (80, 70000, 6, 8);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (90, 35600,6, 9);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (100, 44000,6, 10);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (120, 5000, 6, 12);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (140, 120000,6, 14);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (150, 150000,6, 15);
INSERT INTO credit (id_credite, sumaramasadeachitat, dobanda, id_client) VALUES (151, 6000,6, 15);

SELECT * FROM credit;

INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, despagubiriexistente, id_client) VALUES (20, 500000, 232, 10000, 2);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, id_client) VALUES (21, 80000, 74, 2);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, despagubiriexistente, id_client) VALUES (30, 30000, 85, 6000, 3);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, id_client) VALUES (40, 100000, 112, 4);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, despagubiriexistente, id_client) VALUES (70, 85000, 117, 12000, 7);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, id_client) VALUES (120, 50000, 54, 12);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, despagubiriexistente, id_client) VALUES (80, 750000, 300, 100000, 8);
INSERT INTO asigurari (id_asigurare, sumaasigurata, primadeplata, id_client) VALUES (140, 60000, 64, 14);

SELECT * FROM asigurari;

--1.	Afișare salariu mediu pe departament+nume departament
SELECT nume_departament, ROUND(AVG(salariu),2) Salariu_Mediu
FROM angajatibanca a, departamentbanca d
WHERE a.id_departament=d.id_departament
GROUP BY nume_departament;

SELECT nume, prenume, COUNT(t.IBAN) Numar_Tranzactii
FROM tranzactii t, clientibanca cb, carduri c
WHERE t.IBAN=c.IBAN AND cb.id_client=c.id_client
GROUP BY cb.nume, cb.prenume
HAVING COUNT(t.IBAN)>=3;

SELECT nume, prenume, TO_DATE(data_angajare, 'DD/MM/YYYY') data_angajare
FROM angajatibanca
WHERE EXTRACT(MONTH FROM (TO_DATE(data_angajare, 'DD/MM/YYYY')))!=03;

SELECT nume, prenume, TO_DATE(data_angajare, 'DD/MM/YYYY') data_angajare
FROM angajatibanca
MINUS
SELECT nume, prenume, TO_DATE(data_angajare, 'DD/MM/YYYY') data_angajare
FROM angajatibanca
WHERE EXTRACT(MONTH FROM (TO_DATE(data_angajare, 'DD/MM/YYYY')))=03;

--4.	Afișare comision de vechime-20%, angajații înainte de 2015, 15% înainte de 2020, 5% restul.
SELECT nume, prenume, TO_DATE(data_angajare, 'DD/MM/YYYY') data_angajare, CASE
WHEN EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY'))<2015 THEN 0.2
WHEN EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY'))<2020 THEN 0.15
ELSE 0.05
END comision
FROM angajatibanca;


UPDATE angajatibanca
SET comision=CASE
WHEN EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY'))<2015 THEN 0.2*salariu
WHEN EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY'))<2020 THEN 0.15*salariu
ELSE 0.05*salariu
END
WHERE comision IS NULL;
SELECT nume, prenume, salariu, comision FROM angajatibanca;

SELECT nume_departament, MAX(salariu) Salariu_Maxim
FROM departamentbanca d, angajatibanca a
WHERE d.id_departament=a.id_departament AND nume_departament NOT IN ('Marketing', 'IT')
GROUP BY nume_departament
ORDER BY MAX(salariu);

SELECT nume, prenume, id_asigurare, despagubiriexistente
FROM asigurari a, clientibanca cb
WHERE a.id_client=cb.id_client AND despagubiriexistente IS NOT NULL;


UPDATE conteconomii
SET sumadepusa=sumadepusa+(SELECT sumadepusa/2 FROM conteconomii WHERE id_cont=111);
SELECT id_cont, sumadepusa 
FROM conteconomii;

SELECT id_cont, sumadepusa
FROM conteconomii;

UPDATE credit
SET dobanda=CASE
WHEN sumaramasadeachitat<50000 THEN 6.5
ELSE 4.5
END;

SELECT sumaramasadeachitat, dobanda
FROM credit;

SELECT nume, prenume, id_tranzactie, tip, valoare, TO_DATE(datatranzactie, 'DD/MM/YYYY') data_tranzactie
FROM tranzactii t, carduri c, clientibanca cb
WHERE t.IBAN=c.IBAN AND c.id_client=cb.id_client AND EXTRACT(YEAR FROM TO_DATE(datatranzactie, 'DD/MM/YYYY'))=2026;

SELECT TO_DATE(datatranzactie, 'DD/MM/YYYY') data_tranzactie, DECODE(EXTRACT(YEAR FROM TO_DATE(datatranzactie, 'DD/MM/YYYY')), 2026, 0.1, 0.05) procent_comision,
DECODE(EXTRACT(YEAR FROM TO_DATE(datatranzactie, 'DD/MM/YYYY')), 2026, 0.1*valoare, 0.05*valoare) comision
FROM tranzactii;

SELECT TO_DATE(datatranzactie, 'DD/MM/YYYY') data_tranzactie, 0.1*valoare
FROM tranzactii;

SELECT nume, prenume, EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY')) An_Angajare
FROM angajatibanca
WHERE SUBSTR(EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY')),1,3)='202';

SELECT nume, prenume, EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY')) An_Angajare
FROM angajatibanca
WHERE EXTRACT(YEAR FROM TO_DATE(data_angajare, 'DD/MM/YYYY')) BETWEEN 2020 AND 2026;

SELECT nume, prenume, TRUNC((SYSDATE-TO_DATE(data_angajare, 'DD/MM/YYYY'))/365) Ani_Vechime, TO_DATE(data_angajare, 'DD/MM/YYYY') data_angajare
FROM angajatibanca;

SELECT id_asigurare, NVL(despagubiriexistente, 0) despagubiri_totale
FROM asigurari;

SELECT nume, prenume, salariu
FROM angajatibanca a, departamentbanca d
WHERE a.id_departament=d.id_departament AND nume_departament LIKE 'Relatii_Cu_Clienti'
INTERSECT
SELECT nume, prenume, salariu
FROM angajatibanca a, departamentbanca d
WHERE a.id_departament=d.id_departament AND salariu<5000;

SELECT id_departament, SUM(salariu)
FROM angajatibanca
WHERE id_departament=70
GROUP BY id_departament
UNION
SELECT id_departament, SUM(salariu)
FROM angajatibanca
WHERE id_departament=80
GROUP BY id_departament;

SELECT nume, prenume, salariu
FROM angajatibanca
WHERE salariu>(SELECT AVG(salariu) FROM angajatibanca);

SELECT id_departament, COUNT(id_angajat) nr_angajati
FROM angajatibanca
WHERE salariu>=10000
GROUP BY id_departament
HAVING COUNT(id_angajat)>=2; 

SELECT id_tranzactie, tip, TO_DATE(datatranzactie, 'DD/MM/YYYY') data_tranzactie
FROM tranzactii
WHERE EXTRACT(MONTH FROM TO_DATE(datatranzactie, 'DD/MM/YYYY'))=12 AND tip LIKE 'Venit';

SELECT nume, prenume, TO_CHAR(TO_DATE(data_angajare, 'DD/MM/YYYY'), 'MM.YYYY') perioada_angajare
FROM angajatibanca;

SELECT t.IBAN, nume, prenume, SUM(valoare) total_cheltuieli
FROM tranzactii t, carduri c, clientibanca cb
WHERE t.IBAN=c.IBAN AND c.id_client=cb.id_client AND tip LIKE 'Cheltuiala'
GROUP BY t.IBAN, nume, prenume;

SELECT TO_DATE(dataexpirare, 'DD/MM/YYYY') data_expirare, nume, prenume
FROM carduri c, clientibanca cb
WHERE c.id_client=cb.id_client AND EXTRACT(YEAR FROM TO_DATE(dataexpirare, 'DD/MM/YYYY'))>=2030;

RENAME taribanca TO nichiformihai_taribanca;
RENAME sucursale TO nichiformihai_sucrusale;
RENAME departamentbanca TO nichiformihai_departamentbanca;
RENAME angajatibanca TO nichiformihai_angajatibanca;
RENAME clientibanca TO nichiformihai_clientibanca;
RENAME carduri TO nichiformihai_carduri;
RENAME tranzactii TO nichiformihai_tranzactii;
RENAME conteconomii TO nichiformihai_conteconomii;
RENAME credit TO nichiformihai_credit;
RENAME asigurari TO nichiformihai_asigurari;

