-- utils.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Utils = {}

-- Função pra criar highlight (wallhack)
function Utils.createHighlight(target, color)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = target
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = target
    return highlight
end

-- Função pra remover highlight
function Utils.removeHighlight(target)
    for _, child in pairs(target:GetChildren()) do
        if child:IsA("Highlight") then
            child:Destroy()
        end
    end
end

-- Função pra criar ESP box (usando BillboardGui)
function Utils.createESPBox(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end

    local hrp = character.HumanoidRootPart

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPBox"
    billboard.Adornee = hrp
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.AlwaysOnTop = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderColor3 = Color3.new(1, 0, 0)
    frame.BorderSizePixel = 2
    frame.Parent = billboard

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 0, 20)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 14
    text.Text = player.Name
    text.Parent = billboard

    billboard.Parent = player.Character.HumanoidRootPart

    return billboard
end

-- Função pra remover ESP box
function Utils.removeESPBox(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    local espBox = hrp:FindFirstChild("ESPBox")
    if espBox then
        espBox:Destroy()
    end
end

-- Função pra detectar inimigos e aliados (exemplo simples)
function Utils.isEnemy(player)
    -- Aqui vc pode colocar sua lógica, exemplo:
    -- return player.Team ~= game.Players.LocalPlayer.Team
    return true -- por enquanto tudo é inimigo
end

return Utils
