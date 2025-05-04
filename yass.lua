-- Adopt Me Pet Auto-Farm with Basic GUI
-- This script uses a simpler GUI that should be compatible with most exploits

-- Variables
local player = game.Players.LocalPlayer
local autoFarmEnabled = false
local runService = game:GetService("RunService")

-- Create a basic GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdoptMePetHelper"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 250)
mainFrame.Position = UDim2.new(0.8, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleLabel.BorderSizePixel = 0
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Adopt Me Pet Helper"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Parent = mainFrame

-- Auto Farm Button
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Name = "AutoFarmButton"
autoFarmButton.Size = UDim2.new(0.9, 0, 0, 30)
autoFarmButton.Position = UDim2.new(0.05, 0, 0.15, 0)
autoFarmButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoFarmButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
autoFarmButton.Font = Enum.Font.SourceSans
autoFarmButton.Text = "Auto Farm: OFF"
autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmButton.TextSize = 16
autoFarmButton.Parent = mainFrame

-- Take Out Pet Button
local takeOutPetButton = Instance.new("TextButton")
takeOutPetButton.Name = "TakeOutPetButton"
takeOutPetButton.Size = UDim2.new(0.9, 0, 0, 30)
takeOutPetButton.Position = UDim2.new(0.05, 0, 0.27, 0)
takeOutPetButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
takeOutPetButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
takeOutPetButton.Font = Enum.Font.SourceSans
takeOutPetButton.Text = "Take Out Pet"
takeOutPetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
takeOutPetButton.TextSize = 16
takeOutPetButton.Parent = mainFrame

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
statusLabel.Position = UDim2.new(0.05, 0, 0.39, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
statusLabel.BorderSizePixel = 0
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Text = "Status: Idle"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

-- Teleport Label
local teleportLabel = Instance.new("TextLabel")
teleportLabel.Name = "TeleportLabel"
teleportLabel.Size = UDim2.new(0.9, 0, 0, 20)
teleportLabel.Position = UDim2.new(0.05, 0, 0.47, 0)
teleportLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
teleportLabel.BorderSizePixel = 0
teleportLabel.Font = Enum.Font.SourceSansBold
teleportLabel.Text = "Teleport To:"
teleportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportLabel.TextSize = 14
teleportLabel.Parent = mainFrame

-- Teleport Buttons
local locations = {"Nursery", "School", "Hospital", "Playground", "Campsite"}
for i, location in ipairs(locations) do
    local teleportButton = Instance.new("TextButton")
    teleportButton.Name = location .. "Button"
    teleportButton.Size = UDim2.new(0.9, 0, 0, 25)
    teleportButton.Position = UDim2.new(0.05, 0, 0.47 + (i * 0.08), 0)
    teleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    teleportButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    teleportButton.Font = Enum.Font.SourceSans
    teleportButton.Text = location
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.TextSize = 14
    teleportButton.Parent = mainFrame
    
    -- Add teleport functionality
    teleportButton.MouseButton1Click:Connect(function()
        statusLabel.Text = "Status: Teleporting to " .. location
        TeleportToLocation(location)
        wait(2)
        statusLabel.Text = "Status: " .. (autoFarmEnabled and "Auto farming" or "Idle")
    end)
end

-- Button Functions
autoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmButton.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")
    autoFarmButton.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(60, 60, 60)
    statusLabel.Text = "Status: " .. (autoFarmEnabled and "Auto farming" or "Idle")
    
    if autoFarmEnabled then
        AutoFarmPetNeeds()
    end
end)

takeOutPetButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Status: Taking out pet"
    TakeOutPet()
    wait(2)
    statusLabel.Text = "Status: " .. (autoFarmEnabled and "Auto farming" or "Idle")
end)

-- Main Functions

-- Function to auto farm pet needs
function AutoFarmPetNeeds()
    if _G.AutoFarmRunning then return end
    _G.AutoFarmRunning = true
    
    spawn(function()
        while autoFarmEnabled do
            if not player or not player.Character then wait(1) continue end
            
            -- Update status
            statusLabel.Text = "Status: Checking pet..."
            
            -- Check if pet is out
            local hasPetOut = CheckIfPetIsOut()
            if not hasPetOut then
                statusLabel.Text = "Status: Taking out pet"
                TakeOutPet()
                wait(2)
            end
            
            -- Handle pet needs
            statusLabel.Text = "Status: Feeding pet"
            HandlePetHunger()
            wait(1)
            
            statusLabel.Text = "Status: Hydrating pet"
            HandlePetThirst()
            wait(1)
            
            statusLabel.Text = "Status: Cleaning pet"
            HandlePetCleanliness()
            wait(1)
            
            statusLabel.Text = "Status: Checking health"
            HandlePetSickness()
            wait(1)
            
            -- Handle tasks
            statusLabel.Text = "Status: Doing tasks"
            DoBasicTask()
            
            -- Update status to auto farming
            statusLabel.Text = "Status: Auto farming"
            
            -- Wait before next cycle
            wait(5)
        end
        
        _G.AutoFarmRunning = false
        statusLabel.Text = "Status: Idle"
    end)
