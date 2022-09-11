Config = {
    DrawDistance = 10,

    Stampanti = {
        { x = -1110.7458496094, y = -844.48376464844, z = 19.316749572754 }
    },

    ItemNecessari = {
        'cartastampa'
    },

    ItemDocumento = 'documento',

    Durata = 4000,
}

Progressbar = function()
    -- Se usi un altro tipo di Progressbar aggiungi dopo la funzione il wait
    exports.ox_inventory:Progress({
        duration = Config.Durata,
        label = IM_Lang.progressbar,
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            combat = true,
        }
    })
end

IM_Lang = {
    -- Notifiche
    ['noti_stampando'] = 'Stai stampando un documento',
    -- Errori
    ['err_nessun_link'] = 'Link non valido',
    ['err_no_item'] = 'Ti manca della carta per stampare',
    -- Progressbar
    ['progressbar'] = 'Stampando...',
    -- Help Notification
    ['help_stampante'] = '[E] - Apri stampante',
}