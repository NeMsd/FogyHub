-- ======================================================
-- FogyHub (MM2 Custom Multi-Tool)
-- Authors: MsD, Gemini
-- Credits: Kiriot22 & Felix (for Server Role logic)
-- ======================================================

-- ==================== 1. ЗАЩИТА СОВМЕСТИМОСТИ ЭКСПЛОЙТОВ ====================
local getgenv = getgenv or function()
    _G.custom_env = _G.custom_env or {}
    return _G.custom_env
end

local setclipboard = setclipboard or toclipboard or (Clipboard and Clipboard.set) or function(text)
    warn("setclipboard не поддерживается.")
    print(text)
end

-- Дефолтный язык (перезаписывается при выборе)
local currentLang = "en"

-- Словарь локализации (2 Языка)
local L = {
    en = {
        CrashTitle = "🚨 FogyHub — Crash Handler",
        CopyLog = "Copy Log",
        Copied = "Log Copied!",
        BufError = "Clipboard Error!",
        Close = "Close",
        Loaded = "FogyHub loaded!",
        FailedUI = "Failed to load WindUI library.",
        Visuals = "Visuals",
        Combat = "Combat",
        Utility = "Utility",
        MobileBinds = "Mobile Buttons",
        Radio = "Radio",
        Teleports = "Teleports",
        EspM = "ESP Murderer",
        EspS = "ESP Sheriff",
        EspI = "ESP Innocents",
        EspBoxes = "3D Box ESP (For Low-End PC)",
        Stretch = "Screen Stretch (4:3)",
        StretchForce = "Stretch Force",
        NebulaSky = "Sky: Space Nebula",
        SunsetSky = "Sky: Beautiful Sunset",
        ClassicSky = "Sky: Default Classic",
        NoFog = "Disable Map Fog",
        TimeOfDay = "Time of Day",
        AutoShoot = "Auto-Shoot Murderer",
        Aimlock = "Aimlock on Murderer",
        TpShoot = "TP Behind & Shoot",
        KillAura = "Kill Aura",
        KillAuraRange = "Kill Aura Range",
        AutoKillAll = "Auto Kill All",
        FlingM = "Fling Murderer",
        FlingS = "Fling Sheriff",
        AutoGrab = "Auto Grab Gun",
        SlideGlitch = "Infinite Speed Glitch",
        SlideSpeed = "Movement Speed",
        Noclip = "Noclip (Walk Through Walls)",
        AntiFling = "Anti-Fling",
        LockButtons = "Lock Button Positions",
        BtnScale = "Mobile Buttons Scale",
        BtnFlingM = "Button: Fling Murderer",
        BtnFlingS = "Button: Fling Sheriff",
        BtnGrab = "Button: Grab Gun",
        BtnSlide = "Button: Slide Glitch",
        BtnNoclip = "Button: Noclip",
        BtnKillAura = "Button: Kill Aura",
        BtnKillAll = "Button: Auto Kill All",
        RobloxId = "Roblox Audio ID",
        PlayId = "Play Roblox ID",
        HttpUrl = "HTTP Link to MP3 / OGG",
        PlayHttp = "Play HTTP Link",
        StopRadio = "Stop Radio",
        Volume = "Volume",
        Loop = "Loop Audio",
        NoKnife = "Knife not found!",
        NoM = "Murderer not found or dead",
        NoS = "Sheriff not found or dead",
        SitError = " is sitting (fling impossible)",
        Flinging = "Flinging: ",
        RadioNoSupport = "Your exploit does not support writefile/getcustomasset!",
        RadioDownloading = "Downloading audio file...",
        RadioHttpSuccess = "External audio started successfully!",
        RadioHttpError = "Failed to parse asset from file.",
        RadioHttpFail = "Failed to download audio file.",
        RadioCache = "Audio loaded from persistent local cache!",
        NoclipToggle = "Noclip",
        NoclipOn = "Enabled",
        NoclipOff = "Disabled",
        SpeedOn = "Enabled",
        SpeedOff = "Disabled",
        DodgeKnife = "Auto-Dodge Thrown Knife (Jump Right)",
        BtnDodgeKnife = "Button: Dodge Knife",
        TpLobby = "Teleport to Lobby",
        TpMap = "Teleport to Map",
        BtnTpLobby = "Button: TP Lobby",
        BtnTpMap = "Button: TP Map",
        NoMapLoaded = "Map not loaded yet or empty!",
        BtnAimlock = "Button: Aimlock",
        SkinChangerTitle = "Visual Skin Changer",
        SkinChangerInput = "Roblox Username",
        SkinChangerBtn = "Apply Skin",
        SkinNotFound = "Player not found!",
        SkinSuccess = "Outfit changed visually!",
    },
    ru = {
        CrashTitle = "🚨 FogyHub — Аварийное Меню",
        CopyLog = "Скопировать Лог",
        Copied = "Лог скопирован!",
        BufError = "Ошибка буфера!",
        Close = "Закрыть",
        Loaded = "FogyHub загружен!",
        FailedUI = "Не удалось загрузить библиотеку WindUI.",
        Visuals = "Визуалы",
        Combat = "Бой",
        Utility = "Утилиты",
        MobileBinds = "Тел. Кнопки",
        Radio = "Радио",
        Teleports = "Телепорты",
        EspM = "ESP Убийца (Мардер)",
        EspS = "ESP Шериф",
        EspI = "ESP Мирные жители",
        EspBoxes = "3D Бокс ESP (Для слабых читов)",
        Stretch = "Растяг экрана (4:3)",
        StretchForce = "Сила растяга",
        NebulaSky = "Небо: Космическая Туманность",
        SunsetSky = "Небо: Красивый Закат",
        ClassicSky = "Небо: Стандартное",
        NoFog = "Отключить Туман на Карте",
        TimeOfDay = "Время Суток в Игре",
        AutoShoot = "Авто-выстрел в Мардера",
        Aimlock = "Аимлок на Убийцу",
        TpShoot = "ТП за Спину & Выстрел",
        KillAura = "Килаура на игроков",
        KillAuraRange = "Радиус килауры",
        AutoKillAll = "Убить всех игроков",
        FlingM = "Флинг Убийцы",
        FlingS = "Флинг Шерифа",
        AutoGrab = "Автоподбор пистолета",
        SlideGlitch = "Бесконечный Спидглитч бега",
        SlideSpeed = "Скорость движения",
        Noclip = "Ноуклип (Проход сквозь стены)",
        AntiFling = "Анти-Флинг",
        LockButtons = "Заблокировать все кнопки",
        BtnScale = "Масштаб мобильных кнопок",
        BtnFlingM = "Кнопка: Fling Murderer",
        BtnFlingS = "Кнопка: Fling Sheriff",
        BtnGrab = "Кнопка: Grab Gun",
        BtnSlide = "Кнопка: Slide Glitch",
        BtnNoclip = "Кнопка: Noclip",
        BtnKillAura = "Кнопка: Kill Aura",
        BtnKillAll = "Кнопка: Auto Kill All",
        RobloxId = "ID Звука из Roblox",
        PlayId = "Играть по Roblox ID",
        HttpUrl = "HTTP Ссылка на MP3 / OGG файл",
        PlayHttp = "Играть по внешней ссылке",
        StopRadio = "Стоп Радио",
        Volume = "Громкость",
        Loop = "Зациклить",
        NoKnife = "Нож не найден!",
        NoM = "Убийца не найден или мертв",
        NoS = "Шериф не найден или мертв",
        SitError = " сидит (флинг невозможен)",
        Flinging = "Выбиваем: ",
        RadioNoSupport = "Ваш эксплойт не поддерживает writefile/getcustomasset!",
        RadioDownloading = "Загрузка аудиофайла...",
        RadioHttpSuccess = "Внешнее аудио успешно запущено!",
        RadioHttpError = "Не удалось преобразовать файл в ассет.",
        RadioHttpFail = "Не удалось скачать аудиофайл.",
        RadioCache = "Песня запущена из постоянного локального кэша!",
        NoclipToggle = "Noclip",
        NoclipOn = "Включен",
        NoclipOff = "Выключен",
        SpeedOn = "Включен",
        SpeedOff = "Выключен",
        DodgeKnife = "Авто-Манс от летящего ножа (Отпрыг вправо)",
        BtnDodgeKnife = "Кнопка: Уворот",
        TpLobby = "Телепорт в Лобби",
        TpMap = "Телепорт на Карту",
        BtnTpLobby = "Кнопка: ТП Лобби",
        BtnTpMap = "Кнопка: ТП Карта",
        NoMapLoaded = "Карта еще не загружена или пуста!",
        BtnAimlock = "Кнопка: Аимлок",
        SkinChangerTitle = "Визуальный скинченджер",
        SkinChangerInput = "Ник игрока для копирования",
        SkinChangerBtn = "Применить скин",
        SkinNotFound = "Игрок не найден!",
        SkinSuccess = "Скин визуально применен!",
    }
}

