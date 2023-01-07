SELECT * from public.commander(
	nom_client => 'John Doe',
	-- LES MENUS ET LES OPTIONS DES MENUS 
	liste_menus => array['Hiver', 'Eté'],
	liste_desserts_menus => array['Banane au whisky', 'Glace'], 
	liste_pizzas_menus => array ['4 fromages', 'Merguez'],
	-- LES EXTRAS
	liste_pizzas => array['Raclette'],
	liste_tailles_pizzas => array['petite'],
	liste_desserts => array['Tiramisu'],
	liste_boissons => array['1664', '1664', '1664', 'Sprite'],
	-- DETAILS COMMANDE
	à_emporter => true,
	téléphone_client => '07 88 09 12 35',
	numéro_rue => '35B',
	rue => 'Rue Paul Santy',
	quartier => 'Mermoz'
)