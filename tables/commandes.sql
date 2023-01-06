-- Table: public.commandes

-- DROP TABLE public.commandes;

CREATE TABLE IF NOT EXISTS public.commandes
(
    id integer NOT NULL DEFAULT nextval('commandes_id_seq'::regclass),
    id_client integer NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    "terminée" boolean NOT NULL DEFAULT false,
    "payée" boolean NOT NULL DEFAULT false,
    CONSTRAINT commandes_pkey PRIMARY KEY (id),
    CONSTRAINT commandes_id_client_fkey FOREIGN KEY (id_client)
        REFERENCES public.clients (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.commandes
    OWNER to postgres;
