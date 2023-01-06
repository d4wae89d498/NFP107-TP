SELECT * from public.passer_commande(
	nom_client => 'Doe john', 
	liste_menus => ARRAY['Hiver'],
	desserts_menus => ARRAY['Tiramisu'], 
	pizzas => null, 
	desserts => null, 
	boissons => null,
	à_emporter => false,
	téléphone_client => null, 
	numéro_rue => null, 
	rue => null, 
	quartier => null
)

