-- DROP SEQUENCE public.boissons_id_seq;
CREATE SEQUENCE public.boissons_id_seq;
-- DROP TABLE public.boissons;
CREATE TABLE IF NOT EXISTS public.boissons
(
    id integer NOT NULL DEFAULT nextval('boissons_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    prix numeric(5,2) NOT NULL,
    dispo boolean NOT NULL DEFAULT true,
    CONSTRAINT boissons_pkey PRIMARY KEY (id),
    CONSTRAINT boissons_nom_key UNIQUE (nom)
)
-- DROP SEQUENCE public.boissons_par_commande_id_seq;
CREATE SEQUENCE public.boissons_par_commande_id_seq;
-- DROP TABLE public.boissons_par_commande;
CREATE TABLE IF NOT EXISTS public.boissons_par_commande
(
    id integer NOT NULL DEFAULT nextval('boissons_par_commande_id_seq'::regclass),
    id_commande integer NOT NULL,
    id_boisson integer NOT NULL,
    CONSTRAINT boissons_par_commande_pkey PRIMARY KEY (id),
    CONSTRAINT boissons_par_commande_id_boisson_fkey FOREIGN KEY (id_boisson)
        REFERENCES public.boissons (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT boissons_par_commande_id_commande_fkey FOREIGN KEY (id_commande)
        REFERENCES public.commandes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.choix_desserts_menu;
CREATE TABLE IF NOT EXISTS public.choix_desserts_menu
(
    id_menu integer NOT NULL,
    id_dessert integer NOT NULL,
    CONSTRAINT choix_desserts_menu_id_dessert_fkey FOREIGN KEY (id_dessert)
        REFERENCES public.desserts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT choix_desserts_menu_id_menu_fkey FOREIGN KEY (id_menu)
        REFERENCES public.menus (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.clients;
CREATE TABLE IF NOT EXISTS public.clients
(
    id integer NOT NULL DEFAULT nextval('clients_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL unique,
    "téléphone" character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT clients_pkey PRIMARY KEY (id),
    CONSTRAINT clients_nom_key UNIQUE (nom)
)
-- Table: public.commandes
CREATE TABLE IF NOT EXISTS public.commandes
(
    id integer NOT NULL DEFAULT nextval('commandes_id_seq'::regclass),
    id_client integer NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    "terminée" boolean NOT NULL DEFAULT false,
    "payée" boolean NOT NULL DEFAULT false,
    CONSTRAINT commandes_pkey PRIMARY KEY (id),
    CONSTRAINT commandes_id_client_fkey FOREIGN KEY (id_client)
        REFERENCES public.clients (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.desserts;
CREATE TABLE IF NOT EXISTS public.desserts
(
    id integer NOT NULL DEFAULT nextval('desserts_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    prix numeric(5,2) NOT NULL,
    dispo boolean NOT NULL DEFAULT true,
    CONSTRAINT desserts_pkey PRIMARY KEY (id),
    CONSTRAINT desserts_nom_key UNIQUE (nom)
)
-- DROP TABLE public.desserts_par_commande;
CREATE TABLE IF NOT EXISTS public.desserts_par_commande
(
    id integer NOT NULL DEFAULT nextval('pizzas_par_commande_id_seq'::regclass),
    id_commande integer NOT NULL,
    id_dessert integer NOT NULL,
    CONSTRAINT desserts_par_commande_pkey PRIMARY KEY (id),
    CONSTRAINT desserts_par_commande_id_commande_fkey FOREIGN KEY (id_commande)
        REFERENCES public.commandes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT desserts_par_commande_id_pizza_fkey FOREIGN KEY (id_dessert)
        REFERENCES public.desserts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.livraisons;
CREATE TABLE IF NOT EXISTS public.livraisons
(
    id integer NOT NULL DEFAULT nextval('livraisons_id_seq'::regclass),
    id_commande integer NOT NULL,
    nom_livreur character varying(255) COLLATE pg_catalog."default",
    numero_rue integer NOT NULL,
    rue character varying(255) COLLATE pg_catalog."default" NOT NULL,
    quartier integer NOT NULL,
    "téléphone_client" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "terminée" boolean NOT NULL DEFAULT false,
    CONSTRAINT livraisons_pkey PRIMARY KEY (id),
    CONSTRAINT livraisons_id_commande_fkey FOREIGN KEY (id_commande)
        REFERENCES public.commandes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT livraisons_id_quartier_fkey FOREIGN KEY (quartier)
        REFERENCES public.quartiers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.livreurs;
CREATE TABLE IF NOT EXISTS public.livreurs
(
    id integer NOT NULL DEFAULT nextval('livreur_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "téléphone" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_quartier integer NOT NULL,
    est_en_livraison boolean NOT NULL DEFAULT false,
    CONSTRAINT livreur_pkey PRIMARY KEY (id),
    CONSTRAINT livreur_nom_key UNIQUE (nom),
    CONSTRAINT livreur_id_quartier_fkey FOREIGN KEY (id_quartier)
        REFERENCES public.quartiers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.menus;

CREATE TABLE IF NOT EXISTS public.menus
(
    id integer NOT NULL DEFAULT nextval('menus_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    pizza integer NOT NULL,
    fromage boolean NOT NULL,
    prix numeric(5,2) NOT NULL,
    CONSTRAINT menus_pkey PRIMARY KEY (id),
    CONSTRAINT menus_nom_key UNIQUE (nom),
    CONSTRAINT menus_pizza_fkey FOREIGN KEY (pizza)
        REFERENCES public.pizzas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.menus_par_commande;
CREATE TABLE IF NOT EXISTS public.menus_par_commande
(
    id integer NOT NULL DEFAULT nextval('menus_par_commande_id_seq'::regclass),
    id_commande integer NOT NULL,
    id_menu integer NOT NULL,
    id_dessert integer,
    CONSTRAINT menus_par_commande_pkey PRIMARY KEY (id),
    CONSTRAINT menus_par_commande_id_commande_fkey FOREIGN KEY (id_commande)
        REFERENCES public.commandes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT menus_par_commande_id_dessert_fkey FOREIGN KEY (id_dessert)
        REFERENCES public.desserts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT menus_par_commande_id_menu_fkey FOREIGN KEY (id_menu)
        REFERENCES public.menus (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.pizzas;
CREATE TABLE IF NOT EXISTS public.pizzas
(
    id integer NOT NULL DEFAULT nextval('pizzas_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    prix_large numeric(5,2) NOT NULL,
    prix_moyenne numeric(5,2) NOT NULL,
    prix_petite numeric(5,2) NOT NULL,
    dispo boolean NOT NULL DEFAULT true,
    CONSTRAINT pizzas_pkey PRIMARY KEY (id),
    CONSTRAINT pizzas_nom_key UNIQUE (nom)
)
-- DROP TABLE public.pizzas_par_commande;
CREATE TABLE IF NOT EXISTS public.pizzas_par_commande
(
    id integer NOT NULL DEFAULT nextval('pizzas_par_commande_id_seq'::regclass),
    id_commande integer NOT NULL,
    id_pizza integer NOT NULL,
    CONSTRAINT pizzas_par_commande_pkey PRIMARY KEY (id),
    CONSTRAINT pizzas_par_commande_id_commande_fkey FOREIGN KEY (id_commande)
        REFERENCES public.commandes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pizzas_par_commande_id_pizza_fkey FOREIGN KEY (id_pizza)
        REFERENCES public.pizzas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
-- DROP TABLE public.quartiers;
CREATE TABLE IF NOT EXISTS public.quartiers
(
    id integer NOT NULL DEFAULT nextval('quartiers_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT quartiers_pkey PRIMARY KEY (id),
    CONSTRAINT quartiers_nom_key UNIQUE (nom)
)