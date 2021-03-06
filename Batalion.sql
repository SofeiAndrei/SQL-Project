/*CREARE DE TABELE SI INSERARE DATE*/
/*start creare tabele*/
CREATE TABLE Regiune(
  cod_regiune number(3) primary key,
  nume_regiune varchar2(20) not null,
  inamic_principal VARCHAR2(20) check(inamic_principal in('Germania','Italia','Rom?nia+Bulgaria','Japonia',NULL)),
  unique(nume_regiune)
);
CREATE TABLE Tara(
  cod_tara number(3) primary key,
  nume_tara varchar2(30) not null,
  cod_regiune number(3) not null,
  foreign key(cod_regiune) references Regiune(cod_regiune) on delete CASCADE,
  unique(nume_tara)
);
CREATE TABLE Oras(
  cod_oras number(3) primary key,
  nume_oras varchar2(20) not null,
  zona_de_conflict varchar2(2) not null check(zona_de_conflict in('Da','Nu')),
  cod_tara number(3) not null,
  foreign key(cod_tara) references Tara(cod_tara) on delete CASCADE,
  unique(nume_oras)
);
CREATE TABLE Pluton(
  cod_pluton number(3) primary key,
  numar_pluton number(2) not null,
  cod_oras number(3) not null,
  foreign key(cod_oras) references Oras(cod_oras) on delete CASCADE,
  unique(numar_pluton)
);
CREATE TABLE Rang(
  cod_rang number(3) primary key,
  nume_rang varchar2(20) not null check(nume_rang in('soldat','soldat prima clasa','caporal','sergent','prim sergent','locotenent','capitan','maior')),
  salariu number(5) not null,
  unique(nume_rang)
);
CREATE TABLE Medalie(
  cod_medalie number(3) primary key,
  nume_medalie varchar2(30) not null,
  conditie_dobandire varchar2(15) not null check(conditie_dobandire in('curaj','eroism','ranit/decedat')),
  unique(nume_medalie)
);
CREATE TABLE Munitie(
  cod_munitie number(3) primary key,
  nume_munitie varchar2(20) not null,
  calibru varchar2(20) not null,
  numar_de_gloante number(4) not null,
  unique(nume_munitie)
);
CREATE TABLE Arma(
  cod_arma number(3) primary key,
  nume_model varchar2(20) not null,
  calibru varchar2(20) not null,
  cod_tara number(3) not null,
  foreign key(cod_tara) references Tara(cod_tara) on delete CASCADE,
  unique(nume_model)
);
CREATE TABLE Echipament(
  cod_echipament number(3) primary key,
  nume_echipament varchar2(20) not null,
  numar_grenade number(1) default (2),
  cod_arma number(3) not null,
  foreign key(cod_arma) references Arma(cod_arma) on delete CASCADE,
  unique(nume_echipament)
);
CREATE TABLE Soldat(
  cod_soldat number(3) primary key,
  nume varchar2(20) not null,
  prenume varchar2(20) not null,
  data_inrolare date not null,
  varsta number(2),
  cod_pluton number(3) not null,
  cod_superior_direct number(3),
  cod_echipament number(3) not null,
  cod_rang number(3) not null,
  foreign key(cod_pluton) references Pluton(cod_pluton) on delete CASCADE,
  foreign key(cod_superior_direct) references Soldat(cod_soldat) on delete set NULL,
  foreign key(cod_echipament) references Echipament(cod_echipament) on delete CASCADE,
  foreign key(cod_rang) references Rang(cod_rang) on delete CASCADE,
  unique(nume, prenume)
);
CREATE TABLE Utilizeaza(
  cod_arma number(3),
  cod_munitie number(3),
  primary key(cod_arma, cod_munitie),
  foreign key(cod_arma) references Arma(cod_arma) on delete CASCADE,
  foreign key(cod_munitie) references Munitie(cod_munitie) on delete CASCADE
);
CREATE TABLE A_fost_decorat_cu(
  cod_medalie number(3),
  cod_soldat number(3),
  data_acordare date not null,
  primary key(cod_medalie, cod_soldat),
  foreign key(cod_medalie) references Medalie(cod_medalie)  on delete CASCADE,
  foreign key(cod_soldat) references Soldat(cod_soldat) on delete CASCADE
);
/*stop creare tabele*/

