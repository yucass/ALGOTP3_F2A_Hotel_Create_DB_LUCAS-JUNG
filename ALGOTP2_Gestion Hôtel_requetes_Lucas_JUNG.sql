--Nombre de clients
select count(CLI_ID)
from T_CLIENT



--Les clients triés sur le titre et le nom

select *
from T_CLIENT
ORDER BY TIT_CODE, CLI_NOM;

--Les clients triés sur le libellé du titre et le nom
select *
from T_CLIENT, T_TITRE
where T_TITRE.TIT_CODE = T_CLIENT.TIT_CODE
ORDER BY T_TITRE.TIT_LIBELLE, T_CLIENT.CLI_NOM;

--Les clients commençant par 'B'
select *
from T_CLIENT
where CLI_NOM like 'B%';

--Les clients homonymes

--Nombre de titres différents
select distinct count(TIT_CODE) as Nombre_de_Titre
from T_TITRE



--Nombre d'enseignes
select count(CLI_ENSEIGNE) as Nombre_d_Enseigne
from T_CLIENT

--Les clients qui représentent une enseigne 
select CLI_NOM, CLI_ENSEIGNE 
from T_CLIENT
where CLI_ENSEIGNE is not null;

--Les clients qui représentent une enseigne de transports
select CLI_NOM, CLI_ENSEIGNE 
from T_CLIENT
where CLI_ENSEIGNE is not null 
AND lower(CLI_ENSEIGNE) like '%transports%';

--Nombre d'hommes,Nombres de femmes, de demoiselles, Nombres de sociétés
select count(CLI_ID), T_CLIENT.TIT_CODE,
from T_TITRE, T_CLIENT
where T_CLIENT.TIT_CODE = T_TITRE.TIT_CODE
Group by T_CLIENT.TIT_CODE

--Nombre d''emails
select count(EML_ID) as Nombre_EMAIL
from T_EMAIL;

--Client sans email 
select * 
from T_CLIENT
where CLI_ID not in
(select T_CLIENT.CLI_ID 
    from T_CLIENT, T_EMAIL 
    where T_CLIENT.CLI_ID = T_EMAIL.CLI_ID)
group by T_CLIENT.CLI_ID

--Clients sans téléphone 

--Les phones des clients
select CLI_NOM as Nom, TEL_NUMERO as Numero_de_tel
from T_CLIENT, T_TELEPHONE
where T_CLIENT.CLI_ID = T_TELEPHONE.CLI_ID


--Ventilation des phones par catégorie
select count(TEL_ID), TEL_LOCALISATION
from T_TELEPHONE
Group by TEL_LOCALISATION

--Les clients ayant plusieurs téléphones

--Clients sans adresse:
select *
from T_CLIENT
where CLI_ID not in 
(select T_ADRESSE.CLI_ID
from T_CLIENT, T_ADRESSE
where T_CLIENT.CLI_ID = T_ADRESSE.CLI_ID);

--Clients sans adresse mais au moins avec mail ou phone 
select *
from T_CLIENT, T_EMAIL, T_TELEPHONE
where T_CLIENT.CLI_ID not in 
(select T_ADRESSE.CLI_ID
from T_CLIENT, T_ADRESSE
where T_CLIENT.CLI_ID = T_ADRESSE.CLI_ID)
 AND T_TELEPHONE.CLI_ID = T_CLIENT.CLI_ID
 AND T_EMAIl.CLI_ID = T_CLIENT.CLI_ID 
AND (T_EMAIl.CLI_ID 
              OR T_TELEPHONE.CLI_ID) is not null;
			  
--Dernier tarif renseigné
select max(TRF_DATE_DEBUT), TRF_TAUX_TAXES, TRF_PETIT_DEJEUNE
from T_TARIF
 
 
--Tarif débutant le plus tôt 
select min(TRF_DATE_DEBUT), TRF_TAUX_TAXES, TRF_PETIT_DEJEUNE
from T_TARIF
 
--Différentes Années des tarifs

--Nombre de chambres de l'hotel 
select count(CHB_ID)
from T_CHAMBRE

--Nombre de chambres par étage
select count(CHB_ID) as Nombre_de_chambre, CHB_ETAGE
from T_CHAMBRE
group by CHB_ETAGE

--Chambres sans telephone
select count(CHB_ID) as Nombre_de_chambre, CHB_ETAGE
from T_CHAMBRE
where CHB_POSTE_TEL is null;

--Existence d'une chambre n°13 ?
select count(CHB_ID) as Nombre_de_chambre, CHB_ETAGE
from T_CHAMBRE
where CHB_ID = '13';

--Chambres avec sdb
select count(CHB_ID) as Nombre_de_chambre_SDB
from T_CHAMBRE
where CHB_BAIN = '1'
--Chambres avec douche
select count(CHB_ID) as Nombre_de_chambre_DOUCHE
from T_CHAMBRE
where CHB_DOUCHE= '1'

--Chambres avec WC
select count(CHB_ID) as Nombre_de_chambre_WC
from T_CHAMBRE
where CHB_WC= '1'

