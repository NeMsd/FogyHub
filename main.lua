
-- ======================================================
-- FogyHub (MM2 Custom Multi-Tool - REBUILT BY HACKER)
-- Authors: MsD, Gemini
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

-- Дефолтный язык (перезаписывается при выборе или загрузке конфига)
local currentLang = "en"
local HttpService = game:GetService("HttpService")
local configFileName = "fogyhub_settings.json"

-- Глобальная конфигурация скрипта (сохраняет абсолютно все настройки и кнопки)
local Config = {
    Language = "en",
    Visuals = {
        MurdererESP = false, SheriffESP = false, InnocentESP = false, EspBoxes = false, 
        StretchEnabled = false, StretchFactor = 0.75, NoFogEnabled = false, TimeOfDay = 14,
    },
    Combat = {
        AutoShootMurderer = false, AimlockEnabled = false, SilentAimEnabled = false,
        AutoDodgeKnife = false, KillAuraEnabled = false, KillAuraRange = 25,
    },
    Utility = {
        AutoGrabGun = false, SlideGlitchEnabled = false, SlideSpeedForce = 45,
        NoclipEnabled = false, AntiFling = false, AutoFarmCoins = false,      
        EmoteSpamEnabled = false, ChatAlertsEnabled = false,  
    },
    MobileButtons = {
        LockMobileButtons = false, ButtonScale = 1.0,
        ["Fling Murderer"] = false, ["Fling Sheriff"] = false, ["Fling Hero"] = false, 
        ["Grab Gun"] = false, ["Slide Glitch"] = false, ["Noclip"] = false,
        ["Kill Aura"] = false, ["Auto Kill All"] = false, ["Godmode"] = false, 
        ["TP Lobby"] = false, ["TP Map"] = false, ["Aimlock"] = false, ["Shoot Murderer"] = false
    },
    ButtonPositions = {
        ["Fling Murderer"] = {X = 30, Y = 100}, ["Fling Sheriff"] = {X = 30, Y = 145}, ["Fling Hero"] = {X = 30, Y = 190}, 
        ["Grab Gun"] = {X = 30, Y = 235}, ["Slide Glitch"] = {X = 30, Y = 280}, ["Noclip"] = {X = 30, Y = 325},
        ["Kill Aura"] = {X = 30, Y = 370}, ["Auto Kill All"] = {X = 30, Y = 415}, ["Godmode"] = {X = 30, Y = 460},
        ["TP Lobby"] = {X = 30, Y = 505}, ["TP Map"] = {X = 30, Y = 550}, ["Aimlock"] = {X = 30, Y = 595}, ["Shoot Murderer"] = {X = 30, Y = 640}
    }
}

-- Функции физического сохранения конфигурации
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
            local content = readfile(configFileName)
            local loaded = HttpService:JSONDecode(content)
            if loaded then
                if loaded.Language then Config.Language = loaded.Language end
                if loaded.Visuals then for k, v in pairs(loaded.Visuals) do Config.Visuals[k] = v end end
                if loaded.Combat then for k, v in pairs(loaded.Combat) do Config.Combat[k] = v end end
                if loaded.Utility then for k, v in pairs(loaded.Utility) do Config.Utility[k] = v end end
                if loaded.MobileButtons then for k, v in pairs(loaded.MobileButtons) do Config.MobileButtons[k] = v end end
                if loaded.ButtonPositions then for k, v in pairs(loaded.ButtonPositions) do Config.ButtonPositions[k] = v end end
                currentLang = Config.Language
            end
        end)
    end
end

-- Загружаем настройки на самом первом этапе инициализации
loadConfig()

