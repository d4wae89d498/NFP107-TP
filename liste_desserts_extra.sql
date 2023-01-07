-- liste desserts en extra
select desserts.nom from desserts_par_commande, desserts 
where 
	desserts.id = id_dessert
	and id_commande = 4