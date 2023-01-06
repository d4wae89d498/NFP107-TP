-- Table: public.pizzas_par_commande

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

TABLESPACE pg_default;

ALTER TABLE public.pizzas_par_commande
    OWNER to postgres;
