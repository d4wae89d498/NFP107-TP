-- Table: public.desserts

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

TABLESPACE pg_default;

ALTER TABLE public.desserts
    OWNER to postgres;
