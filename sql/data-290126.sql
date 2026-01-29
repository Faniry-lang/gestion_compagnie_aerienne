\c gestion_compagnie_aerienne;

-- =====================================================
-- NETTOYAGE
-- =====================================================
-- =====================================================
-- NETTOYAGE
-- =====================================================
TRUNCATE TABLE
    vente_produit,
    stock_produit,
    prix_vente_produit,
    produit_extra,
    payement_pub,
    diffusion_pub,
    cout_pub,
    societe,
    remise_age_tarif,
    tranche_age,
    historique_statut_billet,
    billet,
    bagage_passager,
    historique_statut_reservation_passager,
    reservation_passager,
    historique_statut_reservation,
    reservation,
    passager,
    tarif_vol,
    escale,
    vol_avion,
    historique_statut_vol_avion,
    historique_statut_vol,
    vol,
    itineraire,
    siege,
    historique_statut_avion,
    avion,
    type_avion,
    classe_siege,
    aeroport
RESTART IDENTITY CASCADE;

-- =====================================================
-- AEROPORTS
-- =====================================================
INSERT INTO aeroport (id, code_iata, nom, ville, pays) VALUES
(1, 'TNR', 'Ivato International Airport', 'Antananarivo', 'Madagascar'),
(2, 'NOS', 'Fascene Airport', 'Nosy Be', 'Madagascar');

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
(1, 'ATR 72');

-- =====================================================
-- AVION: ATR - 045 (120 Sieges)
-- =====================================================
INSERT INTO avion (id, id_type_avion, modele, nbr_siege, constructeur, date_mise_service)
VALUES (1, 1, 'ATR - 045', 120, 'ATR', '2020-01-01');

-- Statut Avion
INSERT INTO statut_avion (id, libelle) VALUES (1, 'En service') ON CONFLICT DO NOTHING;
INSERT INTO historique_statut_avion (id_avion, id_statut_avion) VALUES (1, 1);

-- =====================================================
-- SIEGES (120 Total)
-- 1ere: 30, Premium: 40, Eco: 50 (Matches data.sql distribution)
-- =====================================================
INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'F' || gs, 1 FROM generate_series(1, 30) gs;

INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'P' || gs, 2 FROM generate_series(1, 40) gs;

INSERT INTO siege (id_avion, numero_siege, id_classe_siege)
SELECT 1, 'E' || gs, 3 FROM generate_series(1, 50) gs;

-- =====================================================
-- ITINERAIRE: TNR -> Nosy Be
-- =====================================================
INSERT INTO itineraire (id, id_aeroport_depart, id_aeroport_arrivee, distance_km, duree_moyenne_estimee)
VALUES (1, 1, 2, 700, 90);

-- =====================================================
-- VOL: TNR -> Nosy Be
-- =====================================================
INSERT INTO statut_vol (id, libelle) VALUES (1, 'Planifie') ON CONFLICT DO NOTHING;
INSERT INTO vol (id, numero_vol, id_aeroport_depart, id_aeroport_arrivee)
VALUES (1, 'MD301', 1, 2);

INSERT INTO historique_statut_vol (id_vol, id_statut_vol) VALUES (1, 1);

-- =====================================================
-- VOL_AVION (3 Instances)
-- =====================================================
INSERT INTO statut_vol_avion (id, libelle) VALUES (1, 'Planifie') ON CONFLICT DO NOTHING;

-- 1: 20 Jan 2026 10:00
INSERT INTO vol_avion (id, id_vol, id_avion, date_depart, date_arrivee)
VALUES (1, 1, 1, '2026-01-20 10:00:00', '2026-01-20 11:30:00');

-- 2: 21 Jan 2026 10:00
INSERT INTO vol_avion (id, id_vol, id_avion, date_depart, date_arrivee)
VALUES (2, 1, 1, '2026-01-21 10:00:00', '2026-01-21 11:30:00');

-- 3: 21 Jan 2026 15:00
INSERT INTO vol_avion (id, id_vol, id_avion, date_depart, date_arrivee)
VALUES (3, 1, 1, '2026-01-21 15:00:00', '2026-01-21 16:30:00');

INSERT INTO historique_statut_vol_avion (id_vol_avion, id_statut_vol) VALUES (1, 1), (2, 1), (3, 1);

-- =====================================================
-- TARIF VOL (Conserving data.sql values)
-- =====================================================
INSERT INTO tarif_vol (id_vol, id_classe_siege, montant) VALUES
(1, 1, 1200000), -- 1ere
(1, 2, 1000000), -- Premium
(1, 3, 700000);  -- Economique

-- =====================================================
-- SOCIETES
-- =====================================================
INSERT INTO societe (nom) VALUES ('Vaniala'), ('Lewis'), ('socobis'), ('Jejoo');

-- =====================================================
-- TRANCHE D'AGE
-- =====================================================
INSERT INTO tranche_age (id, libelle, age_min, age_max) VALUES
(1, 'Bebe', 0, 2),
(2, 'Enfant', 2, 12),
(3, 'Adulte', 12, 150);

-- =====================================================
-- REMISE (Adulte Eco 800 000 Ar)
-- =====================================================
INSERT INTO remise_age_tarif (id_vol, id_classe_siege, id_tranche_age, montant_complet, est_en_pourcentage, created_on)
VALUES (1, 3, 3, 800000, false, CURRENT_TIMESTAMP);

