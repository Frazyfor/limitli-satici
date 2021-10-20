
Config = {
    Recipes = {
        ["Balık"] = {
            RequiredItems = {
                {Item = 'kofishmur', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Kömür - $15', Count = 10}
        },
        ["Kesilmiş Odun"] = {
            RequiredItems = {
                {Item = 'cutted_wood', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Kesilmiş Odun - $20', Count = 20}
        },
        ["Balık"] = {
            RequiredItems = {
                {Item = 'fish', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Çiğ Balık - $1000', Count = 1000}
        }
    }
}

Config.Limit = 15000

Config.ToptanciCoords = vector3(1441.34, 1137.92, 114.33)

Config.NPCEnable = true -- npc olup olmayacagı
Config.NPCHash = 68070371 -- npc hash kodu
Config.NPCShop = { x = -326.108, y = -1295.85, z = 30.378, h = 90.89 } -- npc nin nerede duracağı 1441.34 1137.92 114.33 90.68