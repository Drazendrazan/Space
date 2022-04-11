local QBCore = exports['qb-core']:GetCoreObject()

-- GUI Functions

function MenuHouses()
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("housemenu.first_header"),
            isMenuHeader = true
        },
        {
            header = Lang:t("housemenu.create_house"),
            txt = "",
            params = {
                event = "qb-realestate:client:createhouse"
            }
        },
        {
            header = Lang:t("housemenu.list_houses_header"),
            txt = Lang:t("housemenu.list_houses_text"),
            params = {
                event = "qb-realestate:client:MenuHouseChoose"
            }
        },
        {
            header = Lang:t("housemenu.remove_blip"),
            txt = "",
            params = {
                event = "qb-realestate:client:RemoveBlip"
            }
        },
        {
            header = Lang:t("housemenu.close"),
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function MenuPlayerOwnedHouses()
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("housemenu.owned_houses"),
            isMenuHeader = true
        },
        {
            header = Lang:t("housemenu.list_player_houses_header"),
            txt = Lang:t("housemenu.list_player_houses_text"),
            params = {
                event = "qb-realestate:client:PlayerHouseList"
            }
        },
        {
            header = Lang:t("housemenu.close"),
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function titleCase( first, rest )
    return first:upper()..rest:lower()
end

-- Events

RegisterNetEvent('qb-realestate:client:OpenHouseListMenu', function()
    MenuHouses()
end)

RegisterNetEvent('qb-realestate:client:OpenOwnedHouseListMenu', function()
    MenuPlayerOwnedHouses()
end)

RegisterNetEvent('qb-realestate:client:RemoveBlip', function()
    RemoveBlip(houseblip)
    ClearGpsPlayerWaypoint()
end)

RegisterNetEvent("qb-realestate:client:MenuHouseChoose", function()
    local MenuHouseChoose = {
        {
            header = Lang:t("housemenu.house_category"),
            isMenuHeader = true
        },
    }
    MenuHouseChoose[#MenuHouseChoose+1] = {
        header = Lang:t("housemenu.houses_for_sale"),
        txt = "",
        params = {
            event = "qb-realestate:client:HouseList_Sale",
            args = data
        }
    }
    MenuHouseChoose[#MenuHouseChoose+1] = {
        header = Lang:t("housemenu.bought_houses"),
        txt = "",
        params = {
            event = "qb-realestate:client:HouseList_Bought",
            args = data
        }
    }
    MenuHouseChoose[#MenuHouseChoose+1] = {
        header = Lang:t("housemenu.back"),
        txt = "",
        params = {
            event = 'qb-realestate:client:OpenHouseListMenu',
        }
    }
    MenuHouseChoose[#MenuHouseChoose+1] = {
        header = Lang:t("housemenu.close"),
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(MenuHouseChoose)
end)

RegisterNetEvent("qb-realestate:client:HouseList_Sale", function()
    QBCore.Functions.TriggerCallback("qb-realestate:server:GetHousesForSale", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("notifications.no_bought_houses"), "error", 5000)
        else
            local MenuHouseList = {
                {
                    header = Lang:t("housemenu.house_list"),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                label = v.label
                tier = v.tier
                owned = tostring(v.owned)
                price = v.price
                garage = v.garage
                garage_coords = json.decode(garage)
                empty = false
                if not tier then
                    tier = Lang:t("housemenu.no_tier")
                end
                if owned == 1 then
                    owned = Lang:t("housemenu.no_owner")
                end
                if not price then
                    price = Lang:t("housemenu.no_price")
                end
                if garage_coords == nil then
                    garage_text = Lang:t("housemenu.no_garage")
                else
                    empty = true
                end
                if empty == true then
                    if garage_coords['x'] == 0 then
                        garage_text = Lang:t("housemenu.no_garage")
                    else
                        empty = false
                        garage_text = Lang:t("housemenu.have_garage")
                    end
                end
                MenuHouseList[#MenuHouseList+1] = {
                    header = label,
                    txt = Lang:t("housemenu.house_info", {label = label, owned = owned, tier = tier, price = price, garage = garage_text}),
                    params = {
                        event = "qb-realestate:client:HouseOptions",
                        args = v
                    }
                }
            end
            MenuHouseList[#MenuHouseList+1] = {
                header = Lang:t("housemenu.back"),
                txt = "",
                params = {
                    event = 'qb-realestate:client:MenuHouseChoose',
                }
            }
            MenuHouseList[#MenuHouseList+1] = {
                header = Lang:t("housemenu.close"),
                txt = "",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            exports['qb-menu']:openMenu(MenuHouseList)
            
        end
    end)
end)

RegisterNetEvent("qb-realestate:client:HouseList_Bought", function()
    QBCore.Functions.TriggerCallback("qb-realestate:server:GetHousesAlreadyBought", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("notifications.no_sale_houses"), "error", 5000)
        else
            local MenuHouseList = {
                {
                    header = Lang:t("housemenu.house_list"),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                label = v.label
                tier = v.tier
                price = v.price
                garage = v.garage
                garage_coords = json.decode(garage)
                empty = false
                if not tier then
                    tier = Lang:t("housemenu.no_tier")
                end
                if not price then
                    price = Lang:t("housemenu.no_price")
                end
                if garage_coords == nil then
                    garage_text = Lang:t("housemenu.no_garage")
                else
                    empty = true
                end
                if empty == true then
                    if garage_coords['x'] == 0 then
                        garage_text = Lang:t("housemenu.no_garage")
                    else
                        empty = false
                        garage_text = Lang:t("housemenu.have_garage")
                    end
                end
                QBCore.Functions.TriggerCallback("qb-realestate:server:GetOwners", function(result)
                    if result == nil then
                        --QBCore.Functions.Notify(Lang:t("notifications.no_sale_houses"), "error", 5000)
                    else
                        for k, house_name in pairs(result) do
                            QBCore.Functions.TriggerCallback("qb-realestate:server:GetOwnersName", function(result)
                                if result == nil then
                                    --QBCore.Functions.Notify(Lang:t("notifications.no_sale_houses"), "error", 5000)
                                else
                                    for k, player in pairs(result) do
                                        player.charinfo= json.decode(player.charinfo)
                                        firstname = player.charinfo.firstname
                                        lastname = player.charinfo.lastname
                                        owned = firstname.. " " ..lastname
                                        MenuHouseList[#MenuHouseList+1] = {
                                            header = label,
                                            txt = Lang:t("housemenu.house_info", {label = label, owned = owned, tier = tier, price = price, garage = garage_have}),
                                            params = {
                                                event = "qb-realestate:client:HouseBoughtOptions",
                                                args = v
                                            }
                                        }
                                        MenuHouseList[#MenuHouseList+1] = {
                                            header = Lang:t("housemenu.back"),
                                            txt = "",
                                            params = {
                                                event = 'qb-realestate:client:MenuHouseChoose',
                                            }
                                        }
                                        MenuHouseList[#MenuHouseList+1] = {
                                            header = Lang:t("housemenu.close"),
                                            txt = "",
                                            params = {
                                                event = "qb-menu:closeMenu",
                                            }
                                        }
                                        exports['qb-menu']:openMenu(MenuHouseList)
                                    end
                                end
                            end, house_name.citizenid)
                        end
                    end
                end, v.name)
            end            
        end
    end)
end)

RegisterNetEvent("qb-realestate:client:PlayerHouseList", function()
    QBCore.Functions.TriggerCallback("qb-realestate:server:GetPlayerHouses", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("notifications.no_owned_houses"), "error", 5000)
        else
            local MenuHouseOwnedList = {
                {
                    header = Lang:t("housemenu.house_list"),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                label = v.house
                MenuHouseOwnedList[#MenuHouseOwnedList+1] = {
                    header = string.gsub(label, "(%a)([%w_']*)", titleCase),
                    txt = "",
                    params = {
                        event = "qb-realestate:client:HousePlayerOptions",
                        args = v
                    }
                }
            end
            MenuHouseOwnedList[#MenuHouseOwnedList+1] = {
                header = Lang:t("housemenu.back"),
                txt = "",
                params = {
                    event = 'qb-realestate:client:OpenOwnedHouseListMenu',
                }
            }
            MenuHouseOwnedList[#MenuHouseOwnedList+1] = {
                header = Lang:t("housemenu.close"),
                txt = "",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            exports['qb-menu']:openMenu(MenuHouseOwnedList)
            
        end
    end)
end)

RegisterNetEvent("qb-realestate:client:HouseOptions", function(data)
    local MenuHouseOptions = {
        {
            header = Lang:t("housemenu.house", {label = data.label}),
            isMenuHeader = true
        },
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.location"),
        txt = Lang:t("housemenu.location_help"),
        params = {
            event = "qb-realestate:client:toHouse",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.add_garage"),
        txt = Lang:t("housemenu.add_garage_help"),
        params = {
            event = "qb-houses:client:addGarage",
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.change_tier"),
        txt = Lang:t("housemenu.change_tier_help"),
        params = {
            event = "qb-realestate:client:changetier",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.change_price"),
        txt = Lang:t("housemenu.change_price_help"),
        params = {
            event = "qb-realestate:client:changeprice",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.delete_house"),
        txt = Lang:t("housemenu.delete_house_help"),
        params = {
            event = "qb-realestate:client:deletehouses",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.back"),
        txt = "",
        params = {
            event = 'qb-realestate:client:HouseList_Sale',
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.close"),
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(MenuHouseOptions)
end)

RegisterNetEvent("qb-realestate:client:HouseBoughtOptions", function(data)
    local MenuHouseOptions = {
        {
            header = Lang:t("housemenu.house", {label = data.label}),
            isMenuHeader = true
        },
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.location"),
        txt = Lang:t("housemenu.location_help"),
        params = {
            event = "qb-realestate:client:toHouse",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.add_garage"),
        txt = Lang:t("housemenu.add_garage_help"),
        params = {
            event = "qb-houses:client:addGarage",
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.delete_house"),
        txt = Lang:t("housemenu.delete_house_help"),
        params = {
            event = "qb-realestate:client:deletehouses",
            args = data
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.back"),
        txt = "",
        params = {
            event = 'qb-realestate:client:HouseList_Bought',
        }
    }
    MenuHouseOptions[#MenuHouseOptions+1] = {
        header = Lang:t("housemenu.close"),
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(MenuHouseOptions)
end)

RegisterNetEvent("qb-realestate:client:HousePlayerOptions", function(data)
    local MenuHousePlayerOptions = {
        {
            header = Lang:t("housemenu.house_player", {label = string.gsub(data.house, "(%a)([%w_']*)", titleCase)}),
            isMenuHeader = true
        },
    }
    MenuHousePlayerOptions[#MenuHousePlayerOptions+1] = {
        header = Lang:t("housemenu.sell_house"),
        txt = Lang:t("housemenu.sell_house_help"),
        params = {
            event = "qb-realestate:client:enterid",
            args = data
        }
    }
    MenuHousePlayerOptions[#MenuHousePlayerOptions+1] = {
        header = Lang:t("housemenu.back"),
        txt = "",
        params = {
            event = 'qb-realestate:client:PlayerHouseList',
        }
    }
    MenuHousePlayerOptions[#MenuHousePlayerOptions+1] = {
        header = Lang:t("housemenu.close"),
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(MenuHousePlayerOptions)
end)

RegisterNetEvent('qb-realestate:client:enterid', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("housemenu.enter_id_header"),
        submitText = Lang:t("housemenu.enter_id_text"),
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = Lang:t("housemenu.enter_id")
            }
        }
    })
    if dialog then
        if not dialog.id then return end
        TriggerEvent('qb-houses:client:Sellhouse', tonumber(dialog.id))
    end
end)

RegisterNetEvent('qb-realestate:client:changetier', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("housemenu.tier_change"),
        submitText = Lang:t("housemenu.change_tier"),
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'tier',
                text = Lang:t("housemenu.tier", {label = Config.MaxTier})
            }
        }
    })
    if dialog then
        local tier = tonumber(dialog.tier)
        if tier < Config.MaxTier and tier >= 1 then
            if not dialog.tier then return end
            TriggerServerEvent('qb-realestate:server:changetier', dialog.tier, data.name, data.owned)
            TriggerEvent('qb-realestate:client:HouseOptions', data)
            
        else
            if not dialog.tier then return end
            --TriggerEvent('qb-realestate:client:changetier', data)
            QBCore.Functions.Notify(Lang:t("notifications.tier", {label = Config.MaxTier}), 'error')
        end
    end
end)

RegisterNetEvent('qb-realestate:client:changeprice', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("housemenu.price_change"),
        submitText = Lang:t("housemenu.change_price"),
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'price',
                text = Lang:t("housemenu.price")
            }
        }
    })
    if dialog then
        if not dialog.price then return end
        TriggerServerEvent('qb-realestate:server:changeprice', dialog.price, data.name, data.owned)
        TriggerEvent('qb-realestate:client:HouseOptions', data)
    end
end)

RegisterNetEvent('qb-realestate:client:createhouse', function()
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("housemenu.create_house"),
        submitText = Lang:t("housemenu.submit"),
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'price',
                text = Lang:t("housemenu.price")
            },
            {
                type = 'number',
                isRequired = true,
                name = 'tier',
                text = Lang:t("housemenu.tier", {label = Config.MaxTier})
            }
        }
    })
    if dialog then
        local tier = tonumber(dialog.tier)
        if tier < Config.MaxTier and tier >= 1 then
            if not dialog.price or not dialog.tier then return end
            TriggerEvent("qb-houses:client:createHouses", tonumber(dialog.price), tonumber(dialog.tier))
        else
            if not dialog.price or not dialog.tier then return end
            QBCore.Functions.Notify(Lang:t("notifications.tier", {label = Config.MaxTier}), 'error')
        end
    end
end)


RegisterNetEvent('qb-realestate:client:toHouse', function(coords)
    position = json.decode(coords.coords)
    x = position.enter.x
    y = position.enter.y
    z= position.enter.z
    SetNewWaypoint(x, y)
    local coords1 = vector3(x,y,z)
    houseblip = AddBlipForCoord(coords1)
    SetBlipSprite (houseblip, 40)
    SetBlipDisplay(houseblip, 4)
    SetBlipScale  (houseblip, 0.65)
    SetBlipAsShortRange(houseblip, true)
    SetBlipColour(houseblip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Lang:t("blip.selected_house"))
    EndTextCommandSetBlipName(houseblip)
    
end)

RegisterNetEvent('qb-realestate:client:deletehouses', function(selectedHouse)
    TriggerEvent("qb-houses:client:deletehouses", selectedHouse)
    TriggerServerEvent("qb-houses:server:deletehouses", selectedHouse)
end)

