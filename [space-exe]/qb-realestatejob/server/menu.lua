local QBCore = exports['qb-core']:GetCoreObject()

--Events

RegisterNetEvent('qb-realestate:server:changetier', function(tier, name, isOwned)
    local src = source
    if isOwned == 1 then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notifications.already_owned"))
    else 
        MySQL.Async.execute('UPDATE houselocations SET tier = ? WHERE name = ?', {tier, name})
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notifications.updated_tier", {label = tier}))
        Wait(200)
        TriggerEvent('qb-houses:server:updateTier', tier)
          
    end 
end)

RegisterNetEvent('qb-realestate:server:changeprice', function(price, name, isOwned)
    local src = source
    if isOwned == 1 then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notifications.already_owned_price"))
    else 
        MySQL.Async.execute('UPDATE houselocations SET price = ? WHERE name = ?', {price, name})
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notifications.updated_price", {label = price}))
        TriggerEvent('qb-houses:server:updatePrice', price)
        
    end 
end)

-- Callbacks

QBCore.Functions.CreateCallback("qb-realestate:server:GetHousesForSale", function(source, cb)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM houselocations WHERE owned = ?' , {0}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-realestate:server:GetHousesAlreadyBought", function(source, cb)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM houselocations WHERE owned = ?' , {1}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-realestate:server:GetOwners", function(source, cb, name)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM player_houses WHERE house = ?' , {name}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-realestate:server:GetOwnersName", function(source, cb, id)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM players WHERE citizenid = ?' , {id}, function(result)
    if result[1] then
        cb(result)
    else
        cb(nil)
    end
end)
end)

QBCore.Functions.CreateCallback("qb-realestate:server:GetPlayerHouses", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = Player.PlayerData.license
    MySQL.Sync.fetchAll('SELECT * FROM player_houses WHERE identifier = ?' , {license}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)