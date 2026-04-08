local menuOpen = {}

local function openMenu(src)
    local ping = GetPlayerPing(src)
    menuOpen[src] = true
    TriggerClientEvent("zx_fpsmenu:open", src, ping)
end


RegisterCommand(Config.Command, function(src)
    openMenu(src)
end, false)


RegisterNetEvent("zx_fpsmenu:requestOpen", function()
    local src = source
    openMenu(src)
end)

RegisterNetEvent("zx_fpsmenu:closed", function()
    local src = source
    menuOpen[src] = nil
end)

AddEventHandler("playerDropped", function()
    local src = source
    menuOpen[src] = nil
end)


Citizen.CreateThread(function()
    while true do
        for src, _ in pairs(menuOpen) do
            TriggerClientEvent("zx_fpsmenu:pingUpdate", src, GetPlayerPing(src))
        end
        Citizen.Wait(250)
    end
end)
