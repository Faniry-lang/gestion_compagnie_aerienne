-- DATA.SQL : jeu de donnees de test pour gestion_compagnie_aerienne
-- Contenu ecrit en ASCII (pas d'accents) et assez volumineux pour les tests

-- 1) Aeroports
INSERT INTO aeroport (code_iata, nom, ville, pays) VALUES
('CDG','Charles de Gaulle','Paris','France'),
('ORY','Orly','Paris','France'),
('JFK','John F Kennedy','New York','USA'),
('LAX','Los Angeles Intl','Los Angeles','USA'),
('LHR','London Heathrow','London','UK'),
('MAN','Manchester','Manchester','UK'),
('DXB','Dubai Intl','Dubai','UAE'),
('HND','Haneda','Tokyo','Japan'),
('NRT','Narita','Tokyo','Japan'),
('GRU','Guarulhos','Sao Paulo','Brazil');

-- 2) Types d'avion
INSERT INTO type_avion (libelle) VALUES
('Long courrier'),('Moyen courrier'),('Court courrier');

-- 3) Statuts et classes (au cas ou non presentes) - idempotent via ignore
-- (schema.sql contient deja certains inserts); ces inserts tolerent les duplicates via ON CONFLICT

-- 4) Flotte - avions
INSERT INTO avion (id_type_avion, modele, nbr_siege, constructeur, date_mise_service) VALUES
((SELECT id FROM type_avion WHERE libelle='Long courrier'),'A380-800',500,'Airbus','2015-05-12'),
((SELECT id FROM type_avion WHERE libelle='Long courrier'),'B747-8',400,'Boeing','2012-10-20'),
((SELECT id FROM type_avion WHERE libelle='Long courrier'),'A350-1000',350,'Airbus','2021-02-10'),
((SELECT id FROM type_avion WHERE libelle='Moyen courrier'),'A320neo',180,'Airbus','2018-03-15'),
((SELECT id FROM type_avion WHERE libelle='Moyen courrier'),'B737-MAX8',170,'Boeing','2019-06-01'),
((SELECT id FROM type_avion WHERE libelle='Moyen courrier'),'A321LR',200,'Airbus','2022-08-20'),
((SELECT id FROM type_avion WHERE libelle='Court courrier'),'ATR72',70,'ATR','2010-04-10');

-- 5) Classes de sieges (si non deja presente)
-- (schema.sql inserte deja les classes, on ne duplique pas)

-- 6) Siege: echantillon representatif par avion (quelques sieges par appareil)
INSERT INTO siege (id_avion, numero_siege, id_classe_siege) VALUES
-- A380 first class samples
((SELECT id FROM avion WHERE modele='A380-800'),'1A',(SELECT id FROM classe_siege WHERE libelle='Premiere')),
((SELECT id FROM avion WHERE modele='A380-800'),'1B',(SELECT id FROM classe_siege WHERE libelle='Premiere')),
((SELECT id FROM avion WHERE modele='A380-800'),'2A',(SELECT id FROM classe_siege WHERE libelle='Affaires')),
((SELECT id FROM avion WHERE modele='A380-800'),'10C',(SELECT id FROM classe_siege WHERE libelle='Economique')),
((SELECT id FROM avion WHERE modele='A380-800'),'10D',(SELECT id FROM classe_siege WHERE libelle='Economique')),
-- A320neo samples
((SELECT id FROM avion WHERE modele='A320neo'),'2A',(SELECT id FROM classe_siege WHERE libelle='Affaires')),
((SELECT id FROM avion WHERE modele='A320neo'),'5D',(SELECT id FROM classe_siege WHERE libelle='Economique')),
-- B737-MAX8 samples
((SELECT id FROM avion WHERE modele='B737-MAX8'),'3A',(SELECT id FROM classe_siege WHERE libelle='Premium Eco')),
((SELECT id FROM avion WHERE modele='B737-MAX8'),'15C',(SELECT id FROM classe_siege WHERE libelle='Economique')),
-- ATR
((SELECT id FROM avion WHERE modele='ATR72'),'1A',(SELECT id FROM classe_siege WHERE libelle='Economique'));

