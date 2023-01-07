-- liste des menus commandés
select menus.nom as nom_menu, pizzas.nom as nom_pizza, 
desserts.nom as nom_dessert, fromage, menus.prix 
	from menus_par_commande, menus, pizzas, desserts
where 
	id_commande = 4 
	and id_menu = menus.id
	and pizzas.id = id_pizza
	and desserts.id = id_dessert
