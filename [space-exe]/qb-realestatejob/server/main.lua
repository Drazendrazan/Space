local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("setestate", Lang:t("chat.hire"), {{
    name = "id",
    help = Lang:t("chat.id")
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                TargetData.Functions.SetJob("realestate")
                TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                Lang:t("notifications.fired"))
                TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.hired_source", {label = TargetData.PlayerData.charinfo.firstname}))
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.provide_id"))
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.cannot_do"), "error")
    end
end)

QBCore.Commands.Add("firerealestate", Lang:t("chat.fire"), {{
    name = "id",
    help = Lang:t("chat.id")
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "realestate" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                    Lang:t("notifications.fired"))
                    TriggerClientEvent('QBCore:Notify', source,
                    Lang:t("notifications.fired_source", {label = TargetData.PlayerData.charinfo.firstname}))
                else
                    TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.not_realestate"), "error")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.provide_id"), "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.cannot_do") "error")
    end
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end