-- Словарь локализации (2 Языка)
local L = {
    en = {
        CrashTitle = "🚨 FogyHub — Crash Handler", CopyLog = "Copy Log", Copied = "Log Copied!", BufError = "Clipboard Error!", Close = "Close", Loaded = "FogyHub loaded!", FailedUI = "Failed to load WindUI library.",
        Visuals = "Visuals", Combat = "Combat", Utility = "Utility", MobileBinds = "Mobile Buttons", Radio = "Radio", Teleports = "Teleports", Configs = "Configs / Settings",
        EspM = "ESP Murderer", EspS = "ESP Sheriff", EspI = "ESP Innocents", EspBoxes = "3D Box ESP (For Low-End PC)", Stretch = "Screen Stretch (4:3)", StretchForce = "Stretch Force",
        NoFog = "Disable Map Fog", TimeOfDay = "Time of Day",
        AutoShoot = "Auto-Shoot Murderer", Aimlock = "Aimlock on Murderer", ShootM = "Shoot Murderer", KillAura = "Kill Aura", KillAuraRange = "Kill Aura Range", AutoKillAll = "Auto Kill All",
        FlingM = "Fling Murderer", FlingS = "Fling Sheriff", FlingH = "Fling Hero", AutoGrab = "Auto Grab Gun", SlideGlitch = "Infinite Speed Glitch", SlideSpeed = "Movement Speed", Noclip = "Noclip (Walk Through Walls)", AntiFling = "Anti-Fling",
        LockButtons = "Lock Button Positions", BtnScale = "Mobile Buttons Scale", BtnFlingM = "Button: Fling Murderer", BtnFlingS = "Button: Fling Sheriff", BtnFlingH = "Button: Fling Hero", BtnGrab = "Button: Grab Gun", BtnSlide = "Button: Slide Glitch",
        BtnNoclip = "Button: Noclip", BtnKillAura = "Button: Kill Aura", BtnKillAll = "Button: Auto Kill All", RobloxId = "Roblox Audio ID", PlayId = "Play Roblox ID", HttpUrl = "HTTP Link to MP3 / OGG",
        PlayHttp = "Play HTTP Link", StopRadio = "Stop Radio", Volume = "Volume", Loop = "Loop Audio", NoKnife = "Knife not found!", NoGun = "Sheriff's gun not found!", NoM = "Murderer not found or dead",
        NoS = "Sheriff not found or dead", NoH = "Hero not found or dead", SitError = " is sitting (fling impossible)", Flinging = "Flinging: ", RadioNoSupport = "Your exploit does not support writefile/getcustomasset!",
        RadioDownloading = "Downloading audio file...", RadioHttpSuccess = "External audio started successfully!", RadioHttpError = "Failed to parse asset from file.", RadioHttpFail = "Failed to download audio file.",
        RadioCache = "Audio loaded from persistent local cache!", NoclipToggle = "Noclip", NoclipOn = "Enabled", NoclipOff = "Disabled", SpeedOn = "Enabled", SpeedOff = "Disabled",
        DodgeKnife = "Auto-Dodge Thrown Knife (Jump Right)", BtnDodgeKnife = "Button: Dodge Knife", TpLobby = "Teleport to Lobby", TpMap = "Teleport to Map", BtnTpLobby = "Button: TP Lobby",
        BtnTpMap = "Button: TP Map", NoMapLoaded = "Map not loaded yet or empty!", BtnAimlock = "Button: Aimlock", VisualsSkinChanger = "Visual Skins",
        SkinChangerTitle = "Visual Skin Changer", SkinChangerInput = "Roblox Username", SkinChangerBtn = "Apply Skin", SkinNotFound = "Player not found!", SkinSuccess = "Outfit changed visually!", SaveConfigBtn = "Save Config File", LoadConfigBtn = "Load Config File",
        ResetConfigBtn = "Reset to Defaults", SetLangRu = "Switch UI to Russian", SetLangEn = "Switch UI to English", ConfSaved = "Config saved to storage!", ConfLoaded = "Config loaded from storage!", ConfReset = "Config reset to factory defaults.",
        BtnShootM = "Button: Shoot", GodMode = "Dodge Knife", BtnGodMode = "Button: Dodge Knife",
        SilentAim = "Silent Aim (Shoot Without Turning Camera)", AutoFarmCoins = "Auto-Farm Coins (Safe Glide)", EmoteSpam = "Emote Glitch Spammer (Zen/Sit)", ChatAlerts = "Local Role Notifications in Chat",
        MMBWarningTitle = "⚠️ Custom Server Detected", MMBWarningContent = "You are playing on an unofficial copy of MM2 (e.g. MMB). Some features like Skin Changer or Role tracking may be unstable."
    },
    ru = {
        CrashTitle = "🚨 FogyHub — Аварийное Меню", CopyLog = "Скопировать Лог", Copied = "Лог скопирован!", BufError = "Ошибка буфера!", Close = "Закрыть", Loaded = "FogyHub loaded!", FailedUI = "Не удалось загрузить библиотеку WindUI.",
        Visuals = "Визуалы", Combat = "Бой", Utility = "Утилиты", MobileBinds = "Тел. Кнопки", Radio = "Радио", Teleports = "Телепорты", Configs = "Конфиги / Настройки",
        EspM = "ESP Убийца (Мардер)", EspS = "ESP Шериф", EspI = "ESP Мирные жители", EspBoxes = "3D Бокс ESP (Для слабых читов)", Stretch = "Растяг экрана (4:3)", StretchForce = "Сила растяга",
        NoFog = "Отключить Туман на Карте", TimeOfDay = "Время Суток в Игре",
        AutoShoot = "Авто-выстрел в Мардера", Aimlock = "Аимлок на Убийцу", ShootM = "Выстрелить в Мардера", KillAura = "Килаура на игроков", KillAuraRange = "Радиус килауры", AutoKillAll = "Убить всех игроков",
        FlingM = "Флинг Убийцы", FlingS = "Флинг Шерифа", FlingH = "Флинг Героя", AutoGrab = "Автоподбор пистолета", SlideGlitch = "Бесконечный Спидглитч бега", SlideSpeed = "Скорость движения", Noclip = "Ноуклип (Проход сквозь стены)", AntiFling = "Анти-Флинг",
        LockButtons = "Заблокировать все кнопки", BtnScale = "Масштаб мобильных кнопок", BtnFlingM = "Кнопка: Fling Murderer", BtnFlingS = "Кнопка: Fling Sheriff", BtnFlingH = "Кнопка: Fling Hero", BtnGrab = "Кнопка: Grab Gun", BtnSlide = "Кнопка: Slide Glitch",
        BtnNoclip = "Кнопка: Noclip", BtnKillAura = "Кнопка: Kill Aura", BtnKillAll = "Кнопка: Auto Kill All", RobloxId = "ID Звука из Roblox", PlayId = "Играть по Roblox ID", HttpUrl = "HTTP Ссылка на MP3 / OGG файл",
        PlayHttp = "Играть по внешней ссылке", StopRadio = "Стоп Радио", Volume = "Громкость", Loop = "Зациклить", NoKnife = "Нож не найден!", NoGun = "Шерифский пистолет не найден!", NoM = "Убийца не найден или мертв", NoS = "Шериф не найден или мертв", NoH = "Герой не найден или мертв",
        SitError = " сидит (флинг невозможен)", Flinging = "Выбиваем: ", RadioNoSupport = "Ваш эксплойт не поддерживает writefile/getcustomasset!",
        RadioDownloading = "Загрузка аудиофайла...", RadioHttpSuccess = "Внешнее аудио успешно запущено!", RadioHttpError = "Не удалось декодировать аудио.", RadioHttpFail = "Не удалось скачать аудиофайл.",
        RadioCache = "Песня запущена из постоянного локального кэша!", NoclipToggle = "Noclip", NoclipOn = "Включен", NoclipOff = "Выключен", SpeedOn = "Включен", SpeedOff = "Выключен",
        DodgeKnife = "Авто-Манс от летящего ножа (Отпрыг вправо)", BtnDodgeKnife = "Кнопка: Уворот", TpLobby = "Телепорт в Лобби", TpMap = "Телепорт на Карту", BtnTpLobby = "Кнопка: ТП Лобби",
        BtnTpMap = "Кнопка: ТП Карта", NoMapLoaded = "Карта еще не загружена или пуста!", BtnAimlock = "Кнопка: Аимлок", VisualsSkinChanger = "Визуальные Скины",
        SkinChangerTitle = "Визуальный скинченджер", SkinChangerInput = "Ник игрока для копирования", SkinChangerBtn = "Применить скин", SkinNotFound = "Игрок не найден!", SkinSuccess = "Скин визуально применен!", SaveConfigBtn = "Сохранить текущие настройки", LoadConfigBtn = "Загрузить настройки из файла",
        ResetConfigBtn = "Сбросить по умолчанию", SetLangRu = "Сменить язык на Русский", SetLangEn = "Сменить язык на Английский", ConfSaved = "Настройки успешно сохранены на устройство!", ConfLoaded = "Настройки успешно загружены из файла!", ConfReset = "Все параметры сброшены до заводских настроек.",
        BtnShootM = "Кнопка: Выстрел", GodMode = "Уворот от ножа", BtnGodMode = "Кнопка: Уворот",
        SilentAim = "Сайлент Аим (Стрельба без наводки камеры)", AutoFarmCoins = "Автофарм монет (Безопасный глайд)", EmoteSpam = "Спам Эмоций для Глитча Хитбокса (Zen/Sit)", ChatAlerts = "Оповещения о Ролях в Чат",
        MMBWarningTitle = "⚠️ Обнаружена копия MM2", MMBWarningContent = "Вы находитесь на кастомной копии игры (например, MMB). Некоторые сетевые функции (скинченджер, роли игроков) могут работать нестабильно."
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

-- ==================== 2. СТАБИЛЬНЫЙ CRASH HANDLER ====================
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
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer

    -- Вспомогательные функции для установки значений UI
    local function setToggle(element, value)
        if element and element.Set then
            pcall(function() element:Set(value) end)
        end
    end

    local function setSlider(element, value)
        if element and element.Set then
            pcall(function() element:Set(value) end)
        end
    end

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

    -- ==================== ИНИЦИАЛИЗАЦИЯ ОКНА И ВКЛАДОК WINDUI ====================
    local Window = WindUI:CreateWindow({
        Title = "FogyHub",
        Icon = "shield",
        Author = "MsD & Gemini",
        Folder = "FogyHub",
        Size = UDim2.fromOffset(580, 460),
        Theme = "Dark",
        ToggleKey = Enum.KeyCode.RightControl
    })

    local VisualsTab = Window:Tab({ Title = T("Visuals"), Icon = "eye" })
    local CombatTab = Window:Tab({ Title = T("Combat"), Icon = "swords" })
    local UtilityTab = Window:Tab({ Title = T("Utility"), Icon = "tool" })
    local TeleportsTab = Window:Tab({ Title = T("Teleports"), Icon = "map-pin" })
    local ButtonsTab = Window:Tab({ Title = T("MobileBinds"), Icon = "smartphone" })
    local ConfigsTab = Window:Tab({ Title = T("Configs"), Icon = "settings" })
    local RadioTab = Window:Tab({ Title = T("Radio"), Icon = "music" })

    local radioModel, radioSound, currentSongId, radioVolume, radioLooped = nil, nil, "", 2, false
    local httpSongUrl, grabbingGun, skinChangerNick = "", false, ""
    local ScreenButtons, BindsScreenGui, originalFog = {}, nil, Lighting.FogEnd 
    local roles, Murder, Sheriff, Hero = {}, nil, nil, nil
    local stretchConnection, antiFlingConnection = nil, nil

    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight

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
                local w = baseWidth * Config.MobileButtons.ButtonScale
                local h = baseHeight * Config.MobileButtons.ButtonScale
                frame.Size = UDim2.new(0, w, 0, h)
                
                local btn = frame:FindFirstChildOfClass("TextButton")
                if btn then
                    btn.TextSize = math.clamp(math.round(11 * Config.MobileButtons.ButtonScale), 8, 24)
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
        
        -- Поиск подсветки (совместимо со стандартным именем "Highlight")
        local highlight = character:FindFirstChild("FogyHub_ESP") or character:FindFirstChild("Highlight")
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
        if character then
            local highlight = character:FindFirstChild("FogyHub_ESP") or character:FindFirstChild("Highlight")
            if highlight then highlight:Destroy() end
        end
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

    -- Поиск модулей на кастомных серверах
    local function findSystemModule(name)
        local standardModules = ReplicatedStorage:FindFirstChild("Modules")
        if standardModules then
            local found = standardModules:FindFirstChild(name)
            if found then return found end
        end
        return ReplicatedStorage:FindFirstChild(name, true)
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

    -- Безопасная телепортация
    local function safeTeleport(targetCFrame)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hrp and hum then
            local wasAnchored = hrp.Anchored
            
            -- Сбрасываем инерцию
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.RotVelocity = Vector3.new(0, 0, 0)
            
            hrp.Anchored = true
            hum.PlatformStand = true -- Временно отключаем анимации
            
            hrp.CFrame = targetCFrame
            char:PivotTo(targetCFrame)
            
            task.wait(0.15) -- Безопасная задержка
            
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.RotVelocity = Vector3.new(0, 0, 0)
            
            hrp.Anchored = wasAnchored
            hum.PlatformStand = false
        end
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

    -- Динамический поиск живого Героя на карте
    local function getHero()
        if Hero then
            local p = Players:FindFirstChild(Hero)
            if p and IsAlive(p) then return p end
        end
        local murderPlayer = getMurderer()
        local sheriffPlayer = getSheriff()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and IsAlive(p) then
                if p ~= murderPlayer and p ~= sheriffPlayer then
                    local backpack = p:FindFirstChild("Backpack")
                    local hasGun = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or p.Character:FindFirstChild("Gun") or p.Character:FindFirstChild("Revolver")
                    if hasGun then
                        return p
                    end
                end
            end
        end
        return nil
    end

    -- Полноценная реализация ультра-агрессивного физического флинга (Kilasik's Multi-Target Fling)
    local function flingPlayer(targetPlayer)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart or (Character and Character:FindFirstChild("HumanoidRootPart"))
        
        local TCharacter = targetPlayer.Character
        if not TCharacter then return end
        
        local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart or TCharacter:FindFirstChild("HumanoidRootPart")
        local THead = TCharacter:FindFirstChild("Head")
        local Accessory = TCharacter:FindFirstChildOfClass("Accessory")
        local Handle = Accessory and Accessory:FindFirstChild("Handle")
        
        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
            end
            
            if THumanoid and THumanoid.Sit then
                WindUI:Notify({ Title = "FogyHub", Content = targetPlayer.Name .. T("SitError"), Icon = "x", Duration = 3 })
                return
            end
            
            WindUI:Notify({ Title = "FogyHub", Content = T("Flinging") .. targetPlayer.DisplayName, Icon = "swords", Duration = 3 })
            
            if THead then
                workspace.CurrentCamera.CameraSubject = THead
            elseif Handle then
                workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then
                workspace.CurrentCamera.CameraSubject = THumanoid
            end
            
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                return
            end
            
            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
            
            local SFBasePart = function(BasePart)
                local TimeToWait = 2
                local Time = tick()
                local Angle = 0
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
                until Time + TimeToWait < tick()
            end
            
            workspace.FallenPartsDestroyHeight = 0/0
            
            local BV = Instance.new("BodyVelocity")
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(0, 0, 0)
            BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            if TRootPart then
                SFBasePart(TRootPart)
            elseif THead then
                SFBasePart(THead)
            elseif Handle then
                SFBasePart(Handle)
            else
                WindUI:Notify({ Title = "Error", Content = targetPlayer.Name .. " has no valid parts", Icon = "x", Duration = 3 })
            end
            
            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid
            
            -- Возвращение на исходную позицию без остаточной физической силы
            if getgenv().OldPos then
                repeat
                    RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                    Humanoid:ChangeState("GettingUp")
                    for _, part in pairs(Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end
                    task.wait()
                until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
                workspace.FallenPartsDestroyHeight = getgenv().FPDH
            end
        else
            WindUI:Notify({ Title = "Error", Content = "Your character is not ready", Icon = "x", Duration = 3 })
        end
    end

    -- Управление спидглитчем (Slide Glitch)
    local function toggleSlideGlitch(state)
        if state == nil then
            state = not Config.Utility.SlideGlitchEnabled
        end
        Config.Utility.SlideGlitchEnabled = state
        if UI_Elements.Utility.SlideGlitchEnabled then
            setToggle(UI_Elements.Utility.SlideGlitchEnabled, state)
        end
        saveConfig()
    end

    -- Управление Noclip (Проход сквозь стены)
    local function toggleNoclip(state)
        if state == nil then
            state = not Config.Utility.NoclipEnabled
        end
        Config.Utility.NoclipEnabled = state
        if UI_Elements.Utility.NoclipEnabled then
            setToggle(UI_Elements.Utility.NoclipEnabled, state)
        end
        saveConfig()
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

    -- Симуляция физического клика (клик мыши) на ПК / Тач на мобильном
    local function simulatePhysicalClick()
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
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
        
        -- Если файл уже физически сохранен в папке читов, моментально запускаем его
        if isfile and isfile(cachedFileName) then
            local localAsset = nil
            pcall(function()
                localAsset = getcustomasset(cachedFileName)
            end)
            
            if localAsset then
                attachRadio()
                if not radioModel then return end
                local sound = radioModel:FindFirstChild("RadioSound") or Instance.new("Sound", radioModel)
                sound.Name, sound.SoundId, sound.Volume, sound.Looped = "RadioSound", localAsset, radioVolume, radioLooped
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
                local getSuccess, assetId = pcall(function() return getcustomasset(cachedFileName) end)
                
                if writeSuccess and getSuccess and assetId then
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
        
        -- УСЛОВИЕ ОТМЕНЫ: если мы мертвы или мы Убийца, отменяем подбор
        if not IsAlive(LocalPlayer) then return end
        
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local isMurderer = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) or (Murder and LocalPlayer.Name == Murder)
        if isMurderer then return end
        
        grabbingGun = true
        
        local gunDrop = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)
        local handle = gunDrop and (gunDrop:FindFirstChild("Handle", true) or gunDrop:FindFirstChildOfClass("Part", true) or gunDrop)
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        -- Функция проверки наличия пистолета у игрока
        local function hasGun()
            local currentBp = LocalPlayer:FindFirstChild("Backpack")
            return (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))) or (currentBp and (currentBp:FindFirstChild("Gun") or currentBp:FindFirstChild("Revolver")))
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
                safeTeleport(targetCFrame)
                
                local timeout = 0
                local altHeight = 0
                while not hasGun() and timeout < 15 do 
                    timeout = timeout + 1
                    altHeight = altHeight - 0.5
                    if altHeight < -2.5 then altHeight = -2.5 end 
                    
                    safeTeleport(targetCFrame * CFrame.new(0, altHeight, 0))
                    task.wait(0.1)
                    
                    local checkGun = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)
                    if not checkGun then break end
                    
                    -- Проверяем на всякий случай смерть во время процесса ТП-подбора
                    if not IsAlive(LocalPlayer) then break end
                end
            end
            
            noclipConn:Disconnect()
            safeTeleport(originalPos)
        end
        grabbingGun = false
    end

    -- Стабильная телепортация в Лобби
    local function tpToLobby()
        local lobby = workspace:FindFirstChild("Lobby")
        local spawnLocation = lobby and (lobby:FindFirstChild("Spawn", true) or lobby:FindFirstChildOfClass("SpawnLocation", true) or lobby:FindFirstChild("Spawns", true))
        
        local targetCFrame
        if spawnLocation then
            targetCFrame = spawnLocation:IsA("Model") and spawnLocation:GetPivot() or spawnLocation.CFrame
            targetCFrame = targetCFrame * CFrame.new(0, 3, 0)
        else
            -- Точные координаты лобби
            targetCFrame = CFrame.new(6.0, 505.2, -35.0)
        end
        safeTeleport(targetCFrame)
    end

    -- Умный анализ геометрии активной карты и безопасное приземление
    local function tpToMap()
        local center = Vector3.new(12.0, 291.7, 9040.0) -- Координаты центра всех карт MM2
        local normal = workspace:FindFirstChild("Normal")
        local bestPart = nil
        local minDistance = math.huge
        
        -- Проверка на предмет того, играем ли мы за Убийцу
        local weAreMurderer = false
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) then
            weAreMurderer = true
        end
        
        -- Поиск твердой плоской поверхности внутри карты в радиусе 120 studs от центра
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
            -- Безопасно телепортируемся прямо на найденную поверхность пола/спавна
            safeTeleport(CFrame.new(bestPart.Position + Vector3.new(0, 3.5, 0)))
        else
            -- Умный обход 2: если спавны карты скрыты, переносимся к живому игроку вне лобби (только если мы НЕ Убийца!)
            local tpSuccess = false
            if not weAreMurderer then
                for _, p in ipairs(Players:GetPlayers()) do
                    -- Блокируем ТП к Мардеру во избежание мгновенной смерти
                    if p ~= LocalPlayer and p.Name ~= Murder and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            -- Проверяем по новым координатам лобби
                            local distToLobby = (p.Character.HumanoidRootPart.Position - Vector3.new(6.0, 505.2, -35.0)).Magnitude
                            if distToLobby > 150 then -- Далеко от лобби
                                safeTeleport(p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
                                tpSuccess = true
                                break
                            end
                        end
                    end
                end
            end
            
            -- Если карта полностью пуста (или мы убийца), переносим в воздух над точными координатами центра
            if not tpSuccess then
                safeTeleport(CFrame.new(center + Vector3.new(0, 3.5, 0)))
            end
        end
    end

    -- Сетевой выстрел без дергания камеры (ОБНОВЛЁННЫЙ ВЫСОКОКЛАССНЫЙ ШОТТЕР)
    local function fireGun(gun, targetPosition)
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if gun.Parent == bp then char.Humanoid:EquipTool(gun) task.wait(0.1) end
        
        local originCF
        local gunServer = gun:FindFirstChild("GunServer")
        if gunServer then
            local attachment = gunServer:FindFirstChild("GunRaycastAttachment1") or gunServer:FindFirstChild("RaycastAttachment")
            if attachment then
                originCF = attachment.WorldCFrame
            end
        end
        
        if not originCF then
            local handle = gun:FindFirstChild("Handle") or gun:FindFirstChild("Gun")
            if handle and handle:IsA("BasePart") then
                originCF = handle.CFrame
            end
        end
        
        if not originCF then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then originCF = hrp.CFrame end
        end
        
        if not originCF then return end
        
        local shootRemote = gun:FindFirstChild("Shoot") or gun:FindFirstChild("Fire")
        if shootRemote then
            local args = {
                CFrame.new(originCF.Position, targetPosition),
                CFrame.new(targetPosition)
            }
            shootRemote:FireServer(unpack(args))
        else
            -- Фоллбэк под классические сервера
            pcall(function()
                if ReplicatedStorage:FindFirstChild("ShootGun") then
                    ReplicatedStorage.ShootGun:InvokeServer(1, targetPosition, targetPosition)
                else
                    simulatePhysicalClick()
                end
            end)
        end
    end

    -- Стабильный скинченджер без затупов и патчей
    local function changeVisualSkin(username)
        task.spawn(function()
            local targetPlr = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == username:lower() or p.DisplayName:lower() == username:lower() then
                    targetPlr = p
                    break
                end
            end

            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not char or not hum then return end

            if targetPlr and targetPlr.Character then
                -- Если цель на сервере — клонируем её элементы напрямую (100% обход любых патчей API)
                pcall(function()
                    for _, obj in ipairs(char:GetChildren()) do
                        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic") then
                            obj:Destroy()
                        end
                    end
                    for _, obj in ipairs(targetPlr.Character:GetChildren()) do
                        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic") then
                            local clone = obj:Clone()
                            clone.Parent = char
                        end
                    end
                    WindUI:Notify({ Title = T("Visuals"), Content = T("SkinSuccess"), Icon = "check", Duration = 3 })
                end)
            else
                -- Оффлайн-загрузка через описание
                local success, userId = pcall(function()
                    return Players:GetUserIdFromNameAsync(username)
                end)
                
                if not success or not userId then
                    WindUI:Notify({ Title = T("Visuals"), Content = T("SkinNotFound"), Icon = "x", Duration = 3 })
                    return
                end
                
                local descSuccess, desc = pcall(function()
                    return Players:GetHumanoidDescriptionFromUserId(userId)
                end)
                
                if descSuccess and desc then
                    local applySuccess, err = pcall(function()
                        -- Чистим старые аксы во избежание наложений
                        for _, obj in ipairs(char:GetChildren()) do
                            if obj:IsA("Accessory") then obj:Destroy() end
                        end
                        hum:ApplyDescription(desc)
                    end)
                    
                    if applySuccess then
                        WindUI:Notify({ Title = T("Visuals"), Content = T("SkinSuccess"), Icon = "check", Duration = 3 })
                    else
                        warn("SkinChanger Error:", err)
                    end
                else
                    WindUI:Notify({ Title = T("Visuals"), Content = T("SkinNotFound"), Icon = "x", Duration = 3 })
                end
            end
        end)
    end

    -- Авто-килл всех (для убийцы)
    local function autoKillAll()
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local knife = char and char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
        
        if not knife then
            WindUI:Notify({ Title = "Error", Content = T("NoKnife"), Icon = "x", Duration = 3 })
            return
        end
        
        local isMurderer = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) or (Murder and LocalPlayer.Name == Murder)
        if not isMurderer then
            WindUI:Notify({ Title = "Error", Content = "You must be the Murderer to use Auto Kill All!", Icon = "x", Duration = 3 })
            return
        end
        
        if char and char:FindFirstChild("HumanoidRootPart") then
            if knife.Parent == bp then char.Humanoid:EquipTool(knife) end
            
            local originalPos = char.HumanoidRootPart.CFrame
            local wasAnchored = char.HumanoidRootPart.Anchored
            
            for _, victim in ipairs(Players:GetPlayers()) do
                if victim ~= LocalPlayer and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
                    local vHum = victim.Character:FindFirstChildOfClass("Humanoid")
                    if vHum and vHum.Health > 0 and IsAlive(victim) then
                        char.HumanoidRootPart.Anchored = true
                        safeTeleport(victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5))
                        task.wait(0.15)
                        
                        knife:Activate()
                        local targetPart = victim.Character:FindFirstChild("HumanoidRootPart") or victim.Character:FindFirstChild("Torso") or victim.Character:FindFirstChild("UpperTorso")
                        if targetPart then
                            pcall(function()
                                firetouchinterest(targetPart, knife.Handle, 0)
                                task.wait(0.05)
                                firetouchinterest(targetPart, knife.Handle, 1)
                            end)
                        end
                        task.wait(0.1)
                    end
                end
            end
            char.HumanoidRootPart.Anchored = wasAnchored
            safeTeleport(originalPos)
        end
    end

    -- Моментальный прямой шот в убийцу без палевных телепортов
    local function shootMurdererDirect()
        local m = getMurderer()
        if not m or not m.Character or not m.Character:FindFirstChild("HumanoidRootPart") then
            WindUI:Notify({ Title = "Error", Content = T("NoM"), Icon = "x", Duration = 3 })
            return
        end
        
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local gun = char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")) or (bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver")))
        
        if not gun then
            WindUI:Notify({ Title = "Error", Content = T("NoGun"), Icon = "x", Duration = 3 })
            return
        end
        
        if char and char:FindFirstChild("HumanoidRootPart") then
            if gun.Parent == bp then char.Humanoid:EquipTool(gun) end
            task.wait(0.05)
            fireGun(gun, m.Character.HumanoidRootPart.Position)
        end
    end

    -- ==================== АКТИВАЦИОННЫЕ ХЭЛПЕРЫ ДЛЯ КОНФИГА ====================
    
    local function applyStretch(state)
        Config.Visuals.StretchEnabled = state
        if not state then
            if stretchConnection then stretchConnection:Disconnect() stretchConnection = nil end
            pcall(function()
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame
            end)
            return
        end
        if not stretchConnection then
            stretchConnection = RunService.RenderStepped:Connect(function()
                local camera = workspace.CurrentCamera
                if camera then 
                    camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, Config.Visuals.StretchFactor, 0, 0, 0, 1) 
                end
            end)
        end
    end

    local function applyNoFog(state)
        Config.Visuals.NoFogEnabled = state
        Lighting.FogEnd = state and 9e9 or originalFog
    end

    local function applyTimeOfDay(v)
        Config.Visuals.TimeOfDay = v
        Lighting.TimeOfDay = string.format("%02d:00:00", v)
    end

    local function applyAntiFling(state)
        Config.Utility.AntiFling = state
        if not state then
            if antiFlingConnection then antiFlingConnection:Disconnect() antiFlingConnection = nil end
            return
        end
        if not antiFlingConnection then
            antiFlingConnection = RunService.Stepped:Connect(function()
                if not Config.Utility.AntiFling then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, part in ipairs(p.Character:GetChildren()) do
                            if part:IsA("BasePart") then 
                                part.CanCollide = false 
                            elseif part:IsA("Accessory") then
                                local handle = part:FindFirstChild("Handle")
                                if handle and handle:IsA("BasePart") then
                                    handle.CanCollide = false
                                end
                            end
                        end
                    end
                end
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if hrp.Velocity.Magnitude > 100 then 
                        hrp.Velocity = Vector3.new(0, 0, 0)
                        hrp.RotVelocity = Vector3.new(0, 0, 0)
                    end
                    pcall(function()
                        if hrp.AssemblyLinearVelocity.Magnitude > 100 then
                            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        end
                    end)
                end
            end)
        end
    end

    -- ==================== ИСПРАВЛЕННЫЕ ПЛАВАЮЩИЕ КНОПКИ ====================
    local function createFloatingButton(name, translationKey, callback)
        if ScreenButtons[name] then ScreenButtons[name]:Destroy() end
        local sg = getBindsScreenGui()
        if not sg then return end
        
        local frame = Instance.new("Frame")
        frame.Name = name .. "_Frame"
        
        -- Установка начального размера с учетом выбранного масштаба
        local baseWidth, baseHeight = 115, 35
        local w = baseWidth * Config.MobileButtons.ButtonScale
        local h = baseHeight * Config.MobileButtons.ButtonScale
        frame.Size = UDim2.new(0, w, 0, h)
        
        -- Прогрузка сохраненных или дефолтных положений
        local savedPos = Config.ButtonPositions[name]
        if savedPos then
            frame.Position = UDim2.new(0, savedPos.X, 0, savedPos.Y)
        else
            local offsets = {
                ["Fling Murderer"] = 100, ["Fling Sheriff"] = 145, ["Fling Hero"] = 190,
                ["Grab Gun"] = 235, ["Slide Glitch"] = 280, ["Noclip"] = 325, 
                ["Kill Aura"] = 370, ["Auto Kill All"] = 415, ["Godmode"] = 460, 
                ["TP Lobby"] = 505, ["TP Map"] = 550, ["Aimlock"] = 595, ["Shoot Murderer"] = 640
            }
            frame.Position = UDim2.new(0.04, 0, 0, offsets[name] or 100)
        end
        frame.BackgroundColor3, frame.BorderSizePixel, frame.BorderColor3 = Color3.fromRGB(30, 30, 30), 1, Color3.fromRGB(0, 150, 255)
        frame.Active, frame.Parent = true, sg
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size, btn.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
        btn.Text, btn.Font, btn.TextColor3 = T(translationKey), Enum.Font.SourceSansBold, Color3.fromRGB(255, 255, 255)
        btn.TextSize = math.clamp(math.round(11 * Config.MobileButtons.ButtonScale), 8, 24)
        btn.Parent = frame
        
        btn.Activated:Connect(callback)
        
        -- Стабильная логика драга
        local dragging = false
        local dragStart, startPos
        
        local function startDrag(input)
            dragging, dragStart, startPos = true, input.Position, frame.Position
        end
        
        frame.InputBegan:Connect(function(input)
            if not Config.MobileButtons.LockMobileButtons and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                startDrag(input)
            end
        end)
        
        btn.InputBegan:Connect(function(input)
            if not Config.MobileButtons.LockMobileButtons and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
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
                if dragging then
                    dragging = false
                    Config.ButtonPositions[name] = {
                        X = frame.Position.X.Offset,
                        Y = frame.Position.Y.Offset
                    }
                    saveConfig()
                end
            end
        end)
        
        ScreenButtons[name] = frame
    end

    local function removeFloatingButton(name)
        if ScreenButtons[name] then ScreenButtons[name]:Destroy() ScreenButtons[name] = nil end
    end

    -- ==================== СИСТЕМНАЯ СВЯЗЬ ДЛЯ ПЕРЕКЛЮЧЕНИЯ UI ИЗ КОНФИГА ====================
    local UI_Elements = {
        Visuals = {},
        Combat = {},
        Utility = {},
        MobileButtons = {}
    }

    -- Таблица динамической настройки мобильных кнопок
    local buttonInfo = {
        ["Fling Murderer"] = {Translation = "BtnFlingM", Target = "FlingM", Callback = function() local m = getMurderer() if m then flingPlayer(m) end end},
        ["Fling Sheriff"] = {Translation = "BtnFlingS", Target = "FlingS", Callback = function() local sh = getSheriff() if sh then flingPlayer(sh) end end},
        ["Fling Hero"] = {Translation = "BtnFlingH", Target = "FlingH", Callback = function() local h = getHero() if h then flingPlayer(h) end end},
        ["Grab Gun"] = {Translation = "BtnGrab", Target = "AutoGrab", Callback = grabGun},
        ["Slide Glitch"] = {Translation = "BtnSlide", Target = "SlideGlitch", Callback = toggleSlideGlitch},
        ["Noclip"] = {Translation = "BtnNoclip", Target = "Noclip", Callback = function() toggleNoclip(not Config.Utility.NoclipEnabled) end},
        ["Kill Aura"] = {Translation = "BtnKillAura", Target = "KillAura", Callback = function() Config.Combat.KillAuraEnabled = not Config.Combat.KillAuraEnabled setToggle(UI_Elements.Combat.KillAuraEnabled, Config.Combat.KillAuraEnabled) end},
        ["Auto Kill All"] = {Translation = "BtnKillAll", Target = "AutoKillAll", Callback = autoKillAll},
        ["Godmode"] = {Translation = "BtnGodMode", Target = "GodMode", Callback = function() Config.Combat.AutoDodgeKnife = not Config.Combat.AutoDodgeKnife setToggle(UI_Elements.Combat.AutoDodgeKnife, Config.Combat.AutoDodgeKnife) end},
        ["TP Lobby"] = {Translation = "BtnTpLobby", Target = "TpLobby", Callback = tpToLobby},
        ["TP Map"] = {Translation = "BtnTpMap", Target = "TpMap", Callback = tpToMap},
        ["Aimlock"] = {Translation = "BtnAimlock", Target = "Aimlock", Callback = function() Config.Combat.AimlockEnabled = not Config.Combat.AimlockEnabled setToggle(UI_Elements.Combat.AimlockEnabled, Config.Combat.AimlockEnabled) end},
        ["Shoot Murderer"] = {Translation = "BtnShootM", Target = "ShootM", Callback = shootMurdererDirect}
    }

    -- Функция применения конфига ко всем графическим элементам меню
    local function applyConfigToUI()
        -- 1. Визуалы
        setToggle(UI_Elements.Visuals.MurdererESP, Config.Visuals.MurdererESP)
        setToggle(UI_Elements.Visuals.SheriffESP, Config.Visuals.SheriffESP)
        setToggle(UI_Elements.Visuals.InnocentESP, Config.Visuals.InnocentESP)
        setToggle(UI_Elements.Visuals.EspBoxes, Config.Visuals.EspBoxes)
        setToggle(UI_Elements.Visuals.StretchEnabled, Config.Visuals.StretchEnabled)
        setSlider(UI_Elements.Visuals.StretchFactor, Config.Visuals.StretchFactor)
        setToggle(UI_Elements.Visuals.NoFogEnabled, Config.Visuals.NoFogEnabled)
        
        applyStretch(Config.Visuals.StretchEnabled)
        applyNoFog(Config.Visuals.NoFogEnabled)
        applyTimeOfDay(Config.Visuals.TimeOfDay)
        
        -- 2. Бой
        setToggle(UI_Elements.Combat.AutoShootMurderer, Config.Combat.AutoShootMurderer)
        setToggle(UI_Elements.Combat.AimlockEnabled, Config.Combat.AimlockEnabled)
        setToggle(UI_Elements.Combat.SilentAimEnabled, Config.Combat.SilentAimEnabled) 
        setToggle(UI_Elements.Combat.AutoDodgeKnife, Config.Combat.AutoDodgeKnife)
        setToggle(UI_Elements.Combat.KillAuraEnabled, Config.Combat.KillAuraEnabled)
        setSlider(UI_Elements.Combat.KillAuraRange, Config.Combat.KillAuraRange)
        
        -- 3. Утилиты
        setToggle(UI_Elements.Utility.AutoGrabGun, Config.Utility.AutoGrabGun)
        setToggle(UI_Elements.Utility.SlideGlitchEnabled, Config.Utility.SlideGlitchEnabled)
        setSlider(UI_Elements.Utility.SlideSpeedForce, Config.Utility.SlideSpeedForce)
        setToggle(UI_Elements.Utility.NoclipEnabled, Config.Utility.NoclipEnabled)
        setToggle(UI_Elements.Utility.AntiFling, Config.Utility.AntiFling)
        setToggle(UI_Elements.Utility.AutoFarmCoins, Config.Utility.AutoFarmCoins)         
        setToggle(UI_Elements.Utility.EmoteSpamEnabled, Config.Utility.EmoteSpamEnabled)   
        setToggle(UI_Elements.Utility.ChatAlertsEnabled, Config.Utility.ChatAlertsEnabled)   
        
        applyAntiFling(Config.Utility.AntiFling)
        
        -- 4. Мобильные кнопки
        setToggle(UI_Elements.MobileButtons.LockMobileButtons, Config.MobileButtons.LockMobileButtons)
        setSlider(UI_Elements.MobileButtons.ButtonScale, Config.MobileButtons.ButtonScale)
        
        for name, info in pairs(buttonInfo) do
            local state = Config.MobileButtons[name]
            setToggle(UI_Elements.MobileButtons[name], state)
            if state then
                createFloatingButton(name, info.Target, info.Callback)
            else
                removeFloatingButton(name)
            end
        end
        updateButtonSizes()
    end

    -- ==================== ВЕРСТКА ИНТЕРФЕЙСА FOGYHUB ====================

    -- Вкладка Визуалы
    UI_Elements.Visuals.MurdererESP = VisualsTab:Toggle({ Title = T("EspM"), Value = Config.Visuals.MurdererESP, Callback = function(s) Config.Visuals.MurdererESP = s saveConfig() end })
    UI_Elements.Visuals.SheriffESP = VisualsTab:Toggle({ Title = T("EspS"), Value = Config.Visuals.SheriffESP, Callback = function(s) Config.Visuals.SheriffESP = s saveConfig() end })
    UI_Elements.Visuals.InnocentESP = VisualsTab:Toggle({ Title = T("EspI"), Value = Config.Visuals.InnocentESP, Callback = function(s) Config.Visuals.InnocentESP = s saveConfig() end })
    UI_Elements.Visuals.EspBoxes = VisualsTab:Toggle({ Title = T("EspBoxes"), Value = Config.Visuals.EspBoxes, Callback = function(s) Config.Visuals.EspBoxes = s saveConfig() end })
    
    UI_Elements.Visuals.StretchEnabled = VisualsTab:Toggle({
        Title = T("Stretch"), Value = Config.Visuals.StretchEnabled, Callback = function(state)
            applyStretch(state)
            saveConfig()
        end
    })
    UI_Elements.Visuals.StretchFactor = VisualsTab:Slider({ Title = T("StretchForce"), Step = 0.05, Value = { Min = 0.5, Max = 1, Default = Config.Visuals.StretchFactor }, Callback = function(v) Config.Visuals.StretchFactor = v saveConfig() end })
    
    UI_Elements.Visuals.NoFogEnabled = VisualsTab:Toggle({ Title = T("NoFog"), Value = Config.Visuals.NoFogEnabled, Callback = function(s) applyNoFog(s) saveConfig() end })
    VisualsTab:Slider({ Title = T("TimeOfDay"), Step = 1, Value = { Min = 0, Max = 24, Default = Config.Visuals.TimeOfDay }, Callback = function(v) applyTimeOfDay(v) saveConfig() end })
    
    -- Локальный Скинченджер Персонажа (ОБХОД ПАТЧА)
    VisualsTab:Input({ Title = T("SkinChangerInput"), Value = "", Placeholder = "Roblox Username...", Callback = function(t) skinChangerNick = t end })
    VisualsTab:Button({ Title = T("SkinChangerBtn"), Callback = function() changeVisualSkin(skinChangerNick) end })

    -- Вкладка Бой
    UI_Elements.Combat.AutoShootMurderer = CombatTab:Toggle({ Title = T("AutoShoot"), Value = Config.Combat.AutoShootMurderer, Callback = function(s) Config.Combat.AutoShootMurderer = s saveConfig() end })
    UI_Elements.Combat.AimlockEnabled = CombatTab:Toggle({ Title = T("Aimlock"), Value = Config.Combat.AimlockEnabled, Callback = function(s) Config.Combat.AimlockEnabled = s saveConfig() end })
    UI_Elements.Combat.SilentAimEnabled = CombatTab:Toggle({ Title = T("SilentAim"), Value = Config.Combat.SilentAimEnabled, Callback = function(s) Config.Combat.SilentAimEnabled = s saveConfig() end }) 
    CombatTab:Button({ Title = T("ShootM"), Callback = shootMurdererDirect })
    
    -- Авто-уклонение от ножей
    local lastDodgeTime = 0
    UI_Elements.Combat.AutoDodgeKnife = CombatTab:Toggle({ Title = T("DodgeKnife"), Value = Config.Combat.AutoDodgeKnife, Callback = function(state) Config.Combat.AutoDodgeKnife = state saveConfig() end }) 
    
    UI_Elements.Combat.KillAuraEnabled = CombatTab:Toggle({ Title = T("KillAura"), Value = Config.Combat.KillAuraEnabled, Callback = function(s) Config.Combat.KillAuraEnabled = s saveConfig() end })
    UI_Elements.Combat.KillAuraRange = CombatTab:Slider({ Title = T("KillAuraRange"), Step = 5, Value = { Min = 10, Max = 45, Default = Config.Combat.KillAuraRange }, Callback = function(v) Config.Combat.KillAuraRange = v saveConfig() end })
    CombatTab:Button({ Title = T("AutoKillAll"), Callback = autoKillAll })
    
    -- Кнопки Флинга (Выбивания)
    CombatTab:Button({ Title = T("FlingM"), Callback = function() local m = getMurderer() if m then flingPlayer(m) else WindUI:Notify({ Title = "Error", Content = T("NoM"), Icon = "x", Duration = 3 }) end end })
    CombatTab:Button({ Title = T("FlingS"), Callback = function() local sh = getSheriff() if sh then flingPlayer(sh) else WindUI:Notify({ Title = "Error", Content = T("NoS"), Icon = "x", Duration = 3 }) end end })
    CombatTab:Button({ Title = T("FlingH"), Callback = function() local h = getHero() if h then flingPlayer(h) else WindUI:Notify({ Title = "Error", Content = T("NoH"), Icon = "x", Duration = 3 }) end end })

    -- Вкладка Утилиты
    UI_Elements.Utility.AutoGrabGun = UtilityTab:Toggle({ Title = T("AutoGrab"), Value = Config.Utility.AutoGrabGun, Callback = function(s) Config.Utility.AutoGrabGun = s saveConfig() end })
    UI_Elements.Utility.SlideGlitchEnabled = UtilityTab:Toggle({ Title = T("SlideGlitch"), Value = Config.Utility.SlideGlitchEnabled, Callback = function(s) if s ~= Config.Utility.SlideGlitchEnabled then toggleSlideGlitch(s) end end })
    UI_Elements.Utility.SlideSpeedForce = UtilityTab:Slider({ Title = T("SlideSpeed"), Step = 5, Value = { Min = 15, Max = 100, Default = Config.Utility.SlideSpeedForce }, Callback = function(v) Config.Utility.SlideSpeedForce = v saveConfig() end })
    UI_Elements.Utility.NoclipEnabled = UtilityTab:Toggle({ Title = T("Noclip"), Value = Config.Utility.NoclipEnabled, Callback = function(s) if s ~= Config.Utility.NoclipEnabled then toggleNoclip(s) end end })
    
    -- Новые утилиты
    UI_Elements.Utility.AutoFarmCoins = UtilityTab:Toggle({ Title = T("AutoFarmCoins"), Value = Config.Utility.AutoFarmCoins, Callback = function(s) Config.Utility.AutoFarmCoins = s saveConfig() end })
    UI_Elements.Utility.EmoteSpamEnabled = UtilityTab:Toggle({ Title = T("EmoteSpam"), Value = Config.Utility.EmoteSpamEnabled, Callback = function(s) Config.Utility.EmoteSpamEnabled = s saveConfig() end })
    UI_Elements.Utility.ChatAlertsEnabled = UtilityTab:Toggle({ Title = T("ChatAlerts"), Value = Config.Utility.ChatAlertsEnabled, Callback = function(s) Config.Utility.ChatAlertsEnabled = s saveConfig() end })

    UI_Elements.Utility.AntiFling = UtilityTab:Toggle({
        Title = T("AntiFling"), Value = Config.Utility.AntiFling, Callback = function(state)
            applyAntiFling(state)
            saveConfig()
        end
    })

    -- Вкладка Телепорты
    TeleportsTab:Button({ Title = T("TpLobby"), Callback = tpToLobby })
    TeleportsTab:Button({ Title = T("TpMap"), Callback = tpToMap })

    -- Вкладка Тел. Кнопки 
    UI_Elements.MobileButtons.LockMobileButtons = ButtonsTab:Toggle({ Title = T("LockButtons"), Value = Config.MobileButtons.LockMobileButtons, Callback = function(s) Config.MobileButtons.LockMobileButtons = s saveConfig() end })
    UI_Elements.MobileButtons.ButtonScale = ButtonsTab:Slider({ Title = T("BtnScale"), Step = 0.1, Value = { Min = 0.5, Max = 2.0, Default = Config.MobileButtons.ButtonScale }, Callback = function(v) Config.MobileButtons.ButtonScale = v saveConfig() updateButtonSizes() end })
    
    -- Умный автоцикл генерации кнопок
    for name, info in pairs(buttonInfo) do
        UI_Elements.MobileButtons[name] = ButtonsTab:Toggle({
            Title = T(info.Translation),
            Value = Config.MobileButtons[name],
            Callback = function(s)
                Config.MobileButtons[name] = s
                saveConfig()
                if s then
                    createFloatingButton(name, info.Target, info.Callback)
                else
                    removeFloatingButton(name)
                end
            end
        })
    end

    -- Вкладка Конфиги
    ConfigsTab:Button({ Title = T("SaveConfigBtn"), Callback = function() saveConfig() WindUI:Notify({ Title = "FogyHub", Content = T("ConfSaved"), Icon = "check", Duration = 3 }) end })
    ConfigsTab:Button({ Title = T("LoadConfigBtn"), Callback = function() loadConfig() applyConfigToUI() WindUI:Notify({ Title = "FogyHub", Content = T("ConfLoaded"), Icon = "check", Duration = 3 }) end })
    ConfigsTab:Button({ Title = T("ResetConfigBtn"), Callback = function() 
        Config.Visuals = { MurdererESP = false, SheriffESP = false, InnocentESP = false, EspBoxes = false, StretchEnabled = false, StretchFactor = 0.75, NoFogEnabled = false, TimeOfDay = 14 }
        Config.Combat = { AutoShootMurderer = false, AimlockEnabled = false, SilentAimEnabled = false, AutoDodgeKnife = false, KillAuraEnabled = false, KillAuraRange = 25 }
        Config.Utility = { AutoGrabGun = false, SlideGlitchEnabled = false, SlideSpeedForce = 45, NoclipEnabled = false, AntiFling = false, AutoFarmCoins = false, EmoteSpamEnabled = false, ChatAlertsEnabled = false }
        Config.MobileButtons = { LockMobileButtons = false, ButtonScale = 1.0, ["Fling Murderer"] = false, ["Fling Sheriff"] = false, ["Fling Hero"] = false, ["Grab Gun"] = false, ["Slide Glitch"] = false, ["Noclip"] = false, ["Kill Aura"] = false, ["Auto Kill All"] = false, ["Godmode"] = false, ["TP Lobby"] = false, ["TP Map"] = false, ["Aimlock"] = false, ["Shoot Murderer"] = false }
        saveConfig() applyConfigToUI() WindUI:Notify({ Title = "FogyHub", Content = T("ConfReset"), Icon = "check", Duration = 3 }) 
    end })
    ConfigsTab:Button({ Title = T("SetLangRu"), Callback = function() Config.Language = "ru" currentLang = "ru" saveConfig() WindUI:Notify({ Title = "Язык", Content = "Язык успешно изменен на Русский!", Icon = "globe", Duration = 3 }) end })
    ConfigsTab:Button({ Title = T("SetLangEn"), Callback = function() Config.Language = "en" currentLang = "en" saveConfig() WindUI:Notify({ Title = "Language", Content = "Language successfully changed to English!", Icon = "globe", Duration = 3 }) end })

    -- Вкладка Радио
    local _ = RadioTab:Input({ Title = T("RobloxId"), Value = "", Placeholder = "ID...", Callback = function(text) currentSongId = text end })
    RadioTab:Button({ Title = T("PlayId"), Callback = playRadio })
    local _ = RadioTab:Input({ Title = T("HttpUrl"), Value = "", Placeholder = "https://...", Callback = function(text) httpSongUrl = text end })
    RadioTab:Button({ Title = T("PlayHttp"), Callback = playHttpRadio })
    RadioTab:Button({ Title = T("StopRadio"), Callback = stopRadio })
    RadioTab:Slider({ Title = T("Volume"), Step = 0.5, Value = { Min = 0, Max = 10, Default = 2 }, Callback = function(v) radioVolume = v if radioSound then radioSound.Volume = v end end })
    RadioTab:Toggle({ Title = T("Loop"), Value = false, Callback = function(s) radioLooped = s if radioSound then radioSound.Looped = s end end })

    -- Автоматическое восстановление активного Радио
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if radioSound and radioSound.Playing then
            attachRadio()
            if radioModel then
                local sound = radioModel:FindFirstChild("RadioSound") or Instance.new("Sound", radioModel)
                sound.Name = "RadioSound"
                sound.SoundId = radioSound.SoundId
                sound.Volume = radioVolume
                sound.Looped = radioLooped
                sound:Play()
                sound.Volume = radioVolume
                radioSound = sound
            end
        end
    end)

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
                elseif keyStr == "V" then toggleNoclip(not Config.Utility.NoclipEnabled) end
            end
        end
    end)

    -- Оповещения в чат при раскрытии ролей
    local lastMurder, lastSheriff = nil, nil
    local function notifyRolesInChat()
        pcall(function()
            local mPlayer = Murder and Players:FindFirstChild(Murder)
            local sPlayer = Sheriff and Players:FindFirstChild(Sheriff)
            
            local message = ""
            if mPlayer then
                message = message .. "[FogyHub] Убийца: " .. mPlayer.DisplayName .. " (@" .. mPlayer.Name .. ")"
            end
            if sPlayer then
                if message ~= "" then message = message .. " | " end
                message = message .. "Шериф: " .. sPlayer.DisplayName .. " (@" .. sPlayer.Name .. ")"
            end
            
            if message ~= "" then
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = message,
                    Color = Color3.fromRGB(0, 150, 255),
                    Font = Enum.Font.SourceSansBold,
                    TextSize = 15
                })
            end
        end)
    end

    -- Оптимизированный ESP обработчик
    local function updateESP()
        local success, serverRoles = pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
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
            
            if Config.Utility.ChatAlertsEnabled then
                if Murder ~= lastMurder or Sheriff ~= lastSheriff then
                    lastMurder = Murder
                    lastSheriff = Sheriff
                    task.spawn(notifyRolesInChat)
                end
            end
        end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local character = player.Character
                if character then
                    local isM, isS, isH = false, false, false
                    local alive = IsAlive(player)
                    
                    if player.Name == Murder and alive then
                        isM = true
                    elseif player.Name == Sheriff and alive then
                        isS = true
                    elseif player.Name == Hero and alive then
                        local sheriffPlayer = Sheriff and Players:FindFirstChild(Sheriff)
                        if sheriffPlayer and not IsAlive(sheriffPlayer) then
                            isH = true
                        end
                    end
                    
                    local inLobby = false
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distToLobby = (hrp.Position - Vector3.new(6.0, 505.2, -35.0)).Magnitude
                        if distToLobby < 150 then
                            inLobby = true
                        end
                    end
                    
                    local espEnabled = false
                    local renderColor = Color3.fromRGB(0, 255, 0)
                    
                    if not alive or inLobby then
                        if Config.Visuals.MurdererESP or Config.Visuals.SheriffESP or Config.Visuals.InnocentESP then
                            espEnabled = true
                            renderColor = Color3.fromRGB(150, 150, 150)
                        end
                    else
                        if isM then
                            espEnabled = Config.Visuals.MurdererESP
                            renderColor = Color3.fromRGB(255, 0, 0)
                        elseif isS then
                            espEnabled = Config.Visuals.SheriffESP
                            renderColor = Color3.fromRGB(0, 0, 255)
                        elseif isH then
                            espEnabled = Config.Visuals.SheriffESP
                            renderColor = Color3.fromRGB(255, 250, 0)
                        else
                            espEnabled = Config.Visuals.InnocentESP
                            renderColor = Color3.fromRGB(0, 255, 0)
                        end
                    end
                    
                    if espEnabled then
                        applyHighlight(player, renderColor)
                    else
                        removeHighlight(player)
                    end

                    if Config.Visuals.EspBoxes then
                        applyBoxESP(player, renderColor)
                    else
                        removeBoxESP(player)
                    end
                end
            end
        end
    end

    -- Запуск цикла ESP
    task.spawn(function()
        while true do
            pcall(updateESP)
            task.wait(0.1)
        end
    end)

    -- Цикл автоподбора пистолета
    task.spawn(function()
        while true do
            pcall(function()
                if Config.Utility.AutoGrabGun then
                    local char = LocalPlayer.Character
                    local bp = LocalPlayer:FindFirstChild("Backpack")
                    local isMurderer = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) or (Murder and LocalPlayer.Name == Murder)
                    
                    if IsAlive(LocalPlayer) and not isMurderer then
                        if (workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)) then 
                            grabGun() 
                            task.wait(1) 
                        end
                    end
                end
            end)
            task.wait(0.2)
        end
    end)

    -- Цикл автофарма монет
    local function getCoinsOnMap()
        local coins = {}
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name == "Coin_Highlight" or v.Name == "CoinContainer" or v.Name == "Coin") then
                table.insert(coins, v)
            end
        end
        return coins
    end

    task.spawn(function()
        while true do
            pcall(function()
                if Config.Utility.AutoFarmCoins then
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local coins = getCoinsOnMap()
                        local nearestCoin, minDist = nil, math.huge
                        
                        for _, coin in ipairs(coins) do
                            local dist = (coin.Position - hrp.Position).Magnitude
                            if dist < minDist then
                                minDist = dist
                                nearestCoin = coin
                            end
                        end
                        
                        if nearestCoin then
                            local stepConn
                            stepConn = RunService.Heartbeat:Connect(function(dt)
                                if not Config.Utility.AutoFarmCoins or not nearestCoin or not nearestCoin.Parent or not hrp.Parent then
                                    if stepConn then stepConn:Disconnect() end
                                    return
                                end
                                local dir = (nearestCoin.Position - hrp.Position).Unit
                                hrp.CFrame = hrp.CFrame + (dir * (22 * dt))
                                if (nearestCoin.Position - hrp.Position).Magnitude < 4 then
                                    if stepConn then stepConn:Disconnect() end
                                end
                            end)
                            
                            local timeout = 0
                            while nearestCoin and nearestCoin.Parent and Config.Utility.AutoFarmCoins and timeout < 100 do
                                if (nearestCoin.Position - hrp.Position).Magnitude < 4 then break end
                                task.wait(0.05)
                                timeout = timeout + 1
                            end
                            if stepConn then stepConn:Disconnect() end
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)

    -- Цикл Спама Эмоций
    task.spawn(function()
        while true do
            pcall(function()
                if Config.Utility.EmoteSpamEnabled then
                    local playEmote = game:GetService("ReplicatedStorage"):FindFirstChild("PlayEmote")
                    if playEmote and playEmote:IsA("RemoteEvent") then
                        playEmote:FireServer("zen")
                        task.wait(0.1)
                        playEmote:FireServer("sit")
                    end
                end
            end)
            task.wait(0.2)
        end
    end)

    -- Цикл авто-выстрела
    task.spawn(function()
        while true do
            pcall(function()
                if Config.Combat.AutoShootMurderer then
                    local char = LocalPlayer.Character
                    local gun = char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))
                    if gun then
                        local m = getMurderer()
                        if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                            fireGun(gun, m.Character.HumanoidRootPart.Position) 
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)

    -- Аимлок
    RunService.RenderStepped:Connect(function()
        pcall(function()
            if Config.Combat.AimlockEnabled then
                local m = getMurderer()
                if m and m.Character and m.Character:FindFirstChild("Head") then
                    local camera = workspace.CurrentCamera
                    if camera then 
                        local targetCFrame = CFrame.lookAt(camera.CFrame.Position, m.Character.Head.Position)
                        camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.15)
                    end
                end
            end
        end)
    end)

    -- Бесконечный спидглитч
    RunService.Heartbeat:Connect(function(deltaTime)
        pcall(function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and hum and Config.Utility.SlideGlitchEnabled and hum.MoveDirection.Magnitude > 0 then
                local slideVector = Vector3.new(hum.MoveDirection.X, 0, hum.MoveDirection.Z).Unit
                hrp.CFrame = hrp.CFrame + (slideVector * (Config.Utility.SlideSpeedForce * deltaTime))
            end
        end)
    end)

    -- Silent Aim (ПЕРЕДОВОЙ СЕТЕВОЙ ПЕРЕХВАТ ПУЛИ В ТАРГЕТ)
    pcall(function()
        if hookmetamethod then
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if Config.Combat.SilentAimEnabled then
                    local m = getMurderer()
                    if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPos = m.Character.HumanoidRootPart.Position
                        -- Хук для современных копий игры (RemoteEvent)
                        if method == "FireServer" and (self.Name == "Shoot" or self.Name == "Fire") and self.Parent == LocalPlayer.Character:FindFirstChild("Gun") then
                            local origin = args[1] and args[1].Position or LocalPlayer.Character.HumanoidRootPart.Position
                            args[1] = CFrame.new(origin, targetPos)
                            args[2] = targetPos
                            return oldNamecall(self, unpack(args))
                        -- Хук для классических серверов (RemoteFunction)
                        elseif method == "InvokeServer" and self.Name == "ShootGun" then
                            args[2] = targetPos
                            args[3] = targetPos
                            return oldNamecall(self, unpack(args))
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
        end
    end)

    -- Kill Aura
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if not Config.Combat.KillAuraEnabled then return end
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
                            if dist <= Config.Combat.KillAuraRange then
                                knife:Activate()
                                pcall(function()
                                    local targetPart = victim.Character:FindFirstChild("HumanoidRootPart") or victim.Character:FindFirstChild("Torso") or victim.Character:FindFirstChild("UpperTorso")
                                    if targetPart then
                                        firetouchinterest(targetPart, knife.Handle, 0)
                                        firetouchinterest(targetPart, knife.Handle, 1)
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end)

    -- Noclip
    RunService.Stepped:Connect(function()
        pcall(function()
            if not Config.Utility.NoclipEnabled then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end)

    -- Потоковая проверка для авто-уклонения
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if not Config.Combat.AutoDodgeKnife then return end
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "ThrownKnife" and obj:IsA("BasePart") then
                    local distance = (hrp.Position - obj.Position).Magnitude
                    
                    if distance < 22 and (tick() - lastDodgeTime > 0.6) then
                        lastDodgeTime = tick()
                        
                        local targetCFrame = hrp.CFrame + (hrp.CFrame.RightVector * 14)
                        
                        local wasAnchored = hrp.Anchored
                        hrp.Anchored = true
                        hrp.CFrame = targetCFrame
                        char:PivotTo(targetCFrame)
                        task.wait(0.04)
                        hrp.Anchored = wasAnchored
                        break
                    end
                end
            end
        end)
    end)

    -- Проверка на неофициальный сервер
    task.spawn(function()
        task.wait(1.5)
        local officialMM2Ids = {142823291, 3383406159}
        if not table.find(officialMM2Ids, game.PlaceId) then
            WindUI:Notify({
                Title = T("MMBWarningTitle"),
                Content = T("MMBWarningContent"),
                Icon = "alert-triangle",
                Duration = 6
            })
        end
    end)

    -- Автоматическое применение конфига
    task.spawn(function()
        task.wait(0.5)
        applyConfigToUI()
    end)

    WindUI:Notify({ Title = "FogyHub", Content = T("Loaded"), Icon = "shield", Duration = 3 })
end

-- ==================== ИНИЦИАЛИЗАЦИЯ И ИНТЕРАКТИВНЫЙ ВЫБОР ЯЗЫКА ====================
local container = getSafeUIContainer()
if container then
    local saveFileName = "fogyhub_lang.txt"
    local hasSavedLang = false
    
    if readfile and isfile and isfile(saveFileName) then
        local saved = pcall(function() return readfile(saveFileName) end) and readfile(saveFileName)
        if saved == "ru" or saved == "en" then
            currentLang = saved
            hasSavedLang = true
        end
    end
    
    if hasSavedLang or isfile(configFileName) then
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
            Config.Language = "ru"
            if writefile then pcall(function() writefile(saveFileName, "ru") end) end
            saveConfig()
            langGui:Destroy()
            xpcall(main, showCrashMenu)
        end)
        
        createLangButton("English", UDim2.new(0.52, 0, 0.5, 0), function()
            currentLang = "en"
            Config.Language = "en"
            if writefile then pcall(function() writefile(saveFileName, "en") end) end
            saveConfig()
            langGui:Destroy()
            xpcall(main, showCrashMenu)
        end)
    end
else
    xpcall(main, showCrashMenu)
end