-- =====================================================
-- PASSAGERS (Generating Adults)
-- =====================================================
INSERT INTO passager (nom, prenom, date_naissance, nationalite, numero_passeport, email, telephone)
SELECT
    'Passager_' || gs,
    'Adult_' || gs,
    '1990-01-01', -- 36 years old -> Adulte
    'Malagasy',
    'PASS' || gs,
    'p' || gs || '@email.com',
    '03400000' || gs
FROM generate_series(1, 200) gs;

-- =====================================================
-- GENERATION DES BILLETS / RESERVATIONS
-- Vol 1: 40 Adulte Eco
-- Vol 2: 30 Adulte Eco
-- Vol 3: 50 Adulte Eco
-- =====================================================

INSERT INTO statut_reservation (id, libelle) VALUES (1, 'Confirmee') ON CONFLICT DO NOTHING;
INSERT INTO statut_billet (id, libelle) VALUES (1, 'Emis') ON CONFLICT DO NOTHING;

DO $$
DECLARE
    p_row record;
    s_row record;
    r_id int;
    rp_id int;
    v_id int := 1; -- Vol ID
    va_id int;
    count_limit int;
    counter int;
    va_cursor int;
    targets int[];
    limits int[];
    p_offset int := 0;
BEGIN
    targets := ARRAY[1, 2, 3]; -- VA IDs
    limits := ARRAY[40, 30, 50]; -- Counts

    FOR va_cursor IN 1..3 LOOP
        va_id := targets[va_cursor];
        count_limit := limits[va_cursor];
        counter := 0;

        FOR p_row IN SELECT * FROM passager ORDER BY id LIMIT count_limit OFFSET p_offset LOOP
            -- Create Reservation
            INSERT INTO reservation (reference) VALUES ('RES-' || va_id || '-' || p_row.id) RETURNING id INTO r_id;
            INSERT INTO historique_statut_reservation (id_reservation, id_statut_reservation) VALUES (r_id, 1);

            -- Find specific seat (Eco) available for this flight
            -- Simplified: Just pick a seat ID available (assuming no conflicts in this clean run)
            -- Eco seats are linked to id_class 3.
            SELECT * FROM siege WHERE id_classe_siege = 3 ORDER BY id LIMIT 1 OFFSET counter INTO s_row;

            -- Insert Reservation Passager
            INSERT INTO reservation_passager (id_reservation, id_passager, id_vol, id_vol_avion, id_siege, prix)
            VALUES (r_id, p_row.id, v_id, va_id, s_row.id, 700000) RETURNING id INTO rp_id;

            INSERT INTO historique_statut_reservation_passager (id_reservation_passager, id_statut_reservation) VALUES (rp_id, 1);

            -- Insert Billet
            INSERT INTO billet (id_passager, id_vol, id_vol_avion, id_siege, prix, id_classe_siege, id_reservation_passager)
            VALUES (p_row.id, v_id, va_id, s_row.id, 700000, 3, rp_id);

            INSERT INTO historique_statut_billet (id_billet, id_statut_billet) VALUES ((SELECT currval('billet_id_seq')), 1);

            counter := counter + 1;
        END LOOP;

        p_offset := p_offset + count_limit;
    END LOOP;
END $$;

-- =====================================================
-- EXTRAS & PUB (Update)
-- =====================================================
INSERT INTO cout_pub(montant) VALUES (400000);

-- Diffusions Vol 1 (id_vol_avion=1): Vaniala(1), Lewis(2)
INSERT INTO diffusion_pub(id_societe, mois, annee, nbr_diffusion, id_vol_avion)
VALUES
(1, 1, 2026, 1, 1), -- Vaniala
(2, 1, 2026, 1, 1); -- Lewis

-- Diffusions Vol 2 (id_vol_avion=2): socobis(3), Jejoo(4)
INSERT INTO diffusion_pub(id_societe, mois, annee, nbr_diffusion, id_vol_avion)
VALUES
(3, 1, 2026, 2, 2), -- socobis
(4, 1, 2026, 1, 2); -- Jejoo

-- Vente Produit Extra (Tablette de chocolat)
INSERT INTO produit_extra (descr) VALUES ('Tablette de chocolat');

-- Prix vente
INSERT INTO prix_vente_produit (id_produit_extra, montant, date_mis_a_jour)
VALUES
((SELECT id FROM produit_extra WHERE descr = 'Tablette de chocolat'), 5000, '2026-01-01 00:00:00');

-- Vente avec id_vol_avion non specifie (NULL)
INSERT INTO vente_produit (id_produit_extra, qte, prix_unitaire_du_jour, id_vol_avion, date_vente)
VALUES
((SELECT id FROM produit_extra WHERE descr = 'Tablette de chocolat'), 150, 5000, NULL, '2026-01-15 12:00:00');

-- Stock Produit (Jan 2026)
INSERT INTO stock_produit(id_produit_extra, qte, date_stock)
VALUES
((SELECT id FROM produit_extra WHERE descr = 'Tablette de chocolat'), 500, '2026-01-01 08:00:00');

INSERT INTO payement_pub (id_societe, montant, date) VALUES 
((SELECT id FROM societe WHERE nom = 'Vaniala'), 200000, '2026-01-01 00:00:00');

