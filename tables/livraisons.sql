-- Table: public.livraisons

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

TABLESPACE pg_default;

ALTER TABLE public.livraisons
    OWNER to postgres;
