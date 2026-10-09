-- Traechka Hub
-- UI template for your own Roblox Studio experience

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TraechkaHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function round(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

local function makeLabel(parent, text, size, position, fontSize)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.Font = Enum.Font.Gotham
    label.TextSize = fontSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    return label
end

local window = Instance.new("Frame")
window.Parent = gui
window.Size = UDim2.fromOffset(650, 420)
window.Position = UDim2.new(0.5, -325, 0.5, -210)
window.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
window.BorderSizePixel = 0
round(window, 10)

local header = Instance.new("Frame")
header.Parent = window
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
header.BorderSizePixel = 0
round(header, 10)

makeLabel(
    header,
    "Traechka Hub",
    UDim2.new(1, -24, 1, 0),
    UDim2.fromOffset(16, 0),
    20
)

local nav = Instance.new("Frame")
nav.Parent = window
nav.Position = UDim2.fromOffset(12, 60)
nav.Size = UDim2.fromOffset(150, 300)
nav.BackgroundTransparency = 1

local navLayout = Instance.new("UIListLayout")
navLayout.Parent = nav
navLayout.Padding = UDim.new(0, 7)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder

local content = Instance.new("Frame")
content.Parent = window
content.Position = UDim2.fromOffset(174, 60)
content.Size = UDim2.fromOffset(464, 300)
content.BackgroundColor3 = Color3.fromRGB(19, 19, 23)
content.BorderSizePixel = 0
round(content, 8)

local sectionTitle = makeLabel(
    content,
    "Main",
    UDim2.new(1, -24, 0, 36),
    UDim2.fromOffset(12, 8),
    18
)

local featureList = Instance.new("Frame")
featureList.Parent = content
featureList.Position = UDim2.fromOffset(12, 48)
featureList.Size = UDim2.new(1, -24, 1, -60)
featureList.BackgroundTransparency = 1

local featureLayout = Instance.new("UIListLayout")
featureLayout.Parent = featureList
featureLayout.Padding = UDim.new(0, 7)
featureLayout.SortOrder = Enum.SortOrder.LayoutOrder

local status = makeLabel(
    window,
    "Выбери вкладку слева",
    UDim2.new(1, -24, 0, 35),
    UDim2.fromOffset(174, 370),
    12
)
status.TextColor3 = Color3.fromRGB(170, 170, 180)

local features = {
    ["Main"] = {
        "Настройки движения (макет)",
        "Полёт (макет)",
        "Телепортация (макет)",
        "Прыжки (макет)"
    },

    ["Combat"] = {
        "Автоподбор пистолета — макет",
        "Настройки стрельбы — макет",
        "Хитбокс ножа — макет",
        "Fling — макет"
    },

    ["Players"] = {
        "Список игроков",
        "Телепортация — макет",
        "Действия с игроками — макет"
    },

    ["Visuals"] = {
        "Подсветка ролей — макет",
        "Поиск монет — макет",
        "Поиск выпавшего пистолета — макет"
    },

    ["Trolling"] = {
        "B-hop — макет",
        "Настройки прыжков — макет"
    },

    ["Vote Dupe Map"] = {
        "Выбор карты — макет",
        "Голосование — макет"
    }
}

local tabButtons = {}

local function showTab(tabName)
    sectionTitle.Text = tabName

    for _, child in ipairs(featureList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for name, button in pairs(tabButtons) do
        button.BackgroundColor3 =
            name == tabName
            and Color3.fromRGB(65, 65, 78)
            or Color3.fromRGB(30, 30, 36)
    end

    for index, featureName in ipairs(features[tabName]) do
        local button = Instance.new("TextButton")
        button.Parent = featureList
        button.LayoutOrder = index
        button.Size = UDim2.new(1, 0, 0, 38)
        button.BackgroundColor3 = Color3.fromRGB(31, 31, 37)
        button.BorderSizePixel = 0
        button.Text = featureName
        button.TextColor3 = Color3.fromRGB(235, 235, 240)
        button.Font = Enum.Font.Gotham
        button.TextSize = 12
        button.TextXAlignment = Enum.TextXAlignment.Left
        round(button, 6)

        local padding = Instance.new("UIPadding")
        padding.Parent = button
        padding.PaddingLeft = UDim.new(0, 10)

        button.MouseButton1Click:Connect(function()
            status.Text = "Макет: " .. featureName
                .. " — игровой эффект не подключён."
        end)
    end

    status.Text = "Открыта вкладка: " .. tabName
end

for index, tabName in ipairs({
    "Main",
    "Combat",
    "Players",
    "Visuals",
    "Trolling",
    "Vote Dupe Map"
}) do
    local button = Instance.new("TextButton")
    button.Parent = nav
    button.LayoutOrder = index
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    button.BorderSizePixel = 0
    button.Text = tabName
    button.TextColor3 = Color3.fromRGB(235, 235, 240)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    round(button, 6)

    tabButtons[tabName] = button

    button.MouseButton1Click:Connect(function()
        showTab(tabName)
    end)
end

showTab("Main")
