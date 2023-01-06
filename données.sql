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
('Glace', 3.50, true);

INSERT INTO menus (nom, pizza, fromage, prix)
VALUES 
       ('Printemps', (SELECT id FROM pizzas WHERE nom = '4 fromages'), true, 12.50),
       ('Eté', (SELECT id FROM pizzas WHERE nom = 'Pepperoni'), false, 11.50),
       ('Automne', (SELECT id FROM pizzas WHERE nom = 'Végétarienne'), true, 11.00),
       ('Hiver', (SELECT id FROM pizzas WHERE nom = 'Raclette'), true, 12.00);

INSERT INTO choix_desserts_menu (id_menu, id_dessert)
VALUES 
       ((SELECT id FROM menus WHERE nom = 'Printemps'), (SELECT id FROM desserts WHERE nom = 'Tiramisu')),
       ((SELECT id FROM menus WHERE nom = 'Eté'), (SELECT id FROM desserts WHERE nom = 'Mousse au chocolat')),
       ((SELECT id FROM menus WHERE nom = 'Automne'), (SELECT id FROM desserts WHERE nom = 'Panna cotta')),
       ((SELECT id FROM menus WHERE nom = 'Hiver'), (SELECT id FROM desserts WHERE nom = 'Glace'));

insert into quartiers VALUES (1, 'Hotel de Ville');
insert into quartiers VALUES (2, 'Bellecours-Ainay-Confluence');
insert into quartiers VALUES (3, 'Part-Dieu');
insert into quartiers VALUES (4, 'Croix Rousse');
insert into quartiers VALUES (5, 'Vieux Lyon');
insert into quartiers VALUES (6, 'Foche');
insert into quartiers VALUES (7, 'Mermoz');
insert into quartiers VALUES (8, 'Etats-Unis');


insert into livreurs VALUES (1, 'Jean Paul', 	'0644889865', 1, false);
insert into livreurs VALUES (2, 'Charles Henry', '0647942304', 2, false);
insert into livreurs VALUES (3, 'Pierre', 		'0642989584', 3, false);
insert into livreurs VALUES (4, 'Alice', 		'0652495849', 4, false);
insert into livreurs VALUES (5, 'Bob', 			'0640408952', 5, false);
insert into livreurs VALUES (6, 'Rose', 			'0740239944', 6, false);
insert into livreurs VALUES (7, 'Agathe', 		'0642342442', 7, false);
insert into livreurs VALUES (8, 'Christophe', 	'0642898753', 8, false);

insert into choix_desserts_menu(6,  7)
insert into choix_desserts_menu(7,	6)
insert into choix_desserts_menu(5,	8)
insert into choix_desserts_menu(8,	5)

-- COMMIT;
ROLLBACK;
