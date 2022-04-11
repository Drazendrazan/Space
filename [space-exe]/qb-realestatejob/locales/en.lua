local Translations = {
    notifications = {
        ["no_sale_houses"] = "No houses for sale",
        ["no_bought_houses"] = "No houses for sale",
        ["no_owned_houses"] = "You don't own any house.",
        ["tier"] = "Please enter number smaller or equal to",
        ["already_owned"] = "This house is owned by somebody. Tier cannot be changed!",
        ["already_owned_price"] = "This house is already bought. Why would you change price?",
        ["updated_tier"] = "Tier updated to: %{label}\n\n",
        ["updated_price"] = "Price updated to: %{label}\n\n",
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
        ["hire"] = "Give Someone The Real Estate Job"
    },
    housemenu = {
        ["first_header"] = "Already set houses",
        ["create_house"] = "Create new house",
        ["list_houses_header"] = "List of houses",
        ["house_category"] = "Choose category",
        ["houses_for_sale"] = "Houses for Sale",
        ["bought_houses"] = "Bought houses",
        ["owned_houses"] = "Owned houses",
        ["remove_blip"] = "Remove location",
        ["list_houses_text"] = "Here you can see all houses that are already set",
        ["list_player_houses_header"] = "List of owned houses",
        ["list_player_houses_text"] = "Here you can see all owned houses",
        ["house_list"] = "House list",
        ["no_tier"] = "Tier is not set yet",
        ["no_price"] = "Price is not set yet",
        ["no_garage"] = "Garage is not placed yet",
        ["have_garage"] = "Have garage",
        ["house_info"] = "Address: %{label} <br>Owned: %{owned} <br>Tier: %{tier} <br>Price: %{price} <br>Garage: %{garage}",
        ["no_owned_houses"] = "No owned houses",
        ["house"] = "House: %{label}\n\n",
        ["location"] = "Location",
        ["location_help"] = "Show location of house",
        ["add_garage"] = "Add garage",
        ["add_garage_help"] = "Add garage to house",
        ["change_tier"] = "Change tier",
        ["tier_change"] = "Tier Change",
        ["change_tier_help"] = "Change tier of selected house",
        ["change_price"] = "Change price",
        ["price_change"] = "Price Change",
        ["change_price_help"] = "Change price of selected house",
        ["delete_house"] = "Delete house",
        ["delete_house_help"] = "Delete selected house",
        ["house_player"] = "House: %{label}\n\n",
        ["tier"] = "Max tier: %{label}\n\n",
        ["price"] = "Price",
        ["submit"] = "Submit",
        ["sell_house"] = "Sell house",
        ["sell_house_help"] = "Sell current house",
        ["enter_id_header"] = "Enter Player ID",
        ["enter_id_text"] = "Enter ID",
        ["enter_id"] = "ID",
        ["back"] = "[<-]Back",
        ["close"] = "Close[x]",
        ["no_owner"] = "No owner"
    },
    
    jobmenu = {
        ["vehicles"] = "Vehicles",
        ["vehicle_list"] = "Vehicle list",
        ["take_out_vehicle"] = "Take out vehicle",
        ["take_out_vehicle_help"] = "Every Real Estate need his own car",
        ["take_out_vehicle"] = "Take out",
        ["back"] = "[<-]Back",
        ["close"] = "Close[x]"
    },
    blip = {
        ["selected_house"] = "Selected house",
        ["office"] = "Real Estate Office"
    },
    text = {
        ["store_vehicle"] = "[E] Store Vehicle",
        ["get_vehicle"] = "[E] Get Vehicle",
        ["on_duty"] = "[E] Off Duty",
        ["off_duty"] = "[E] On Duty"
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
