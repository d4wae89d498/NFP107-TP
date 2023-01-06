-- Table: public.menus_par_commande

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

TABLESPACE pg_default;

ALTER TABLE public.menus_par_commande
    OWNER to postgres;
