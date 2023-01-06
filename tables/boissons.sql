-- Table: public.boissons

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

TABLESPACE pg_default;

ALTER TABLE public.boissons
    OWNER to postgres;
