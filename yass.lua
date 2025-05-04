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
    
  
