-- Custom Adopt Me Auto Farm GUI
-- Pink and yellow gradient theme

-- Game Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- Character References
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Character Added Event
LocalPlayer.CharacterAdded:Connect(function(Char)
    Character = Char
    Humanoid = Char:WaitForChild("Humanoid")
    HumanoidRootPart = Char:WaitForChild("HumanoidRootPart")
end)

-- Variables
local AutoFarm = false
local PetTasksActive = false
local BabyTasksActive = false
local AutoAge = false
local AutoBuild = false
local AutoFish = false
local AutoShower = false
local AutoSleep = false
local AutoHungry = false
local AutoThirsty = false
local AutoBored = false
local AutoSchool = false
local AutoCamping = false
local AutoSick = false
local AutoPizzaParty = false
local AutoFamilyPlanning = false

-- Important Locations
local Locations = {
    ["Main Map"] = CFrame.new(-247, 17, 1606),
    ["Nursery"] = CFrame.new(-248, 17, 1533),
    ["Coffee Shop"] = CFrame.new(365, 17, 1181),
    ["Pizza Shop"] = CFrame.new(953, 14, 1050),
    ["Playground"] = CFrame.new(-304, 17, 2192),
    ["School"] = CFrame.new(99, 17, 2345),
    ["Salon"] = CFrame.new(-1698, 14, -8),
    ["Pet Shop"] = CFrame.new(266, 17, 1456),
    ["Clothing Store"] = CFrame.new(-784, 14, -780),
    ["Hospital"] = CFrame.new(85, 17, 1911),
    ["Grocery Store"] = CFrame.new(-41, 17, 999),
    ["Campsite"] = CFrame.new(-1019, 17, 652),
    ["Gifts"] = CFrame.new(45, 17, 1560),
    ["Furniture Store"] = CFrame.new(-4380, 16, 767),
    ["Home Improvement"] = CFrame.new(-4481, 15, 982),
    ["Ice Cream Shop"] = CFrame.new(735, 17, -1275),
    ["Auto Shop"] = CFrame.new(549, 17, -1698),
    ["Gym"] = CFrame.new(-1304, 17, -215),
    ["Sky Castle"] = CFrame.new(-180, 130, 1748),
    ["Hot Springs"] = CFrame.new(-576, 17, 411),
    ["Pool"] = CFrame.new(-114, 17, 2124),
    ["Estate Agents"] = CFrame.new(-376, 17, 1139),
    ["Spirit Showdown"] = CFrame.new(-855, 17, 1394),
    ["Cave"] = CFrame.new(2895, 12, 528),
    ["AFK Spot"] = CFrame.new(0, 500, 0)
}

-- Functions
local function Teleport(location)
    if typeof(location) == "string" then
        if Locations[location] then
            HumanoidRootPart.CFrame = Locations[location]
        end
    elseif typeof(location) == "CFrame" then
        HumanoidRootPart.CFrame = location
    end
end

local function GetPetsEquipped()
    local pets = {}
    for _, pet in pairs(workspace.Pets:GetChildren()) do
        if pet:FindFirstChild("Owner") and pet.Owner.Value == LocalPlayer then
            table.insert(pets, pet)
        end
    end
    return pets
end

local function UseObject(object, name, useType)
    -- Default parameters if not specified
    useType = useType or "StartTask"
    
    -- Simulate using an object in the game
    local args = {
        [1] = name,
        [2] = useType
    }
    ReplicatedStorage.Remote.PlayerAPI:FireServer(unpack(args))
    wait(5) -- Wait for task animation
    
    -- End the task if it was started
    if useType == "StartTask" then
        local args = {
            [1] = name,
            [2] = "EndTask"
        }
        ReplicatedStorage.Remote.PlayerAPI:FireServer(unpack(args))
    end
end

local function BuyItem(itemName, itemType)
    -- Simulate buying an item
    local args = {
        [1] = itemName,
        [2] = "BuyItem",
        [3] = itemType
    }
    ReplicatedStorage.Remote.ShopAPI:FireServer(unpack(args))
end

local function UseConsumable(itemName)
    -- Simulate using a consumable item
    local args = {
        [1] = itemName,
        [2] = "UseConsumable"
    }
    ReplicatedStorage.Remote.InventoryAPI:FireServer(unpack(args))
end

-- Pet Tasks Function
local function DoPetTasks()
    while PetTasksActive do
        local pets = GetPetsEquipped()
        if #pets > 0 then
            -- Handle hunger
            if AutoHungry then
                Teleport("Grocery Store")
                wait(1)
                BuyItem("Apple", "Food")
                wait(0.5)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Apple",
                        [2] = "FeedPet",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(0.5)
                end
            end
            
            -- Handle thirst
            if AutoThirsty then
                Teleport("Coffee Shop")
                wait(1)
                BuyItem("Water", "Drink")
                wait(0.5)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Water",
                        [2] = "HydratePet",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(0.5)
                end
            end
            
            -- Handle sleep
            if AutoSleep then
                Teleport("AFK Spot")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Sleep",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Sleep",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle boredom
            if AutoBored then
                Teleport("Playground")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Play",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Play",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle shower
            if AutoShower then
                Teleport("AFK Spot")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Bath",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Bath",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle school
            if AutoSchool then
                Teleport("School")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "School",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "School",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle camping
            if AutoCamping then
                Teleport("Campsite")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Camping",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Camping",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle sickness
            if AutoSick then
                Teleport("Hospital")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Healing",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Healing",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
        end
        wait(1)
    end
end

-- Baby Tasks Function
local function DoBabyTasks()
    while BabyTasksActive do
        -- Handle hunger
        if AutoHungry then
            Teleport("Pizza Shop")
            wait(1)
            UseObject(nil, "Pizza", "BuyFood")
            wait(0.5)
            UseObject(nil, "Pizza", "Eat")
        end
        
        -- Handle thirst
        if AutoThirsty then
            Teleport("Coffee Shop")
            wait(1)
            UseObject(nil, "Coffee", "BuyDrink")
            wait(0.5)
            UseObject(nil, "Coffee", "Drink")
        end
        
        -- Handle sleep
        if AutoSleep then
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Sleep", "StartTask")
        end
        
        -- Handle boredom
        if AutoBored then
            Teleport("Playground")
            wait(1)
            UseObject(nil, "Playground", "StartTask")
        end
        
        -- Handle shower
        if AutoShower then
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Shower", "StartTask")
        end
        
        -- Handle school
        if AutoSchool then
            Teleport("School")
            wait(1)
            UseObject(nil, "School", "StartTask")
        end
        
        -- Handle camping
        if AutoCamping then
            Teleport("Campsite")
            wait(1)
            UseObject(nil, "Camping", "StartTask")
        end
        
        -- Handle sickness
        if AutoSick then
            Teleport("Hospital")
            wait(1)
            UseObject(nil, "Hospital", "StartTask")
        end
        
        wait(1)
    end
end

-- Auto Aging Function
local function DoAutoAge()
    while AutoAge do
        -- Check if we are a baby
        local isBaby = LocalPlayer:FindFirstChild("PlayerGrowth") and LocalPlayer.PlayerGrowth.Value < 100
        
        if isBaby then
            -- Do all baby tasks
            Teleport("Pizza Shop")
            wait(1)
            UseObject(nil, "Pizza", "BuyFood")
            wait(0.5)
            UseObject(nil, "Pizza", "Eat")
            
            Teleport("Coffee Shop")
            wait(1)
            UseObject(nil, "Coffee", "BuyDrink")
            wait(0.5)
            UseObject(nil, "Coffee", "Drink")
            
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Sleep", "StartTask")
            
            Teleport("Playground")
            wait(1)
            UseObject(nil, "Playground", "StartTask")
            
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Shower", "StartTask")
            
            Teleport("School")
            wait(1)
            UseObject(nil, "School", "StartTask")
            
            Teleport("Campsite")
            wait(1)
            UseObject(nil, "Camping", "StartTask")
            
            Teleport("Hospital")
            wait(1)
            UseObject(nil, "Hospital", "StartTask")
        end
        
        wait(5)
    end
