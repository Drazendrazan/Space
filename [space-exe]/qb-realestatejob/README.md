### QB-RealEstate Job for QBCore! - Made by Aljo

# Office for job was changed alittle bit, converted from https://www.gta5-mods.com/maps/jonhsons-realty-office.
# This job have own wardrobe, duty blip, vehicle spawner and boss menu.

# There are some things that need to be added to qb-houses, qb-clothing, qb-radialmenu and changed in qb-bossmenu

# qb-houses server/main.lua under Events

```lua

RegisterNetEvent('qb-houses:server:updateTier', function()
    local HouseGarages = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM houselocations', {})
    local newtier = tonumber(tier)
    if result[1] then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = json.decode(v.garage) or {}
            Config.Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {}
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
end)

RegisterNetEvent('qb-houses:server:updatePrice', function(price)
    local newprice = price
    local HouseGarages = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM houselocations', {})
    if result[1] then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = json.decode(v.garage) or {}
            Config.Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = newprice,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {}
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)    
end)

RegisterNetEvent('qb-houses:server:deletehouses', function(selectedHouse)
    local label = selectedHouse.label
    local playerhouse = selectedHouse.name
    if selectedHouse.owned == true then
        MySQL.Async.execute('DELETE FROM player_houses WHERE house=?', {playerhouse})
        housekeyholders[playerhouse] = nil
        houseowneridentifier[playerhouse] = nil
        houseownercid[playerhouse] = nil
    end
    MySQL.Async.execute('DELETE FROM houselocations WHERE label=?', {label})
    local src = source
    TriggerClientEvent('QBCore:Notify', src, "You deleted house: " .. label)
    
end)

RegisterNetEvent('qb-houses:server:Sellhouse', function(target, house)
    local src = source
    local tPlayer = QBCore.Functions.GetPlayer(target)
    if tPlayer then
        houseowneridentifier[house] = tPlayer.PlayerData.license
        houseownercid[house] = tPlayer.PlayerData.citizenid
        housekeyholders[house] = {
            [1] = tPlayer.PlayerData.citizenid
        }
        MySQL.Async.execute('UPDATE player_houses SET identifier = ? ,citizenid = ? ,keyholders = ? WHERE house = ?', {tPlayer.PlayerData.license, tPlayer.PlayerData.citizenid, json.encode(housekeyholders[house]), house})    
        TriggerClientEvent('qb-houses:client:SetClosestHouse', src)
        TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.PlayerData.source)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sold_house", {value = Config.Houses[house].adress}), 'success', 2500)
        TriggerClientEvent('QBCore:Notify', tPlayer.PlayerData.source, Lang:t("success.sold_house_target", {value = Config.Houses[house].adress}), 'success', 2500)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.something_wrong"), 'error', 2500)
    end
end)

```

# qb-houses client/main.lua under Events

```lua

RegisterNetEvent('qb-houses:client:deletehouses', function(selectedHouse)
    Config.Houses[selectedHouse.name] = nil
    SetClosestHouse()
end)

RegisterNetEvent('qb-houses:client:Sellhouse', function(id)
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 and ClosestHouse ~= nil then
        local playerId = id
        local ped = PlayerPedId()
        local pedpos = GetEntityCoords(ped)
        local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if playerId == nil then
            QBCore.Functions.Notify(Lang:t("error.no_id"), "error")
        else
            if housedist < 10 then
                TriggerServerEvent('qb-houses:server:Sellhouse', playerId, ClosestHouse)
            else
                QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
            end
        end
    elseif ClosestHouse == nil then
        QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
    else
        QBCore.Functions.Notify(Lang:t("error.no_one_near"), "error")
    end
end)
```

# qb-houses locales/en.lua under error section 

```lua
    
    ["no_id"] = "Did you forget to enter ID?",

```

# qb-houses locales/en.lua under success section

```lua
    
    ["sold_house"] = "You successfully sold your house!",
    ["sold_house_target"] = "House is now all yours!",

```

# MAKE SURE TO ADD OWN TRANSLATION IN OTHER LOCALES FILES


# qb-clothing config.lua line 50

```lua
    
    [7] = {requiredJob = "realestate", coords = vector3(-447.29, 168.25, 78.82), cameraLocation = vector4(-447.32, 166.44, 78.82,  300.44)},

```
# And line 710

```lua

    ["realestate"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "Work clothes",
                outfitData = {
                    ["pants"]       = { item = 28, texture = 0},  -- Pants
                    ["arms"]        = { item = 1, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 31, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 294, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 10, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 12, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
            },
        },
        ["female"] = {
            [1] = {
                outfitLabel = "Work clothes",
                outfitData = {
                    ["pants"]       = { item = 133, texture = 0},  -- Pants
                    ["arms"]        = { item = 31, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 35, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 34, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 48, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 0, texture = 0},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
            },
        }
    },

```

# qb-radialmenu config.lua line 572

```lua

    ["realestate"] = {
        {
            id = 'housemenu',
            title = 'List of houses',
            icon = 'laptop-house',
            type = 'client',
            event = 'qb-realestate:client:OpenHouseListMenu',
            shouldClose = true
        }
    },

```

# qb-radialmenu config.lua under general/house section

```lua

    {
        id = 'houseplayermenu',
        title = 'List of owned houses',
        icon = 'laptop-house',
        type = 'client',
        event = 'qb-realestate:client:OpenOwnedHouseListMenu',
        shouldClose = true
    },

```



# qb-bossmenu config.lua

```lua

    ['realestate'] = vector3(-450.79, 168.38, 78.82),
    
```