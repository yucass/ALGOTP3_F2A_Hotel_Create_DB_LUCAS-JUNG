/*PRAGMA Foreign_Keys = ON;*/


create schema Gestion_Hotel;
use Gestion_Hotel;

create table T_CHAMBRE(

	CHB_ID integer primary key autoincrement unique not null,
	CHB_NUMERO smallint not null,
	CHB_ETAGE char (3) not null,
	CHB_BAIN tinyint (1) not null,
	CHB_DOUCHE  tinyint (1) not null,
	CHB_WC tinyint (1) not null,
	CHB_COUCHAGE smallint not null,
	CHB_POSTE_TEL char (3) null

 );




create table T_PLANNING (

	PLN_JOUR date not null,

primary key (PLN_JOUR));



create table T_TITRE (

	TIT_CODE char (8) not null,
	TIT_LIBELLE varchar (32) not null,

primary key (TIT_CODE));





create table T_TYPE (

	TYP_COD char (8) not null,
	TYP_LIBELLE varchar (32) not null,

primary key (TYP_COD));





create table T_MODE_PAIEMENT (

	PMT_CODE char (8) not null,
	PMT_LIBELLE varchar (64) not null,

Primary key (PMT_CODE));





create table T_CLIENT (

	CLI_ID  integer primary key autoincrement unique not null,
	CLI_NOM char (32) not null,
	CLI_PRNOM varchar (25) not null,
	CLI_ENSEIGNE varchar (100) null,
	TIT_CODE char (8) not null,


foreign key (TIT_CODE) references T_TITRE
	on delete no action on update cascade);
	
	
	
	
	
create table T_ADRESSE (

	ADR_ID  integer primary key autoincrement unique not null,
	ADR_Ligne1 varchar (32) not null,
	ADR_Ligne2 varchar (32),
	ADR_Ligne3 varchar (32),
	ADR_Ligne4 varchar (32),
	ADR_CP char (5) not null,
	ADR_VILLE char (32) not null,
	CLI_ID int (255) not null,


foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);
	
	
	
	
	
	
create table TJ_CHB_PLN_CLI (

	CHB_PLN_CLI_NB_PERS smallint not null,
	CHB_PLN_CLI_RESERVE tinyint (1) not null,
	CHB_PLN_CLI_OCCUPE tinyint (1) not null,
	CLI_ID int (255) not null,
	CHB_ID int (100) not null,
	PLN_JOUR date not null,

primary key (CHB_ID, PLN_JOUR),
foreign key (PLN_JOUR) references T_PLANNING
	on delete no action on update cascade,
foreign key (CHB_ID) references T_CHAMBRE
	on delete no action on update cascade,
foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);

	
	
	
	
	
create table T_EMAIL (

	EML_ID integer primary key autoincrement unique not null,
	EML_ADRESSE varchar (100) not null,
	EML_LOCALISATION varchar (64),
	CLI_ID int (255) not null,


foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);

	
	
	
	
	
	
create table T_TELEPHONE (

	TEL_ID integer primary key autoincrement unique not null,
	TEL_NUMERO char (20) not null,
	TEL_LOCALISATION varchar (64),
	TYP_COD char (8) not null,
	CLI_ID int(255) not null,

foreign key (TYP_COD) references T_TYPE
	on delete no action on update cascade,
foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);

	
	
	
	
	
create table T_FACTURE (

	FAC_ID integer primary key autoincrement unique not null,
	FAC_DATE date not null,
	CLI_ID int (255) not null,


foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);

	
	
	
	
	
create table T_TARIF (

	TRF_DATE_DEBUT date not null,
	TRF_TAUX_TAXES real not null,
	TRF_PETIT_DEJEUNE money not null,
	CLI_ID int (255) not null,

primary key (TRF_DATE_DEBUT),
foreign key (CLI_ID) references T_CLIENT
	on delete no action on update cascade);

	
	
	
	
	
create table TJ_TRF_CHB (

	TRF_CHB_PRIX money not null,
	CHB_ID int (100) not null,
	TRF_DATE_DEBUT date not null,

primary key (CHB_ID, TRF_DATE_DEBUT),
foreign key (CHB_ID) references T_CHAMBRE
	on delete no action on update cascade,
foreign key (TRF_DATE_DEBUT) references T_TARIF
	on delete no action on update cascade);

	
	
	
	
create table T_LIGNE_FACTURE (

	LIF_ID int (200) not null,
	LIF_QTE real (100) not null,
	LIF_REMISE_POURCENT real (10),
	LIF_REMISE_MONTANT money ,
	LIF_MONTANT money not null,
	LIF_TAUX_TVA real (10) not null,
	FAC_ID int (255) not null,

primary key (LIF_ID),
foreign key (FAC_ID) references T_FACTURE
	on delete no action on update cascade);


	
	
	
	
create table TJ_FAC_PMT(

	FAC_PMT_DATE date,
	PMT_CODE char (8) not null,
	FAC_ID int (255) not null,

primary key (FAC_ID, PMT_CODE),
foreign key (FAC_ID) references T_FACTURE
	on delete no action on update cascade);
foreign key (PMT_CODE) references T_MODE_PAIEMENT
	on delete no action on update cascade);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	