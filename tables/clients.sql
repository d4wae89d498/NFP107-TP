-- Table: public.clients

-- DROP TABLE public.clients;

CREATE TABLE IF NOT EXISTS public.clients
(
    id integer NOT NULL DEFAULT nextval('clients_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "téléphone" character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT clients_pkey PRIMARY KEY (id),
    CONSTRAINT clients_nom_key UNIQUE (nom)
)

TABLESPACE pg_default;

ALTER TABLE public.clients
    OWNER to postgres;