/*start de sters*/
DROP TABLE Regiune;
DROP TABLE Tara;
DROP TABLE Oras;
DROP TABLE Pluton;
DROP TABLE Rang;
DROP TABLE Medalie;
DROP TABLE Munitie;
DROP TABLE Arma;
DROP TABLE Echipament;
DROP TABLE Soldat;
DROP TABLE Utilizeaza;
DROP TABLE A_fost_decorat_cu;
/*stop de sters*/

/*start secvente*/
create sequence incrementare_cod_regiune
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_tara
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_oras
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_pluton
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_rang
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_medalie
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_munitie
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_arma
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_echipament
  increment by 1
  start with 1
  nocycle
  nocache;
create sequence incrementare_cod_soldat
  increment by 1
  start with 1
  nocycle
  nocache;
/*start secvente*/

/*start inserari*/
insert into Regiune values(incrementare_cod_regiune.nextval,'America de Nord',NULL);
insert into Regiune values(incrementare_cod_regiune.nextval,'Africa de Nord','Italia');
insert into Regiune values(incrementare_cod_regiune.nextval,'Europa de Vest','Germania');
insert into Regiune values(incrementare_cod_regiune.nextval,'Europa de Sud','Italia');
insert into Regiune values(incrementare_cod_regiune.nextval,'Peninsula Balcanic?','Rom?nia+Bulgaria');
insert into Regiune values(incrementare_cod_regiune.nextval,'Asia','Japonia');

insert into Tara values(incrementare_cod_tara.nextval,'Statele Unite ale Americii',1);
insert into Tara values(incrementare_cod_tara.nextval,'Canada',1);
insert into Tara values(incrementare_cod_tara.nextval,'Libia',2);
insert into Tara values(incrementare_cod_tara.nextval,'Tunisia',2);
insert into Tara values(incrementare_cod_tara.nextval,'Algeria',2);
insert into Tara values(incrementare_cod_tara.nextval,'Belgia',3);
insert into Tara values(incrementare_cod_tara.nextval,'Olanda',3);
insert into Tara values(incrementare_cod_tara.nextval,'Fran?a',3);
insert into Tara values(incrementare_cod_tara.nextval,'Italia',4);
insert into Tara values(incrementare_cod_tara.nextval,'Grecia',5);
insert into Tara values(incrementare_cod_tara.nextval,'Filipine',6);
insert into Tara values(incrementare_cod_tara.nextval,'Japonia',6);
insert into Tara values(incrementare_cod_tara.nextval,'Singapore',6);
insert into Tara values(incrementare_cod_tara.nextval,'Indonezia',6);
insert into Tara values(incrementare_cod_tara.nextval,'Papua Noua Guinee',6);
insert into Tara values(incrementare_cod_tara.nextval,'Regatul Unit',3);
insert into Tara values(incrementare_cod_tara.nextval,'Germania',3);

insert into Munitie values(incrementare_cod_munitie.nextval,'.303 British','.303',300);
insert into Munitie values(incrementare_cod_munitie.nextval,'.45 ACP','.45',300);
insert into Munitie values(incrementare_cod_munitie.nextval,'.30 Carbine','.30',160);
insert into Munitie values(incrementare_cod_munitie.nextval,'.30-06 Springfield','.30',100);
insert into Munitie values(incrementare_cod_munitie.nextval,'.50 BMG','.50',5000);
insert into Munitie values(incrementare_cod_munitie.nextval,'9mm Parabellum','9mm',360);

insert into Medalie values(incrementare_cod_medalie.nextval,'Medal of Honor','curaj');
insert into Medalie values(incrementare_cod_medalie.nextval,'Distinguished Service Cross','eroism');
insert into Medalie values(incrementare_cod_medalie.nextval,'Silver Star','curaj');
insert into Medalie values(incrementare_cod_medalie.nextval,'Bronze Star','curaj');
insert into Medalie values(incrementare_cod_medalie.nextval,'Purple Heart','ranit/decedat');

