
-- UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Adopt Me Pet Helper", HidePremium = false, SaveConfig = true, ConfigFolder = "AdoptMeConfig"})

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Status Variables
local autoFarmEnabled = false

-- Create Main Tab
local mainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Create Teleport Tab
local teleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Tab - Auto Farm Toggle
mainTab:AddToggle({
    Name = "Auto Farm Pet Needs",
    Default = false,
    Callback = function(Value)
        autoFarmEnabled = Value
        if autoFarmEnabled then
            AutoFarmPetNeeds()
        end
    end    
})

mainTab:AddButton({
    Name = "Take Out Pet",
    Callback = function()
        TakeOutPet()
    end    
})

-- Teleport Tab Functions
teleportTab:AddButton({
    Name = "Teleport to Nursery",
    Callback = function()
        TeleportToLocation("Nursery")
    end    
})

teleportTab:AddButton({
    Name = "Teleport to School",
    Callback = function()
        TeleportToLocation("School")
    end    
})

teleportTab:AddButton({
    Name = "Teleport to Hospital",
    Callback = function()
        TeleportToLocation("Hospital")
    end    
})

teleportTab:AddButton({
    Name = "Teleport to Playground",
    Callback = function()
        TeleportToLocation("Playground")
    end    
})

teleportTab:AddButton({
    Name = "Teleport to Campsite",
    Callback = function()
        TeleportToLocation("Campsite")
    end    
})

-- Function Implementations

-- The main auto farm function that handles all pet needs
function AutoFarmPetNeeds()
    print("Auto Farm Started!")
    
    -- Make sure function only runs once
    if _G.AutoFarmRunning then return end
    _G.AutoFarmRunning = true
    
    -- Create a loop that runs as long as autoFarmEnabled is true
    spawn(function()
        while autoFarmEnabled do
            if not player or not player.Character then wait(1) continue end
            
            -- Check if pet is out
            local hasPetOut = CheckIfPetIsOut()
            if not hasPetOut then
                TakeOutPet()
                wait(2)
            end
            
            -- Check and handle pet needs
            HandlePetHunger()
            wait(1)
            
            HandlePetThirst()
            wait(1)
            
            HandlePetCleanliness()
            wait(1)
            
            HandlePetSickness()
            wait(1)
            
            -- Handle basic tasks
            DoBasicTask()
            
            -- Short wait before next cycle
            wait(5)
        end
        
        _G.AutoFarmRunning = false
        print("Auto Farm Stopped!")
    end)
end

-- Check if pet is currently out
function CheckIfPetIsOut()
    -- Logic to check if pet is out
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

-- Take out pet if not already out
function TakeOutPet()
    print("Taking out pet...")
    
    -- Find pet selection button and click it
    local success, err = pcall(function()
        -- Try to access the pet interface
        local petButton = player.PlayerGui:FindFirstChild("PetInventory", true)
        if petButton then
            -- Simulate clicking the button
            firesignal(petButton.MouseButton1Click)
            wait(0.5)
            
            -- Select first pet
            local petSlot = player.PlayerGui:FindFirstChild("PetSlot1", true)
            if petSlot then
                firesignal(petSlot.MouseButton1Click)
            end
        end
    end)
    
    if not success then
        print("Failed to take out pet: " .. err)
        
        -- Alternative approach using remote events
        local petRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("TakeOutPet")
        if petRemote then
            petRemote:FireServer()
        end
    end
end