end

-- Check if pet is out
function CheckIfPetIsOut()
    local petFolder = player:FindFirstChild("Pets")
    if petFolder then
        for _, pet in pairs(petFolder:GetChildren()) do
            if pet:FindFirstChild("OutState") and pet.OutState.Value == true then
                return true
            end
        end
    end
    return false
end

-- Take out pet
function TakeOutPet()
    -- Try to find and click pet interface buttons
    local success, err = pcall(function()
        local petButton = player.PlayerGui:FindFirstChild("PetInventory", true)
        if petButton then
            firesignal(petButton.MouseButton1Click)
            wait(0.5)
            
            local petSlot = player.PlayerGui:FindFirstChild("PetSlot1", true)
            if petSlot then
                firesignal(petSlot.MouseButton1Click)
            end
        end
    end)
    
    if not success then
        -- Try alternative methods
        local petRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("TakeOutPet")
        if petRemote then
            petRemote:FireServer()
        end
    end
end

-- Handle pet hunger
function HandlePetHunger()
    local hungerBar = player.PlayerGui:FindFirstChild("PetHunger", true)
    if hungerBar and hungerBar.Value < 50 then
        -- Try to feed pet
        local foodRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("FeedPet")
        if foodRemote then
            foodRemote:FireServer("Apple")
        else
            -- Alternative approach
            TeleportToLocation("Home")
            wait(1)
            
            local foodStorage = workspace:FindFirstChild("FoodStorage", true)
            if foodStorage then
                local clickDetector = foodStorage:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
    end
end

-- Handle pet thirst
function HandlePetThirst()
    local thirstBar = player.PlayerGui:FindFirstChild("PetThirst", true)
    if thirstBar and thirstBar.Value < 50 then
        -- Try to give water
        local waterRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("GiveDrink")
        if waterRemote then
            waterRemote:FireServer("Water")
        else
            -- Alternative approach
            TeleportToLocation("Home")
            wait(1)
            
            local waterSource = workspace:FindFirstChild("WaterSource", true)
            if waterSource then
                local clickDetector = waterSource:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
    end
end

-- Handle pet cleanliness
function HandlePetCleanliness()
    local cleanBar = player.PlayerGui:FindFirstChild("PetClean", true)
    if cleanBar and cleanBar.Value < 50 then
        -- Try to clean pet
        local cleanRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("CleanPet")
        if cleanRemote then
            cleanRemote:FireServer()
        else
            -- Alternative approach
            TeleportToLocation("Home")
            wait(1)
            
            local shower = workspace:FindFirstChild("Shower", true) or workspace:FindFirstChild("Bath", true)
            if shower then
                local clickDetector = shower:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
    end
end

-- Handle pet sickness
function HandlePetSickness()
    local sickIndicator = player.PlayerGui:FindFirstChild("PetSick", true)
    if sickIndicator and sickIndicator.Visible then
        -- Go to hospital
        TeleportToLocation("Hospital")
        wait(2)
        
        local healingStation = workspace:FindFirstChild("HealingStation", true)
        if healingStation then
            local clickDetector = healingStation:FindFirstChild("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
            end
        end
    end
end

-- Do basic tasks
function DoBasicTask()
    local taskLabel = player.PlayerGui:FindFirstChild("TaskLabel", true)
    if taskLabel and taskLabel.Visible then
        local taskText = taskLabel.Text
        
        if taskText:find("school") then
            TeleportToLocation("School")
        elseif taskText:find("camp") then
            TeleportToLocation("Campsite")
        elseif taskText:find("playground") then
            TeleportToLocation("Playground")
        elseif taskText:find("sleep") or taskText:find("bed") then
            TeleportToLocation("Home")
            
            local bed = workspace:FindFirstChild("Bed", true)
            if bed then
                local clickDetector = bed:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
    end
end

-- Teleport to location
function TeleportToLocation(location)
    -- Method 1: Try GUI teleport
    local teleportGui = player.PlayerGui:FindFirstChild("TeleportGui", true)
    if teleportGui then
        local locationButton = teleportGui:FindFirstChild(location, true)
        if locationButton then
            firesignal(locationButton.MouseButton1Click)
            wait(2)
            return
        end
    end
    
    -- Method 2: Try remote event
    local teleportFunc = game:GetService("ReplicatedStorage"):FindFirstChild("TeleportToLocation")
    if teleportFunc then
        teleportFunc:FireServer(location)
        wait(2)
        return
    end
    
    -- Method 3: Hardcoded coordinates
    local locations = {
        ["Nursery"] = Vector3.new(0, 20, 0),
        ["School"] = Vector3.new(100, 20, 100),
        ["Hospital"] = Vector3.new(-100, 20, 100),
        ["Playground"] = Vector3.new(100, 20, -100),
        ["Campsite"] = Vector3.new(-100, 20, -100),
        ["Home"] = Vector3.new(50, 20, 50)
    }
    
    if locations[location] and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(locations[location])
    end
end

-- Display welcome message
print("Adopt Me Pet Helper loaded successfully!")
print("The GUI should appear on your screen.")
print("If you don't see it, check if your exploit supports GUI creation.")
