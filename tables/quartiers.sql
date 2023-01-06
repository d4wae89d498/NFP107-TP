-- Table: public.quartiers

-- DROP TABLE public.quartiers;

CREATE TABLE IF NOT EXISTS public.quartiers
(
    id integer NOT NULL DEFAULT nextval('quartiers_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT quartiers_pkey PRIMARY KEY (id),
    CONSTRAINT quartiers_nom_key UNIQUE (nom)
)

TABLESPACE pg_default;

ALTER TABLE public.quartiers
    OWNER to postgres;