insert into Rang values(incrementare_cod_rang.nextval,'soldat',50);
insert into Rang values(incrementare_cod_rang.nextval,'soldat prima clasa',55);
insert into Rang values(incrementare_cod_rang.nextval,'caporal',65);
insert into Rang values(incrementare_cod_rang.nextval,'sergent',80);
insert into Rang values(incrementare_cod_rang.nextval,'prim sergent',140);
insert into Rang values(incrementare_cod_rang.nextval,'locotenent',165);
insert into Rang values(incrementare_cod_rang.nextval,'capitan',200);
insert into Rang values(incrementare_cod_rang.nextval,'maior',250);

insert into Arma values(incrementare_cod_arma.nextval,'Colt M1911','.45',1);
insert into Arma values(incrementare_cod_arma.nextval,'Thompson M1A1','.45',1);
insert into Arma values(incrementare_cod_arma.nextval,'M3A1 "Grease Gun"','.45',1);
insert into Arma values(incrementare_cod_arma.nextval,'M1 Carbine','.30',1);
insert into Arma values(incrementare_cod_arma.nextval,'M1 Garand','.30',1);
insert into Arma values(incrementare_cod_arma.nextval,'Springfield M1903','.30',1);
insert into Arma values(incrementare_cod_arma.nextval,'M1918A2 BAR','.30',1);
insert into Arma values(incrementare_cod_arma.nextval,'M2 Browning','.50',1);
insert into Arma values(incrementare_cod_arma.nextval,'Sten','9mm',16);
insert into Arma values(incrementare_cod_arma.nextval,'Bren','.303',16);

insert into Echipament values(incrementare_cod_echipament.nextval,'Medic',0,1);
insert into Echipament values(incrementare_cod_echipament.nextval,'Lunetist',1,6);
insert into Echipament values(incrementare_cod_echipament.nextval,'Mitralior',0,8);
insert into Echipament values(incrementare_cod_echipament.nextval,'Infanterist v1',2,5);
insert into Echipament values(incrementare_cod_echipament.nextval,'Infanterist v2',2,4);
insert into Echipament values(incrementare_cod_echipament.nextval,'Infanterist v3',3,3);
insert into Echipament values(incrementare_cod_echipament.nextval,'Infanterist v4',3,7);
insert into Echipament values(incrementare_cod_echipament.nextval,'Infanterist v5',3,2);

insert into Utilizeaza values(1,2);
insert into Utilizeaza values(2,2);
insert into Utilizeaza values(3,2);
insert into Utilizeaza values(3,6);
insert into Utilizeaza values(4,3);
insert into Utilizeaza values(5,4);
insert into Utilizeaza values(6,4);
insert into Utilizeaza values(7,4);
insert into Utilizeaza values(8,5);
insert into Utilizeaza values(9,6);
insert into Utilizeaza values(10,1);

insert into Oras values(incrementare_cod_oras.nextval,'Washington','Nu',1);
insert into Oras values(incrementare_cod_oras.nextval,'New York','Nu',1);
insert into Oras values(incrementare_cod_oras.nextval,'Ottawa','Nu',2);
insert into Oras values(incrementare_cod_oras.nextval,'Quebec','Nu',2);
insert into Oras values(incrementare_cod_oras.nextval,'Tripoli','Da',3);
insert into Oras values(incrementare_cod_oras.nextval,'Tunis','Da',4);
insert into Oras values(incrementare_cod_oras.nextval,'Algiers','Da',5);
insert into Oras values(incrementare_cod_oras.nextval,'Bruxel','Da',6);
insert into Oras values(incrementare_cod_oras.nextval,'Liege','Da',6);
insert into Oras values(incrementare_cod_oras.nextval,'Amsterdam','Da',7);
insert into Oras values(incrementare_cod_oras.nextval,'Eindhoven','Da',7);
insert into Oras values(incrementare_cod_oras.nextval,'Paris','Nu',8);
insert into Oras values(incrementare_cod_oras.nextval,'Caen','Da',8);
insert into Oras values(incrementare_cod_oras.nextval,'Napoli','Da',9);
insert into Oras values(incrementare_cod_oras.nextval,'Roma','Da',9);
insert into Oras values(incrementare_cod_oras.nextval,'Salonic','Da',10);
insert into Oras values(incrementare_cod_oras.nextval,'Manila','Da',11);
insert into Oras values(incrementare_cod_oras.nextval,'Okinawa','Da',12);
insert into Oras values(incrementare_cod_oras.nextval,'Singapore','Da',13);
insert into Oras values(incrementare_cod_oras.nextval,'Jakarta','Da',14);
insert into Oras values(incrementare_cod_oras.nextval,'Port Moresby','Nu',15);
insert into Oras values(incrementare_cod_oras.nextval,'Londra','Nu',16);
insert into Oras values(incrementare_cod_oras.nextval,'Cologne','Da',17);
insert into Oras values(incrementare_cod_oras.nextval,'Frankfurt','Da',17);

