-- Un livreur est arrivée chez un client
BEGIN TRANSACTION;
    update public.commande set terminée = true, payée = true where id = 8;
    update public.livraison set date_heure_livraison = now() where id_commande = 8;
COMMIT;