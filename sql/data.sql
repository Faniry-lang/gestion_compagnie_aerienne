-- RE-GENERATION COMPLETE DES DONNEES DE TEST
-- AUCUN ACCENT / AUCUN CARACTERE SPECIAL

-- 1. REFERENTIELS
INSERT INTO aeroport (code_iata, nom, ville, pays) VALUES
                                                       ('CDG', 'Charles de Gaulle', 'Paris', 'France'),
                                                       ('JFK', 'John F Kennedy', 'New York', 'USA'),
                                                       ('LHR', 'London Heathrow', 'Londres', 'Royaume-Uni'),
                                                       ('DXB', 'Dubai International', 'Dubai', 'Emirats Arabes Unis'),
                                                       ('HND', 'Haneda', 'Tokyo', 'Japon');

INSERT INTO statut_avion (libelle) VALUES ('En service'), ('Maintenance'), ('Stocke'), ('A vendre');
INSERT INTO type_avion (libelle) VALUES ('Long courrier'), ('Moyen courrier'), ('Court courrier');
INSERT INTO statut_vol (libelle) VALUES ('Planifie'), ('Enregistrement'), ('Embarquement'), ('En vol'), ('Atterri'), ('Annule'), ('Retarde');
INSERT INTO statut_reservation (libelle) VALUES ('Confirmee'), ('En attente'), ('Payee'), ('Annulee'), ('Remboursee');
INSERT INTO statut_billet (libelle) VALUES ('Valide'), ('Utilise'), ('Expire'), ('Annule');
INSERT INTO classe_siege (libelle) VALUES ('Economique'), ('Premium Eco'), ('Affaires'), ('Premiere');

-- 2. FLOTTE D'AVIONS (Plus d'appareils)
INSERT INTO avion (id_type_avion, modele, nbr_siege, constructeur, date_mise_service) VALUES
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Long courrier'), 'A380-800', 500, 'Airbus', '2015-05-12'),
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Long courrier'), '747-8', 400, 'Boeing', '2012-10-20'),
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Long courrier'), 'A350-1000', 350, 'Airbus', '2021-02-10'),
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Moyen courrier'), 'A320neo', 180, 'Airbus', '2018-03-15'),
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Moyen courrier'), '737 MAX 8', 170, 'Boeing', '2019-06-01'),
                                                                                          ((SELECT id FROM type_avion WHERE libelle='Moyen courrier'), 'A321LR', 200, 'Airbus', '2022-08-20');

-- 3. SIEGES (Echantillon pour tests)
INSERT INTO siege (id_avion, numero_siege, id_classe_siege) VALUES
                                                                ((SELECT id FROM avion WHERE modele='A380-800'), '01A', (SELECT id FROM classe_siege WHERE libelle='Premiere')),
                                                                ((SELECT id FROM avion WHERE modele='A380-800'), '01B', (SELECT id FROM classe_siege WHERE libelle='Premiere')),
                                                                ((SELECT id FROM avion WHERE modele='A380-800'), '10C', (SELECT id FROM classe_siege WHERE libelle='Economique')),
                                                                ((SELECT id FROM avion WHERE modele='A320neo'), '02A', (SELECT id FROM classe_siege WHERE libelle='Affaires')),
                                                                ((SELECT id FROM avion WHERE modele='A320neo'), '05D', (SELECT id FROM classe_siege WHERE libelle='Economique'));

-- 4. VOLS COMMERCIAUX
INSERT INTO vol (numero_vol, id_aeroport_depart, id_aeroport_arrivee) VALUES
                                                                          ('AF001', (SELECT id FROM aeroport WHERE code_iata='CDG'), (SELECT id FROM aeroport WHERE code_iata='JFK')),
                                                                          ('EK005', (SELECT id FROM aeroport WHERE code_iata='DXB'), (SELECT id FROM aeroport WHERE code_iata='LHR')),
                                                                          ('JL123', (SELECT id FROM aeroport WHERE code_iata='HND'), (SELECT id FROM aeroport WHERE code_iata='CDG'));

-- 5. GENERATION MASSIVE DE VOL_AVION (ROTATIONS SUR 7 JOURS)
-- AF001 : Paris -> New York
INSERT INTO vol_avion (id_vol, id_avion, date_depart, date_arrivee) VALUES
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='A380-800'), '2025-07-01 10:00:00', '2025-07-01 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='747-8'), '2025-07-02 10:00:00', '2025-07-02 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-03 10:00:00', '2025-07-03 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='A380-800'), '2025-07-04 10:00:00', '2025-07-04 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='747-8'), '2025-07-05 10:00:00', '2025-07-05 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-06 10:00:00', '2025-07-06 18:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM avion WHERE modele='A380-800'), '2025-07-07 10:00:00', '2025-07-07 18:00:00');

