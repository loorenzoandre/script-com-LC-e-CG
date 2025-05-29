-- ui.lua
-- Painel visual LC & CG

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ESPButton = Instance.new("TextButton")
local WallhackButton = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")

ScreenGui.Name = "LCCG_GUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 250)

local function createButton(name, position, text, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = Frame
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Position = position
    button.Size = UDim2.new(0, 180, 0, 50)
    button.Font = Enum.Font.SourceSans
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18.0
    button.MouseButton1Click:Connect(callback)
    return button
end

createButton("ESPButton", UDim2.new(0, 10, 0, 10), "Ativar ESP", function()
    print("ESP ativado!")
end)

createButton("WallhackButton", UDim2.new(0, 10, 0, 70), "Ativar Wallhack", function()
    print("Wallhack ativado!")
end)

createButton("FlyButton", UDim2.new(0, 10, 0, 130), "Ativar Fly", function()
    print("Fly ativado!")
end)