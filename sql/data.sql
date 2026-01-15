\c gestion_compagnie_aerienne;

-- =====================================================
-- NETTOYAGE DES DONNÉES (ordre respectant les FK)
-- =====================================================
DELETE FROM historique_statut_billet;
DELETE FROM billet;
DELETE FROM bagage_passager;
DELETE FROM historique_statut_reservation_passager;
DELETE FROM reservation_passager;
DELETE FROM historique_statut_reservation;
DELETE FROM reservation;
DELETE FROM passager;
DELETE FROM tarif_vol;
DELETE FROM escale;
DELETE FROM vol_avion;
DELETE FROM historique_statut_vol_avion;
DELETE FROM historique_statut_vol;
DELETE FROM vol;
DELETE FROM itineraire;
DELETE FROM siege;
DELETE FROM historique_statut_avion;
DELETE FROM avion;
DELETE FROM type_avion;
DELETE FROM classe_siege;
DELETE FROM aeroport;

-- =====================================================
-- AEROPORTS
-- =====================================================
INSERT INTO aeroport (id, code_iata, nom, ville, pays) VALUES
                                                           (1, 'TNR', 'Ivato International Airport', 'Antananarivo', 'Madagascar'),
                                                           (2, 'NOS', 'Fascene Airport', 'Nosy Be', 'Madagascar'),
                                                           (3, 'DIE', 'Arrachart Airport', 'Antsiranana', 'Madagascar');

-- =====================================================
-- CLASSES DE SIEGE
-- =====================================================
INSERT INTO classe_siege (id, libelle) VALUES
                                           (1, '1ere classe'),
                                           (2, 'premium'),
                                           (3, 'economique');

-- =====================================================
-- TYPE AVION
-- =====================================================
INSERT INTO type_avion (id, libelle) VALUES
    (1, 'Moyen courrier');

-- =====================================================
-- AVION UNIQUE
-- capacité = 30 + 40 + 50 = 120 sièges
-- =====================================================
INSERT INTO avion (
    id,
    id_type_avion,
    modele,
    nbr_siege,
    constructeur,
    date_mise_service
) VALUES (
             1,
             1,
             'Airbus A321',
             120,
             'Airbus',
             '2020-01-01'
         );

-- =====================================================
-- STATUT AVION
-- =====================================================
INSERT INTO historique_statut_avion (id_avion, id_statut_avion)
VALUES (1, 1);

-- =====================================================
-- SIEGES
-- =====================================================
-- 1ere classe : 30 sièges
INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'F' || gs, 1 FROM generate_series(1, 30) gs;

-- premium : 40 sièges
INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'P' || gs, 2 FROM generate_series(1, 40) gs;

-- economique : 50 sièges
INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'E' || gs, 3 FROM generate_series(1, 50) gs;

-- =====================================================
-- ITINERAIRES
-- =====================================================
INSERT INTO itineraire (id, id_aeroport_depart, id_aeroport_arrivee, distance_km, duree_moyenne_estimee) VALUES
                                                                                                             (1, 1, 2, 620, 90),
                                                                                                             (2, 1, 3, 950, 130);

-- =====================================================
-- VOLS
-- =====================================================
INSERT INTO vol (id, numero_vol, id_aeroport_depart, id_aeroport_arrivee) VALUES
                                                                              (1, 'MD101', 1, 2),
                                                                              (2, 'MD102', 1, 3);

-- =====================================================
-- VOL_AVION (un seul avion utilisé)
-- =====================================================
INSERT INTO vol_avion (id, id_vol, id_avion, date_depart, date_arrivee) VALUES
                                                                            (1, 1, 1, '2026-03-10 08:00', '2026-03-10 09:30'),
                                                                            (2, 2, 1, '2026-03-11 07:30', '2026-03-11 09:40');

-- =====================================================
-- TARIFS (IDENTIQUES POUR TOUS LES VOLS)
-- =====================================================
INSERT INTO tarif_vol (id_vol, id_classe_siege, montant)
SELECT v.id, 1, 1200000 FROM vol v;

INSERT INTO tarif_vol (id_vol, id_classe_siege, montant)
SELECT v.id, 2, 1000000 FROM vol v;

INSERT INTO tarif_vol (id_vol, id_classe_siege, montant)
SELECT v.id, 3, 700000 FROM vol v;

-- =====================================================
-- PASSAGERS
-- =====================================================
INSERT INTO passager (id, nom, prenom, date_naissance, nationalite, numero_passeport, email, telephone) VALUES
                                                                                                            (1, 'Rakoto', 'Jean', '1990-05-12', 'Malagasy', 'MG000111', 'jean.rakoto@mail.mg', '0341122334'),
                                                                                                            (2, 'Rasoanaivo', 'Claire', '1988-08-20', 'Malagasy', 'MG000222', 'claire.r@mail.mg', '0329988776');

-- =====================================================
-- RESERVATION
-- =====================================================
INSERT INTO reservation (id, reference) VALUES
    (1, 'RES-2026-0001');

INSERT INTO historique_statut_reservation (id_reservation, id_statut_reservation)
VALUES (1, 4);

-- =====================================================
-- RESERVATION_PASSAGER
-- =====================================================
INSERT INTO reservation_passager
(id, id_reservation, id_passager, id_vol, id_vol_avion, id_siege, prix)
VALUES
    (1, 1, 1, 1, 1, 1, 700000),
    (2, 1, 2, 1, 1, 2, 700000);

-- =====================================================
-- BILLETS
-- =====================================================
INSERT INTO billet
(id, id_passager, id_vol, id_vol_avion, id_siege, prix, id_classe_siege, id_reservation_passager)
VALUES
    (1, 1, 1, 1, 1, 700000, 3, 1),
    (2, 2, 1, 1, 2, 700000, 3, 2);

-- =====================================================
-- STATUT BILLET
-- =====================================================
INSERT INTO statut_billet (id, libelle) VALUES
                                            (1, 'Emis'),
                                            (2, 'Annule');

INSERT INTO historique_statut_billet (id_billet, id_statut_billet)
VALUES
    (1, 1),
    (2, 1);
