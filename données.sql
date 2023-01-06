-- Transaction pour insérer les données

BEGIN TRANSACTION;

INSERT INTO pizzas (nom, prix_large, prix_moyenne, prix_petite, dispo)
VALUES 
('4 fromages', 12.50, 9.50, 7.50, true),
('Margherita', 10.50, 8.50, 6.50, true),
('Pepperoni', 11.50, 9.50, 7.50, true),
('Végétarienne', 11.00, 8.50, 6.50, true),
('BBQ New York', 12.50, 9.50, 7.50, true),
('Merguez', 13.50, 10.50, 8.50, true),
('Raclette', 12.00, 9.00, 7.00, true);

INSERT INTO boissons (nom, prix, dispo)
VALUES 
('Coca', 2.00, true),
('1664', 3.00, true),
('Sprite', 2.00, true),
('Ice Tea', 2.00, true);

INSERT INTO desserts (nom, prix, dispo)
VALUES 
('Tiramisu', 3.50, true),
('Panna cotta', 3.50, true),
('Mousse au chocolat', 3.50, true),
('Glace', 3.50, true),
('Macarons crème', 4.00, true),
('Banane au whisky', 12.00, true);

INSERT INTO menus (nom, fromage, prix)
VALUES 
       ('Printemps', true, 12.50),
       ('Eté', false, 11.50),
       ('Automne', true, 11.00),
       ('Hiver', true, 12.00);

INSERT INTO choix_pizzas_menu (id_menu, id_pizza)
VALUES 
       ((SELECT id FROM menus WHERE nom = 'Printemps'), 
              (SELECT id FROM pizzas WHERE nom = 'Margherita')),
       ((SELECT id FROM menus WHERE nom = 'Eté'), 
              (SELECT id FROM pizzas WHERE nom = 'Merguez')),
       ((SELECT id FROM menus WHERE nom = 'Automne'), 
              (SELECT id FROM pizzas WHERE nom = 'BBQ New York')),
       ((SELECT id FROM menus WHERE nom = 'Hiver'), 
              (SELECT id FROM pizzas WHERE nom = '4 fromages')),
       ((SELECT id FROM menus WHERE nom = 'Hiver'), 
              (SELECT id FROM pizzas WHERE nom = 'Raclette'));


INSERT INTO choix_desserts_menu (id_menu, id_dessert)
VALUES 
       ((SELECT id FROM menus WHERE nom = 'Printemps'), 
              (SELECT id FROM desserts WHERE nom = 'Tiramisu')),
       ((SELECT id FROM menus WHERE nom = 'Eté'), 
              (SELECT id FROM desserts WHERE nom = 'Glace')),
       ((SELECT id FROM menus WHERE nom = 'Automne'), 
              (SELECT id FROM desserts WHERE nom = 'Panna cotta')),
       ((SELECT id FROM menus WHERE nom = 'Hiver'), 
              (SELECT id FROM desserts WHERE nom = 'Mousse au chocolat')),
       ((SELECT id FROM menus WHERE nom = 'Hiver'), 
              (SELECT id FROM desserts WHERE nom = 'Banane au whisky'));

insert into quartiers (id, nom) 
VALUES (1, 'Hotel de Ville'),
(2, 'Bellecours-Ainay-Confluence'),
(3, 'Part-Dieu'),
(4, 'Croix Rousse'),
(5, 'Vieux Lyon'),
(6, 'Foche'),
(7, 'Mermoz'),
(8, 'Etats-Unis');


insert into livreurs (nom, téléphone, quartier, est_en_livraison) 
VALUES 
('Jean Paul', 	'0644889865', 1, false),
('Charles Henry', '0647942304', 2, false),
('Pierre', 		'0642989584', 3, false),
('Alice', 		'0652495849', 4, false),
('Bob', 			'0640408952', 5, false),
('Rose', 			'0740239944', 6, false),
('Agathe', 		'0642342442', 7, false),
('Christophe', 	'0642898753', 8, false);


COMMIT;

select * from quartiers