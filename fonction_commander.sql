CREATE OR REPLACE FUNCTION public.commander(
	nom_client character varying,
	liste_menus character varying[],
	liste_desserts_menus character varying[],
	liste_pizzas_menus character varying[],
	liste_pizzas character varying[],
	liste_tailles_pizzas character varying[],
	liste_desserts character varying[],
	liste_boissons character varying[],
	"à_emporter" boolean,
	"téléphone_client" character varying,
	"numéro_rue" character varying,
	rue character varying,
	quartier character varying,
	OUT id_commande integer,
	OUT id_livreur integer)
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
	id_livreur := null;
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
	-- Enregistrer la commande et verifier la cohérance
	if liste_menus is null and liste_pizzas is null and liste_desserts is null and liste_boissons is null then
		raise exception 'Il n''y a rien a commander!';
	end if;
  	if 
  		liste_menus is not null and liste_desserts_menus is not null and cardinality(liste_menus) != cardinality(liste_desserts_menus) 
  		or
		liste_menus is not null and liste_desserts_menus is null
		or 
		liste_menus is null and liste_desserts_menus is not null
		or
		liste_menus is not null and liste_pizzas_menus is not null and cardinality(liste_menus) != cardinality(liste_pizzas_menus) 
  		or
		liste_menus is not null and liste_pizzas_menus is null
		or 
		liste_menus is null and liste_pizzas_menus is not null
  	then
		raise exception 'Le nombre de menu et de desserts/pizzas par menu doit etre identique!';
   	end if;
	insert into commandes (id_client, montant_total, terminée, payée) 
		values (id_client, 0, false, false) returning id into id_commande;
	if liste_menus is not null then
		for i in 1..cardinality(liste_menus) loop
			if not exists (select * from menus where nom = liste_menus[i]) then
				raise exception 'Le menu n''existe pas!';
			end if;
			id_du_menu = (select id from menus where nom = liste_menus[i]);
			insert into menus_par_commande (id_commande, id_menu)
    		values (id_commande, id_du_menu);
    		if liste_pizzas_menus[i] is null then
				raise exception 'Un menu doit avoir une pizza!';
			end if;
			if not exists (select * from choix_pizzas_menu
							where id_menu = id_du_menu and  id_pizza = (
								select id from pizzas where nom = liste_pizzas_menus[i])) then
	  				raise exception 'La pizza n''existe pas dans le menu!';
			end if;
			update menus_par_commande set id_pizza = (
				select id from pizzas where nom = liste_pizzas_menus[i]
			) where id_menu = id_du_menu;
			if liste_desserts_menus[i] is not null then
				if not exists (select * from choix_desserts_menu
							where id_menu = id_du_menu and  id_dessert = (
								select id from desserts where nom = liste_desserts_menus[i])) then
	  				raise exception 'Le déssert n''existe pas dans le menu!';
				end if ;
				update menus_par_commande set id_dessert = (
					select id from desserts where nom = liste_desserts_menus[i]
				) where id_menu = id_du_menu;
			end if;
			update commandes 
					set montant_total = montant_total + (SELECT prix FROM menus WHERE nom = liste_menus[i]) 
						where id = id_commande;	
		end loop;
	end if;
    -- Extras hors menu
	if liste_pizzas is not null then
		for i in 1..cardinality(liste_pizzas) loop
			if not exists (select * from pizzas where nom = liste_pizzas[i]) then 
				raise exception 'Il y a une pizza dans lise_pizza qui n''existe pas';
			end if;
			insert into pizzas_par_commande (id_commande, id_pizza, taille) values (id_commande, (select id from pizzas where nom = liste_pizzas[i]), liste_tailles_pizzas[i]);				
			if (liste_tailles_pizzas[i] = 'petite') then
				update commandes 
					set montant_total = montant_total + (SELECT prix_petite FROM pizzas WHERE nom = liste_pizzas[i]) 
						where id = id_commande;
			elsif (liste_tailles_pizzas[i] = 'moyenne') then
				update commandes 
					set montant_total = montant_total + (SELECT prix_moyenne FROM pizzas WHERE nom = liste_pizzas[i]) 
						where id = id_commande;
			elsif (liste_tailles_pizzas[i] = 'grande') then
				update commandes
					set montant_total = montant_total + (SELECT prix_grande FROM pizzas WHERE nom = liste_pizzas[i]) 
						where id = id_commande;
			else
				raise exception 'Il manque des taille pour les pizzas hors menu!';
			end if;
		end loop;
	end if;
    if liste_desserts is not null then
		for i in 1..cardinality(liste_desserts) loop
			if not exists (select * from desserts where nom = liste_desserts[i]) then 
				raise exception 'Il y a un dessert dans liste_desserts qui n''existe pas';
			end if;
			update commandes
					set montant_total = montant_total + (SELECT prix FROM desserts WHERE nom = liste_desserts[i]) 
						where id = id_commande;
            insert into desserts_par_commande (id_commande, id_dessert) values (id_commande, (select id from desserts where nom = liste_desserts[i]));
		end loop;
	end if;
	if liste_boissons is not null then
		for i in 1..cardinality(liste_boissons) loop
			if not exists (select * from boissons where nom = liste_boissons[i]) then 
				raise exception 'Il y a une boisson dans liste_boissons qui n''existe pas';
			end if;
			update commandes
					set montant_total = montant_total + (SELECT prix FROM boissons WHERE nom = liste_boissons[i]) 
						where id = id_commande;
            insert into boissons_par_commande (id_commande, id_boisson) values (id_commande, (select id from boissons where nom = liste_boissons[i]));
		end loop;
	end if;
	-- Gerer la partie livraison
  	if à_emporter then
		if téléphone_client is null or numéro_rue is null or rue is null is null or quartier is null then
			raise exception 'Les données de livraison sont incomplètes';
		end if;
    	id_du_quartier := (select id from quartiers where nom = quartier);
    	id_livreur := (select id from livreurs where livreurs.quartier = id_du_quartier limit 1);
    	if id_livreur is null then
      		raise exception 'Aucun livreur disponible dans le quartier demandé';
    	end if;
    	insert into livraisons (id_commande, id_livreur, numéro_rue, rue, id_quartier, téléphone_client)
    	values (id_commande, id_livreur, numéro_rue, rue, id_du_quartier, téléphone_client);
   end if;
 END;
$BODY$;