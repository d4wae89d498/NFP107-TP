-- Table: public.menus

-- DROP TABLE public.menus;

CREATE TABLE IF NOT EXISTS public.menus
(
    id integer NOT NULL DEFAULT nextval('menus_id_seq'::regclass),
    nom character varying(255) COLLATE pg_catalog."default" NOT NULL,
    pizza integer NOT NULL,
    fromage boolean NOT NULL,
    prix numeric(5,2) NOT NULL,
    CONSTRAINT menus_pkey PRIMARY KEY (id),
    CONSTRAINT menus_nom_key UNIQUE (nom),
    CONSTRAINT menus_pizza_fkey FOREIGN KEY (pizza)
        REFERENCES public.pizzas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.menus
    OWNER to postgres;
