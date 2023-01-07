-- Créer les tables

CREATE TABLE pizzas (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL UNIQUE,
  prix_large NUMERIC(5,2) NOT NULL,
  prix_moyenne NUMERIC(5,2) NOT NULL,
  prix_petite NUMERIC(5,2) NOT NULL,
  dispo BOOLEAN NOT NULL DEFAULT(true)
);

CREATE TABLE menus (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL UNIQUE,
  fromage BOOLEAN NOT NULL,
  prix DECIMAL(5,2) NOT NULL
);

CREATE TABLE choix_pizzas_menu (
	id_menu INTEGER NOT NULL REFERENCES menus (id),
	id_pizza INTEGER NOT NULL REFERENCES pizzas (id)
);

CREATE TABLE desserts (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL UNIQUE,
  prix DECIMAL(5,2) NOT NULL,
  dispo BOOLEAN NOT NULL DEFAULT(true)
);

CREATE TABLE choix_desserts_menu (
	id_menu INTEGER NOT NULL REFERENCES menus (id),
	id_dessert INTEGER NOT NULL REFERENCES desserts (id)
);

CREATE TABLE clients (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL UNIQUE,
  téléphone VARCHAR(15) NULL
);

CREATE TABLE commandes (
  id SERIAL PRIMARY KEY,
  id_client INTEGER NOT NULL REFERENCES clients (id),
  montant_total DECIMAL(10,2) NOT NULL,
  date_heure_commande TIMESTAMP NOT NULL default(NOW()),
  terminée BOOLEAN NOT NULL DEFAULT(false),
  payée BOOLEAN NOT NULL DEFAULT(false)
);

CREATE TABLE menus_par_commande (
  id SERIAL PRIMARY KEY,
  id_commande INTEGER NOT NULL REFERENCES commandes (id),
  id_menu INTEGER NOT NULL REFERENCES menus (id),
  id_pizza INTEGER NULL REFERENCES pizzas (id),
  id_dessert INTEGER NULL REFERENCES desserts (id)
);

CREATE TABLE pizzas_par_commande (
  id SERIAL PRIMARY KEY,
  id_commande INTEGER NOT NULL REFERENCES commandes (id),
  id_pizza INTEGER NOT NULL REFERENCES pizzas (id),
  taille VARCHAR(255) NOT NULL
);

CREATE TABLE desserts_par_commande (
  id SERIAL PRIMARY KEY,
  id_commande INTEGER NOT NULL REFERENCES commandes (id),
  id_dessert INTEGER NOT NULL REFERENCES desserts (id)
);

CREATE TABLE boissons (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL UNIQUE,
  prix DECIMAL(5,2) NOT NULL,
  dispo BOOLEAN NOT NULL DEFAULT(true)
);

CREATE TABLE boissons_par_commande (
  id SERIAL PRIMARY KEY,
  id_commande INTEGER NOT NULL REFERENCES commandes (id),
  id_boisson INTEGER NOT NULL REFERENCES boissons (id)
);

CREATE TABLE quartiers (
   id SERIAL PRIMARY KEY,
   nom VARCHAR (255) NOT NULL UNIQUE
);

CREATE TABLE livreurs (
 id SERIAL PRIMARY KEY,
 nom VARCHAR (255) NOT NULL UNIQUE,
 téléphone VARCHAR (255) NOT NULL,
 quartier INTEGER NOT NULL REFERENCES quartiers (id),
 est_en_livraison BOOLEAN NOT NULL default (false)
);

CREATE TABLE livraisons (
  id SERIAL PRIMARY KEY,
  id_commande INTEGER NOT NULL REFERENCES commandes (id),
  id_livreur INTEGER NOT NULL REFERENCES livreurs (id),
  numéro_rue VARCHAR(255) NOT NULL,
  rue VARCHAR(255) NOT NULL,
  id_quartier INTEGER NOT NULL REFERENCES quartiers (id),
  téléphone_client VARCHAR (255) NOT NULL,
  date_heure_livraison TIMESTAMP NULL
);
