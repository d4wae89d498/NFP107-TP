-- Table: public.boissons_par_commande

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

TABLESPACE pg_default;

ALTER TABLE public.boissons_par_commande
    OWNER to postgres;
