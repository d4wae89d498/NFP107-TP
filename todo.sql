select montant_total from commandes where id = (SELECT id_commande from public.commander(
	nom_client => ...
))



