-- Table: public.livreurs

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

TABLESPACE pg_default;

ALTER TABLE public.livreurs
    OWNER to postgres;