-- 7) Itineraires (some direct routes)
INSERT INTO itineraire (id_aeroport_depart, id_aeroport_arrivee, distance_km, duree_moyenne_estimee) VALUES
((SELECT id FROM aeroport WHERE code_iata='CDG'),(SELECT id FROM aeroport WHERE code_iata='JFK'),5836,8),
((SELECT id FROM aeroport WHERE code_iata='CDG'),(SELECT id FROM aeroport WHERE code_iata='LHR'),344,1),
((SELECT id FROM aeroport WHERE code_iata='DXB'),(SELECT id FROM aeroport WHERE code_iata='LHR'),5500,7),
((SELECT id FROM aeroport WHERE code_iata='HND'),(SELECT id FROM aeroport WHERE code_iata='CDG'),9710,12),
((SELECT id FROM aeroport WHERE code_iata='GRU'),(SELECT id FROM aeroport WHERE code_iata='JFK'),7687,9);

-- 8) Vols (commercial flight numbers)
INSERT INTO vol (numero_vol, id_aeroport_depart, id_aeroport_arrivee) VALUES
('AF001',(SELECT id FROM aeroport WHERE code_iata='CDG'),(SELECT id FROM aeroport WHERE code_iata='JFK')),
('AF101',(SELECT id FROM aeroport WHERE code_iata='CDG'),(SELECT id FROM aeroport WHERE code_iata='LHR')),
('EK005',(SELECT id FROM aeroport WHERE code_iata='DXB'),(SELECT id FROM aeroport WHERE code_iata='LHR')),
('JL123',(SELECT id FROM aeroport WHERE code_iata='HND'),(SELECT id FROM aeroport WHERE code_iata='CDG')),
('LA210',(SELECT id FROM aeroport WHERE code_iata='GRU'),(SELECT id FROM aeroport WHERE code_iata='JFK'));

-- 9) Occurrences (vol_avion) : exemples sur 14 jours pour quelques vols
INSERT INTO vol_avion (id_vol, id_avion, date_depart, date_arrivee) VALUES
-- AF001 weekly rotations
((SELECT id FROM vol WHERE numero_vol='AF001'),(SELECT id FROM avion WHERE modele='A380-800'),'2025-07-01 10:00:00','2025-07-01 18:00:00'),
((SELECT id FROM vol WHERE numero_vol='AF001'),(SELECT id FROM avion WHERE modele='A380-800'),'2025-07-08 10:00:00','2025-07-08 18:00:00'),
((SELECT id FROM vol WHERE numero_vol='AF001'),(SELECT id FROM avion WHERE modele='A350-1000'),'2025-07-15 10:00:00','2025-07-15 18:00:00'),
-- EK005 multiple dates
((SELECT id FROM vol WHERE numero_vol='EK005'),(SELECT id FROM avion WHERE modele='A320neo'),'2025-07-02 14:00:00','2025-07-02 19:30:00'),
((SELECT id FROM vol WHERE numero_vol='EK005'),(SELECT id FROM avion WHERE modele='A321LR'),'2025-07-03 14:00:00','2025-07-03 19:30:00'),
-- JL123 nightly
((SELECT id FROM vol WHERE numero_vol='JL123'),(SELECT id FROM avion WHERE modele='A350-1000'),'2025-07-01 22:00:00','2025-07-02 06:00:00'),
((SELECT id FROM vol WHERE numero_vol='JL123'),(SELECT id FROM avion WHERE modele='A350-1000'),'2025-07-02 22:00:00','2025-07-03 06:00:00'),
-- LA210
((SELECT id FROM vol WHERE numero_vol='LA210'),(SELECT id FROM avion WHERE modele='B747-8'),'2025-07-05 08:00:00','2025-07-05 16:30:00');

-- 10) Limites bagage & forfaits & taxes
INSERT INTO limite_bagage (volume_max, poids_max, pieces_max) VALUES (0.08,23,1),(0.15,32,2);

INSERT INTO forfait_bagage (nom_forfait, poids_min, poids_max, volume_total, nbr_piece) VALUES
('Basic',0,20,0.06,1),('Standard',0,23,0.08,1),('Plus',0,32,0.15,2);

INSERT INTO taxe_aeroport (id_aeroport, montant) VALUES
((SELECT id FROM aeroport WHERE code_iata='CDG'),35.0),
((SELECT id FROM aeroport WHERE code_iata='JFK'),40.0),
((SELECT id FROM aeroport WHERE code_iata='LHR'),38.5);

