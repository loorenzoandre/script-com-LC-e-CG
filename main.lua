-- main.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Utils = require(script.Parent.utils) -- ajusta o caminho conforme estrutura
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local flying = false
local flyVelocity

-- Lógica Fly toggleável
local function toggleFly(state)
    flying = state
    if flying then
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyVelocity.Parent = hrp
    else
        if flyVelocity then
            flyVelocity:Destroy()
            flyVelocity = nil
        end
    end
end

-- Atualizar fly velocity com input
RunService.Heartbeat:Connect(function()
    if flying and flyVelocity then
        local moveDirection = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        flyVelocity.Velocity = moveDirection.Unit * 50
    end
end)

-- Toggle ESP
local espEnabled = false

local function toggleESP(state)
    espEnabled = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            if espEnabled then
                local color = Utils.isEnemy(plr) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                Utils.createESPBox(plr)
                Utils.createHighlight(plr.Character, color)
            else
                Utils.removeESPBox(plr)
                Utils.removeHighlight(plr.Character)
            end
        end
    end
end

-- AutoFarm simples (exemplo básico)
local autoFarmEnabled = false
local autoFarmConnection

local function startAutoFarm()
    autoFarmEnabled = true
    autoFarmConnection = RunService.Heartbeat:Connect(function()
        -- Aqui vc bota lógica de auto atacar NPCs ou coletar itens
        -- Exemplo: andar pra NPC mais perto
    end)
end

local function stopAutoFarm()
    autoFarmEnabled = false
    if autoFarmConnection then
        autoFarmConnection:Disconnect()
        autoFarmConnection = nil
    end
end

-- Receber evento dos toggles do UI (supondo que use Attributes)
local function onAttributeChanged(gui, attrName)
    local value = gui:GetAttribute(attrName)
    if attrName == "ESP" then
        toggleESP(value)
    elseif attrName == "Fly" then
        toggleFly(value)
    elseif attrName == "AutoFarm" then
        if value then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end
    -- Pode adicionar mais toggles aqui
end

local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("LC_CG_HUB")

screenGui:GetPropertyChangedSignal("Attributes"):Connect(function()
    -- Aqui é para caso queira tratar mudanças gerais, mas Attributes mudam individualmente
end)

-- Pra garantir captura das mudanças em cada atributo toggle, usa loop
for _, attr in pairs({"ESP", "Fly", "AutoFarm"}) do
    screenGui:GetAttributeChangedSignal(attr):Connect(function()
        onAttributeChanged(screenGui, attr)
    end)
end
