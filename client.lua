ESX = exports.es_extended:getSharedObject()

Citizen.CreateThread(function()
    while true do
        local whilee = 1000
        local coordinate = GetEntityCoords(PlayerPedId())

        for i=1, #Config.Stampanti, 1 do
            local x, y, z = Config.Stampanti[i].x, Config.Stampanti[i].y, Config.Stampanti[i].z
            if GetDistanceBetweenCoords(coordinate, x, y, z, true) < Config.DrawDistance then
                whilee = 5
                ESX.Marker(x, y, z, 'idrp')
                if GetDistanceBetweenCoords(coordinate, x, y, z, true) < 2.0 then
                    whilee = 5
                    ESX.ShowHelpNotification(IM_Lang.help_stampante)
                    if IsControlJustReleased(0, 51) then
                        ESX.TriggerServerCallback('im_stampante:possiedeitems', function(bool)
                            if bool then
                                SendNUIMessage({
                                    tipo = 'ui',
                                    stato = true,
                                })
                                SetNuiFocus(true, true)
                            else
                                ESX.ShowNotification(IM_Lang.err_no_item, 'error')
                            end
                        end)
                    end
                end
            end
        end
        Wait(whilee)
    end
end)

RegisterNUICallback('azioni', function(data)
    if data.azione == 'chiudi' then
        SendNUIMessage({
            tipo = 'ui',
            stato = false,
        })
        SendNUIMessage({
            tipo = 'foto',
            stato = false,
        })
        SetNuiFocus(false, false)
    elseif data.azione == 'stampa' then
        SetNuiFocus(false, false)
        ESX.ShowNotification(IM_Lang.noti_stampando)
        ExecuteCommand('e wait')
        Progressbar()
        ExecuteCommand('e c')
        TriggerServerEvent('im_stampante:metadatadocumento', data.link)
    elseif data.azione == 'niente_link' then
        ESX.ShowNotification(IM_Lang.err_nessun_link, 'error')
    end
end)

RegisterNetEvent('im_stampante:usadocumento')
AddEventHandler('im_stampante:usadocumento', function(linkdocumento)
    SendNUIMessage({
        tipo = 'foto',
        stato = true,
        link = linkdocumento,
    })
    SetNuiFocus(true, true)
end)