-- 11) Tarifs (TarifVol) : pour chaque vol et classe, creer tarifs differents
-- AF001
INSERT INTO tarif_vol (id_vol, id_classe_siege, montant) VALUES
((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM classe_siege WHERE libelle='Premiere'), 3500.00),
((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM classe_siege WHERE libelle='Affaires'), 1800.00),
((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM classe_siege WHERE libelle='Premium Eco'), 950.00),
((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM classe_siege WHERE libelle='Economique'), 650.00);

-- EK005
INSERT INTO tarif_vol (id_vol, id_classe_siege, montant) VALUES
((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM classe_siege WHERE libelle='Affaires'), 1400.00),
((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM classe_siege WHERE libelle='Economique'), 700.00);

-- JL123
INSERT INTO tarif_vol (id_vol, id_classe_siege, montant) VALUES
((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM classe_siege WHERE libelle='Affaires'), 2200.00),
((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM classe_siege WHERE libelle='Economique'), 900.00);

-- 12) Passagers (beaucoup)
INSERT INTO passager (nom, prenom, date_naissance, nationalite, numero_passeport, email, telephone) VALUES
('Martin','Alice','1995-03-20','FR','FRA001','alice@mail.com','0123456789'),
('Dupont','Jean','1980-01-10','FR','FRA002','jean.dupont@mail.com','0147258391'),
('Bernard','Claire','1992-06-05','FR','FRA003','claire.b@mail.com','0147258392'),
('Lopez','Carlos','1975-09-11','BR','BRA001','c.lopez@mail.br','551199999001'),
('Silva','Mariana','1988-04-22','BR','BRA002','m.silva@mail.br','551199999002'),
('Smith','John','1985-12-02','US','USA001','john.smith@mail.com','15551234567'),
('Johnson','Robert','1970-11-12','US','USA002','robert.j@mail.com','15557654321'),
('Garcia','Luis','1994-02-18','ES','ESP001','luis.g@mail.es','34900100203'),
('Sato','Yuki','1990-07-05','JP','JPN001','yuki@mail.jp','8190000111'),
('Tanaka','Hiro','1987-08-30','JP','JPN002','hiro.t@mail.jp','8190000112'),
('Kumar','Anita','1993-05-12','IN','IND001','anita.k@mail.in','91900001111'),
('Nguyen','Thi','1991-10-10','VN','VNM001','thi.nguyen@mail.vn','84900001111'),
('Muller','Peter','1968-04-04','DE','DEU001','peter.m@mail.de','491700001111'),
('Rossi','Giulia','1996-12-25','IT','ITA001','giulia.r@mail.it','390600001111'),
('Olsen','Lars','1982-02-02','NO','NOR001','lars.o@mail.no','47900001111'),
('Chen','Li','1999-09-09','CN','CHN001','li.chen@mail.cn','861300001111'),
('Kim','Jin','1990-01-01','KR','KOR001','jin.kim@mail.kr','82100001111'),
('Ahmed','Sara','1994-03-03','AE','ARE001','s.ahmed@mail.ae','97100001111'),
('Ali','Omar','1986-07-07','AE','ARE002','omar.ali@mail.ae','97100001112'),
('Lopez','Ana','2000-11-11','ES','ESP002','ana.lopez@mail.es','34900100204');

-- 13) Reservations
INSERT INTO reservation (reference, created_on) VALUES
('RES-AF-0001','2025-06-01 10:00:00'),
('RES-AF-0002','2025-06-02 11:30:00'),
('RES-JL-001','2025-06-03 09:20:00'),
('RES-EK-100','2025-06-04 16:45:00'),
('RES-LA-200','2025-06-05 08:12:00'),
('RES-BULK-1','2025-06-06 12:00:00'),
('RES-BULK-2','2025-06-07 13:00:00'),
('RES-BULK-3','2025-06-08 14:00:00'),
('RES-BULK-4','2025-06-09 15:00:00'),
('RES-BULK-5','2025-06-10 16:00:00');

