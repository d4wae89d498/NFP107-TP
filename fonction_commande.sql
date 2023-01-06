-- FUNCTION: public.commander(character varying, character varying[], character varying[], character varying[], character varying[], character varying[], character varying, boolean, integer, character varying, character varying)

--DROP FUNCTION public.commander(character varying, character varying[], character varying[], character varying[], character varying[], character varying[], character varying, boolean, integer, character varying, character varying);

CREATE FUNCTION public.commander(
	nom_client character varying,
	liste_menus character varying[],
	desserts_menus character varying[],
	liste_pizzas character varying[],
	liste_desserts character varying[],
	liste_boissons character varying[],
	à_emporter boolean,
	téléphone_client character varying,
	numéro_rue character varying,
	rue character varying,
	quartier character varying,
	OUT id_commande integer,
	OUT nom_livreur character varying)
    RETURNS record
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE id_client INTEGER;
DECLARE id_du_menu INTEGER;
DECLARE id_du_quartier INTEGER;

BEGIN
 	id_commande := null;
	nom_livreur := null;
	-- Enregistrer un client
	if (nom_client is null) then
		raise exception 'Le nom du client est obligatoire';
	end if;
	if not exists (select 1 from clients where nom = nom_client) then
    	insert into clients (nom, téléphone) values (nom_client, téléphone_client);
 	else
    	update clients set téléphone = téléphone_client where nom = nom_client;
  	end if;
  	id_client := (select id from clients where nom = nom_client);
	-- Verifier la coherence de la commande
	if liste_menus is null and liste_pizzas is null and liste_desserts is null and liste_boissons is null then
		raise exception 'Il n''y a rien a commander!';
	end if;
  	if 
  		liste_menus is not null and desserts_menus is not null and cardinality(liste_menus) != cardinality(desserts_menus) 
  		or
		liste_menus is not null and desserts_menus is null
		or 
		liste_menus is null and desserts_menus is not null
  	then
		raise exception 'Le nombre de menu et de dessert par menu doit etre identique!';
   	end if;
	-- Enregistrer les menus commander et verifier la cohérance
	insert into commandes (id_client, montant_total, terminée, payée) 
		values (id_client, 0, false, false) returning id into id_commande;
	for i in 1..cardinality(liste_menus) loop
		if not exists (select * from menus where nom = liste_menus[i]) then
			raise exception 'Le menu n''existe pas!';
		end if;
		id_du_menu = (select id from menus where nom = liste_menus[i]);
		insert into menus_par_commande (id_commande, id_menu)
    		values (id_commande, id_du_menu);
    	update commandes 
			set montant_total = montant_total + (select prix from menus where id = id_du_menu) where id = id_commande;
		-- todo : check if pizza exists 
		if desserts_menus[i] is not null then
			if not exists (select * from choix_desserts_menu
							where id_menu = id_du_menu and  id_dessert = (
								select id from desserts where nom = desserts_menus[i])) then
	  			raise exception 'Le déssert n''existe pas dans le menu!';
			end if ;
			insert into desserts_par_commande (id_commande, id_dessert)
    		values (id_commande, (select id from desserts where nom = desserts_menus[i]));
			update commandes 
			set montant_total = montant_total + (SELECT prix FROM desserts WHERE nom = desserts_menus[i]) 
			where id = id_commande;
		end if;	
	end loop;

	for i in 1..cardinality(liste_pizzas) loop
		if not exists (select * from pizzas where nom = liste_pizzas[i]) then 
			raise exception 'Il y a une pizza dans lise_pizza qui n''existe pas';
		end if;
		insert into pizzas_par_commande (id_commande, id_pizza) values (id_commande, (select id from pizzas where nom = liste_pizzas[i]));
	end loop;

	for i in 1..cardinality(liste_boissons) loop
		if not exists (select * from pizzas where nom = liste_boissons[i]) then 
			raise exception 'Il y a une boisson dans liste_boissons qui n''existe pas';
		end if;
		insert into boissons_par_commande (id_commande, id_pizza) values (id_commande, (select id from boissons where nom = liste_boissons[i]));
	end loop;

	-- Gerer la partie livraison
  	if à_emporter then
		if téléphone_client is null or adresse_livraison is null or numéro_rue is null or quartier is null then
			raise exception 'Les données de livraison sont incomplètes';
		end if;
    	id_du_quartier := (select id from quartiers where nom = quartier);
    	nom_livreur := (select nom from livreurs where livreurs.id_quartier = id_du_quartier limit 1);
    	if nom_livreur is null then
      		raise exception 'Aucun livreur disponible dans le quartier demandé';
    	end if;
    	insert into livraisons (id_commande, nom_livreur, numéro_rue, rue, quartier)
    	values (id_commande, nom_livreur, numéro_rue, rue, id_du_quartier);
   end if;
 END;
$BODY$;
