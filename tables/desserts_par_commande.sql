-- Table: public.desserts_par_commande

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

TABLESPACE pg_default;

ALTER TABLE public.desserts_par_commande
    OWNER to postgres;
