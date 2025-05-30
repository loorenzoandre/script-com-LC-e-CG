-- ui.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar tela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LC_CG_HUB"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Fundo escuro com neon
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Glow neon no contorno
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 255, 255)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Título animado
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "LC & CG HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.Arcade
title.TextSize = 28
title.Parent = mainFrame

-- Função para piscar o título neon
spawn(function()
    while true do
        for i = 0, 1, 0.05 do
            title.TextColor3 = Color3.new(0, i, i)
            wait(0.03)
        end
        for i = 1, 0, -0.05 do
            title.TextColor3 = Color3.new(0, i, i)
            wait(0.03)
        end
    end
end)

-- Função auxiliar para criar botão toggle
local function createToggleButton(text, parent, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 300, 0, 50)
    button.Position = UDim2.new(0, 25, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Text = text .. ": OFF"
    button.Parent = parent
    button.AutoButtonColor = false

    local toggled = false
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 150)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(15, 15, 15)
    end)

    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        button.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(15, 15, 15)
        button.Text = text .. (toggled and ": ON" or ": OFF")
        screenGui:SetAttribute(text, toggled)
    end)

    return button
end

-- Botões toggle no painel (com espaço entre eles)
local espToggle = createToggleButton("ESP", mainFrame, 60)
local flyToggle = createToggleButton("Fly", mainFrame, 120)
local wallhackToggle = createToggleButton("WallHack", mainFrame, 180)
local autofarmToggle = createToggleButton("AutoFarm", mainFrame, 240)

-- Sliders para speed e jump
local function createSlider(text, parent, posY, minVal, maxVal, defaultVal)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 0, 25)
    label.Position = UDim2.new(0, 25, 0, posY)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Text = text .. ": " .. tostring(defaultVal)
    label.Parent = parent

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 300, 0, 20)
    slider.Position = UDim2.new(0, 25, 0, posY + 30)
    slider.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    slider.Parent = parent

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 1, 0)
    knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    knob.Parent = slider

    knob.Active = true
    knob.Draggable = true

    knob.DragStopped:Connect(function()
        local relativePos = math.clamp((knob.Position.X.Scale), 0, 1)
        local value = math.floor(minVal + relativePos * (maxVal - minVal))
        knob.Position = UDim2.new(relativePos, 0, 0, 0)
        label.Text = text .. ": " .. value
        screenGui:SetAttribute(text, value)
    end)

    return slider
end

createSlider("WalkSpeed", mainFrame, 300, 16, 150, 16)
createSlider("JumpPower", mainFrame, 360, 50, 250, 50)

-- Botão fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
