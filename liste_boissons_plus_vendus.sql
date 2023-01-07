-- liste des boisons par nb vente decroissant
select boissons.nom, count(boissons_par_commande.id) as nb
from public.boissons, boissons_par_commande 
where boissons.id = id_boisson
GROUP BY boissons.nom
ORDER BY nb desc