-- Вспомогательная функция перевода
local function T(key)
    return L[currentLang][key] or L["en"][key] or key
end

-- Безопасный выбор контейнера
local function getSafeUIContainer()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    if gethui then return gethui()
    elseif game:GetService("CoreGui") then return game:GetService("CoreGui")
    else return LocalPlayer:WaitForChild("PlayerGui", 10) end
end

-- ==================== 2. СТАБИЛЬНЫЙ CRASH HANDLER (ПОЛНОСТЬЮ ИСПРАВЛЕННЫЙ) ====================
local function showCrashMenu(err)
    local traceback = debug.traceback()
    local logText = "FogyHub Crash Log:\n" .. tostring(err) .. "\n\nTraceback:\n" .. tostring(traceback)
    warn(logText)
    
    pcall(function()
        local container = getSafeUIContainer()
        if not container then return end
        local old = container:FindFirstChild("FogyHub_CrashHandler")
        if old then old:Destroy() end
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "FogyHub_CrashHandler"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = container
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 420, 0, 280)
        mainFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        mainFrame.BorderSizePixel = 0
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = mainFrame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(231, 76, 60)
        stroke.Thickness = 1.5
        stroke.Parent = mainFrame
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 35)
        title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        title.Text = T("CrashTitle")
        title.TextColor3 = Color3.fromRGB(231, 76, 60)
        title.TextSize = 13
        title.Font = Enum.Font.SourceSansBold
        title.Parent = mainFrame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 8)
        titleCorner.Parent = title
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0.9, 0, 0, 150)
        textBox.Position = UDim2.new(0.05, 0, 0.18, 0)
        textBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
        textBox.Text = logText
        textBox.TextSize = 11
        textBox.ClearTextOnFocus = false
        textBox.TextEditable = false
        textBox.MultiLine = true
        textBox.TextWrapped = true
        textBox.TextYAlignment = Enum.TextYAlignment.Top
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.Font = Enum.Font.Code
        textBox.Parent = mainFrame
        
        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, 6)
        boxCorner.Parent = textBox
        
        local copyBtn = Instance.new("TextButton")
        copyBtn.Size = UDim2.new(0.42, 0, 0, 35)
        copyBtn.Position = UDim2.new(0.06, 0, 0.78, 0)
        copyBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
        copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        copyBtn.Text = T("CopyLog")
        copyBtn.Font = Enum.Font.SourceSansBold
        copyBtn.TextSize = 13
        copyBtn.Parent = mainFrame
        
        local copyCorner = Instance.new("UICorner")
        copyCorner.CornerRadius = UDim.new(0, 4)
        copyCorner.Parent = copyBtn
        
        copyBtn.MouseButton1Click:Connect(function()
            local success, _ = pcall(function() setclipboard(logText) end)
            if success then
                copyBtn.Text = T("Copied")
                copyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
                task.wait(2)
                copyBtn.Text = T("CopyLog")
                copyBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
            else
                copyBtn.Text = T("BufError")
                copyBtn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
            end
        end)
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0.42, 0, 0, 35)
        closeBtn.Position = UDim2.new(0.52, 0, 0.78, 0)
        closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Text = T("Close")
        closeBtn.Font = Enum.Font.SourceSansBold
        closeBtn.TextSize = 13
        closeBtn.Parent = mainFrame
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 4)
        closeCorner.Parent = closeBtn
        closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
    end)
end