end

-- Auto Build Function
local function DoAutoBuild()
    while AutoBuild do
        -- Simulate building furniture
        Teleport("Furniture Store")
        wait(1)
        
        local args = {
            [1] = "Basic Bed",
            [2] = "BuyFurniture"
        }
        ReplicatedStorage.Remote.HousingAPI:FireServer(unpack(args))
        
        wait(0.5)
        
        local args = {
            [1] = "Basic Bed",
            [2] = "PlaceFurniture",
            [3] = CFrame.new(0, 0, 0)
        }
        ReplicatedStorage.Remote.HousingAPI:FireServer(unpack(args))
        
        wait(5)
    end
end

-- Auto Fish Function
local function DoAutoFish()
    while AutoFish do
        -- Simulate fishing
        Teleport("Hot Springs")
        wait(1)
        
        local args = {
            [1] = "FishingRod",
            [2] = "StartFishing"
        }
        ReplicatedStorage.Remote.ToolAPI:FireServer(unpack(args))
        
        wait(10) -- Wait for fish to bite
        
        local args = {
            [1] = "FishingRod",
            [2] = "CatchFish"
        }
        ReplicatedStorage.Remote.ToolAPI:FireServer(unpack(args))
        
        wait(2)
    end
end

-- Custom GUI Creation
-- Colors and Design Constants
local Colors = {
    Background = Color3.fromRGB(45, 45, 45),
    BackgroundTransparent = Color3.fromRGB(35, 35, 35),
    Border = Color3.fromRGB(0, 0, 0),
    Text = Color3.fromRGB(255, 255, 255),
    ButtonDefault = Color3.fromRGB(85, 85, 85),
    ButtonHover = Color3.fromRGB(100, 100, 100),
    ToggleOff = Color3.fromRGB(255, 100, 100),
    ToggleOn = Color3.fromRGB(100, 255, 100),
    Pink = Color3.fromRGB(255, 105, 180),
    Yellow = Color3.fromRGB(255, 215, 0),
    Gradient1 = Color3.fromRGB(255, 150, 200), -- Light Pink
    Gradient2 = Color3.fromRGB(255, 240, 150)  -- Light Yellow
}

-- Create Rounded Corners
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
    return corner
end

-- Create Gradient
local function CreateGradient(parent, rotation, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Colors.Gradient1),
        ColorSequenceKeypoint.new(1, color2 or Colors.Gradient2)
    })
    gradient.Parent = parent
    return gradient
end

-- Create Shadow Effect
local function CreateShadow(parent, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Parent = parent
    return shadow
end

-- Create Text Label
local function CreateLabel(parent, text, size, position, textSize, textColor)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size or UDim2.new(1, 0, 0, 20)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextSize = textSize or 14
    label.TextColor3 = textColor or Colors.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

-- Create Button
local function CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.BackgroundColor3 = Colors.ButtonDefault
    button.Size = size or UDim2.new(1, -20, 0, 30)
    button.Position = position or UDim2.new(0, 10, 0, 30)
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextSize = 14
    button.TextColor3 = Colors.Text
    button.Parent = parent
    
    -- Add rounded corners and gradient
    CreateCorner(button, 8)
    CreateGradient(button, 90)
    
    -- Add shadow for 3D effect
    CreateShadow(button, 0.7)
    
    -- Add hover and click effects
    button.MouseEnter:Connect(function()
        button:TweenSize(UDim2.new(1, -16, 0, 32), "Out", "Quad", 0.2, true)
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(size or UDim2.new(1, -20, 0, 30), "Out", "Quad", 0.2, true)
    end)
    
    button.MouseButton1Click:Connect(function()
        button:TweenSize(UDim2.new(1, -24, 0, 28), "Out", "Quad", 0.1, true)
        wait(0.1)
        button:TweenSize(size or UDim2.new(1, -20, 0, 30), "Out", "Quad", 0.1, true)
        callback()
    end)
    
    return button
end

-- Create Toggle
local function CreateToggle(parent, text, size, position, default, callback)
    local toggleContainer = Instance.new("Frame")
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.Size = size or UDim2.new(1, -20, 0, 30)
    toggleContainer.Position = position or UDim2.new(0, 10, 0, 30)
    toggleContainer.Parent = parent
    
    local label = CreateLabel(toggleContainer, text, UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 0, 0, 0), 14)
    
    local toggle = Instance.new("Frame")
    toggle.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -40, 0.5, -10)
    toggle.Parent = toggleContainer
    
    CreateCorner(toggle, 10)
    
    local indicator = Instance.new("Frame")
    indicator.BackgroundColor3 = Colors.Text
    indicator.Size = UDim2.new(0, 16, 0, 16)
    indicator.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    indicator.Parent = toggle
    
    CreateCorner(indicator, 8)
    
    local value = default or false
    
    local button = Instance.new("TextButton")
    button.BackgroundTransparency = 1
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Text = ""
    button.Parent = toggleContainer
    
    button.MouseButton1Click:Connect(function()
        value = not value
        
        if value then
            toggle.BackgroundColor3 = Colors.ToggleOn
            indicator:TweenPosition(UDim2.new(1, -18, 0.5, -8), "Out", "Quad", 0.2, true)
        else
            toggle.BackgroundColor3 = Colors.ToggleOff
            indicator:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.2, true)
        end
        
        callback(value)
    end)
    
    return toggleContainer, value
end

