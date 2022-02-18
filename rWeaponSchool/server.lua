local ESX

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('rWeaponSchool:getWeaponLicence', function(source, cb, type)
    local _src = source
    CheckLicense(_src, type, cb)
end)

ESX.RegisterServerCallback('rWeaponSchool:removeMoney', function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
	local getMoney = xPlayer.getMoney() 
    if getMoney >= amount then
		xPlayer.removeMoney(amount)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('rWeaponSchool:addLicence')
AddEventHandler('rWeaponSchool:addLicence', function(permis)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)

    MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
        ['@type'] = permis,
        ['@owner'] = xPlayer.identifier
    })
end)

RegisterServerEvent('rWeaponSchool:addMoney')
AddEventHandler('rWeaponSchool:addMoney', function(amount)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addMoney(amount)
end)

RegisterServerEvent('rWeaponSchool:buyWeapon')
AddEventHandler('rWeaponSchool:buyWeapon', function(weaponPrice, weaponName, weaponAmmo)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local getCash = xPlayer.getMoney()
	if getCash >= weaponPrice then
		xPlayer.removeMoney(weaponPrice)
		xPlayer.addWeapon(weaponName, weaponAmmo)
		TriggerClientEvent('esx:showAdvancedNotification', _src, 'Ammu-Nation', 'Five-Dev', "Vous venez d'acheter un ~y~"..ESX.GetWeaponLabel(weaponName).."~s~ pour "..weaponPrice.."$", 'CHAR_AMMUNATION', 9)
	end
end)

function CheckLicense(source, type, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end