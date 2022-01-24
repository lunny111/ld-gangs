--[[
 _                             _____                 _                                  _       
| |                           |  __ \               | |                                | |      
| |    _   _ _ __  _ __  _   _| |  | | _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ ___ 
| |   | | | | '_ \| '_ \| | | | |  | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __/ __|
| |___| |_| | | | | | | | |_| | |__| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_\__ \
|______\__,_|_| |_|_| |_|\__, |_____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|___/
                          __/ |                             | |                                 
                         |___/                              |_|                                 
]]



Config = {}


-- GSF

Config.Locale = "en" -- Dil.
Config.CursedWordList = {"siktir", "yarrak", "orospu çocuğu", "amcık", "orospu", "oç", "öç", "sikik", "gavat", "pezevenk", "amın evladı", "yarrağımı ye", "penis", "am", "çük", "oruspu çocuğu"}
Config.UpdateTime = 30 -- TimerEnable configi true ise drive-by yolladığınızda tekrar yollanabilmesi için kaç dakika beklemesi gerekli?

Config.GsfSinirlenme = true -- Kişiye küfür veya belirli hakaretler ettiğinizde sinirlenip size drive by atsın mı? Eğer true ise atar false ise atmaz.
Config.GsfTimerEnable = true -- Drive-by yolladığınızda tekrar yollanabilmesi için üstteki Config.UpdateTime kadar beklesin mi? Eğer true ise bekler false ise beklemez.
Config.GsfEnable = true -- Gsf'in hoodundaki gang sistemi açılsın mı? Eğer true ise açar false ise kapatır.
Config.GsfNPCEnable = true -- Npc olsun mu? Eğer true ise olur false ise olmaz.
Config.GsfJobEnabled = false -- Meslek sistemi olsun mu? Meslek sistemi sayesinde sadece aşşağıdaki mesleğe sahip olan kişiler bu npc'yi kullanabilir. Eğer true ise açılır false ise kapatılır.
Config.GsfJobName = "gsf" -- Meslek sistemini kullanıyorsanız gsf job ismi.
Config.GsfNPC = { x = -115.94, y = -1577.96, z = 33.18, h = 140.89 } -- Gsf'in hoodundaki npc'nin konumu.
Config.GsfAttackerHashKey = 0xE8594E22 -- Araçtan inen ve ateş eden npclerin hash'i.
Config.GsfNPCHash = 0xE8594E22 -- Duran npc'nin hash'i.
Config.GsfSifre = "gsf" -- Şifreyi hatırlıyor musun kısmında yazılacak şifre.
Config.GsfNPCText = "~r~[E]~w~ GSF Üyesi" -- Gsf'in hoodundaki NPC'nin üzerinde yazacak yazı.
Config.GsfNPCText2 = "Hey, merhaba dostum. Hava güzel değil mi?" -- Eğer meslek sistemi aktifse ve oyuncuda belirlediğiniz meslek yok ise npc'nin üzerinde yazılacak yazı.
Config.GsfParaMiktari = 250 -- Drive-by attırmak için kaç para gerekli?



-- Ballas
Config.BallasSinirlenme = true -- Kişiye küfür veya belirli hakaretler ettiğinizde sinirlenip size drive by atsın mı? Eğer true ise atar false ise atmaz.
Config.BallasTimerEnable = true -- Drive-by yolladığınızda tekrar yollanabilmesi için üstteki Config.UpdateTime kadar beklesin mi? Eğer true ise bekler false ise beklemez.
Config.BallasEnable = true -- Ballas'ın hoodundaki gang sistemi açılsın mı? Eğer true ise açar false ise kapatır.
Config.BallasNPCEnable = true -- Npc olsun mu? Eğer true ise olur false ise olmaz.
Config.BallasJobEnabled = false -- Meslek sistemi olsun mu? Meslek sistemi sayesinde sadece aşşağıdaki mesleğe sahip olan kişiler bu npc'yi kullanabilir. Eğer true ise açılır false ise kapatılır.
Config.BallasJobName = "ballas" -- Meslek sistemini kullanıyorsanız gsf job ismi.
Config.BallasNPC = { x = 83.9, y = -1955.31, z = 19.75, h = 320.14 } -- Ballas'ın hoodundaki npc'nin konumu.
Config.BallasAttackerHashKey = 0x231AF63F -- Araçtan inen ve ateş eden npclerin hash'i.
Config.BallasNPCHash = 0x231AF63F -- Duran npc'nin hash'i.
Config.BallasSifre = "ballas" -- Şifreyi hatırlıyor musun kısmında yazılacak şifre.
Config.BallasNPCText = "~r~[E]~w~ Ballas Üyesi" -- Ballas'ın hoodundaki NPC'nin üzerinde yazacak yazı.
Config.BallasNPCText2 = "Hey, merhaba dostum. Hava güzel değil mi?" -- Eğer meslek sistemi aktifse ve oyuncuda belirlediğiniz meslek yok ise npc'nin üzerinde yazılacak yazı.
Config.BallasParaMiktari = 250 -- Drive-by attırmak için kaç para gerekli?


-- Vagos
Config.VagosSinirlenme = true -- Kişiye küfür veya belirli hakaretler ettiğinizde sinirlenip size drive by atsın mı? Eğer true ise atar false ise atmaz.
Config.VagosTimerEnable = true -- Drive-by yolladığınızda tekrar yollanabilmesi için üstteki Config.UpdateTime kadar beklesin mi? Eğer true ise bekler false ise beklemez.
Config.VagosEnable = true -- Vagos'un hoodundaki gang sistemi açılsın mı? Eğer true ise açar false ise kapatır.
Config.VagosNPCEnable = true -- Npc olsun mu? Eğer true ise olur false ise olmaz.
Config.VagosJobEnabled = false -- Meslek sistemi olsun mu? Meslek sistemi sayesinde sadece aşşağıdaki mesleğe sahip olan kişiler bu npc'yi kullanabilir. Eğer true ise açılır false ise kapatılır.
Config.VagosJobName = "vagos" -- Meslek sistemini kullanıyorsanız gsf job ismi.
Config.VagosNPC = { x = 364.6, y = -2065.4, z = 20.74, h = 52.19 }
Config.VagosAttackerHashKey = 0x26EF3426 -- Araçtan inen ve ateş eden npclerin hash'i.
Config.VagosNPCHash = 0x26EF3426 -- Duran npc'nin hash'i.
Config.VagosSifre = "vagos" -- Şifreyi hatırlıyor musun kısmında yazılacak şifre.
Config.VagosNPCText = "~r~[E]~w~ Vagos Üyesi" -- Vagos'un hoodundaki NPC'nin üzerinde yazacak yazı.
Config.VagosNPCText2 = "Hey, merhaba dostum. Hava güzel değil mi?" -- Eğer meslek sistemi aktifse ve oyuncuda belirlediğiniz meslek yok ise npc'nin üzerinde yazılacak yazı.
Config.VagosParaMiktari = 1250 -- Drive-by attırmak için kaç para gerekli?