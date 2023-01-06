-- Table: public.pizzas

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

TABLESPACE pg_default;

ALTER TABLE public.pizzas
    OWNER to postgres;
