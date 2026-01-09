CREATE OR REPLACE VIEW vol_details AS
   SELECT
   v.id as id_vol,
   v.numero_vol,
    v.id_aeroport_depart,
    v.id_aeroport_arrivee,
    v.created_on as date_vol,
    va.id as id_vol_avion,
    va.date_depart,
    va.date_arrivee,
    va.created_on as date_vol_avion,
    a.id as id_avion,
    a.nbr_siege as capacite_totale,
    COALESCE(vr.places_reservees, 0) as places_reservees,
    a.nbr_siege - COALESCE(vr.places_reservees, 0) as places_restantes
       FROM vol_avion va
           JOIN vol v ON v.id = va.id_vol
           JOIN avion a ON a.id = va.id_avion
           LEFT JOIN (
           SELECT
           id_vol_avion,
           COUNT(*) as places_reservees
           FROM billet
           GROUP BY id_vol_avion
           ) as vr ON vr.id_vol_avion = va.id
   ORDER BY va.created_on DESC;
