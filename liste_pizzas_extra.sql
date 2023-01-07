-- liste pizzas en extra
select pizzas.nom, taille from pizzas_par_commande, pizzas 
where 
	pizzas.id = id_pizza
	and id_commande = 4