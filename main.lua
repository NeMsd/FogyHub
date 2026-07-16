-- ======================================================
-- FogyHub Official Loader (MsD & Gemini)
-- Bypasses Prometheus VM "newproxy" nil crashes on Delta/Solara
-- ======================================================

local gp = getgenv and getgenv() or _G

-- Жесткий глобальный полифилл для обфускаторов
if not gp.newproxy then
    local function np(bool)
        return setmetatable({}, {__metatable = bool and false or nil})
    end
    gp.newproxy = np
    _G.newproxy = np
    if shared then shared.newproxy = np end
end

-- Запуск основного кода
loadstring(game:HttpGet("https://raw.githubusercontent.com/NeMsd/FogyHub/refs/heads/main/source.lua"))()
