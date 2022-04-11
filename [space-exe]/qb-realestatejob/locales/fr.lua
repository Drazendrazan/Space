local Translations = {
    notifications = {
        ["no_houses"] = "Aucune maison définie",
        ["no_owned_houses"] = "Vous ne possédez aucune maison.",
        ["tier"] = "Veuillez saisir un nombre inférieur ou égal à",
        ["already_owned"] = "Cette maison appartient à quelqu'un. Le niveau ne peut pas être modifié!",
        ["already_owned_price"] = "Cette maison est déjà achetée. Pourquoi changer de prix?",
        ["updated_tier"] = "Niveau de mis à jour à: %{label}\n\n",
        ["updated_price"] = "Prix de ​​mis la jour à: %{label}\n\n",
        ["hired_source"] = "You have (%{label}) Hired As An Real Estate Agent!",
        ["hired"] = "You Were Hired As An Real Estate Agent!",
        ["fired_source"] = "You have (%{label}) Fired As Real Estate Agent!",
        ["fired"] = "You Were Fired As An Real Estate Agent!",
        ["provide_id"] = "You Must Provide A Player ID!",
        ["cannot_do"] = "You Cannot Do This!",
        ["not_realestate"] = "You're Not An Real Estate Agent!"
    },
    chat = {
        ["id"] = "ID Of The Player",
        ["fire"] = "Fire A Real Estate",
        ["hire"] = "Give Someone The Real Estate Job",
        ["no_owned_houses"] = "You don't own any house."
    },
    housemenu = {
        ["first_header"] = "Maisons déjà installées",
        ["create_house"] = "Crée une nouvelle maison",
        ["list_houses_header"] = "Listes des maisons",
        ["owned_houses"] = "Maisons possédées",
        ["remove_blip"] = "Supprimer l'emplacement",
        ["list_houses_text"] = "Ici, vous pouvez voir toutes les maisons qui sont déjà définies",
        ["list_player_houses_header"] = "Liste des maisons possédées",
        ["list_player_houses_text"] = "Ici vous pouvez voir toutes les maisons possédées",
        ["house_list"] = "Listes des maisons",
        ["no_tier"] = "Le niveau n'est pas encore défini",
        ["no_price"] = "Le prix n'est pas encore défini",
        ["no_garage"] = "Le garage n'est pas encore placé",
        ["have_garage"] = "Avoir un garage",
        ["house_info"] = "Address: %{label} <br>Owned: %{owned} <br>Tier: %{tier} <br>Price: %{price} <br>Garage: %{garage}",
        ["no_owned_houses"] = "No owned houses",
        ["house"] = "Maison/appartement: %{label}\n\n",
        ["location"] = "Position",
        ["location_help"] = "Voir la position de la maison",
        ["add_garage"] = "Ajouter un garage",
        ["add_garage_help"] = "Ajouter un garage à la maison",
        ["change_tier"] = "Changer d'etage",
        ["tier_change"] = "Etage changer",
        ["change_tier_help"] = "Changer le niveau de la maison sélectionnée",
        ["change_price"] = "Changer le prix",
        ["price_change"] = "Prix changer",
        ["change_price_help"] = "Modifier le prix de la maison sélectionnée",
        ["delete_house"] = "Supprimer la maison",
        ["delete_house_help"] = "Supprimer la maison sélectionnée",
        ["house_player"] = "Maison: %{label}\n\n",
        ["tier"] = "Etage maximum: %{label}\n\n",
        ["price"] = "Prix",
        ["submit"] = "Soumettre",
        ["sell_house"] = "Vendre la maison",
        ["sell_house_help"] = "Vendre la maison actuelle",
        ["enter_id_header"] = "Entrez l'ID du joueur",
        ["enter_id_text"] = "Entrez ID",
        ["enter_id"] = "ID",
        ["back"] = "[<-]Retour",
        ["close"] = "Fermer[x]"
    },
    
    jobmenu = {
        ["vehicles"] = "Vehicules",
        ["vehicle_list"] = "Liste des vehicules",
        ["take_out_vehicle"] = "Sortir le véhicule",
        ["take_out_vehicle_help"] = "Chaque immobilier a besoin de sa propre voiture",
        ["take_out_vehicle"] = "Sortir",
        ["back"] = "[<-]Retour",
        ["close"] = "Fermer[x]"
    },
    blip = {
        ["selected_house"] = "Selectionner une maison",
        ["office"] = "Bureau Immobilier"
    },
    text = {
        ["store_vehicle"] = "[E] Garage",
        ["get_vehicle"] = "[E] Obtenir un véhicule",
        ["on_duty"] = "[E] Hors service",
        ["off_duty"] = "[E] En service"
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