-- Create Tab System
local function CreateTabButton(parent, text, tabContent, selectedTab, tabButtons)
    local tabButton = Instance.new("TextButton")
    tabButton.BackgroundColor3 = Colors.ButtonDefault
    tabButton.Size = UDim2.new(1/#{}, 0, 1, 0)
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.Text = text
    tabButton.TextSize = 14
    tabButton.TextColor3 = Colors.Text
    tabButton.Parent = parent
-- Add gradient
    CreateGradient(tabButton, 90)
    
    -- Store the tab content
    tabButton.TabContent = tabContent
    
    -- Add to table of tab buttons
    table.insert(tabButtons, tabButton)
    
    -- Position the tab button
    tabButton.Position = UDim2.new((#tabButtons-1)/(#{} or 1), 0, 0, 0)
    
    -- Add click event
    tabButton.MouseButton1Click:Connect(function()
        selectedTab.Value = tabButton
    end)
    
    -- Create underline indicator for active tab
    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.BackgroundColor3 = Colors.Yellow
    underline.Size = UDim2.new(1, 0, 0, 2)
    underline.Position = UDim2.new(0, 0, 1, -2)
    underline.Visible = false
    underline.Parent = tabButton
    
    return tabButton
end

-- Create Main GUI
local function CreateMainGUI()
    -- Screen GUI
    local AdoptMeGui = Instance.new("ScreenGui")
    AdoptMeGui.Name = "AdoptMeCustomGUI"
    AdoptMeGui.ResetOnSpawn = false
    AdoptMeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Check if the explorer object exists
    if game:GetService("CoreGui") then
        AdoptMeGui.Parent = game:GetService("CoreGui")
    else
        AdoptMeGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.BackgroundColor3 = Colors.Background
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true
    Main.Parent = AdoptMeGui
    
    -- Apply rounded corners to main frame
    CreateCorner(Main, 15)
    
    -- Add shadow
    CreateShadow(Main, 0.5)
    
    -- Apply gradient to main frame
    CreateGradient(Main, 135)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.BackgroundColor3 = Colors.BackgroundTransparent
    TitleBar.BackgroundTransparency = 0.3
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.Parent = Main
    
    -- Apply gradient to title bar
    CreateGradient(TitleBar, 90)
    
    -- Title Text
    local Title = CreateLabel(TitleBar, "Adopt Me Auto Farm", UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 15, 0, 0), 18)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextSize = 18
    CloseButton.TextColor3 = Colors.Text
    CloseButton.Parent = TitleBar
    
    CloseButton.MouseButton1Click:Connect(function()
        AdoptMeGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextSize = 24
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.Parent = TitleBar
    
    local minimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            Main:TweenSize(UDim2.new(0, 500, 0, 350), "Out", "Quad", 0.3, true)
        else
            Main:TweenSize(UDim2.new(0, 500, 0, 40), "Out", "Quad", 0.3, true)
        end
        minimized = not minimized
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.BackgroundTransparency = 0.5
    TabContainer.BackgroundColor3 = Colors.BackgroundTransparent
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Parent = Main
    
    -- Tab Content Container
    local TabContentContainer = Instance.new("Frame")
    TabContentContainer.Name = "TabContentContainer"
    TabContentContainer.BackgroundTransparency = 1
    TabContentContainer.Size = UDim2.new(1, 0, 1, -70)
    TabContentContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContentContainer.Parent = Main
    
    -- Create the tab instances
    local MainTab = Instance.new("ScrollingFrame")
    MainTab.Name = "MainTab"
    MainTab.BackgroundTransparency = 1
    MainTab.Size = UDim2.new(1, 0, 1, 0)
    MainTab.Position = UDim2.new(0, 0, 0, 0)
    MainTab.ScrollBarThickness = 6
    MainTab.ScrollingDirection = Enum.ScrollingDirection.Y
    MainTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    MainTab.Visible = true
    MainTab.Parent = TabContentContainer
    
    local PetTab = Instance.new("ScrollingFrame")
    PetTab.Name = "PetTab"
    PetTab.BackgroundTransparency = 1
    PetTab.Size = UDim2.new(1, 0, 1, 0)
    PetTab.Position = UDim2.new(0, 0, 0, 0)
    PetTab.ScrollBarThickness = 6
    PetTab.ScrollingDirection = Enum.ScrollingDirection.Y
    PetTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    PetTab.Visible = false
    PetTab.Parent = TabContentContainer
    
    local BabyTab = Instance.new("ScrollingFrame")
    BabyTab.Name = "BabyTab"
    BabyTab.BackgroundTransparency = 1
    BabyTab.Size = UDim2.new(1, 0, 1, 0)
    BabyTab.Position = UDim2.new(0, 0, 0, 0)
    BabyTab.ScrollBarThickness = 6
    BabyTab.ScrollingDirection = Enum.ScrollingDirection.Y
    BabyTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    BabyTab.Visible = false
    BabyTab.Parent = TabContentContainer
    
    local TeleportTab = Instance.new("ScrollingFrame")
    TeleportTab.Name = "TeleportTab"
    TeleportTab.BackgroundTransparency = 1
    TeleportTab.Size = UDim2.new(1, 0, 1, 0)
    TeleportTab.Position = UDim2.new(0, 0, 0, 0)
    TeleportTab.ScrollBarThickness = 6
    TeleportTab.ScrollingDirection = Enum.ScrollingDirection.Y
    TeleportTab.CanvasSize = UDim2.new(0, 0, 0, 900) -- Taller for many teleport locations
    TeleportTab.Visible = false
    TeleportTab.Parent = TabContentContainer
    
    local MiscTab = Instance.new("ScrollingFrame")
    MiscTab.Name = "MiscTab"
    MiscTab.BackgroundTransparency = 1
    MiscTab.Size = UDim2.new(1, 0, 1, 0)
    MiscTab.Position = UDim2.new(0, 0, 0, 0)
    MiscTab.ScrollBarThickness = 6
    MiscTab.ScrollingDirection = Enum.ScrollingDirection.Y
    MiscTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    MiscTab.Visible = false
    MiscTab.Parent = TabContentContainer
    
    -- Tab system setup
    local selectedTab = Instance.new("ObjectValue")
    selectedTab.Name = "SelectedTab"
    selectedTab.Parent = Main
    
    local tabButtons = {}
    
    local mainTabBtn = CreateTabButton(TabContainer, "Main", MainTab, selectedTab, tabButtons)
    local petTabBtn = CreateTabButton(TabContainer, "Pet Tasks", PetTab, selectedTab, tabButtons)
    local babyTabBtn = CreateTabButton(TabContainer, "Baby Tasks", BabyTab, selectedTab, tabButtons)
    local teleportTabBtn = CreateTabButton(TabContainer, "Teleport", TeleportTab, selectedTab, tabButtons)
    local miscTabBtn = CreateTabButton(TabContainer, "Misc", MiscTab, selectedTab, tabButtons)
    
    -- Listen for tab changes
    selectedTab.Changed:Connect(function()
        for _, btn in pairs(tabButtons) do
            -- Update tab button appearance
            btn:FindFirstChild("Underline").Visible = (btn == selectedTab.Value)
            
            -- Update tab content visibility
            if btn.TabContent then
                btn.TabContent.Visible = (btn == selectedTab.Value)
            end
        end
    end)
    
    -- Select default tab
    selectedTab.Value = mainTabBtn
    
    -- Fill Main Tab
    local yOffset = 10
    local yPadding = 40
    
    -- Main Tab - Auto Farm All Tasks
    CreateLabel(MainTab, "General Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoFarmToggle
    autoFarmToggle = CreateToggle(MainTab, "Auto Farm (All Tasks)", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFarm = value
        PetTasksActive = value
        BabyTasksActive = value
        
        if value then
            -- Start all automation tasks
            spawn(DoPetTasks)
            spawn(DoBabyTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoAgeToggle
    autoAgeToggle = CreateToggle(MainTab, "Auto Age Baby", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoAge = value
        
        if value then
            spawn(DoAutoAge)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoBuildToggle
    autoBuildToggle = CreateToggle(MainTab, "Auto Build", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBuild = value
        
        if value then
            spawn(DoAutoBuild)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFishToggle
    autoFishToggle = CreateToggle(MainTab, "Auto Fish", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFish = value
        
        if value then
            spawn(DoAutoFish)
        end
    end)
    yOffset = yOffset + yPadding
    
    -- Main Tab Credits
    CreateLabel(MainTab, "Created by You", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, yOffset), 12)
    yOffset = yOffset + 30
    
    -- Main Tab Status Display
    local statusFrame = Instance.new("Frame")
    statusFrame.BackgroundColor3 = Colors.BackgroundTransparent
    statusFrame.BackgroundTransparency = 0.5
    statusFrame.Size = UDim2.new(1, -20, 0, 80)
    statusFrame.Position = UDim2.new(0, 10, 0, yOffset)
    statusFrame.Parent = MainTab
    
    CreateCorner(statusFrame, 10)
    CreateGradient(statusFrame, 135, Color3.fromRGB(230, 140, 190), Color3.fromRGB(230, 220, 140))
    
    local statusTitle = CreateLabel(statusFrame, "Status", UDim2.new(1, -10, 0, 25), UDim2.new(0, 10, 0, 5), 14)
    statusTitle.Font = Enum.Font.GothamBold
    
    local statusText = CreateLabel(statusFrame, "Waiting for tasks to start...", UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 30), 12)
    statusText.TextWrapped = true
    
    -- Update status periodically
    spawn(function()
        while wait(1) do
            if not statusText or not statusText.Parent then break end
            
            local activeFeatures = {}
            if AutoFarm then table.insert(activeFeatures, "Auto Farm") end
            if AutoAge then table.insert(activeFeatures, "Auto Age") end
            if AutoBuild then table.insert(activeFeatures, "Auto Build") end
            if AutoFish then table.insert(activeFeatures, "Auto Fish") end
            
            if #activeFeatures > 0 then
                statusText.Text = "Active: " .. table.concat(activeFeatures, ", ")
            else
                statusText.Text = "No tasks currently active"
            end
        end
    end)
    
    -- Fill Pet Tab
    yOffset = 10
    
    -- Pet Tab - Auto Pet Tasks
    CreateLabel(PetTab, "Pet Task Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoPetTasksToggle
    autoPetTasksToggle = CreateToggle(PetTab, "Auto Pet Tasks", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        PetTasksActive = value
        
        if value then
            spawn(DoPetTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFeedToggle
    autoFeedToggle = CreateToggle(PetTab, "Auto Feed", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoHungry = value
    end)
    yOffset = yOffset + yPadding
    
    local autoHydrateToggle
    autoHydrateToggle = CreateToggle(PetTab, "Auto Hydrate", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoThirsty = value
    end)
    yOffset = yOffset + yPadding
    
    local autoSleepToggle
    autoSleepToggle = CreateToggle(PetTab, "Auto Sleep", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSleep = value
    end)
    yOffset = yOffset + yPadding
    
    local autoPlayToggle
    autoPlayToggle = CreateToggle(PetTab, "Auto Play", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBored = value
    end)
    yOffset = yOffset + yPadding
    
    local autoShowerToggle
    autoShowerToggle = CreateToggle(PetTab, "Auto Shower", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoShower = value
    end)
    yOffset = yOffset + yPadding
    
    local autoSchoolToggle
    autoSchoolToggle = CreateToggle(PetTab, "Auto School", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSchool = value
    end)
    yOffset = yOffset + yPadding
    
    local autoCampingToggle
    autoCampingToggle = CreateToggle(PetTab, "Auto Camping", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoCamping = value
    end)
    yOffset = yOffset + yPadding
    
    local autoHospitalToggle
    autoHospitalToggle = CreateToggle(PetTab, "Auto Hospital", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSick = value
    end)
    
    -- Fill Baby Tab
    yOffset = 10
    
    -- Baby Tab - Auto Baby Tasks
    CreateLabel(BabyTab, "Baby Task Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoBabyTasksToggle
    autoBabyTasksToggle = CreateToggle(BabyTab, "Auto Baby Tasks", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        BabyTasksActive = value
        
        if value then
            spawn(DoBabyTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoEatToggle
    autoEatToggle = CreateToggle(BabyTab, "Auto Eat", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoHungry = value
    end)
    yOffset = yOffset + yPadding
    
    local autoDrinkToggle
    autoDrinkToggle = CreateToggle(BabyTab, "Auto Drink", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoThirsty = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoSleepToggle
    babyAutoSleepToggle = CreateToggle(BabyTab, "Auto Sleep", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSleep = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoPlayToggle
    babyAutoPlayToggle = CreateToggle(BabyTab, "Auto Play", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBored = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoShowerToggle
    babyAutoShowerToggle = CreateToggle(BabyTab, "Auto Shower", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoShower = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoSchoolToggle
    babyAutoSchoolToggle = CreateToggle(BabyTab, "Auto School", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSchool = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoCampingToggle
    babyAutoCampingToggle = CreateToggle(BabyTab, "Auto Camping", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoCamping = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoHospitalToggle
    babyAutoHospitalToggle = CreateToggle(BabyTab, "Auto Hospital", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSick = value
    end)
    
    -- Fill Teleport Tab
    yOffset = 10
    
    -- Teleport Tab - Locations
    CreateLabel(TeleportTab, "Teleport Locations", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    -- Sort locations alphabetically
    local sortedLocations = {}
    for locationName, _ in pairs(Locations) do
        table.insert(sortedLocations, locationName)
    end
    table.sort(sortedLocations)
    
    -- Create buttons for each location
    for _, locationName in ipairs(sortedLocations) do
        local teleportButton = CreateButton(TeleportTab, "Teleport to " .. locationName, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
            Teleport(locationName)
        end)
        yOffset = yOffset + 40
    end
    
    -- Update canvas size for scrolling
    TeleportTab.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)
    
    -- Fill Misc Tab
    yOffset = 10
    
    -- Misc Tab - Special Features
    CreateLabel(MiscTab, "Misc Features", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local collectDailyButton = CreateButton(MiscTab, "Collect Daily Streak", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        Teleport("Gifts")
        wait(1)
        
        local args = {
            [1] = "Daily",
            [2] = "ClaimReward"
        }
        ReplicatedStorage.Remote.RewardAPI:FireServer(unpack(args))
    end)
    yOffset = yOffset + 40
    
    local collectStarsButton = CreateButton(MiscTab, "Collect Star Rewards", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        Teleport("Gifts")
        wait(1)
        
        local args = {
            [1] = "Stars",
            [2] = "ClaimReward"
        }
        ReplicatedStorage.Remote.RewardAPI:FireServer(unpack(args))
    end)
    yOffset = yOffset + 40
    
    local autoPizzaPartyToggle
    autoPizzaPartyToggle = CreateToggle(MiscTab, "Auto Pizza Party", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoPizzaParty = value
        
        if value then
            spawn(function()
                while AutoPizzaParty do
                    Teleport("Pizza Shop")
                    wait(1)
                    
                    local args = {
                        [1] = "PizzaParty",
                        [2] = "StartEvent"
                    }
                    ReplicatedStorage.Remote.EventAPI:FireServer(unpack(args))
                    
                    wait(60 * 15) -- Wait 15 minutes between parties
                end
            end)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFamilyPlanningToggle
    autoFamilyPlanningToggle = CreateToggle(MiscTab, "Auto Family Planning", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFamilyPlanning = value
        
        if value then
            spawn(function()
                while AutoFamilyPlanning do
                    Teleport("Hospital")
                    wait(1)
                    
                    local args = {
                        [1] = "FamilyPlanning",
                        [2] = "StartEvent"
                    }
                    ReplicatedStorage.Remote.EventAPI:FireServer(unpack(args))
                    
                    wait(60 * 15) -- Wait 15 minutes between events
                end
            end)
        end
    end)
    yOffset = yOffset + yPadding
    
    -- Destroy GUI Button
    local destroyButton = CreateButton(MiscTab, "Destroy GUI", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        AdoptMeGui:Destroy()
    end)
    yOffset = yOffset + 40
    
    -- Add animated elements
    local function CreateAnimatedLogo()
        local logo = Instance.new("ImageLabel")
        logo.BackgroundTransparency = 1
    logo.Size = UDim2.new(0, 50, 0, 50)
        logo.Position = UDim2.new(0.5, -25, 0.5, -25)
        logo.Image = "rbxassetid://6034227061" -- Generic pet icon
        logo.ImageColor3 = Colors.Pink
        logo.Parent = MiscTab
        
        -- Animation
        spawn(function()
            while logo and logo.Parent do
                for i = 0, 360, 5 do
                    if not logo or not logo.Parent then break end
                    logo.Rotation = i
                    logo.ImageColor3 = Color3.fromHSV(i/360, 0.8, 1)
                    wait(0.05)
                end
            end
        end)
        
        return logo
    end
    
    CreateAnimatedLogo()
    
    -- Return the GUI
    return AdoptMeGui
end

-- Create and show the GUI
local GUI = CreateMainGUI()

-- Notification on load
local function CreateNotification(title, text, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 250, 0, 80)
    notif.Position = UDim2.new(1, -260, 1, -90)
    notif.BackgroundColor3 = Colors.Background
    notif.BorderSizePixel = 0
    notif.Parent = GUI
    
    CreateCorner(notif, 10)
    CreateGradient(notif, 45)
    CreateShadow(notif, 0.5)
    
    local title = CreateLabel(notif, title, UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 10), 16)
    title.Font = Enum.Font.GothamBold
    
    local body = CreateLabel(notif, text, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 35), 14)
    body.TextWrapped = true
    
    -- Animation
    notif:TweenPosition(UDim2.new(1, -260, 1, -90), "Out", "Quad", 0.5, true)
    
    -- Auto destroy after duration
    spawn(function()
        wait(duration)
        notif:TweenPosition(UDim2.new(1, 10, 1, -90), "Out", "Quad", 0.5, true)
        wait(0.5)
        notif:Destroy()
    end)
end
-- Custom Adopt Me Auto Farm GUI
-- Pink and yellow gradient theme

-- Game Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- Character References
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Character Added Event
LocalPlayer.CharacterAdded:Connect(function(Char)
    Character = Char
    Humanoid = Char:WaitForChild("Humanoid")
    HumanoidRootPart = Char:WaitForChild("HumanoidRootPart")
end)

-- Variables
local AutoFarm = false
local PetTasksActive = false
local BabyTasksActive = false
local AutoAge = false
local AutoBuild = false
local AutoFish = false
local AutoShower = false
local AutoSleep = false
local AutoHungry = false
local AutoThirsty = false
local AutoBored = false
local AutoSchool = false
local AutoCamping = false
local AutoSick = false
local AutoPizzaParty = false
local AutoFamilyPlanning = false

-- Important Locations
local Locations = {
    ["Main Map"] = CFrame.new(-247, 17, 1606),
    ["Nursery"] = CFrame.new(-248, 17, 1533),
    ["Coffee Shop"] = CFrame.new(365, 17, 1181),
    ["Pizza Shop"] = CFrame.new(953, 14, 1050),
    ["Playground"] = CFrame.new(-304, 17, 2192),
    ["School"] = CFrame.new(99, 17, 2345),
    ["Salon"] = CFrame.new(-1698, 14, -8),
    ["Pet Shop"] = CFrame.new(266, 17, 1456),
    ["Clothing Store"] = CFrame.new(-784, 14, -780),
    ["Hospital"] = CFrame.new(85, 17, 1911),
    ["Grocery Store"] = CFrame.new(-41, 17, 999),
    ["Campsite"] = CFrame.new(-1019, 17, 652),
    ["Gifts"] = CFrame.new(45, 17, 1560),
    ["Furniture Store"] = CFrame.new(-4380, 16, 767),
    ["Home Improvement"] = CFrame.new(-4481, 15, 982),
    ["Ice Cream Shop"] = CFrame.new(735, 17, -1275),
    ["Auto Shop"] = CFrame.new(549, 17, -1698),
    ["Gym"] = CFrame.new(-1304, 17, -215),
    ["Sky Castle"] = CFrame.new(-180, 130, 1748),
    ["Hot Springs"] = CFrame.new(-576, 17, 411),
    ["Pool"] = CFrame.new(-114, 17, 2124),
    ["Estate Agents"] = CFrame.new(-376, 17, 1139),
    ["Spirit Showdown"] = CFrame.new(-855, 17, 1394),
    ["Cave"] = CFrame.new(2895, 12, 528),
    ["AFK Spot"] = CFrame.new(0, 500, 0)
}

-- Functions
local function Teleport(location)
    if typeof(location) == "string" then
        if Locations[location] then
            HumanoidRootPart.CFrame = Locations[location]
        end
    elseif typeof(location) == "CFrame" then
        HumanoidRootPart.CFrame = location
    end
end

local function GetPetsEquipped()
    local pets = {}
    for _, pet in pairs(workspace.Pets:GetChildren()) do
        if pet:FindFirstChild("Owner") and pet.Owner.Value == LocalPlayer then
            table.insert(pets, pet)
        end
    end
    return pets
end

local function UseObject(object, name, useType)
    -- Default parameters if not specified
    useType = useType or "StartTask"
    
    -- Simulate using an object in the game
    local args = {
        [1] = name,
        [2] = useType
    }
    ReplicatedStorage.Remote.PlayerAPI:FireServer(unpack(args))
    wait(5) -- Wait for task animation
    
    -- End the task if it was started
    if useType == "StartTask" then
        local args = {
            [1] = name,
            [2] = "EndTask"
        }
        ReplicatedStorage.Remote.PlayerAPI:FireServer(unpack(args))
    end
end

local function BuyItem(itemName, itemType)
    -- Simulate buying an item
    local args = {
        [1] = itemName,
        [2] = "BuyItem",
        [3] = itemType
    }
    ReplicatedStorage.Remote.ShopAPI:FireServer(unpack(args))
end

local function UseConsumable(itemName)
    -- Simulate using a consumable item
    local args = {
        [1] = itemName,
        [2] = "UseConsumable"
    }
    ReplicatedStorage.Remote.InventoryAPI:FireServer(unpack(args))
end

-- Pet Tasks Function
local function DoPetTasks()
    while PetTasksActive do
        local pets = GetPetsEquipped()
        if #pets > 0 then
            -- Handle hunger
            if AutoHungry then
                Teleport("Grocery Store")
                wait(1)
                BuyItem("Apple", "Food")
                wait(0.5)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Apple",
                        [2] = "FeedPet",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(0.5)
                end
            end
            
            -- Handle thirst
            if AutoThirsty then
                Teleport("Coffee Shop")
                wait(1)
                BuyItem("Water", "Drink")
                wait(0.5)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Water",
                        [2] = "HydratePet",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(0.5)
                end
            end
            
            -- Handle sleep
            if AutoSleep then
                Teleport("AFK Spot")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Sleep",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Sleep",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle boredom
            if AutoBored then
                Teleport("Playground")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Play",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Play",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle shower
            if AutoShower then
                Teleport("AFK Spot")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Bath",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Bath",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle school
            if AutoSchool then
                Teleport("School")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "School",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "School",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle camping
            if AutoCamping then
                Teleport("Campsite")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Camping",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Camping",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
            
            -- Handle sickness
            if AutoSick then
                Teleport("Hospital")
                wait(1)
                for _, pet in pairs(pets) do
                    local args = {
                        [1] = "Healing",
                        [2] = "StartPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                    wait(10)
                    local args = {
                        [1] = "Healing",
                        [2] = "EndPetTask",
                        [3] = pet
                    }
                    ReplicatedStorage.Remote.PetAPI:FireServer(unpack(args))
                end
            end
        end
        wait(1)
    end
end

-- Baby Tasks Function
local function DoBabyTasks()
    while BabyTasksActive do
        -- Handle hunger
        if AutoHungry then
            Teleport("Pizza Shop")
            wait(1)
            UseObject(nil, "Pizza", "BuyFood")
            wait(0.5)
            UseObject(nil, "Pizza", "Eat")
        end
        
        -- Handle thirst
        if AutoThirsty then
            Teleport("Coffee Shop")
            wait(1)
            UseObject(nil, "Coffee", "BuyDrink")
            wait(0.5)
            UseObject(nil, "Coffee", "Drink")
        end
        
        -- Handle sleep
        if AutoSleep then
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Sleep", "StartTask")
        end
        
        -- Handle boredom
        if AutoBored then
            Teleport("Playground")
            wait(1)
            UseObject(nil, "Playground", "StartTask")
        end
        
        -- Handle shower
        if AutoShower then
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Shower", "StartTask")
        end
        
        -- Handle school
        if AutoSchool then
            Teleport("School")
            wait(1)
            UseObject(nil, "School", "StartTask")
        end
        
        -- Handle camping
        if AutoCamping then
            Teleport("Campsite")
            wait(1)
            UseObject(nil, "Camping", "StartTask")
        end
        
        -- Handle sickness
        if AutoSick then
            Teleport("Hospital")
            wait(1)
            UseObject(nil, "Hospital", "StartTask")
        end
        
        wait(1)
    end
end

-- Auto Aging Function
local function DoAutoAge()
    while AutoAge do
        -- Check if we are a baby
        local isBaby = LocalPlayer:FindFirstChild("PlayerGrowth") and LocalPlayer.PlayerGrowth.Value < 100
        
        if isBaby then
            -- Do all baby tasks
            Teleport("Pizza Shop")
            wait(1)
            UseObject(nil, "Pizza", "BuyFood")
            wait(0.5)
            UseObject(nil, "Pizza", "Eat")
            
            Teleport("Coffee Shop")
            wait(1)
            UseObject(nil, "Coffee", "BuyDrink")
            wait(0.5)
            UseObject(nil, "Coffee", "Drink")
            
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Sleep", "StartTask")
            
            Teleport("Playground")
            wait(1)
            UseObject(nil, "Playground", "StartTask")
            
            Teleport("AFK Spot")
            wait(1)
            UseObject(nil, "Shower", "StartTask")
            
            Teleport("School")
            wait(1)
            UseObject(nil, "School", "StartTask")
            
            Teleport("Campsite")
            wait(1)
            UseObject(nil, "Camping", "StartTask")
            
            Teleport("Hospital")
            wait(1)
            UseObject(nil, "Hospital", "StartTask")
        end
        
        wait(5)
    end
end

-- Auto Build Function
local function DoAutoBuild()
    while AutoBuild do
        -- Simulate building furniture
        Teleport("Furniture Store")
        wait(1)
        
        local args = {
            [1] = "Basic Bed",
            [2] = "BuyFurniture"
        }
        ReplicatedStorage.Remote.HousingAPI:FireServer(unpack(args))
        
        wait(0.5)
        
        local args = {
            [1] = "Basic Bed",
            [2] = "PlaceFurniture",
            [3] = CFrame.new(0, 0, 0)
        }
        ReplicatedStorage.Remote.HousingAPI:FireServer(unpack(args))
        
        wait(5)
    end
end

-- Auto Fish Function
local function DoAutoFish()
    while AutoFish do
        -- Simulate fishing
        Teleport("Hot Springs")
        wait(1)
        
        local args = {
            [1] = "FishingRod",
            [2] = "StartFishing"
        }
        ReplicatedStorage.Remote.ToolAPI:FireServer(unpack(args))
        
        wait(10) -- Wait for fish to bite
        
        local args = {
            [1] = "FishingRod",
            [2] = "CatchFish"
        }
        ReplicatedStorage.Remote.ToolAPI:FireServer(unpack(args))
        
        wait(2)
    end
end

-- Custom GUI Creation
-- Colors and Design Constants
local Colors = {
    Background = Color3.fromRGB(45, 45, 45),
    BackgroundTransparent = Color3.fromRGB(35, 35, 35),
    Border = Color3.fromRGB(0, 0, 0),
    Text = Color3.fromRGB(255, 255, 255),
    ButtonDefault = Color3.fromRGB(85, 85, 85),
    ButtonHover = Color3.fromRGB(100, 100, 100),
    ToggleOff = Color3.fromRGB(255, 100, 100),
    ToggleOn = Color3.fromRGB(100, 255, 100),
    Pink = Color3.fromRGB(255, 105, 180),
    Yellow = Color3.fromRGB(255, 215, 0),
    Gradient1 = Color3.fromRGB(255, 150, 200), -- Light Pink
    Gradient2 = Color3.fromRGB(255, 240, 150)  -- Light Yellow
}

-- Create Rounded Corners
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
    return corner
end

-- Create Gradient
local function CreateGradient(parent, rotation, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Colors.Gradient1),
        ColorSequenceKeypoint.new(1, color2 or Colors.Gradient2)
    })
    gradient.Parent = parent
    return gradient
end

-- Create Shadow Effect
local function CreateShadow(parent, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Parent = parent
    return shadow
end

-- Create Text Label
local function CreateLabel(parent, text, size, position, textSize, textColor)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size or UDim2.new(1, 0, 0, 20)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextSize = textSize or 14
    label.TextColor3 = textColor or Colors.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

-- Create Button
local function CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.BackgroundColor3 = Colors.ButtonDefault
    button.Size = size or UDim2.new(1, -20, 0, 30)
    button.Position = position or UDim2.new(0, 10, 0, 30)
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextSize = 14
    button.TextColor3 = Colors.Text
    button.Parent = parent
    
    -- Add rounded corners and gradient
    CreateCorner(button, 8)
    CreateGradient(button, 90)
    
    -- Add shadow for 3D effect
    CreateShadow(button, 0.7)
    
    -- Add hover and click effects
    button.MouseEnter:Connect(function()
        button:TweenSize(UDim2.new(1, -16, 0, 32), "Out", "Quad", 0.2, true)
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(size or UDim2.new(1, -20, 0, 30), "Out", "Quad", 0.2, true)
    end)
    
    button.MouseButton1Click:Connect(function()
        button:TweenSize(UDim2.new(1, -24, 0, 28), "Out", "Quad", 0.1, true)
        wait(0.1)
        button:TweenSize(size or UDim2.new(1, -20, 0, 30), "Out", "Quad", 0.1, true)
        callback()
    end)
    
    return button
end

-- Create Toggle
local function CreateToggle(parent, text, size, position, default, callback)
    local toggleContainer = Instance.new("Frame")
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.Size = size or UDim2.new(1, -20, 0, 30)
    toggleContainer.Position = position or UDim2.new(0, 10, 0, 30)
    toggleContainer.Parent = parent
    
    local label = CreateLabel(toggleContainer, text, UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 0, 0, 0), 14)
    
    local toggle = Instance.new("Frame")
    toggle.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -40, 0.5, -10)
    toggle.Parent = toggleContainer
    
    CreateCorner(toggle, 10)
    
    local indicator = Instance.new("Frame")
    indicator.BackgroundColor3 = Colors.Text
    indicator.Size = UDim2.new(0, 16, 0, 16)
    indicator.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    indicator.Parent = toggle
    
    CreateCorner(indicator, 8)
    
    local value = default or false
    
    local button = Instance.new("TextButton")
    button.BackgroundTransparency = 1
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Text = ""
    button.Parent = toggleContainer
    
    button.MouseButton1Click:Connect(function()
        value = not value
        
        if value then
            toggle.BackgroundColor3 = Colors.ToggleOn
            indicator:TweenPosition(UDim2.new(1, -18, 0.5, -8), "Out", "Quad", 0.2, true)
        else
            toggle.BackgroundColor3 = Colors.ToggleOff
            indicator:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.2, true)
        end
        
        callback(value)
    end)
    
    return toggleContainer, value
end

-- Create Tab System
local function CreateTabButton(parent, text, tabContent, selectedTab, tabButtons)
    local tabButton = Instance.new("TextButton")
    tabButton.BackgroundColor3 = Colors.ButtonDefault
    tabButton.Size = UDim2.new(1/#{}, 0, 1, 0)
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.Text = text
    tabButton.TextSize = 14
    tabButton.TextColor3 = Colors.Text
    tabButton.Parent = parent
-- Add gradient
    CreateGradient(tabButton, 90)
    
    -- Store the tab content
    tabButton.TabContent = tabContent
    
    -- Add to table of tab buttons
    table.insert(tabButtons, tabButton)
    
    -- Position the tab button
    tabButton.Position = UDim2.new((#tabButtons-1)/(#{} or 1), 0, 0, 0)
    
    -- Add click event
    tabButton.MouseButton1Click:Connect(function()
        selectedTab.Value = tabButton
    end)
    
    -- Create underline indicator for active tab
    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.BackgroundColor3 = Colors.Yellow
    underline.Size = UDim2.new(1, 0, 0, 2)
    underline.Position = UDim2.new(0, 0, 1, -2)
    underline.Visible = false
    underline.Parent = tabButton
    
    return tabButton
end

-- Create Main GUI
local function CreateMainGUI()
    -- Screen GUI
    local AdoptMeGui = Instance.new("ScreenGui")
    AdoptMeGui.Name = "AdoptMeCustomGUI"
    AdoptMeGui.ResetOnSpawn = false
    AdoptMeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Check if the explorer object exists
    if game:GetService("CoreGui") then
        AdoptMeGui.Parent = game:GetService("CoreGui")
    else
        AdoptMeGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.BackgroundColor3 = Colors.Background
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true
    Main.Parent = AdoptMeGui
    
    -- Apply rounded corners to main frame
    CreateCorner(Main, 15)
    
    -- Add shadow
    CreateShadow(Main, 0.5)
    
    -- Apply gradient to main frame
    CreateGradient(Main, 135)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.BackgroundColor3 = Colors.BackgroundTransparent
    TitleBar.BackgroundTransparency = 0.3
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.Parent = Main
    
    -- Apply gradient to title bar
    CreateGradient(TitleBar, 90)
    
    -- Title Text
    local Title = CreateLabel(TitleBar, "Adopt Me Auto Farm", UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 15, 0, 0), 18)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextSize = 18
    CloseButton.TextColor3 = Colors.Text
    CloseButton.Parent = TitleBar
    
    CloseButton.MouseButton1Click:Connect(function()
        AdoptMeGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextSize = 24
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.Parent = TitleBar
    
    local minimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            Main:TweenSize(UDim2.new(0, 500, 0, 350), "Out", "Quad", 0.3, true)
        else
            Main:TweenSize(UDim2.new(0, 500, 0, 40), "Out", "Quad", 0.3, true)
        end
        minimized = not minimized
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.BackgroundTransparency = 0.5
    TabContainer.BackgroundColor3 = Colors.BackgroundTransparent
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Parent = Main
    
    -- Tab Content Container
    local TabContentContainer = Instance.new("Frame")
    TabContentContainer.Name = "TabContentContainer"
    TabContentContainer.BackgroundTransparency = 1
    TabContentContainer.Size = UDim2.new(1, 0, 1, -70)
    TabContentContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContentContainer.Parent = Main
    
    -- Create the tab instances
    local MainTab = Instance.new("ScrollingFrame")
    MainTab.Name = "MainTab"
    MainTab.BackgroundTransparency = 1
    MainTab.Size = UDim2.new(1, 0, 1, 0)
    MainTab.Position = UDim2.new(0, 0, 0, 0)
    MainTab.ScrollBarThickness = 6
    MainTab.ScrollingDirection = Enum.ScrollingDirection.Y
    MainTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    MainTab.Visible = true
    MainTab.Parent = TabContentContainer
    
    local PetTab = Instance.new("ScrollingFrame")
    PetTab.Name = "PetTab"
    PetTab.BackgroundTransparency = 1
    PetTab.Size = UDim2.new(1, 0, 1, 0)
    PetTab.Position = UDim2.new(0, 0, 0, 0)
    PetTab.ScrollBarThickness = 6
    PetTab.ScrollingDirection = Enum.ScrollingDirection.Y
    PetTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    PetTab.Visible = false
    PetTab.Parent = TabContentContainer
    
    local BabyTab = Instance.new("ScrollingFrame")
    BabyTab.Name = "BabyTab"
    BabyTab.BackgroundTransparency = 1
    BabyTab.Size = UDim2.new(1, 0, 1, 0)
    BabyTab.Position = UDim2.new(0, 0, 0, 0)
    BabyTab.ScrollBarThickness = 6
    BabyTab.ScrollingDirection = Enum.ScrollingDirection.Y
    BabyTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    BabyTab.Visible = false
    BabyTab.Parent = TabContentContainer
    
    local TeleportTab = Instance.new("ScrollingFrame")
    TeleportTab.Name = "TeleportTab"
    TeleportTab.BackgroundTransparency = 1
    TeleportTab.Size = UDim2.new(1, 0, 1, 0)
    TeleportTab.Position = UDim2.new(0, 0, 0, 0)
    TeleportTab.ScrollBarThickness = 6
    TeleportTab.ScrollingDirection = Enum.ScrollingDirection.Y
    TeleportTab.CanvasSize = UDim2.new(0, 0, 0, 900) -- Taller for many teleport locations
    TeleportTab.Visible = false
    TeleportTab.Parent = TabContentContainer
    
    local MiscTab = Instance.new("ScrollingFrame")
    MiscTab.Name = "MiscTab"
    MiscTab.BackgroundTransparency = 1
    MiscTab.Size = UDim2.new(1, 0, 1, 0)
    MiscTab.Position = UDim2.new(0, 0, 0, 0)
    MiscTab.ScrollBarThickness = 6
    MiscTab.ScrollingDirection = Enum.ScrollingDirection.Y
    MiscTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    MiscTab.Visible = false
    MiscTab.Parent = TabContentContainer
    
    -- Tab system setup
    local selectedTab = Instance.new("ObjectValue")
    selectedTab.Name = "SelectedTab"
    selectedTab.Parent = Main
    
    local tabButtons = {}
    
    local mainTabBtn = CreateTabButton(TabContainer, "Main", MainTab, selectedTab, tabButtons)
    local petTabBtn = CreateTabButton(TabContainer, "Pet Tasks", PetTab, selectedTab, tabButtons)
    local babyTabBtn = CreateTabButton(TabContainer, "Baby Tasks", BabyTab, selectedTab, tabButtons)
    local teleportTabBtn = CreateTabButton(TabContainer, "Teleport", TeleportTab, selectedTab, tabButtons)
    local miscTabBtn = CreateTabButton(TabContainer, "Misc", MiscTab, selectedTab, tabButtons)
    
    -- Listen for tab changes
    selectedTab.Changed:Connect(function()
        for _, btn in pairs(tabButtons) do
            -- Update tab button appearance
            btn:FindFirstChild("Underline").Visible = (btn == selectedTab.Value)
            
            -- Update tab content visibility
            if btn.TabContent then
                btn.TabContent.Visible = (btn == selectedTab.Value)
            end
        end
    end)
    
    -- Select default tab
    selectedTab.Value = mainTabBtn
    
    -- Fill Main Tab
    local yOffset = 10
    local yPadding = 40
    
    -- Main Tab - Auto Farm All Tasks
    CreateLabel(MainTab, "General Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoFarmToggle
    autoFarmToggle = CreateToggle(MainTab, "Auto Farm (All Tasks)", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFarm = value
        PetTasksActive = value
        BabyTasksActive = value
        
        if value then
            -- Start all automation tasks
            spawn(DoPetTasks)
            spawn(DoBabyTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoAgeToggle
    autoAgeToggle = CreateToggle(MainTab, "Auto Age Baby", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoAge = value
        
        if value then
            spawn(DoAutoAge)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoBuildToggle
    autoBuildToggle = CreateToggle(MainTab, "Auto Build", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBuild = value
        
        if value then
            spawn(DoAutoBuild)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFishToggle
    autoFishToggle = CreateToggle(MainTab, "Auto Fish", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFish = value
        
        if value then
            spawn(DoAutoFish)
        end
    end)
    yOffset = yOffset + yPadding
    
    -- Main Tab Credits
    CreateLabel(MainTab, "Created by You", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, yOffset), 12)
    yOffset = yOffset + 30
    
    -- Main Tab Status Display
    local statusFrame = Instance.new("Frame")
    statusFrame.BackgroundColor3 = Colors.BackgroundTransparent
    statusFrame.BackgroundTransparency = 0.5
    statusFrame.Size = UDim2.new(1, -20, 0, 80)
    statusFrame.Position = UDim2.new(0, 10, 0, yOffset)
    statusFrame.Parent = MainTab
    
    CreateCorner(statusFrame, 10)
    CreateGradient(statusFrame, 135, Color3.fromRGB(230, 140, 190), Color3.fromRGB(230, 220, 140))
    
    local statusTitle = CreateLabel(statusFrame, "Status", UDim2.new(1, -10, 0, 25), UDim2.new(0, 10, 0, 5), 14)
    statusTitle.Font = Enum.Font.GothamBold
    
    local statusText = CreateLabel(statusFrame, "Waiting for tasks to start...", UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 30), 12)
    statusText.TextWrapped = true
    
    -- Update status periodically
    spawn(function()
        while wait(1) do
            if not statusText or not statusText.Parent then break end
            
            local activeFeatures = {}
            if AutoFarm then table.insert(activeFeatures, "Auto Farm") end
            if AutoAge then table.insert(activeFeatures, "Auto Age") end
            if AutoBuild then table.insert(activeFeatures, "Auto Build") end
            if AutoFish then table.insert(activeFeatures, "Auto Fish") end
            
            if #activeFeatures > 0 then
                statusText.Text = "Active: " .. table.concat(activeFeatures, ", ")
            else
                statusText.Text = "No tasks currently active"
            end
        end
    end)
    
    -- Fill Pet Tab
    yOffset = 10
    
    -- Pet Tab - Auto Pet Tasks
    CreateLabel(PetTab, "Pet Task Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoPetTasksToggle
    autoPetTasksToggle = CreateToggle(PetTab, "Auto Pet Tasks", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        PetTasksActive = value
        
        if value then
            spawn(DoPetTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFeedToggle
    autoFeedToggle = CreateToggle(PetTab, "Auto Feed", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoHungry = value
    end)
    yOffset = yOffset + yPadding
    
    local autoHydrateToggle
    autoHydrateToggle = CreateToggle(PetTab, "Auto Hydrate", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoThirsty = value
    end)
    yOffset = yOffset + yPadding
    
    local autoSleepToggle
    autoSleepToggle = CreateToggle(PetTab, "Auto Sleep", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSleep = value
    end)
    yOffset = yOffset + yPadding
    
    local autoPlayToggle
    autoPlayToggle = CreateToggle(PetTab, "Auto Play", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBored = value
    end)
    yOffset = yOffset + yPadding
    
    local autoShowerToggle
    autoShowerToggle = CreateToggle(PetTab, "Auto Shower", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoShower = value
    end)
    yOffset = yOffset + yPadding
    
    local autoSchoolToggle
    autoSchoolToggle = CreateToggle(PetTab, "Auto School", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSchool = value
    end)
    yOffset = yOffset + yPadding
    
    local autoCampingToggle
    autoCampingToggle = CreateToggle(PetTab, "Auto Camping", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoCamping = value
    end)
    yOffset = yOffset + yPadding
    
    local autoHospitalToggle
    autoHospitalToggle = CreateToggle(PetTab, "Auto Hospital", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSick = value
    end)
    
    -- Fill Baby Tab
    yOffset = 10
    
    -- Baby Tab - Auto Baby Tasks
    CreateLabel(BabyTab, "Baby Task Settings", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local autoBabyTasksToggle
    autoBabyTasksToggle = CreateToggle(BabyTab, "Auto Baby Tasks", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        BabyTasksActive = value
        
        if value then
            spawn(DoBabyTasks)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoEatToggle
    autoEatToggle = CreateToggle(BabyTab, "Auto Eat", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoHungry = value
    end)
    yOffset = yOffset + yPadding
    
    local autoDrinkToggle
    autoDrinkToggle = CreateToggle(BabyTab, "Auto Drink", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoThirsty = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoSleepToggle
    babyAutoSleepToggle = CreateToggle(BabyTab, "Auto Sleep", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSleep = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoPlayToggle
    babyAutoPlayToggle = CreateToggle(BabyTab, "Auto Play", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoBored = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoShowerToggle
    babyAutoShowerToggle = CreateToggle(BabyTab, "Auto Shower", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoShower = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoSchoolToggle
    babyAutoSchoolToggle = CreateToggle(BabyTab, "Auto School", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSchool = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoCampingToggle
    babyAutoCampingToggle = CreateToggle(BabyTab, "Auto Camping", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoCamping = value
    end)
    yOffset = yOffset + yPadding
    
    local babyAutoHospitalToggle
    babyAutoHospitalToggle = CreateToggle(BabyTab, "Auto Hospital", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoSick = value
    end)
    
    -- Fill Teleport Tab
    yOffset = 10
    
    -- Teleport Tab - Locations
    CreateLabel(TeleportTab, "Teleport Locations", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    -- Sort locations alphabetically
    local sortedLocations = {}
    for locationName, _ in pairs(Locations) do
        table.insert(sortedLocations, locationName)
    end
    table.sort(sortedLocations)
    
    -- Create buttons for each location
    for _, locationName in ipairs(sortedLocations) do
        local teleportButton = CreateButton(TeleportTab, "Teleport to " .. locationName, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
            Teleport(locationName)
        end)
        yOffset = yOffset + 40
    end
    
    -- Update canvas size for scrolling
    TeleportTab.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)
    
    -- Fill Misc Tab
    yOffset = 10
    
    -- Misc Tab - Special Features
    CreateLabel(MiscTab, "Misc Features", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, yOffset), 16)
    yOffset = yOffset + 30
    
    local collectDailyButton = CreateButton(MiscTab, "Collect Daily Streak", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        Teleport("Gifts")
        wait(1)
        
        local args = {
            [1] = "Daily",
            [2] = "ClaimReward"
        }
        ReplicatedStorage.Remote.RewardAPI:FireServer(unpack(args))
    end)
    yOffset = yOffset + 40
    
    local collectStarsButton = CreateButton(MiscTab, "Collect Star Rewards", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        Teleport("Gifts")
        wait(1)
        
        local args = {
            [1] = "Stars",
            [2] = "ClaimReward"
        }
        ReplicatedStorage.Remote.RewardAPI:FireServer(unpack(args))
    end)
    yOffset = yOffset + 40
    
    local autoPizzaPartyToggle
    autoPizzaPartyToggle = CreateToggle(MiscTab, "Auto Pizza Party", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoPizzaParty = value
        
        if value then
            spawn(function()
                while AutoPizzaParty do
                    Teleport("Pizza Shop")
                    wait(1)
                    
                    local args = {
                        [1] = "PizzaParty",
                        [2] = "StartEvent"
                    }
                    ReplicatedStorage.Remote.EventAPI:FireServer(unpack(args))
                    
                    wait(60 * 15) -- Wait 15 minutes between parties
                end
            end)
        end
    end)
    yOffset = yOffset + yPadding
    
    local autoFamilyPlanningToggle
    autoFamilyPlanningToggle = CreateToggle(MiscTab, "Auto Family Planning", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), false, function(value)
        AutoFamilyPlanning = value
        
        if value then
            spawn(function()
                while AutoFamilyPlanning do
                    Teleport("Hospital")
                    wait(1)
                    
                    local args = {
                        [1] = "FamilyPlanning",
                        [2] = "StartEvent"
                    }
                    ReplicatedStorage.Remote.EventAPI:FireServer(unpack(args))
                    
                    wait(60 * 15) -- Wait 15 minutes between events
                end
            end)
        end
    end)
    yOffset = yOffset + yPadding
    
    -- Destroy GUI Button
    local destroyButton = CreateButton(MiscTab, "Destroy GUI", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, yOffset), function()
        AdoptMeGui:Destroy()
    end)
    yOffset = yOffset + 40
    
    -- Add animated elements
    local function CreateAnimatedLogo()
        local logo = Instance.new("ImageLabel")
        logo.BackgroundTransparency = 1
    logo.Size = UDim2.new(0, 50, 0, 50)
        logo.Position = UDim2.new(0.5, -25, 0.5, -25)
        logo.Image = "rbxassetid://6034227061" -- Generic pet icon
        logo.ImageColor3 = Colors.Pink
        logo.Parent = MiscTab
        
        -- Animation
        spawn(function()
            while logo and logo.Parent do
                for i = 0, 360, 5 do
                    if not logo or not logo.Parent then break end
                    logo.Rotation = i
                    logo.ImageColor3 = Color3.fromHSV(i/360, 0.8, 1)
                    wait(0.05)
                end
            end
        end)
        
        return logo
    end
    
    CreateAnimatedLogo()
    
    -- Return the GUI
    return AdoptMeGui
end

-- Create and show the GUI
local GUI = CreateMainGUI()

-- Notification on load
local function CreateNotification(title, text, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 250, 0, 80)
    notif.Position = UDim2.new(1, -260, 1, -90)
    notif.BackgroundColor3 = Colors.Background
    notif.BorderSizePixel = 0
    notif.Parent = GUI
    
    CreateCorner(notif, 10)
    CreateGradient(notif, 45)
    CreateShadow(notif, 0.5)
    
    local title = CreateLabel(notif, title, UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 10), 16)
    title.Font = Enum.Font.GothamBold
    
    local body = CreateLabel(notif, text, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 35), 14)
    body.TextWrapped = true
    
    -- Animation
    notif:TweenPosition(UDim2.new(1, -260, 1, -90), "Out", "Quad", 0.5, true)
    
    -- Auto destroy after duration
    spawn(function()
        wait(duration)
        notif:TweenPosition(UDim2.new(1, 10, 1, -90), "Out", "Quad", 0.5, true)
        wait(0.5)
        notif:Destroy()
    end)
end

CreateNotification("Adopt Me Auto Farm", "GUI successfully loaded!", 5) 
        
CreateNotification("Adopt Me Auto Farm", "GUI successfully loaded!", 5) 
         