-- ==================== 3. ОСНОВНОЙ КОД СКРИПТА ====================
local function main()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local Lighting = game:GetService("Lighting")
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = Players.LocalPlayer

    -- Полноценный, безопасный загрузчик WindUI
    local WindUI
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if success and result then
        WindUI = result
    else
        local fallbackSuccess, fallbackResult = pcall(function()
            return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
        end)
        if fallbackSuccess and fallbackResult then
            WindUI = fallbackResult
        end
    end
    
    if not WindUI then
        error(T("FailedUI"))
    end

    -- Глобальная конфигурация скрипта (будет сохраняться/считываться физически)
    local Config = {
        MurdererESP = false,
        SheriffESP = false,
        InnocentESP = false,
        EspBoxes = false, 
        AutoShootMurderer = false,
        AutoGrabGun = false,
        AntiFling = false,
        StretchEnabled = false,
        StretchFactor = 0.75,
        LockMobileButtons = false,
        AimlockEnabled = false,
        SlideGlitchEnabled = false,
        SlideSpeedForce = 45,
        KillAuraEnabled = false,
        KillAuraRange = 25,
        NoclipEnabled = false,
        NoFogEnabled = false,
        AutoDodgeKnife = false, 
        ButtonScale = 1.0, 
    }

    local radioModel, radioSound, currentSongId, radioVolume, radioLooped = nil, nil, "", 2, false
    local httpSongUrl = "" 
    local ScreenButtons = {} 
    local BindsScreenGui = nil 
    local originalFog = Lighting.FogEnd 
    local grabbingGun = false
    local skinChangerNick = ""

    -- Переменные серверной синхронизации ролей
    local roles = {}
    local Murder, Sheriff, Hero

    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight

    -- ==================== СИСТЕМА КОНФИГОВ (JSON СОХРАНЕНИЯ) ====================
    local configFileName = "fogyhub_settings.json"
    
    local function saveConfig()
        if writefile then
            pcall(function()
                writefile(configFileName, HttpService:JSONEncode(Config))
            end)
        end
    end
    
    local function loadConfig()
        if readfile and isfile and isfile(configFileName) then
            pcall(function()
                local loaded = HttpService:JSONDecode(readfile(configFileName))
                for k, v in pairs(loaded) do
                    if Config[k] ~= nil then
                        Config[k] = v
                    end
                end
            end)
        end
    end
    
    -- Загружаем настройки перед созданием UI
    loadConfig()

    -- Получение ScreenGui для мобильных плавающих кнопок
    local function getBindsScreenGui()
        if BindsScreenGui and BindsScreenGui.Parent then return BindsScreenGui end
        local container = getSafeUIContainer()
        if not container then return nil end
        
        BindsScreenGui = container:FindFirstChild("FogyHub_MobileBindsGui")
        if not BindsScreenGui then
            BindsScreenGui = Instance.new("ScreenGui")
            BindsScreenGui.Name = "FogyHub_MobileBindsGui"
            BindsScreenGui.ResetOnSpawn = false
            BindsScreenGui.Parent = container
        end
        return BindsScreenGui
    end

    -- Перерисовка размеров всех активных кнопок в реальном времени при изменении слайдера
    local function updateButtonSizes()
        for name, frame in pairs(ScreenButtons) do
            if frame and frame.Parent then
                local baseWidth, baseHeight = 115, 35
                local w = baseWidth * Config.ButtonScale
                local h = baseHeight * Config.ButtonScale
                frame.Size = UDim2.new(0, w, 0, h)
                
                local btn = frame:FindFirstChildOfClass("TextButton")
                if btn then
                    btn.TextSize = math.clamp(math.round(11 * Config.ButtonScale), 8, 24)
                end
            end
        end
    end

    -- Кросс-платформенный HttpGet
    local function httpGet(url)
        local success, result
        if game and game.HttpGet then
            success, result = pcall(function() return game:HttpGet(url) end)
        elseif http and http.request then
            success, result = pcall(function()
                local res = http.request({Url = url, Method = "GET"})
                return res.Body
            end)
        elseif request then
            success, result = pcall(function()
                local res = request({Url = url, Method = "GET"})
                return res.Body
            end)
        end
        if success and result and #result > 0 then
            return result
        end
        return nil
    end

    -- Генерация уникального безопасного имени файла на основе URL для физического кэширования аудио
    local function getFileNameFromUrl(url)
        local clean = url:gsub("[^%w]", "") -- Только латиница и цифры
        if #clean > 25 then
            clean = clean:sub(#clean - 24)
        end
        return "fogyhub_radio_" .. clean .. ".mp3"
    end

    -- Функция создания подсветки (Highlight) с защитой от мерцания
    local function applyHighlight(player, color)
        local character = player.Character
        if not character then return end
        
        local highlight = character:FindFirstChild("FogyHub_ESP")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "FogyHub_ESP"
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = character
        else
            if highlight.FillColor ~= color then
                highlight.FillColor = color
                highlight.OutlineColor = color
            end
            if highlight.FillTransparency ~= 0.5 then
                highlight.FillTransparency = 0.5
            end
            if highlight.DepthMode ~= Enum.HighlightDepthMode.AlwaysOnTop then
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end

    -- Функция удаления подсветки
    local function removeHighlight(player)
        local character = player.Character
        local highlight = character and character:FindFirstChild("FogyHub_ESP")
        if highlight then highlight:Destroy() end
    end

    -- 3D Box ESP на базе BoxHandleAdornment
    local function applyBoxESP(player, color)
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local box = hrp:FindFirstChild("FogyHub_BoxESP") or Instance.new("BoxHandleAdornment")
        box.Name = "FogyHub_BoxESP"
        box.Size = Vector3.new(4, 5.5, 2.5) 
        box.Color3 = color
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Transparency = 0.65
        box.Adornee = hrp
        box.Parent = hrp
    end

    local function removeBoxESP(player)
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local box = hrp and hrp:FindFirstChild("FogyHub_BoxESP")
        if box then box:Destroy() end
    end

    -- Стабильная проверка состояния "Жив" на стороне сервера MM2
    local function IsAlive(Player)
        local data = roles and roles[Player.Name]
        if data then
            return not data.Killed and not data.Dead
        end
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        return hum and hum.Health > 0
    end

    -- Вспомогательные функции для поиска Мардера и Шерифа (Мгновенно по Кэшу сервера)
    local function getMurderer()
        if Murder then
            return Players:FindFirstChild(Murder)
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local backpack = p:FindFirstChild("Backpack")
                if (backpack and backpack:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife") then
                    return p
                end
            end
        end
        return nil
    end

    local function getSheriff()
        if Sheriff then
            return Players:FindFirstChild(Sheriff)
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local backpack = p:FindFirstChild("Backpack")
                local hasGun = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or p.Character:FindFirstChild("Gun") or p.Character:FindFirstChild("Revolver")
                if hasGun then
                    return p
                end
            end
        end
        return nil
    end

    -- Прикрепление радио на спину
    local function attachRadio()
        if radioModel then radioModel:Destroy() end
        local char = LocalPlayer.Character
        local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
        if not torso then return end
        
        radioModel = Instance.new("Part")
        radioModel.Name = "ClientRadio"
        radioModel.Size = Vector3.new(2, 1, 1)
        radioModel.CanCollide = false
        radioModel.BrickColor = BrickColor.new("Bright yellow")
        radioModel.Material = Enum.Material.Metal
        
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshId = "rbxassetid://212641536"
        mesh.TextureId = "rbxassetid://212641944"
        mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
        mesh.Parent = radioModel
        
        local weld = Instance.new("Weld")
        weld.Part0 = torso
        weld.Part1 = radioModel
        weld.C0 = CFrame.new(0, 0, 0.75) * CFrame.Angles(0, math.rad(180), 0)
        weld.Parent = radioModel
        
        radioModel.Parent = char
    end

    -- Воспроизведение музыки по ID
    local function playRadio()
        if currentSongId == "" then return end
        attachRadio()
        if not radioModel then return end
        
        local sound = radioModel:FindFirstChild("RadioSound") or Instance.new("Sound", radioModel)
        sound.Name = "RadioSound"
        sound:Stop()
        sound.SoundId = "rbxassetid://" .. currentSongId
        sound.Volume = radioVolume
        sound.Looped = radioLooped
        sound:Play()
        radioSound = sound
    end

    -- Воспроизведение через внешнюю ссылку (HTTP) с ФИЗИЧЕСКИМ КЭШИРОВАНИЕМ
    local function playHttpRadio()
        if httpSongUrl == "" then return end
        if not writefile or not getcustomasset then
            WindUI:Notify({ Title = T("Radio"), Content = T("RadioNoSupport"), Icon = "x", Duration = 3 })
            return
        end
        
        local cachedFileName = getFileNameFromUrl(httpSongUrl)
        
        -- Если файл уже физически сохранен в папке чита, моментально запускаем его
        if isfile and isfile(cachedFileName) then
            local localAsset = nil
            pcall(function()
                localAsset = getcustomasset(cachedFileName)
            end)
            
            if localAsset then
                attachRadio()
                if not radioModel then return end
                local sound = radioModel:FindFirstChild("RadioSound") or Instance.new("Sound", radioModel)
                sound.Name = "RadioSound"
                sound.SoundId = localAsset
                sound.Volume = radioVolume
                sound.Looped = radioLooped
                sound:Stop() 
                sound:Play() 
                radioSound = sound
                WindUI:Notify({ Title = T("Radio"), Content = T("RadioCache"), Icon = "check", Duration = 3 })
                return
            end
        end
        
        WindUI:Notify({ Title = T("Radio"), Content = T("RadioDownloading"), Icon = "music", Duration = 3 })
        
        task.spawn(function()
            local data = httpGet(httpSongUrl)
            if data and #data > 0 then
                local writeSuccess = pcall(function() writefile(cachedFileName, data) end)
                local assetId = writeSuccess and pcall(function() return getcustomasset(cachedFileName) end) and getcustomasset(cachedFileName)
                
                if assetId then
                    attachRadio()
                    if not radioModel then return end
                    local sound = radioModel:FindFirstChild("RadioSound") or Instance.new("Sound", radioModel)
                    sound.Name = "RadioSound"
                    sound.SoundId = assetId
                    sound.Volume = radioVolume
                    sound.Looped = radioLooped
                    sound:Stop() 
                    sound:Play() 
                    radioSound = sound
                    WindUI:Notify({ Title = T("Radio"), Content = T("RadioHttpSuccess"), Icon = "check", Duration = 3 })
                else
                    WindUI:Notify({ Title = T("Radio"), Content = T("RadioHttpError"), Icon = "x", Duration = 3 })
                end
            else
                WindUI:Notify({ Title = T("Radio"), Content = T("RadioHttpFail"), Icon = "x", Duration = 3 })
            end
        end)
    end

    local function stopRadio()
        if radioSound then radioSound:Stop() end
        if radioModel then radioModel:Destroy() radioModel = nil end
    end

    -- Умный бесконфликтный автоподбор пистолета
    local function grabGun()
        if grabbingGun then return end
        grabbingGun = true
        
        local gunDrop = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)
        local handle = gunDrop and (gunDrop:FindFirstChild("Handle", true) or gunDrop:FindFirstChildOfClass("Part", true) or gunDrop)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        -- Функция проверки наличия пистолета у игрока
        local function hasGun()
            local bp = LocalPlayer:FindFirstChild("Backpack")
            return (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))) or (bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver")))
        end
        
        if handle and hrp and not hasGun() then
            local originalPos = hrp.CFrame
            local wasAnchored = hrp.Anchored
            
            local noclipConn = RunService.Stepped:Connect(function()
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
            
            hrp.Anchored = true
            local targetCFrame = handle:IsA("Model") and handle:GetPivot() or (handle:IsA("BasePart") and handle.CFrame)
            if targetCFrame then
                hrp.CFrame = targetCFrame
                char:PivotTo(targetCFrame)
                task.wait(0.1)
                
                local timeout = 0
                local altHeight = 0
                while not hasGun() and timeout < 15 do 
                    timeout = timeout + 1
                    
                    altHeight = altHeight - 0.5
                    if altHeight < -2.5 then altHeight = -2.5 end 
                    
                    hrp.Anchored = false 
                    local adjustedCFrame = targetCFrame * CFrame.new(0, altHeight, 0)
                    hrp.CFrame = adjustedCFrame
                    char:PivotTo(adjustedCFrame)
                    
                    task.wait(0.1)
                    
                    local checkGun = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)
                    if not checkGun then break end
                end
            end
            
            noclipConn:Disconnect()
            
            hrp.CFrame = originalPos
            char:PivotTo(originalPos)
            hrp.Anchored = wasAnchored
        end
        grabbingGun = false
    end

    -- Стабильная телепортация в Лобби (Обновлено на точные координаты со скриншота!)
    local function tpToLobby()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local lobby = workspace:FindFirstChild("Lobby")
        local spawnLocation = lobby and (lobby:FindFirstChild("Spawn", true) or lobby:FindFirstChildOfClass("SpawnLocation", true) or lobby:FindFirstChild("Spawns", true))
        
        if spawnLocation then
            local targetCFrame = spawnLocation:IsA("Model") and spawnLocation:GetPivot() or spawnLocation.CFrame
            hrp.CFrame = targetCFrame * CFrame.new(0, 3, 0)
        else
            -- Точные вечные координаты лобби со скриншота!
            hrp.CFrame = CFrame.new(6.0, 505.2, -35.0)
        end
    end

    -- Умный анализ геометрии активной карты и безопасное приземление
    local function tpToMap()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local center = Vector3.new(12.0, 291.7, 9040.0) 
        local normal = workspace:FindFirstChild("Normal")
        local bestPart = nil
        local minDistance = math.huge
        
        if normal then
            for _, obj in ipairs(normal:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" and obj.CanCollide then
                    local dist = (obj.Position - center).Magnitude
                    if dist < minDistance and dist < 120 then
                        minDistance = dist
                        bestPart = obj
                    end
                end
            end
        end
        
        if bestPart then
            hrp.CFrame = CFrame.new(bestPart.Position + Vector3.new(0, 3.5, 0))
        else
            local tpSuccess = false
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        local distToLobby = (p.Character.HumanoidRootPart.Position - Vector3.new(6.0, 505.2, -35.0)).Magnitude
                        if distToLobby > 150 then 
                            hrp.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                            tpSuccess = true
                            break
                        end
                    end
                end
            end
            
            if not tpSuccess then
                hrp.CFrame = CFrame.new(center + Vector3.new(0, 3.5, 0))
            end
        end
    end

    -- Локальный 3D Скинченджер по никнейму игрока
    local function changeVisualSkin(username)
        task.spawn(function()
            local success, userId = pcall(function()
                return Players:GetUserIdFromNameAsync(username)
            end)
            
            if not success or not userId then
                WindUI:Notify({ Title = T("Visuals"), Content = T("SkinNotFound"), Icon = "x", Duration = 3 })
                return
            end
            
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if char and hum then
                local descSuccess, desc = pcall(function()
                    return Players:GetHumanoidDescriptionFromUserId(userId)
                end)
                
                if descSuccess and desc then
                    local applySuccess, err = pcall(function()
                        hum:ApplyDescription(desc)
                    end)
                    
                    if applySuccess then
                        WindUI:Notify({ Title = T("Visuals"), Content = T("SkinSuccess"), Icon = "check", Duration = 3 })
                    else
                        warn("SkinChanger Error:", err)
                    end
                end
            end
        end)
    end

    local function toggleSlideGlitch()
        Config.SlideGlitchEnabled = not Config.SlideGlitchEnabled
        saveConfig()
        WindUI:Notify({ Title = T("SlideGlitch"), Content = Config.SlideGlitchEnabled and T("SpeedOn") or T("SpeedOff"), Icon = "zap", Duration = 2 })
    end

    local function toggleNoclip(state)
        Config.NoclipEnabled = state
        saveConfig()
        WindUI:Notify({ Title = T("NoclipToggle"), Content = state and T("NoclipOn") or T("NoclipOff"), Icon = "shield", Duration = 2 })
    end

    -- Смена скайбокса
    local function applySkybox(presetName)
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
        if presetName == "Classic" then return end
        
        local sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        if presetName == "Nebula" then 
            sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = "rbxassetid://159417433", "rbxassetid://159417478", "rbxassetid://159417491", "rbxassetid://159417508", "rbxassetid://159417527", "rbxassetid://159417537"
        elseif presetName == "Sunset" then 
            sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = "rbxassetid://178044738", "rbxassetid://178044772", "rbxassetid://178044793", "rbxassetid://178044810", "rbxassetid://178044825", "rbxassetid://178044857"
        end
        sky.Parent = Lighting
    end

    -- Auto Kill All
    local function autoKillAll()
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local knife = char and char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
        
        if not knife then
            WindUI:Notify({ Title = "Error", Content = T("NoKnife"), Icon = "x", Duration = 3 })
            return
        end
        
        if char and char:FindFirstChild("HumanoidRootPart") then
            local originalPos = char.HumanoidRootPart.CFrame
            if knife.Parent == bp then char.Humanoid:EquipTool(knife) end
            
            for _, victim in ipairs(Players:GetPlayers()) do
                if victim ~= LocalPlayer and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
                    local vHum = victim.Character:FindFirstChildOfClass("Humanoid")
                    if vHum and vHum.Health > 0 then
                        char.HumanoidRootPart.CFrame = victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.2)
                        task.wait(0.04)
                        knife:Activate()
                        pcall(function()
                            firetouchinterest(victim.Character.HumanoidRootPart, knife.Handle, 0)
                            firetouchinterest(victim.Character.HumanoidRootPart, knife.Handle, 1)
                        end)
                        task.wait(0.04)
                    end
                end
            end
            char.HumanoidRootPart.CFrame = originalPos
        end
    end

    -- SkidFling
    local function flingPlayer(targetPlayer)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = targetPlayer.Character
        if not TCharacter then return end
        
        local THumanoid, TRootPart, THead, Accessory, Handle
        if TCharacter:FindFirstChildOfClass("Humanoid") then THumanoid = TCharacter:FindFirstChildOfClass("Humanoid") end
        if THumanoid and THumanoid.RootPart then TRootPart = THumanoid.RootPart end
        if TCharacter:FindFirstChild("Head") then THead = TCharacter.Head end
        if TCharacter:FindFirstChildOfClass("Accessory") then Accessory = TCharacter:FindFirstChildOfClass("Accessory") end
        if Accessory and Accessory:FindFirstChild("Handle") then Handle = Accessory.Handle end
        
        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then getgenv().OldPos = RootPart.CFrame end
            if THumanoid and THumanoid.Sit then
                return WindUI:Notify({ Title = "Error", Content = targetPlayer.Name .. T("SitError"), Icon = "x", Duration = 2 })
            end
            
            if THead then workspace.CurrentCamera.CameraSubject = THead
            elseif Handle then workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then workspace.CurrentCamera.CameraSubject = THumanoid end
            
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
            
            local FPos = function(BasePart, Pos, Ang)
                local targetCFrame = CFrame.new(BasePart.Position) * Pos * Ang
                RootPart.CFrame = targetCFrame
                Character:PivotTo(targetCFrame)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
            
            local SFBasePart = function(BasePart)
                local TimeToWait, Time, Angle = 1.5, tick(), 0
                repeat
                    if RootPart and THumanoid then
                        if BasePart.Velocity.Magnitude < 50 then
                            Angle = Angle + 100
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    end
                until Time + TimeToWait < tick() or not BasePart.Parent
            end
            
            getgenv().FPDH = workspace.FallenPartsDestroyHeight
            workspace.FallenPartsDestroyHeight = -50000
            
            local BV = Instance.new("BodyVelocity")
            BV.Parent, BV.Velocity, BV.MaxForce = RootPart, Vector3.new(0, 0, 0), Vector3.new(9e9, 9e9, 9e9)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            local stepConn = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
            
            if TRootPart then SFBasePart(TRootPart) elseif THead then SFBasePart(THead) elseif Handle then SFBasePart(Handle) end
            
            stepConn:Disconnect() BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid
            
            if getgenv().OldPos then
                repeat
                    local targetCFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    RootPart.CFrame = targetCFrame Character:PivotTo(targetCFrame)
                    Humanoid:ChangeState("GettingUp")
                    for _, part in pairs(Character:GetChildren()) do
                        if part:IsA("BasePart") then part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new() end
                    end
                    task.wait()
                until (RootPart.Position - getgenv().OldPos.Position).Magnitude < 25
                workspace.FallenPartsDestroyHeight = getgenv().FPDH
            end
        end
    end

    -- ==================== ИСПРАВЛЕННЫЕ ПЛАВАЮЩИЕ КНОПОК ====================
    local function createFloatingButton(name, translationKey, callback)
        if ScreenButtons[name] then ScreenButtons[name]:Destroy() end
        local sg = getBindsScreenGui()
        if not sg then return end
        
        local frame = Instance.new("Frame")
        frame.Name = name .. "_Frame"
        
        local baseWidth, baseHeight = 115, 35
        local w = baseWidth * Config.ButtonScale
        local h = baseHeight * Config.ButtonScale
        frame.Size = UDim2.new(0, w, 0, h)
        
        local offsets = {
            ["Fling Murderer"] = 100, ["Fling Sheriff"] = 145, ["Grab Gun"] = 190,
            ["Slide Glitch"] = 280, ["Noclip"] = 325, ["Kill Aura"] = 370,
            ["Auto Kill All"] = 415, ["Godmode"] = 460, ["TP Lobby"] = 505, 
            ["TP Map"] = 550, ["Aimlock"] = 595
        }
        frame.Position = UDim2.new(0.04, 0, 0, offsets[name] or 100)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 1
        frame.BorderColor3 = Color3.fromRGB(0, 150, 255)
        frame.Active = true
        frame.Parent = sg
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = T(translationKey)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = math.clamp(math.round(11 * Config.ButtonScale), 8, 24)
        btn.Parent = frame
        
        btn.Activated:Connect(callback)
        
        local dragging = false
        local dragStart, startPos
        
        local function startDrag(input)
            dragging, dragStart, startPos = true, input.Position, frame.Position
        end
        
        frame.InputBegan:Connect(function(input)
            if not Config.LockMobileButtons and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                startDrag(input)
            end
        end)
        
        btn.InputBegan:Connect(function(input)
            if not Config.LockMobileButtons and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                startDrag(input)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        ScreenButtons[name] = frame
    end

    local function removeFloatingButton(name)
        if ScreenButtons[name] then ScreenButtons[name]:Destroy() ScreenButtons[name] = nil end
    end

    -- ==================== СОЗДАНИЕ ИНТЕРФЕЙСА FOGYHUB ====================
    local Window = WindUI:CreateWindow({
        Title = "FogyHub MM2", Author = "Gemini & MsD", Folder = "fogyhub_mm2", Icon = "shield", Theme = "Dark", Size = UDim2.fromOffset(580, 460)
    })
    pcall(function() Window:SetToggleKey(Enum.KeyCode.RightShift) end)

    local VisualsTab = Window:Tab({ Title = T("Visuals"), Icon = "eye" })
    local CombatTab = Window:Tab({ Title = T("Combat"), Icon = "swords" })
    local UtilityTab = Window:Tab({ Title = T("Utility"), Icon = "zap" })
    local TeleportsTab = Window:Tab({ Title = T("Teleports"), Icon = "map-pin" }) 
    local ButtonsTab = Window:Tab({ Title = T("MobileBinds"), Icon = "smartphone" })
    local RadioTab = Window:Tab({ Title = T("Radio"), Icon = "music" })

    -- Вкладка Визуалы
    VisualsTab:Toggle({ Title = T("EspM"), Value = Config.MurdererESP, Callback = function(s) Config.MurdererESP = s saveConfig() end })
    VisualsTab:Toggle({ Title = T("EspS"), Value = Config.SheriffESP, Callback = function(s) Config.SheriffESP = s saveConfig() end })
    VisualsTab:Toggle({ Title = T("EspI"), Value = Config.InnocentESP, Callback = function(s) Config.InnocentESP = s saveConfig() end })
    VisualsTab:Toggle({ Title = T("EspBoxes"), Value = Config.EspBoxes, Callback = function(s) Config.EspBoxes = s saveConfig() end })
    
    local stretchConnection = nil
    VisualsTab:Toggle({
        Title = T("Stretch"), Value = Config.StretchEnabled, Callback = function(state)
            Config.StretchEnabled = state
            saveConfig()
            if not state then
                if stretchConnection then stretchConnection:Disconnect() stretchConnection = nil end
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame
                return
            end
            stretchConnection = RunService.RenderStepped:Connect(function()
                local camera = workspace.CurrentCamera
                if camera then camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, Config.StretchFactor, 0, 0, 0, 1) end
            end)
        end
    })
    VisualsTab:Slider({ Title = T("StretchForce"), Step = 0.05, Value = { Min = 0.5, Max = 1, Default = Config.StretchFactor }, Callback = function(v) Config.StretchFactor = v saveConfig() end })
    VisualsTab:Button({ Title = T("NebulaSky"), Callback = function() applySkybox("Nebula") end })
    VisualsTab:Button({ Title = T("SunsetSky"), Callback = function() applySkybox("Sunset") end })
    VisualsTab:Button({ Title = T("ClassicSky"), Callback = function() applySkybox("Classic") end })
    VisualsTab:Toggle({ Title = T("NoFog"), Value = Config.NoFogEnabled, Callback = function(s) Config.NoFogEnabled = s saveConfig() Lighting.FogEnd = s and 9e9 or originalFog end })
    VisualsTab:Slider({ Title = T("TimeOfDay"), Step = 1, Value = { Min = 0, Max = 24, Default = 14 }, Callback = function(v) Lighting.TimeOfDay = string.format("%02d:00:00", v) end })
    
    -- Локальный Скинченджер
    VisualsTab:Input({ Title = T("SkinChangerInput"), Value = "", Placeholder = "Roblox Username...", Callback = function(t) skinChangerNick = t end })
    VisualsTab:Button({ Title = T("SkinChangerBtn"), Callback = function() changeVisualSkin(skinChangerNick) end })

    -- Вкладка Бой
    CombatTab:Toggle({ Title = T("AutoShoot"), Value = Config.AutoShootMurderer, Callback = function(s) Config.AutoShootMurderer = s saveConfig() end })
    CombatTab:Toggle({ Title = T("Aimlock"), Value = Config.AimlockEnabled, Callback = function(s) Config.AimlockEnabled = s saveConfig() end })
    
    -- Авто-уклонение от ножей
    local lastDodgeTime = 0
    CombatTab:Toggle({ Title = T("DodgeKnife"), Value = Config.AutoDodgeKnife, Callback = function(state) Config.AutoDodgeKnife = state saveConfig() end }) 
    
    CombatTab:Toggle({ Title = T("KillAura"), Value = Config.KillAuraEnabled, Callback = function(s) Config.KillAuraEnabled = s saveConfig() end })
    CombatTab:Slider({ Title = T("KillAuraRange"), Step = 5, Value = { Min = 10, Max = 45, Default = Config.KillAuraRange }, Callback = function(v) Config.KillAuraRange = v saveConfig() end })
    CombatTab:Button({ Title = T("AutoKillAll"), Callback = autoKillAll })
    CombatTab:Button({ Title = T("FlingM"), Callback = function() local m = getMurderer() if m then flingPlayer(m) else WindUI:Notify({ Title = "Error", Content = T("NoM"), Icon = "x", Duration = 3 }) end end })
    CombatTab:Button({ Title = T("FlingS"), Callback = function() local s = getSheriff() if s then flingPlayer(s) else WindUI:Notify({ Title = "Error", Content = T("NoS"), Icon = "x", Duration = 3 }) end end })

    -- Вкладка Утилиты
    UtilityTab:Toggle({ Title = T("AutoGrab"), Value = Config.AutoGrabGun, Callback = function(s) Config.AutoGrabGun = s saveConfig() end })
    UtilityTab:Toggle({ Title = T("SlideGlitch"), Value = Config.SlideGlitchEnabled, Callback = function(s) Config.SlideGlitchEnabled = s saveConfig() end })
    UtilityTab:Slider({ Title = T("SlideSpeed"), Step = 5, Value = { Min = 15, Max = 100, Default = Config.SlideSpeedForce }, Callback = function(v) Config.SlideSpeedForce = v saveConfig() end })
    UtilityTab:Toggle({ Title = T("Noclip"), Value = Config.NoclipEnabled, Callback = toggleNoclip })
    
    local antiFlingConnection = nil
    UtilityTab:Toggle({
        Title = T("AntiFling"), Value = Config.AntiFling, Callback = function(state)
            Config.AntiFling = state
            saveConfig()
            if not state then
                if antiFlingConnection then antiFlingConnection:Disconnect() antiFlingConnection = nil end
                return
            end
            antiFlingConnection = RunService.Stepped:Connect(function()
                if not Config.AntiFling then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, part in ipairs(p.Character:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = false end
                        end
                    end
                end
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp.Velocity.Magnitude > 100 then hrp.Velocity, hrp.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0) end
            end)
        end
    })

    -- Вкладка Телепорты
    TeleportsTab:Button({ Title = T("TpLobby"), Callback = tpToLobby })
    TeleportsTab:Button({ Title = T("TpMap"), Callback = tpToMap })

    -- Вкладка Тел. Кнопки
    ButtonsTab:Toggle({ Title = T("LockButtons"), Value = Config.LockMobileButtons, Callback = function(s) Config.LockMobileButtons = s saveConfig() end })
    ButtonsTab:Slider({ Title = T("BtnScale"), Step = 0.1, Value = { Min = 0.5, Max = 2.0, Default = Config.ButtonScale }, Callback = function(v) Config.ButtonScale = v saveConfig() updateButtonSizes() end }) -- Слайдер размера
    ButtonsTab:Toggle({ Title = T("BtnFlingM"), Value = false, Callback = function(s) if s then createFloatingButton("Fling Murderer", "FlingM", function() local m = getMurderer() if m then flingPlayer(m) end end) else removeFloatingButton("Fling Murderer") end end })
    ButtonsTab:Toggle({ Title = T("BtnFlingS"), Value = false, Callback = function(s) if s then createFloatingButton("Fling Sheriff", "FlingS", function() local sh = getSheriff() if sh then flingPlayer(s) end end) else removeFloatingButton("Fling Sheriff") end end })
    ButtonsTab:Toggle({ Title = T("BtnGrab"), Value = false, Callback = function(s) if s then createFloatingButton("Grab Gun", "AutoGrab", grabGun) else removeFloatingButton("Grab Gun") end end })
    ButtonsTab:Toggle({ Title = T("BtnSlide"), Value = false, Callback = function(s) if s then createFloatingButton("Slide Glitch", "SlideGlitch", toggleSlideGlitch) else removeFloatingButton("Slide Glitch") end end })
    ButtonsTab:Toggle({ Title = T("BtnNoclip"), Value = false, Callback = function(s) if s then createFloatingButton("Noclip", "Noclip", function() toggleNoclip(not Config.NoclipEnabled) end) else removeFloatingButton("Noclip") end end })
    ButtonsTab:Toggle({ Title = T("BtnKillAura"), Value = false, Callback = function(s) if s then createFloatingButton("Kill Aura", "KillAura", function() Config.KillAuraEnabled = not Config.KillAuraEnabled WindUI:Notify({ Title = "Kill Aura", Content = Config.KillAuraEnabled and T("NoclipOn") or T("NoclipOff"), Icon = "swords", Duration = 2 }) end) else removeFloatingButton("Kill Aura") end end })
    ButtonsTab:Toggle({ Title = T("BtnKillAll"), Value = false, Callback = function(s) if s then createFloatingButton("Auto Kill All", "AutoKillAll", autoKillAll) else removeFloatingButton("Auto Kill All") end end })
    ButtonsTab:Toggle({ Title = T("BtnGodMode"), Value = false, Callback = function(s) if s then createFloatingButton("Godmode", "GodMode", function() Config.AutoDodgeKnife = not Config.AutoDodgeKnife WindUI:Notify({ Title = "Auto Dodge", Content = Config.AutoDodgeKnife and T("NoclipOn") or T("NoclipOff"), Icon = "shield", Duration = 2 }) end) else removeFloatingButton("Godmode") end end })
    ButtonsTab:Toggle({ Title = T("BtnTpLobby"), Value = false, Callback = function(s) if s then createFloatingButton("TP Lobby", "TpLobby", tpToLobby) else removeFloatingButton("TP Lobby") end end }) 
    ButtonsTab:Toggle({ Title = T("BtnTpMap"), Value = false, Callback = function(s) if s then createFloatingButton("TP Map", "TpMap", tpToMap) else removeFloatingButton("TP Map") end end }) 
    ButtonsTab:Toggle({ Title = T("BtnAimlock"), Value = false, Callback = function(s) if s then createFloatingButton("Aimlock", "Aimlock", function() Config.AimlockEnabled = not Config.AimlockEnabled WindUI:Notify({ Title = "Aimlock", Content = Config.AimlockEnabled and T("NoclipOn") or T("NoclipOff"), Icon = "eye", Duration = 2 }) end) else removeFloatingButton("Aimlock") end end }) 

    -- Вкладка Радио
    local radioInput = RadioTab:Input({ Title = T("RobloxId"), Value = "", Placeholder = "ID...", Callback = function(text) currentSongId = text end })
    RadioTab:Button({ Title = T("PlayId"), Callback = playRadio })
    local httpInput = RadioTab:Input({ Title = T("HttpUrl"), Value = "", Placeholder = "https://...", Callback = function(text) httpSongUrl = text end })
    RadioTab:Button({ Title = T("PlayHttp"), Callback = playHttpRadio })
    RadioTab:Button({ Title = T("StopRadio"), Callback = stopRadio })
    RadioTab:Slider({ Title = T("Volume"), Step = 0.5, Value = { Min = 0, Max = 10, Default = 2 }, Callback = function(v) radioVolume = v if radioSound then radioSound.Volume = v end end })
    RadioTab:Toggle({ Title = T("Loop"), Value = false, Callback = function(s) radioLooped = s if radioSound then radioSound.Looped = s end end })

    -- ==================== ФОНОВЫЕ ЦИКЛЫ И ПРОСЛУШИВАТЕЛИ ====================
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local success, keyStr = pcall(function() return input.KeyCode and input.KeyCode.Name end)
            if success and keyStr then
                if keyStr == "F" then local m = getMurderer() if m then flingPlayer(m) end
                elseif keyStr == "G" then local s = getSheriff() if s then flingPlayer(s) end
                elseif keyStr == "T" then grabGun()
                elseif keyStr == "C" then toggleSlideGlitch()
                elseif keyStr == "V" then toggleNoclip(not Config.NoclipEnabled) end
            end
        end
    end)

    -- Цикл ESP (Фоновый опрос роли и статуса с сервера раз в 0.3 сек для максимальной оптимизации сети)
    task.spawn(function()
        while true do
            local success, serverRoles = pcall(function()
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true)
                return remote and remote:InvokeServer()
            end)
            
            if success and serverRoles then
                roles = serverRoles
                Murder, Sheriff, Hero = nil, nil, nil
                for i, v in pairs(roles) do
                    if v.Role == "Murderer" then
                        Murder = i
                    elseif v.Role == "Sheriff" then
                        Sheriff = i
                    elseif v.Role == "Hero" then
                        Hero = i
                    end
                end
            end
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    local isM, isS, isH = false, false, false
                    local alive = IsAlive(player)
                    
                    -- Определение ролей на основе серверных API данных
                    if player.Name == Murder and alive then
                        isM = true
                    elseif player.Name == Sheriff and alive then
                        isS = true
                    elseif player.Name == Hero and alive then
                        local sheriffPlayer = Sheriff and Players:FindFirstChild(Sheriff)
                        -- Если Шериф мертв, красим Героя в желтый. Если жив — считаем его мирным.
                        if sheriffPlayer and not IsAlive(sheriffPlayer) then
                            isH = true
                        end
                    end
                    
                    -- Проверка нахождения зрителей на спавне лобби
                    local inLobby = false
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local distToLobby = (character.HumanoidRootPart.Position - Vector3.new(6.0, 505.2, -35.0)).Magnitude
                        if distToLobby < 150 then
                            inLobby = true
                        end
                    end
                    
                    -- Отрисовка ESP цветов в зависимости от условий
                    if not alive or inLobby then
                        -- Мертвые или наблюдатели в лобби подсвечиваются серым
                        if Config.MurdererESP or Config.SheriffESP or Config.InnocentESP then
                            applyHighlight(player, Color3.fromRGB(150, 150, 150))
                        else
                            removeHighlight(player)
                        end
                        if Config.EspBoxes then
                            applyBoxESP(player, Color3.fromRGB(150, 150, 150))
                        else
                            removeBoxESP(player)
                        end
                    else
                        -- Активные выжившие на карте красятся по своим ролям
                        local renderColor = Color3.fromRGB(0, 255, 0) -- Зеленый по умолчанию
                        
                        if isM then
                            renderColor = Color3.fromRGB(255, 0, 0) -- Красный (Мардер)
                        elseif isS then
                            renderColor = Color3.fromRGB(0, 0, 255) -- Синий (Шериф)
                        elseif isH then
                            renderColor = Color3.fromRGB(255, 250, 0) -- Желтый (Герой)
                        end
                        
                        if (isM and Config.MurdererESP) or (isS and Config.SheriffESP) or (not isM and not isS and Config.InnocentESP) or (isH and Config.SheriffESP) then
                            applyHighlight(player, renderColor)
                        else
                            removeHighlight(player)
                        end

                        if (isM and Config.EspBoxes) or (isS and Config.EspBoxes) or (not isM and not isS and Config.EspBoxes) or (isH and Config.EspBoxes) then
                            applyBoxESP(player, renderColor)
                        else
                            removeBoxESP(player)
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)

    -- Цикл автоподбора
    task.spawn(function()
        while true do
            task.wait(0.2)
            if Config.AutoGrabGun and workspace:FindFirstChild("GunDrop") then grabGun() task.wait(1) end
        end
    end)

    -- Цикл авто-выстрела
    task.spawn(function()
        while true do
            task.wait(0.1)
            if Config.AutoShootMurderer then
                local char = LocalPlayer.Character
                local gun = char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))
                if gun then
                    local m = getMurderer()
                    if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, m.Character.HumanoidRootPart.Position)
                        fireGun(gun, m.Character.HumanoidRootPart.Position) 
                    end
                end
            end
        end
    end)

    -- Аимлок
    RunService.RenderStepped:Connect(function()
        if Config.AimlockEnabled then
            local m = getMurderer()
            if m and m.Character and m.Character:FindFirstChild("Head") then
                local camera = workspace.CurrentCamera
                if camera then camera.CFrame = CFrame.new(camera.CFrame.Position, m.Character.Head.Position) end
            end
        end
    end)

    -- Бесконечный спидглитч
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and hum and Config.SlideGlitchEnabled and hum.MoveDirection.Magnitude > 0 then
            local slideVector = Vector3.new(hum.MoveDirection.X, 0, hum.MoveDirection.Z).Unit
            hrp.CFrame = hrp.CFrame + (slideVector * (Config.SlideSpeedForce / 100))
        end
    end)

    -- Kill Aura
    RunService.Heartbeat:Connect(function()
        if not Config.KillAuraEnabled then return end
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local knife = char and char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
        
        if knife and char and char:FindFirstChild("HumanoidRootPart") then
            if knife.Parent == bp then char.Humanoid:EquipTool(knife) end
            for _, victim in ipairs(Players:GetPlayers()) do
                if victim ~= LocalPlayer and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
                    local vHum = victim.Character:FindFirstChildOfClass("Humanoid")
                    if vHum and vHum.Health > 0 then
                        local dist = (char.HumanoidRootPart.Position - victim.Character.HumanoidRootPart.Position).Magnitude
                        if dist <= Config.KillAuraRange then
                            knife:Activate()
                            pcall(function()
                                firetouchinterest(victim.Character.HumanoidRootPart, knife.Handle, 0)
                                firetouchinterest(victim.Character.HumanoidRootPart, knife.Handle, 1)
                            end)
                        end
                    end
                end
            end
        end
    end)

    -- Noclip
    RunService.Stepped:Connect(function()
        if not Config.NoclipEnabled then return end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    -- Потоковая проверка для авто-уклонения (Auto-Dodge Thrown Knife)
    RunService.Heartbeat:Connect(function()
        if not Config.AutoDodgeKnife then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Поиск летящего ножа в workspace
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "ThrownKnife" and obj:IsA("BasePart") then
                local distance = (hrp.Position - obj.Position).Magnitude
                
                -- Если нож близко и кулдаун прошел (0.6 сек)
                if distance < 22 and (tick() - lastDodgeTime > 0.6) then
                    lastDodgeTime = tick()
                    
                    -- Мгновенно смещаемся строго вправо относительно направления взгляда
                    local targetCFrame = hrp.CFrame + (hrp.CFrame.RightVector * 14)
                    
                    local wasAnchored = hrp.Anchored
                    hrp.Anchored = true
                    hrp.CFrame = targetCFrame
                    char:PivotTo(targetCFrame)
                    task.wait(0.04) -- Кратковременный анкор для фиксации положения
                    hrp.Anchored = wasAnchored
                    break
                end
            end
        end
    end)

    WindUI:Notify({ Title = "FogyHub", Content = T("Loaded"), Icon = "shield", Duration = 3 })
end

-- ==================== ИНИЦИАЛИЗАЦИЯ И ИНТЕРАКТИВНЫЙ ВЫБОР ЯЗЫКА ====================
local container = getSafeUIContainer()
if container then
    local saveFileName = "fogyhub_lang.txt"
    local hasSavedLang = false
    
    -- Проверка сохраненного языка
    if readfile and isfile and isfile(saveFileName) then
        local saved = pcall(function() return readfile(saveFileName) end) and readfile(saveFileName)
        if saved == "ru" or saved == "en" then
            currentLang = saved
            hasSavedLang = true
        end
    end
    
    if hasSavedLang then
        xpcall(main, showCrashMenu)
    else
        local langGui = Instance.new("ScreenGui")
        langGui.Name = "FogyHub_LanguageSelector"
        langGui.ResetOnSpawn = false
        langGui.Parent = container
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 150)
        frame.Position = UDim2.new(0.5, -150, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BorderSizePixel = 0
        frame.Parent = langGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 150, 255)
        stroke.Thickness = 1.5
        stroke.Parent = frame
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        title.Text = "🌐 FogyHub — Select Language"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 13
        title.Font = Enum.Font.SourceSansBold
        title.Parent = frame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 8)
        titleCorner.Parent = title
        
        local function createLangButton(text, pos, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.4, 0, 0, 40)
            btn.Position = pos
            btn.Text = text
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 13
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BorderSizePixel = 0
            btn.Parent = frame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btn
            
            btn.Activated:Connect(callback)
        end
        
        createLangButton("Русский", UDim2.new(0.08, 0, 0.5, 0), function()
            currentLang = "ru"
            if writefile then pcall(function() writefile(saveFileName, "ru") end) end
            langGui:Destroy()
            xpcall(main, showCrashMenu)
        end)
        
        createLangButton("English", UDim2.new(0.52, 0, 0.5, 0), function()
            currentLang = "en"
            if writefile then pcall(function() writefile(saveFileName, "en") end) end
            langGui:Destroy()
            xpcall(main, showCrashMenu)
        end)
    end
else
    xpcall(main, showCrashMenu)
end
