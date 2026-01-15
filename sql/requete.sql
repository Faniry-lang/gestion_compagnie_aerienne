SELECT *,
       CASE
           WHEN
               id NOT IN (
                   SELECT id_siege FROM reservation_passager WHERE id_vol_avion = 1
               )
               THEN TRUE
           ELSE FALSE
           END AS est_disponible
FROM siege WHERE id_avion = 1;

SELECT *
    FROM tarif_vol WHERE id_vol = ? AND id_classe_siege = ? OR id_classe_siege IS NULL
                   AND created_on <= ?
ORDER BY created_on DESC LIMIT 1;

