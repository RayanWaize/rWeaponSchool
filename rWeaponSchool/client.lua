local ESX = nil
local weapon = nil
local ammo = nil
local run = false
local haveCode = false
local havePPAA = false

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(lib) ESX = lib end)
    while ESX == nil do Citizen.Wait(100) end
end)

-- ↓ PPA ↓ --

function menuPermis()
    local menuP = RageUI.CreateMenu("PPA", " ")
    RageUI.Visible(menuP, not RageUI.Visible(menuP))
    while menuP do
        Citizen.Wait(0)
        RageUI.IsVisible(menuP, true, true, true, function()

            
        if haveCode then
            RageUI.Separator("~g~Vous avez votre code !")
            RageUI.ButtonWithStyle("Commencer le test", nil, {RightLabel = Config.pricePermis.."$"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.TriggerServerCallback('rWeaponSchool:removeMoney', function(haveMoney)
                        if haveMoney then
                            ESX.ShowNotification("~g~GOOO !")
                            RageUI.CloseAll()
                            startTest(10)
                        else
                            ESX.ShowNotification("~r~Vous avez pas assez d'argent")
                        end
                    end, Config.pricePermis)
                end
            end)
        else
            RageUI.ButtonWithStyle("Commencer le code", nil, {RightLabel = Config.priceCode.."$"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.TriggerServerCallback('rWeaponSchool:removeMoney', function(haveMoney)
                        if haveMoney then
                            menuCode()
                        else
                            ESX.ShowNotification("~r~Vous avez pas assez d'argent")
                        end
                    end, Config.priceCode)
                end
            end)
        end

        end)
        if not RageUI.Visible(menuP) then
            menuP = RMenu:DeleteType("menuP", true)
        end
    end
end

function menuCode()
    local pts = 0
    local passagecode = RageUI.CreateMenu("Menu Examen Code", "PPA")
    local page = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
	local page2 = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
	local page3 = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
	local page4 = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
	local page5 = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
    local finish = RageUI.CreateSubMenu(passagecode, "PPA", "Code")
    RageUI.Visible(passagecode, not RageUI.Visible(passagecode))
    while passagecode do
        Citizen.Wait(0)

			RageUI.IsVisible(passagecode, true, true, true, function()

				RageUI.Separator('~b~Bienvenue !')
				RageUI.Separator('~b~Prêt pour passer votre code ?')
                RageUI.ButtonWithStyle("Oui", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page)
                RageUI.ButtonWithStyle("Non", nil, {RightLabel = "→"}, true, function(_,_,s)
					if s then
                        TriggerServerEvent('rWeaponSchool:addMoney', Config.priceCode)
                        RageUI.CloseAll()
					end
                end)
			end, function()
			end)

            RageUI.IsVisible(page, true, true, true, function()

                RageUI.Separator("~b~Pouvez vous tirée en centre ville sans raison ?")

                RageUI.ButtonWithStyle("OUI je suis sur GTAV", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page2)

                RageUI.ButtonWithStyle("Non c'est pas autorisée", nil, {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        pts = pts + 1
                    end
                end, page2)

                RageUI.ButtonWithStyle("Si la ville c'est de la merde oui", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page2)

				end, function()
				end)

                RageUI.IsVisible(page2, true, true, true, function()

                RageUI.Separator("~b~Avez vous le droit de braquée une arme sur qui que ce soit ?")

                RageUI.ButtonWithStyle("Oui je suis Lucky Luke", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page3)

                RageUI.ButtonWithStyle("Non, j'encoure une peine", nil, {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        pts = pts + 1
                    end
                end, page3)

                RageUI.ButtonWithStyle("pour chassée les rats", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page3)
        
                end, function()
                end)

                RageUI.IsVisible(page3, true, true, true, function()

                RageUI.Separator("~b~Avez le droit de sortir une arme en pleine rue ?")

                RageUI.ButtonWithStyle("Oui la ville est déserte", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page4)

                RageUI.ButtonWithStyle("Oui si la personne en face présente une menace", nil, {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        pts = pts + 1
                    end
                end, page4)

                RageUI.ButtonWithStyle("Non y'a des caméras", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page4)
        
                end, function()
                end)

                RageUI.IsVisible(page4, true, true, true, function()

				RageUI.Separator("~b~Qu'est-ce que la légitime défense ?")

                RageUI.ButtonWithStyle("Se défendre proportionnellement à l'attaque", nil, {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        pts = pts + 1
                    end
                end, page5)

                RageUI.ButtonWithStyle("C'est avoir le droit de tirée", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page5)

                RageUI.ButtonWithStyle("C'est savoir tirée", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, page5)
        
                end, function()
                end)

                RageUI.IsVisible(page5, true, true, true, function()

                RageUI.Separator("~b~Connaissez vous les risque d'une arme ?")

                RageUI.ButtonWithStyle("C'est dangereux", nil, {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        pts = pts + 1
                    end
                end, finish)

                RageUI.ButtonWithStyle("C'est dure à utilisée", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, finish)

                RageUI.ButtonWithStyle("Bah y'a pas de risque", nil, {RightLabel = "→"}, true, function(_,_,s)
                end, finish)
        
                end, function()
                end)

                RageUI.IsVisible(finish, true, true, true, function()

                    if pts >= 3 then

                        RageUI.Separator("~g~Félicitations !")
        
                        RageUI.ButtonWithStyle("Récupérer son code", nil, {RightLabel = "→"}, true, function(_,_,s)
                            if s then
								TriggerServerEvent('rWeaponSchool:addLicence', "code_weapon")
                                RageUI.CloseAll()
                            end
                        end)
        
                    else
        
                        RageUI.Separator("~r~Vous avez échoué !")
        
                        RageUI.ButtonWithStyle("Repasser votre code une prochaine fois", nil, {RightLabel = "→"}, true, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                            end
                        end)
        
                    end
        
                end, function()
                end)


        if not RageUI.Visible(passagecode) and not RageUI.Visible(page) and not RageUI.Visible(page2) and not RageUI.Visible(page3) and not RageUI.Visible(page4) and not RageUI.Visible(page5) and not RageUI.Visible(finish) then
            passagecode = RMenu:DeleteType("PPA", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        local dist = #(plyPos-Config.posPermis)
        if dist <= 10.0 then
         Timer = 0
         DrawMarker(22, Config.posPermis, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
        end
         if dist <= 3.0 then
            Timer = 0
                RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour faire le PPA", time_display = 1 })
            if IsControlJustPressed(1,51) then
                ESX.TriggerServerCallback('rWeaponSchool:getWeaponLicence', function(havePPA)
                    if havePPA then
                        ESX.ShowNotification("~g~Vous avez déjà le PPA")
                    else
                        ESX.TriggerServerCallback('rWeaponSchool:getWeaponLicence', function(havePPA)
                            if havePPA then
                                haveCode = true
                            else
                                haveCode = false
                            end
                        end, "code_weapon")
                        menuPermis()
                    end
                end, "weapon")
            end
        end
    Citizen.Wait(Timer)
 end
end)



function startTest(nb)
    run = true
    poste = 1
    inShoot = false
    ped = {}
    ped_kill = 0
    all_ped = 0
    ligne = math.random(1,4)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(Config.weaponTest),100, true, true)
    weapon = GetSelectedPedWeapon(PlayerPedId())
    ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
    while run do 
        Citizen.Wait(1)
        if not inShoot then
            place = math.random(1,6)
            poste = place
            if all_ped < nb then
                for k,v in pairs(Config.PosPed) do
                    if v.ligne == ligne and v.poste == place then
                            local Spawnpedname = GetHashKey(Config.pedModel)
                            while not HasModelLoaded(Spawnpedname) do
                                RequestModel(Spawnpedname)
                                Wait(60)
                            end
                            local Spawnped = CreatePed(9, Spawnpedname, v.x, v.y, v.z - 1, Config.PedHeading, true, false)
                            all_ped = all_ped + 1
                            table.insert(ped, Spawnped)
                            SetBlockingOfNonTemporaryEvents(Spawnped, true)
                            FreezeEntityPosition(Spawnped, true)
                    end 
                end
            else
                run = false
                RemoveWeaponFromPed(PlayerPedId(), GetHashKey(Config.weaponTest))
                Stat()
            end
            inShoot = true
        else
            for k,v in pairs(ped) do
                if IsEntityDead(v) then
                    DeleteEntity(v)
                    table.remove(ped, k)
                    ped_kill = ped_kill + 1
                    inShoot = false
                end
            end
        end
    end
    for k,v in pairs(ped) do
        DeleteEntity(v)
        table.remove(ped, k)
    end
end

function Stat()
    new_ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
    ammo_use = ammo - new_ammo
    pourcentage = ( ped_kill * 100) / ammo_use
    pourcentage = math.round(pourcentage)
    if pourcentage > 55 then
        ESX.ShowNotification("~g~Vous avez réussi le test !")
        TriggerServerEvent('rWeaponSchool:addLicence', "weapon")
    else
        ESX.ShowNotification("~r~Vous avez raté le test !")
    end
end

function Prompt(text, spinner)
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandBusyspinnerOn(spinner or 1)
end

function PromptDuration(duration, text, spinner)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        Prompt(text, spinner)
        Citizen.Wait(duration)
        if (BusyspinnerIsOn()) then
            BusyspinnerOff();
        end
    end)
end


-- ↓ Ammu-Nation ↓ --


function menuAmmu()
    local menuP = RageUI.CreateMenu('Ammu-Nation', ' ')
            RageUI.Visible(menuP, not RageUI.Visible(menuP))
            while menuP do
            Citizen.Wait(0)
            RageUI.IsVisible(menuP, true, true, true, function()
                RageUI.Separator("~y~↓ Armes Disponible ↓")

            for k,v in pairs(Config.weaponInAmmuAvecPPA) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.price.."$"}, havePPAA, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('rWeaponSchool:buyWeapon', v.price, v.name, v.ammo)
                    end
                end)
            end

            for k,v in pairs(Config.weaponInAmmuSansPPA) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.price.."$"},true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('rWeaponSchool:buyWeapon', v.price, v.name, v.ammo)
                    end
                end)
            end

            end, function()
            end)
            if not RageUI.Visible(menuP) then
            menuP = RMenu:DeleteType("menuP", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.posAmmu) do
        local dist = #(plyPos-v)
        if dist <= 10.0 then
         Timer = 0
         DrawMarker(22, v, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
        end
         if dist <= 3.0 then
            Timer = 0
                RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder a l'Ammu-Nation", time_display = 1 })
            if IsControlJustPressed(1,51) then
                ESX.TriggerServerCallback('rWeaponSchool:getWeaponLicence', function(havePPA)
                    if havePPA then
                        havePPAA = true
                        menuAmmu()
                    else
                        havePPAA = false
                        menuAmmu()
                    end
                end, "weapon")
            end
         end
        end
    Citizen.Wait(Timer)
 end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.posAmmu) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 110)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Ammu-Nation')
        EndTextCommandSetBlipName(blip)
    end
end)