insert into Pluton values(incrementare_cod_pluton.nextval,11,6);
insert into Pluton values(incrementare_cod_pluton.nextval,12,11);
insert into Pluton values(incrementare_cod_pluton.nextval,13,16);
insert into Pluton values(incrementare_cod_pluton.nextval,21,14);
insert into Pluton values(incrementare_cod_pluton.nextval,22,24);
insert into Pluton values(incrementare_cod_pluton.nextval,23,18);

insert into Soldat values(incrementare_cod_soldat.nextval,'Sofei','Andrei-Adrian',to_date('16-04-1920','dd-mm-yyyy'),51,1,NULL,8,8);
insert into Soldat values(incrementare_cod_soldat.nextval,'Sherman','Fred',to_date('08-05-1927','dd-mm-yyyy'),47,2,1,5,7);
insert into Soldat values(incrementare_cod_soldat.nextval,'Howells','Benjamin',to_date('28-10-1929','dd-mm-yyyy'),37,3,1,6,7);
insert into Soldat values(incrementare_cod_soldat.nextval,'Warner','Jacob',to_date('01-01-1933','dd-mm-yyyy'),41,4,1,7,7);
insert into Soldat values(incrementare_cod_soldat.nextval,'King','Douglas',to_date('05-01-1933','dd-mm-yyyy'),39,5,1,8,7);
insert into Soldat values(incrementare_cod_soldat.nextval,'Bright','Alex',to_date('01-06-1934','dd-mm-yyyy'),44,6,1,5,7);
insert into Soldat values(incrementare_cod_soldat.nextval,'Walton','Simon',to_date('29-04-1930','dd-mm-yyyy'),41,1,1,8,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Warren','Josh',to_date('29-09-1930','dd-mm-yyyy'),36,2,2,7,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Flynn','Scott',to_date('10-07-1931','dd-mm-yyyy'),34,3,3,8,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Torres','Marco',to_date('22-07-1932','dd-mm-yyyy'),33,4,4,5,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Whittle','Benjamin',to_date('05-06-1933','dd-mm-yyyy'),29,5,5,4,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Ferguson','Patrick',to_date('09-11-1933','dd-mm-yyyy'),27,6,6,5,6);
insert into Soldat values(incrementare_cod_soldat.nextval,'Barnes','Tyler',to_date('22-02-1934','dd-mm-yyyy'),28,1,7,7,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Wilkins','Jacob',to_date('15-12-1935','dd-mm-yyyy'),31,2,8,8,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Watson','Scott',to_date('11-04-1937','dd-mm-yyyy'),30,3,9,4,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Gordon','Josh',to_date('06-05-1937','dd-mm-yyyy'),28,4,10,5,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Banks','Robbie',to_date('21-09-1938','dd-mm-yyyy'),29,5,11,5,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Caldwell','Josh',to_date('27-04-1939','dd-mm-yyyy'),27,6,12,4,5);
insert into Soldat values(incrementare_cod_soldat.nextval,'Stuart','Mason',to_date('10-07-1935','dd-mm-yyyy'),27,1,13,4,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Smith','Tobias',to_date('25-07-1937','dd-mm-yyyy'),26,1,13,5,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Ferguson','Jeremy',to_date('01-09-1938','dd-mm-yyyy'),28,2,14,7,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hubbard','Tyler',to_date('09-03-1939','dd-mm-yyyy'),31,2,14,8,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Porter','Scott',to_date('30-05-1939','dd-mm-yyyy'),23,3,15,6,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Woods','Glenn',to_date('28-04-1941','dd-mm-yyyy'),24,3,15,5,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Morgan','Gerald',to_date('20-10-1941','dd-mm-yyyy'),23,4,16,4,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Lawson','David',to_date('08-09-1942','dd-mm-yyyy'),22,5,17,4,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Wagner','Tony',to_date('25-11-1942','dd-mm-yyyy'),26,6,18,4,4);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hardy','Fred',to_date('09-02-1938','dd-mm-yyyy'),23,1,1,1,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Peterson','Jacob',to_date('31-05-1938','dd-mm-yyyy'),21,1,1,2,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Mueller','Mason',to_date('05-06-1938','dd-mm-yyyy'),20,1,19,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Carter','Scott',to_date('17-06-1938','dd-mm-yyyy'),24,1,20,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Campbell','Marco',to_date('24-06-1938','dd-mm-yyyy'),22,2,21,7,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Vaughn','Douglas',to_date('21-10-1938','dd-mm-yyyy'),23,2,21,5,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Wolf','Lawrence',to_date('19-07-1939','dd-mm-yyyy'),21,2,22,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Walters','Tobias',to_date('11-09-1939','dd-mm-yyyy'),22,3,23,5,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Bush','Patrick',to_date('23-05-1940','dd-mm-yyyy'),24,3,23,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Graves','Glenn',to_date('27-10-1940','dd-mm-yyyy'),26,3,24,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Perkins','Zack',to_date('13-02-1941','dd-mm-yyyy'),24,4,25,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Smith','Jeremy',to_date('08-08-1941','dd-mm-yyyy'),27,4,25,7,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hardy','Robbie',to_date('25-06-1942','dd-mm-yyyy'),25,5,26,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Chapman','Jacob',to_date('05-12-1942','dd-mm-yyyy'),20,5,26,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Daniels','Melvin',to_date('19-09-1941','dd-mm-yyyy'),23,6,27,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Reyes','Gerald',to_date('06-05-1942','dd-mm-yyyy'),26,6,27,4,3);
insert into Soldat values(incrementare_cod_soldat.nextval,'Campbell','Tony',to_date('24-10-1942','dd-mm-yyyy'),22,1,1,3,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Thompson','Aron',to_date('27-12-1942','dd-mm-yyyy'),19,2,2,1,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Fernandez','Lawrence',to_date('26-11-1940','dd-mm-yyyy'),21,3,3,1,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Mcdonald','Mason',to_date('07-09-1939','dd-mm-yyyy'),23,1,30,7,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Burns','David',to_date('03-06-1941','dd-mm-yyyy'),20,2,2,3,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Morgan','Zack',to_date('07-09-1940','dd-mm-yyyy'),21,3,3,3,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Woods','Isaac',to_date('27-12-1942','dd-mm-yyyy'),18,4,38,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Peterson','Fred',to_date('08-01-1939','dd-mm-yyyy'),24,1,30,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Chapman','Scott',to_date('18-03-1940','dd-mm-yyyy'),22,1,30,6,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Stevenson','Douglas',to_date('11-03-1941','dd-mm-yyyy'),23,1,31,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Owens','Glenn',to_date('27-09-1942','dd-mm-yyyy'),21,1,31,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hart','Scott',to_date('25-12-1942','dd-mm-yyyy'),20,2,32,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hardy','David',to_date('11-03-1942','dd-mm-yyyy'),18,2,32,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Norris','Simon',to_date('15-10-1942','dd-mm-yyyy'),19,2,33,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Barker','Tomas',to_date('27-12-1939','dd-mm-yyyy'),24,2,34,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Peterson','Melvin',to_date('04-09-1940','dd-mm-yyyy'),25,3,35,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Castro','Josh',to_date('28-10-1942','dd-mm-yyyy'),23,3,35,6,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Higgins','Robbie',to_date('27-12-1942','dd-mm-yyyy'),20,3,36,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Klein','Mason',to_date('15-10-1941','dd-mm-yyyy'),21,3,37,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Cunningham','Jon',to_date('07-09-1940','dd-mm-yyyy'),22,4,38,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Smith','Isaac',to_date('04-05-1941','dd-mm-yyyy'),21,4,38,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Hansen','Aron',to_date('11-03-1943','dd-mm-yyyy'),19,4,39,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Johnson','Zack',to_date('15-10-1941','dd-mm-yyyy'),19,4,39,6,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Ramirez','Marco',to_date('28-10-1942','dd-mm-yyyy'),18,5,40,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Stevenson','Scott',to_date('04-05-1941','dd-mm-yyyy'),20,5,40,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Castro','Tony',to_date('04-09-1940','dd-mm-yyyy'),23,5,41,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Higgins','Douglas',to_date('28-01-1939','dd-mm-yyyy'),26,5,41,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Matthews','Gerald',to_date('07-06-1942','dd-mm-yyyy'),24,6,42,5,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Houston','Alex',to_date('27-12-1939','dd-mm-yyyy'),26,6,42,6,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Frost','Zack',to_date('04-05-1940','dd-mm-yyyy'),25,6,43,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Montgomery','David',to_date('07-06-1942','dd-mm-yyyy'),21,6,43,4,2);
insert into Soldat values(incrementare_cod_soldat.nextval,'Wright','Kristian',to_date('07-09-1939','dd-mm-yyyy'),21,1,30,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Blithe','Oliver',to_date('04-09-1940','dd-mm-yyyy'),23,1,30,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Klein','Jon',to_date('11-03-1941','dd-mm-yyyy'),20,1,30,3,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Cunningham','Stefan',to_date('07-06-1942','dd-mm-yyyy'),21,1,31,5,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Johnson','Lawrence',to_date('04-05-1940','dd-mm-yyyy'),22,1,31,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Morgan','Tomas',to_date('07-06-1942','dd-mm-yyyy'),22,2,32,6,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Owens','Jon',to_date('27-09-1942','dd-mm-yyyy'),21,2,32,5,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Powers','Robbie',to_date('28-01-1942','dd-mm-yyyy'),19,2,33,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Matthews','Zack',to_date('28-10-1942','dd-mm-yyyy'),20,2,34,6,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Wright','Tony',to_date('15-10-1941','dd-mm-yyyy'),24,3,35,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Todd','Mason',to_date('04-05-1940','dd-mm-yyyy'),19,3,36,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Turner','Alex',to_date('28-10-1942','dd-mm-yyyy'),20,3,36,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Ryan','Stefan',to_date('07-06-1942','dd-mm-yyyy'),21,3,37,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Daniel','Charles',to_date('27-09-1942','dd-mm-yyyy'),21,4,38,6,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Knight','Alan',to_date('28-10-1942','dd-mm-yyyy'),21,4,38,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'White','Kristian',to_date('28-01-1939','dd-mm-yyyy'),23,4,39,5,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Parker','Aron',to_date('28-10-1942','dd-mm-yyyy'),22,5,40,6,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Montgomery','Oliver',to_date('28-10-1942','dd-mm-yyyy'),23,5,40,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Johnson','Tomas',to_date('04-05-1940','dd-mm-yyyy'),19,5,41,6,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Owens','David',to_date('07-06-1942','dd-mm-yyyy'),18,6,42,5,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Woods','Mason',to_date('15-10-1941','dd-mm-yyyy'),2,6,42,4,1);
insert into Soldat values(incrementare_cod_soldat.nextval,'Ramirez','Tony',to_date('27-09-1942','dd-mm-yyyy'),20,6,43,4,1);

insert into A_fost_decorat_cu values(1,1,to_date('09-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(1,14,to_date('24-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(1,33,to_date('12-05-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(2,1,to_date('08-02-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(2,26,to_date('28-09-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(2,7,to_date('12-05-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(2,5,to_date('30-11-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,16,to_date('07-01-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,32,to_date('14-07-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,47,to_date('08-02-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,89,to_date('09-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,54,to_date('15-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(3,23,to_date('08-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,46,to_date('24-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,37,to_date('28-09-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,68,to_date('30-11-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,39,to_date('17-12-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,62,to_date('19-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,19,to_date('08-02-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,6,to_date('07-01-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,86,to_date('27-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,71,to_date('27-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(4,44,to_date('09-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,13,to_date('14-07-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,87,to_date('15-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,52,to_date('30-11-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,74,to_date('08-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,42,to_date('01-05-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,18,to_date('19-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,19,to_date('15-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,26,to_date('28-09-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,39,to_date('07-01-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,65,to_date('12-05-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,48,to_date('17-12-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,95,to_date('27-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,57,to_date('08-08-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,64,to_date('08-02-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,35,to_date('17-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,3,to_date('17-03-1945','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,79,to_date('09-06-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,60,to_date('14-07-1944','dd-mm-yyyy'));
insert into A_fost_decorat_cu values(5,20,to_date('19-03-1945','dd-mm-yyyy'));

/*stop inserari*/

/*start de sters*/
drop sequence incrementare_cod_regiune;
drop sequence incrementare_cod_tara;
drop sequence incrementare_cod_oras;
drop sequence incrementare_cod_pluton;
drop sequence incrementare_cod_rang;
drop sequence incrementare_cod_medalie;
drop sequence incrementare_cod_munitie;
drop sequence incrementare_cod_arma;
drop sequence incrementare_cod_echipament;
drop sequence incrementare_cod_soldat;
/*stop de sters*/

/*start de sters*/
select * from Regiune;
select * from Tara;
select * from Oras;
select * from Pluton;
select * from Rang;
select * from Medalie;
select * from Munitie;
select * from Arma;
select * from Echipament;
select * from Soldat;
select * from Utilizeaza;
select * from A_fost_decorat_cu;
/*stop de sters*/

/*start de sters*/
delete from Regiune;
delete from Tara;
delete from Rang;
delete from Oras;
delete from Pluton;
delete from Soldat;
delete from A_fost_decorat_cu;
/*stop de sters*/


----------------CERERI------------------
--11.
--1.S? se afi?eze, pentru solda?ii sta?iona?i ?n regiunea Europa de Vest ?i care au litera 'o' ?n nume sau ?n prenume, id-ul soldatului, numele, prenumele, 
--data primului salariu(ultima zi din luna ?n care s-a ?nrolat),c?te zile a fost activ ?n for?ele armate p?n? la terminarea r?zboiului(diferen?a dintre ziua sf?r?itului r?zboiului 02.09.1945 ?i data ?nrol?rii)
--?i dac? este ofi?er(maior,capitan,locotenent),subofiter(prim sergent, sergent) sau soldat (caporal, soldat prima clasa, soldat).
--S? se ordoneze cresc?tor valorile dup? lungimea numelui ?i ?n caz de egalitate dup? lungimea prenumelui.

select s.cod_soldat,s.nume,s.prenume,
last_day(s.data_inrolare) as primul_salariu,
to_date('02-09-1945','dd-mm-yyyy')-s.data_inrolare as zile_la_activ,
decode(rng.nume_rang, 'maior','ofiter','capitan','ofiter','locotenent','ofiter',
'prim sergent','subofiter','sergent','subofiter','soldat') as rang
from soldat s,
pluton p,
oras o,
tara t,
regiune r,
rang rng
where s.cod_pluton = p.cod_pluton
and p.cod_oras = o.cod_oras
and o.cod_tara = t.cod_tara
and t.cod_regiune = r.cod_regiune
and r.nume_regiune = 'Europa de Vest'
and s.cod_rang = rng.cod_rang
and (instr(s.nume, 'o')!=0 or instr(s.prenume,'o')!=0)
order by length(nume), length(prenume);
--25 de rezultate


--2.S? se afi?eze numele, prenumele,arma, tipul de arm?(arm? automat? (cod arma=2,3,7,8,9,10), arm? semi-automat?(cod arma=1,4,5) sau pu?c? cu repeti?ie(cod arma=6) ?i salariul,
--pentru solda?ii care au ca superior direct un soldat sta?ionat ?ntr-o regiune ?n care inamicul principal este Italia ?i care au salariul mai mic dec?t media salariilor rangurilor.

select s.cod_soldat,s.nume, s.prenume,
a.nume_model,
case
when a.cod_arma=2 or a.cod_arma=3 or a.cod_arma=7 or a.cod_arma=8 or a.cod_arma=9 or a.cod_arma=10 then 'arma automata'
when a.cod_arma=1 or a.cod_arma=4 or a.cod_arma=5 then 'arma semi-automata'
else 'pusca cu repetitie'
end as tip_arma
from soldat s,
echipament e,
arma a,
rang rng
where s.cod_superior_direct in(select s2.cod_soldat
                               from soldat s2,
                               pluton p,
                               oras o,
                               tara t,
                               regiune r
                               where s2.cod_pluton=p.cod_pluton
                               and p.cod_oras=o.cod_oras
                               and o.cod_tara=t.cod_tara
                               and t.cod_regiune=r.cod_regiune
                               and r.inamic_principal='Italia')
and s.cod_rang = rng.cod_rang
and s.cod_echipament = e.cod_echipament
and e.cod_arma = a.cod_arma
and rng.salariu < (select avg(salariu)
                   from rang);
--28 de rezultate


--3.S? se afi?eze codul si num?rul de subordona?i direc?i ai solda?ilor care au cel pu?in 2 subordona?i direc?i.
--S? se ordoneze valorile descresc?tor dup? num?rul de subordona?i direc?i ?i ?n caz de egalitate cresc?tor dup? codul soldatului.
select s1.cod_superior_direct as soldat,
count(s1.cod_soldat) as numar_subordonati_directi
from soldat s1
group by s1.cod_superior_direct
having count(s1.cod_soldat)>2
order by 2 desc, 1;
--14 rezultate


--4.S? se afi?eze codul, numele, prenumele, codul superiorului direct(dac? nu au se va pune valoarea 0),
--num?rul plutonului ?i salariul pentru solda?ii care au un salariu mai mare dec?t media salariilor solda?ilor din plutonul lor.
--S? se ordoneze cresc?tor dup? codul plutonului.
select s.cod_soldat, s.nume,s.prenume,
NVL(s.cod_superior_direct,0) as cod_superior_direct, 
p.cod_pluton, rng.salariu
from soldat s,
pluton p,
rang rng
where s.cod_pluton=p.cod_pluton
and s.cod_rang=rng.cod_rang
and rng.salariu > (select avg(rng2.salariu)
                   from soldat s2,
                   rang rng2
                   where s2.cod_pluton=s.cod_pluton
                   and s2.cod_rang=rng2.cod_rang)
order by 5;
--24 de rezultate
--Mediile salariale pe fiecare pluton:
--1->77.75
--2->77.22
--3->77.22
--4->81.43
--5->83.46
--6->83.46


--5.S? se afi?eze numele, prenumele ?i codul plutonului pentru solda?ii care au ca ?i arm? M1 Garand ?i fac parte din plutonul cu codul 1.
with temp(nume_soldat_cu_garand, prenume_soldat_cu_garand, cod_pluton_soldat_cu_garand) as
(select st.nume,st.prenume,st.cod_pluton
 from soldat st,
 echipament et,
 arma at
 where st.cod_echipament=et.cod_echipament and et.cod_arma=at.cod_arma and at.nume_model='M1 Garand')
select *
from temp
where cod_pluton_soldat_cu_garand=1;
--9 rezultate


--12.
--1.Trece?i ora?ele din Singapore, Indonezia ?i Belgia ca fiind ?ntr-o zon? f?r? conflict.
Update Oras
set zona_de_conflict='Nu'
where nume_oras in (select o.nume_oras
                     from oras o,
                     tara t
                     where o.cod_tara = t.cod_tara
                     and (t.nume_tara='Singapore'
                     or t.nume_tara='Indonezia'
                     or t.nume_tara='Belgia'));
ROLLBACK;
--2.S-a decis m?rirea salariilor ofi?erilor(solda?i cu codul de rang >=6) cu 20% datorit? serviciilor excep?ionale. Efectua?i aceast? actualizare.
Update Rang
set salariu=salariu*1.2
where cod_rang in (select cod_rang
                   from rang
                   where nume_rang='maior' or nume_rang='capitan' or nume_rang='locotenent');
--3.Sterge?i to?i solda?ii care au rangul de 'soldat prima clasa'.
Delete from Soldat
where cod_soldat in (select s.cod_soldat
                     from soldat s,
                     rang rng
                     where s.cod_rang=rng.cod_rang
                     and rng.nume_rang='soldat prima clasa');
ROLLBACK;
select * from soldat;