ESX = exports.es_extended:getSharedObject()

ESX.RegisterServerCallback('im_stampante:possiedeitems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in ipairs(Config.ItemNecessari) do
        local item = xPlayer.getInventoryItem(v)
        if item.count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

ESX.RegisterUsableItem(Config.ItemDocumento, function(source, iceman, m)
    local xPlayer  = ESX.GetPlayerFromId(source)
    if m.metadata.link ~= nil then
        TriggerClientEvent("im_stampante:usadocumento", source, m.metadata.link)
    else
        xPlayer.showNotification(IM_Lang.err_nessun_link, 'error')
    end
end)

RegisterServerEvent('im_stampante:metadatadocumento')
AddEventHandler('im_stampante:metadatadocumento', function(link)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in ipairs(Config.ItemNecessari) do
        xPlayer.removeInventoryItem(v, 1)
    end
    
    xPlayer.removeInventoryItem(Config.ItemDocumento, xPlayer.getInventoryItem(Config.ItemDocumento).count)
    xPlayer.addInventoryItem(Config.ItemDocumento, 1)

    local documento = exports.ox_inventory:Search(xPlayer.source, 1, Config.ItemDocumento, nil)

	for k, v in pairs(documento) do
		documento = v
        break
	end

	documento.metadata.type = 'Stampato il '..os.date("%d/%m %H:%M")..' da '..xPlayer.getName()
	documento.metadata.link = link

	exports.ox_inventory:SetMetadata(xPlayer.source, documento.slot, documento.metadata)
end)