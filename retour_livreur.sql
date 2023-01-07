-- Example de requête pour le retour d'un livreur à la pizzeria après une livraison
BEGIN TRANSACTION;
    update public.livreurs set est_en_livraison = false 
    where nom = 'Rose'
COMMIT;