-- Handle pet hunger
function HandlePetHunger()
    print("Checking pet hunger...")
    
    -- Find hunger bar/indicator
    local hungerBar = player.PlayerGui:FindFirstChild("PetHunger", true)
    if hungerBar and hungerBar.Value < 50 then
        print("Pet is hungry, feeding...")
        
        -- Logic to feed pet
        local foodRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("FeedPet")
        if foodRemote then
            foodRemote:FireServer("Apple") -- Try to feed an apple
        else
            -- Alternative approach - try to find and use food item
            TeleportToLocation("Home")
            wait(1)
            
            -- Try to find refrigerator or food storage
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
    print("Checking pet thirst...")
    
    -- Find thirst bar/indicator
    local thirstBar = player.PlayerGui:FindFirstChild("PetThirst", true)
    if thirstBar and thirstBar.Value < 50 then
        print("Pet is thirsty, giving water...")
        
        -- Logic to give water to pet
        local waterRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("GiveDrink")
        if waterRemote then
            waterRemote:FireServer("Water") -- Try to give water
        else
            -- Alternative approach - try to find and use water source
            TeleportToLocation("Home")
            wait(1)
            
            -- Try to find water source
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
    print("Checking pet cleanliness...")
    
    -- Find cleanliness bar/indicator
    local cleanBar = player.PlayerGui:FindFirstChild("PetClean", true)
    if cleanBar and cleanBar.Value < 50 then
        print("Pet is dirty, cleaning...")
        
        -- Logic to clean pet
        local cleanRemote = game:GetService("ReplicatedStorage"):FindFirstChild("PetRemotes"):FindFirstChild("CleanPet")
        if cleanRemote then
            cleanRemote:FireServer()
        else
            -- Alternative approach - try to find and use shower/bath
            TeleportToLocation("Home")
            wait(1)
            
            -- Try to find shower
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
    print("Checking if pet is sick...")
    
    -- Check for sickness indicator
    local sickIndicator = player.PlayerGui:FindFirstChild("PetSick", true)
    if sickIndicator and sickIndicator.Visible then
        print("Pet is sick, going to hospital...")
        
        -- Go to hospital
        TeleportToLocation("Hospital")
        wait(2)
        
        -- Look for healing station
        local healingStation = workspace:FindFirstChild("HealingStation", true)
        if healingStation then
            local clickDetector = healingStation:FindFirstChild("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
            end
        end
    end
end

-- Do basic tasks for money/rewards
function DoBasicTask()
    print("Checking for tasks...")
    
    -- Try to find current task
    local taskLabel = player.PlayerGui:FindFirstChild("TaskLabel", true)
    if taskLabel and taskLabel.Visible then
        local taskText = taskLabel.Text
        print("Found task: " .. taskText)
        
        -- Handle different tasks based on text
        if taskText:find("school") then
            TeleportToLocation("School")
        elseif taskText:find("camp") then
            TeleportToLocation("Campsite")
        elseif taskText:find("playground") then
            TeleportToLocation("Playground")
        elseif taskText:find("sleep") or taskText:find("bed") then
            TeleportToLocation("Home")
            -- Find bed
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
    print("Teleporting to " .. location .. "...")
    
    -- Get teleport button for location
    local teleportGui = player.PlayerGui:FindFirstChild("TeleportGui", true)
    if teleportGui then
        local locationButton = teleportGui:FindFirstChild(location, true)
        if locationButton then
            firesignal(locationButton.MouseButton1Click)
            wait(2) -- Wait for teleport to complete
            return
        end
    end
    
    -- Alternative method - use game's teleport system if available
    local teleportFunc = game:GetService("ReplicatedStorage"):FindFirstChild("TeleportToLocation")
    if teleportFunc then
        teleportFunc:FireServer(location)
        wait(2)
        return
    end
    
    -- Last resort - hardcoded coordinates
    local locations = {
        ["Nursery"] = Vector3.new(0, 20, 0),
        ["School"] = Vector3.new(100, 20, 100),
        ["Hospital"] = Vector3.new(-100, 20, 100),
        ["Playground"] = Vector3.new(100, 20, -100),
        ["Campsite"] = Vector3.new(-100, 20, -100),
        ["Home"] = Vector3.new(50, 20, 50)
    }
    
    if locations[location] then
        -- Check if character exists
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Teleport character to location
            character.HumanoidRootPart.CFrame = CFrame.new(locations[location])
            print("Teleported to " .. location .. " using coordinates")
        end
    else
        print("Unknown location: " .. location)
    end
end

-- Initialize UI
OrionLib:Init()
print("Adopt Me Pet Helper script loaded successfully!")
print("Use the toggle to start/stop auto farming pet needs")
