
local OpenMenu      = false
local refresh       = true
local currentType   = nil
local files         = 0
local activeSetting = 0
local activeName    = "NONE"



local fps = 0
CreateThread(function()
    while true do
        fps = math.floor(1.0 / GetFrameTime())
        Wait(500)
    end
end)

local function GetFPS()
    return fps
end


local function OpenFPSMenu()
    if OpenMenu then return end
    TriggerServerEvent('zx_fpsmenu:requestOpen')
end

RegisterCommand(Config.Command, function()
    OpenFPSMenu()
end, false)

RegisterKeyMapping(Config.Command, 'Open FPS Menu', 'keyboard', Config.OpenKey)


local function CountResources()
    return GetNumResources()
end


RegisterNetEvent("zx_fpsmenu:open", function(ping)
    files = CountResources()
    OpenMenu = true

    SetNuiFocus(true, true)

    SendNUIMessage({
        action        = "display",
        ServerName    = Config.ServerName,
        SubName       = Config.SubName,
        Discord       = Config.Discord,
        Web           = Config.Web,
        Version       = Config.Version,
        Ping          = ping,
        Files         = files,
        Fps           = GetFPS(),
        ActiveSetting = activeSetting,
        ActiveName    = activeName,
    })
end)


CreateThread(function()
    while true do
        if OpenMenu then
            SendNUIMessage({
                action = "fps-update",
                Fps = GetFPS(),
            })
            Wait(500)
        else
            Wait(2000)
        end
    end
end)


RegisterNUICallback("close", function(_, cb)
    TriggerServerEvent("zx_fpsmenu:closed")
    OpenMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide" })
    cb({})
end)


RegisterNUICallback("fpschanger", function(data, cb)
    local id = tonumber(data.id)

    if id == 1 then 
        currentType = "medium"

        CascadeShadowsSetAircraftMode(false)
        CascadeShadowsEnableEntityTracker(true)
        CascadeShadowsSetDynamicDepthMode(false)

        SetFlashLightFadeDistance(3.0)
        SetLightsCutoffDistanceTweak(3.0)

    elseif id == 2 then 
        currentType = "low"

        SetTimecycleModifier('tunnel')
        RopeDrawShadowEnabled(false)

        SetFlashLightFadeDistance(5.0)
        SetLightsCutoffDistanceTweak(5.0)

    elseif id == 3 then 
        currentType = "ulow"

        SetFlashLightFadeDistance(2.0)
        SetLightsCutoffDistanceTweak(0.0)
        SetArtificialLightsState(false)
    end

    cb({})
end)



RegisterNUICallback("advancedchanger", function(data, cb)
    local id = tonumber(data.id)
    refresh = false

    if id == 1 then
        SetTimecycleModifier('yell_tunnel_nodirect')
        activeSetting = 1
        activeName = "FPS+"

    elseif id == 2 then
        SetTimecycleModifier('MP_Powerplay_blend')
        SetExtraTimecycleModifier('reflection_correct_ambient')
        RopeDrawShadowEnabled(false)
        activeSetting = 2
        activeName = "ADVANCED"

    elseif id == 3 then
        SetTimecycleModifier('tunnel')
        RopeDrawShadowEnabled(false)
        activeSetting = 3
        activeName = "LIGHT"

    elseif id == 4 then
        refresh = true
        ClearTimecycleModifier()
        ClearExtraTimecycleModifier()
        activeSetting = 4
        activeName = "ULTRA"
    end

    cb({})
end)


RegisterNUICallback("reset", function(_, cb)

    RopeDrawShadowEnabled(true)
    CascadeShadowsSetAircraftMode(true)
    CascadeShadowsEnableEntityTracker(false)
    CascadeShadowsSetDynamicDepthMode(true)

    SetFlashLightFadeDistance(10.0)
    SetLightsCutoffDistanceTweak(10.0)

    SetArtificialLightsState(false)

    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()

    refresh       = true
    currentType   = nil
    activeSetting = 0
    activeName    = "NONE"

    cb({})
end)


local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = setmetatable({handle = iter, destructor = disposeFunc}, entityEnumerator)

        repeat
            coroutine.yield(id)
            success, id = moveFunc(iter)
        until not success

        disposeFunc(iter)
    end)
end

function GetWorldPeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetWorldObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end


local function OptimizeEntities(alphaPed, alphaObj, lod)
    local processed = 0
    local max = 30

    for ped in GetWorldPeds() do
        if processed >= max then break end

        if DoesEntityExist(ped) then
            if not IsEntityOnScreen(ped) then
                SetEntityAlpha(ped, 0)
            else
                SetEntityAlpha(ped, alphaPed)
            end
            SetPedAoBlobRendering(ped, false)
            processed += 1
        end
    end

    processed = 0

    for obj in GetWorldObjects() do
        if processed >= max then break end

        if DoesEntityExist(obj) then
            if not IsEntityOnScreen(obj) then
                SetEntityAlpha(obj, 0)
            else
                SetEntityAlpha(obj, alphaObj)
            end
            processed += 1
        end
    end

    OverrideLodscaleThisFrame(lod)
end


CreateThread(function()
    while true do
        if refresh and currentType then

            if currentType == "ulow" then
                OptimizeEntities(210, 170, 0.4)
                DisableOcclusionThisFrame()
                SetDisableDecalRenderingThisFrame()
                Wait(700)

            elseif currentType == "low" then
                OptimizeEntities(210, 210, 0.6)
                SetDisableDecalRenderingThisFrame()
                Wait(800)

            elseif currentType == "medium" then
                OptimizeEntities(255, 255, 0.8)
                Wait(1000)
            end

        else
            Wait(1500)
        end
    end
end)


CreateThread(function()
    while true do
        if currentType == "ulow" or currentType == "low" then
            ClearAllHelpMessages()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()

            SetRainLevel(0.0)
            SetWindSpeed(0.0)

            Wait(1000)

        elseif currentType == "medium" then
            ClearBrief()
            SetWindSpeed(0.0)

            Wait(1500)
        else
            Wait(2000)
        end
    end
end)


RegisterNetEvent("zx_fpsmenu:pingUpdate", function(ping)
    if OpenMenu then
        SendNUIMessage({
            action = "ping-update",
            Ping   = ping,
        })
    end
end)