-- 14) Reservation_passager examples: associer passagers a occurrences
-- Reserve Alice (FRA001) on AF001 2025-07-01 10:00
INSERT INTO reservation_passager (id_reservation, id_passager, id_vol, id_vol_avion, id_siege, prix) VALUES
((SELECT id FROM reservation WHERE reference='RES-AF-0001'),
 (SELECT id FROM passager WHERE numero_passeport='FRA001'),
 (SELECT id FROM vol WHERE numero_vol='AF001'),
 (SELECT id FROM vol_avion WHERE id_vol=(SELECT id FROM vol WHERE numero_vol='AF001') AND date_depart='2025-07-01 10:00:00' LIMIT 1),
 (SELECT id FROM siege WHERE numero_siege='1A' AND id_avion=(SELECT id FROM avion WHERE modele='A380-800') LIMIT 1),
 3500.00);

-- Several mixed reservations
INSERT INTO reservation_passager (id_reservation, id_passager, id_vol, id_vol_avion, id_siege, prix) VALUES
((SELECT id FROM reservation WHERE reference='RES-AF-0001'), (SELECT id FROM passager WHERE numero_passeport='FRA002'), (SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM vol_avion WHERE id_vol=(SELECT id FROM vol WHERE numero_vol='AF001') AND date_depart='2025-07-01 10:00:00' LIMIT 1), (SELECT id FROM siege WHERE numero_siege='1B' AND id_avion=(SELECT id FROM avion WHERE modele='A380-800') LIMIT 1), 3500.00),
((SELECT id FROM reservation WHERE reference='RES-JL-001'), (SELECT id FROM passager WHERE numero_passeport='JPN001'), (SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM vol_avion WHERE id_vol=(SELECT id FROM vol WHERE numero_vol='JL123') AND date_depart='2025-07-01 22:00:00' LIMIT 1), (SELECT id FROM siege WHERE numero_siege='10C' AND id_avion=(SELECT id FROM avion WHERE modele='A380-800') LIMIT 1), 900.00),
((SELECT id FROM reservation WHERE reference='RES-EK-100'), (SELECT id FROM passager WHERE numero_passeport='USA001'), (SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM vol_avion WHERE id_vol=(SELECT id FROM vol WHERE numero_vol='EK005') AND date_depart='2025-07-02 14:00:00' LIMIT 1), (SELECT id FROM siege WHERE numero_siege='5D' AND id_avion=(SELECT id FROM avion WHERE modele='A320neo') LIMIT 1), 700.00);

-- 15) Billets (pour reservation_passager existants)
INSERT INTO billet (id_passager, id_vol, id_vol_avion, id_siege, prix, id_classe_siege, id_reservation_passager) VALUES
((SELECT id_passager FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)),
 (SELECT id_vol FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)),
 (SELECT id_vol_avion FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)),
 (SELECT id_siege FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)),
 (SELECT prix FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)),
 (SELECT id FROM classe_siege WHERE libelle='Premiere'),
 (SELECT id FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)));

-- 16) Historique statuts (sample)
INSERT INTO historique_statut_reservation (id_reservation, id_statut_reservation) VALUES
((SELECT id FROM reservation WHERE reference='RES-AF-0001'), (SELECT id FROM statut_reservation WHERE libelle='Creee')),
((SELECT id FROM reservation WHERE reference='RES-AF-0001'), (SELECT id FROM statut_reservation WHERE libelle='Confirmee'));

INSERT INTO historique_statut_vol (id_vol, id_statut_vol) VALUES
((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM statut_vol WHERE libelle='Cree')),
((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM statut_vol WHERE libelle='Cree'));

-- 17) Bagages : quelques exemples
INSERT INTO bagage_passager (id_reservation_passager, numero_bagage, poids, longueur, largeur) VALUES
((SELECT id FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 1)), 'BG001', 18.5, 55, 40),
((SELECT id FROM reservation_passager WHERE id=(SELECT id FROM reservation_passager ORDER BY id LIMIT 2 OFFSET 1)), 'BG002', 22.0, 60, 45);

-- 18) Taxes additionnelles (exemple) deja definies dans taxe_aeroport

-- Fin du fichier de donnees de test.
-- Ce fichier ecrase le precedent. Pour generer davantage de sieges ou de vols, on peut utiliser generate_series dans des scripts ad-hoc.