-- EK005 : Dubai -> Londres
INSERT INTO vol_avion (id_vol, id_avion, date_depart, date_arrivee) VALUES
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='A320neo'), '2025-07-01 14:00:00', '2025-07-01 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='A321LR'), '2025-07-02 14:00:00', '2025-07-02 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='737 MAX 8'), '2025-07-03 14:00:00', '2025-07-03 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='A320neo'), '2025-07-04 14:00:00', '2025-07-04 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='A321LR'), '2025-07-05 14:00:00', '2025-07-05 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='737 MAX 8'), '2025-07-06 14:00:00', '2025-07-06 19:30:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM avion WHERE modele='A320neo'), '2025-07-07 14:00:00', '2025-07-07 19:30:00');

-- JL123 : Tokyo -> Paris
INSERT INTO vol_avion (id_vol, id_avion, date_depart, date_arrivee) VALUES
                                                                        ((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-01 22:00:00', '2025-07-02 06:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-02 22:00:00', '2025-07-03 06:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-03 22:00:00', '2025-07-04 06:00:00'),
                                                                        ((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM avion WHERE modele='A350-1000'), '2025-07-04 22:00:00', '2025-07-05 06:00:00');

-- 6. PASSAGERS ET RESERVATIONS
INSERT INTO passager (nom, prenom, date_naissance, nationalite, numero_passeport, email, telephone) VALUES
                                                                                                        ('Martin', 'Alice', '1995-03-20', 'Francaise', 'FRA001', 'alice@mail.com', '0123456789'),
                                                                                                        ('Johnson', 'Robert', '1982-11-12', 'Americaine', 'USA999', 'rob@mail.com', '15551234'),
                                                                                                        ('Sato', 'Yuki', '1990-07-05', 'Japonaise', 'JPN444', 'yuki@mail.jp', '8190000111');

INSERT INTO reservation (reference) VALUES ('ABC12345'), ('XYZ67890'), ('LMN45678');

-- 7. RESERVATION_PASSAGER (Liaison passager / occurrence de vol)
INSERT INTO reservation_passager (id_reservation, id_passager, id_vol, id_vol_avion, id_siege, prix) VALUES
                                                                                                         (
                                                                                                             (SELECT id FROM reservation WHERE reference='ABC12345'),
                                                                                                             (SELECT id FROM passager WHERE numero_passeport='FRA001'),
                                                                                                             (SELECT id FROM vol WHERE numero_vol='AF001'),
                                                                                                             (SELECT id FROM vol_avion WHERE date_depart='2025-07-01 10:00:00' AND id_vol=(SELECT id FROM vol WHERE numero_vol='AF001')),
                                                                                                             (SELECT id FROM siege WHERE numero_siege='01A' AND id_avion=(SELECT id FROM avion WHERE modele='A380-800')),
                                                                                                             1200.00
                                                                                                         ),
                                                                                                         (
                                                                                                             (SELECT id FROM reservation WHERE reference='XYZ67890'),
                                                                                                             (SELECT id FROM passager WHERE numero_passeport='JPN444'),
                                                                                                             (SELECT id FROM vol WHERE numero_vol='JL123'),
                                                                                                             (SELECT id FROM vol_avion WHERE date_depart='2025-07-01 22:00:00' AND id_vol=(SELECT id FROM vol WHERE numero_vol='JL123')),
                                                                                                             (SELECT id FROM siege WHERE numero_siege='10C' AND id_avion=(SELECT id FROM avion WHERE modele='A380-800')),
                                                                                                             850.00
                                                                                                         );

-- 8. BILLETS ET HISTORIQUE
INSERT INTO billet (id_passager, id_vol, id_vol_avion, id_siege, prix, id_classe_siege, id_reservation_passager) VALUES
    (
        (SELECT id_passager FROM reservation_passager WHERE id=1),
        (SELECT id_vol FROM reservation_passager WHERE id=1),
        (SELECT id_vol_avion FROM reservation_passager WHERE id=1),
        (SELECT id_siege FROM reservation_passager WHERE id=1),
        1200.00,
        (SELECT id FROM classe_siege WHERE libelle='Premiere'),
        1
    );

INSERT INTO historique_statut_vol (id_vol, id_statut_vol) VALUES
                                                              ((SELECT id FROM vol WHERE numero_vol='AF001'), (SELECT id FROM statut_vol WHERE libelle='Planifie')),
                                                              ((SELECT id FROM vol WHERE numero_vol='EK005'), (SELECT id FROM statut_vol WHERE libelle='Planifie')),
                                                              ((SELECT id FROM vol WHERE numero_vol='JL123'), (SELECT id FROM statut_vol WHERE libelle='Planifie'));