--Chambres sans WC séparés
select count(CHB_ID) as Nombre_de_chambre_WC
from T_CHAMBRE
where CHB_WC= '0'

--Quels sont les étages qui ont des chambres sans WC séparés ?
select count(CHB_ID) as Nombre_de_chambre_WC, CHB_ETAGE
from T_CHAMBRE
where CHB_WC= '0'
GROUP BY CHB_ETAGE

--Nombre d'équipements sanitaires par chambre trié par ce nombre d'équipement croissant


--Chambres les plus équipées et leur capacité

--Repartition des chambres en fonction du nombre d'équipements et de leur capacité

--Nombre de clients ayant utilisé une chambre
select TJ_CHB_PLN_CLI.CLI_ID
from T_CLIENT, TJ_CHB_PLN_CLI
where TJ_CHB_PLN_CLI.CLI_ID = T_CLIENT.CLI_ID
AND CHB_PLN_CLI_OCCUPE = 1
Group by T_CLIENT.CLI_ID;

--Clients n'ayant jamais utilisé une chambre (sans facture)
select TJ_CHB_PLN_CLI.CLI_ID as ID, T_CLIENT.CLI_NOM as NOM, T_CLIENT.CLI_PRENOM as Prenom
from T_CLIENT, TJ_CHB_PLN_CLI, T_FACTURE
where TJ_CHB_PLN_CLI.CLI_ID = T_CLIENT.CLI_ID
AND T_CLIENT.CLI_ID = T_FACTURE.CLI_ID
AND CHB_PLN_CLI_OCCUPE = 1
Group by T_CLIENT.CLI_ID

--Nom et prénom des clients qui ont une facture
select T_CLIENT.CLI_NOM as Nom, T_CLIENT.CLI_PRENOM as Prenom
from T_FACTURE, T_CLIENT
where T_FACTURE.CLI_ID = T_CLIENT.CLI_ID
Group by CLI_NOM;

--Nom, prénom, telephone des clients qui ont une facture
select T_CLIENT.CLI_NOM as Nom, T_CLIENT.CLI_PRENOM as Prenom, T_TELEPHONE.TEL_NUMERO as Numero_de_tel
from T_FACTURE, T_CLIENT, T_TELEPHONE
where T_FACTURE.CLI_ID = T_CLIENT.CLI_ID
AND T_CLIENT.CLI_ID = T_TELEPHONE.CLI_ID
Group by T_CLIENT.CLI_NOM

--Attention si email car pas obligatoire : jointure externe

--Adresse où envoyer factures aux clients
select T_FACTURE.CLI_ID, ADR_Ligne1, ADR_Ligne2, ADR_Ligne3, ADR_CP as Code_Postal, ADR_VILLE as Ville
from T_ADRESSE, T_FACTURE
where T_ADRESSE.CLI_ID = T_FACTURE.CLI_ID
Group By T_FACTURE.CLI_ID

--Répartition des factures par mode de paiement (libellé)
select count(FAC_ID) as Nombre_Paiement, PMT_LIBELLE as Mode_paiement_libelle
from T_FACTURE, T_MODE_PAIEMENT
where T_FACTURE.PMT_CODE =  T_MODE_PAIEMENT.PMT_CODE
GROUP BY  T_MODE_PAIEMENT.PMT_CODE

--Répartition des factures par mode de paiement 
select count(FAC_ID) as Nombre_Paiement, T_MODE_PAIEMENT.PMT_CODE as Mode_paiement
from T_FACTURE, T_MODE_PAIEMENT
where T_FACTURE.PMT_CODE =  T_MODE_PAIEMENT.PMT_CODE
GROUP BY  T_MODE_PAIEMENT.PMT_CODE

--Différence entre ces 2 requêtes ? 

--Factures sans mode de paiement 
select count(FAC_ID) as Nombre_Paiement, T_MODE_PAIEMENT.PMT_CODE as Mode_paiement
from T_FACTURE, T_MODE_PAIEMENT
where T_MODE_PAIEMENT.PMT_CODE not in (select T_FACTURE.PMT_CODE from T_FACTURE, T_MODE_PAIEMENT where T_FACTURE.PMT_CODE =  T_MODE_PAIEMENT.PMT_CODE)

--Repartition des factures par Années

--Repartition des clients par ville
select count(T_CLIENT.CLI_ID) as total_de_client, ADR_VILLE as ville
from T_CLIENT, T_ADRESSE
where T_CLIENT.cli_id = T_ADRESSE.CLI_ID
Group by ADR_VILLE
ORDER BY count(T_CLIENT.CLI_ID) desc
--Montant TTC de chaque ligne de facture (avec remises)

--Classement du montant total TTC (avec remises) des factures

--Tarif moyen des chambres par années croissantes

--Tarif moyen des chambres par étage et années croissantes

--Chambre la plus cher et en quelle année

--Chambre la plus cher par année 

--Clasement décroissant des réservation des chambres 

--Classement décroissant des meilleurs clients par nombre de réservations

--Classement des meilleurs clients par le montant total des factures

--Factures payées le jour de leur édition

--Facture dates et Délai entre date de paiement et date d'édition de la facture