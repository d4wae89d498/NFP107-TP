-- Table: public.choix_desserts_menu

-- DROP TABLE public.choix_desserts_menu;

CREATE TABLE IF NOT EXISTS public.choix_desserts_menu
(
    id_menu integer NOT NULL,
    id_dessert integer NOT NULL,
    CONSTRAINT choix_desserts_menu_id_dessert_fkey FOREIGN KEY (id_dessert)
        REFERENCES public.desserts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT choix_desserts_menu_id_menu_fkey FOREIGN KEY (id_menu)
        REFERENCES public.menus (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.choix_desserts_menu
    OWNER to postgres;
