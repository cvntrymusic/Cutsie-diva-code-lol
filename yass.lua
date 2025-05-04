-- Improved Adopt Me Script with Toggles
-- Author: Claude
-- Based on: https://github.com/cvntrymusic/Cutsie-diva-code-lol/blob/main/yass.lua

-- GUI Library (using Orion UI Library as an example)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Adopt Me Helper", HidePremium = false, SaveConfig = true, ConfigFolder = "AdoptMeConfig"})

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Status Variables
local autoFarm = false
local autoCollect = false
local autoDrink = false
local autoEat = false
local autoShower = false
local autoCampingTask = false
local autoSchoolTask = false
local autoHotspringTask = false
local autoFamilyTask = false
local autoSleepTask = false
local isPetOut = false
local autoHealSick = false

-- Tabs
local mainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local farmingTab = Window:MakeTab({
    Name = "Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local taskTab = Window:MakeTab({
    Name = "Tasks",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local petsTab = Window:MakeTab({
    Name = "Pets",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local teleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Tab Functions
mainTab:AddToggle({
    Name = "Auto Farm Money",
    Default = false,
    Callback = function(Value)
        autoFarm = Value
        if autoFarm then
            AutoFarmMoney()
        end
    end    
})

mainTab:AddToggle({
    Name = "Auto Collect Money",
    Default = false,
    Callback = function(Value)
        autoCollect = Value
        if autoCollect then
            AutoCollectMoney()
        end
    end    
})

-- Farming Tab Functions
farmingTab:AddToggle({
    Name = "Auto Drink",
    Default = false,
    Callback = function(Value)
        autoDrink = Value
        if autoDrink then
            AutoDrink()
        end
    end    
})

farmingTab:AddToggle({
    Name = "Auto Eat",
    Default = false,
    Callback = function(Value)
        autoEat = Value
        if autoEat then
            AutoEat()
        end
    end    
})

farmingTab:AddToggle({
    Name = "Auto Shower",
    Default = false,
    Callback = function(Value)
        autoShower = Value
        if autoShower then
            AutoShower()
        end
    end    
})

-- Tasks Tab Functions
taskTab:AddToggle({
    Name = "Auto Camping Task",
    Default = false,
    Callback = function(Value)
        autoCampingTask = Value
        if autoCampingTask then
            AutoCampingTask()
        end
    end    
})

taskTab:AddToggle({
    Name = "Auto School Task",
    Default = false,
    Callback = function(Value)
        autoSchoolTask = Value
        if autoSchoolTask then
            AutoSchoolTask()
        end
    end    
})

taskTab:AddToggle({
    Name = "Auto Hotspring Task",
    Default = false,
    Callback = function(Value)
        autoHotspringTask = Value
        if autoHotspringTask then
            AutoHotspringTask()
        end
    end    
})

taskTab:AddToggle({
    Name = "Auto Family Task",
    Default = false,
    Callback = function(Value)
        autoFamilyTask = Value
        if autoFamilyTask then
            AutoFamilyTask()
        end
    end    
})

taskTab:AddToggle({
    Name = "Auto Sleep Task",
    Default = false,
    Callback = function(Value)
        autoSleepTask = Value
        if autoSleepTask then
            AutoSleepTask()
        end
    end    
})

-- Pets Tab Functions
petsTab:AddToggle({
    Name = "Auto Heal Sick Pet",
    Default = false,
    Callback = function(Value)
        autoHealSick = Value
        if autoHealSick then
            AutoHealSickPet()
        end
    end    
})

petsTab:AddButton({
    Name = "Take Out Pet",
    Callback = function()
        TakeOutPet()
    end    
})

petsTab:AddButton({
    Name = "Put Away Pet",
    Callback = function()
        PutAwayPet()
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
function AutoFarmMoney()
    spawn(function()
        while autoFarm do
            -- Logic for auto farming money
            print("Auto farming money...")
            
            -- Simulate completing tasks for money
            local tasks = {"Drink", "Eat", "Shower", "Sleep", "School", "Camping"}
            for _, task in ipairs(tasks) do
                print("Doing task: " .. task)
                -- Add task completion logic here
                wait(5) -- Wait between tasks
            end
            
            wait(1)
        end
    end)
end

function AutoCollectMoney()
    spawn(function()
        while autoCollect do
            -- Logic to collect money rewards
            print("Collecting money...")
            
            -- Look for collectibles in the game
            local collectibles = workspace:FindFirstChild("Collectibles")
            if collectibles then
                for _, collectible in pairs(collectibles:GetChildren()) do
                    -- Logic to collect each item
                    print("Collecting: " .. collectible.Name)
                end
            end
            
            wait(10) -- Wait 10 seconds between collection attempts
        end
    end)
end

function AutoDrink()
    spawn(function()
        while autoDrink do
            -- Check thirst level and drink if needed
            print("Checking thirst level...")
            
            -- Simulate drinking
            print("Drinking water...")
            
            wait(30) -- Check every 30 seconds
        end
    end)
end

function AutoEat()
    spawn(function()
        while autoEat do
            -- Check hunger level and eat if needed
            print("Checking hunger level...")
            
            -- Simulate eating
            print("Eating food...")
            
            wait(45) -- Check every 45 seconds
        end
    end)
end

function AutoShower()
    spawn(function()
        while autoShower do
            -- Check cleanliness and shower if needed
            print("Checking cleanliness...")
            
            -- Simulate showering
            print("Taking a shower...")
            
            wait(60) -- Check every 60 seconds
        end
    end)
end

function AutoCampingTask()
    spawn(function()
        while autoCampingTask do
            -- Logic for completing camping tasks
            print("Doing camping task...")
            
            -- Teleport to campsite if needed
            TeleportToLocation("Campsite")
            
            -- Simulate completing the task
            print("Camping task completed!")
            
            wait(120) -- Wait 2 minutes between tasks
        end
    end)
end

function AutoSchoolTask()
    spawn(function()
        while autoSchoolTask do
            -- Logic for completing school tasks
            print("Doing school task...")
            
            -- Teleport to school if needed
            TeleportToLocation("School")
            
            -- Simulate completing the task
            print("School task completed!")
            
            wait(120) -- Wait 2 minutes between tasks
        end
    end)
end

function AutoHotspringTask()
    spawn(function()
        while autoHotspringTask do
            -- Logic for completing hotspring tasks
            print("Doing hotspring task...")
            
            -- Teleport to hotspring if needed
            TeleportToLocation("Hotspring")
            
            -- Simulate completing the task
            print("Hotspring task completed!")
            
            wait(120) -- Wait 2 minutes between tasks
        end
    end)
end

function AutoFamilyTask()
    spawn(function()
        while autoFamilyTask do
            -- Logic for completing family tasks
            print("Doing family task...")
            
            -- Look for family members
            print("Interacting with family members...")
            
            -- Simulate completing the task
            print("Family task completed!")
            
            wait(180) -- Wait 3 minutes between tasks
        end
    end)
end

function AutoSleepTask()
    spawn(function()
        while autoSleepTask do
            -- Logic for completing sleep tasks
            print("Doing sleep task...")
            
            -- Teleport to home if needed
            TeleportToLocation("Home")
            
            -- Simulate sleeping
            print("Sleeping...")
            
            wait(300) -- Sleep for 5 minutes
        end
    end)
end

function AutoHealSickPet()
    spawn(function()
        while autoHealSick do
            -- Check if pet is sick
            print("Checking if pet is sick...")
            
            -- Logic to heal the pet if it's sick
            print("Healing sick pet...")
            
            -- Teleport to hospital if needed
            TeleportToLocation("Hospital")
            
            wait(60) -- Check every minute
        end
    end)
end

function TakeOutPet()
    -- Logic to take out pet
    print("Taking out pet...")
    isPetOut = true
end

function PutAwayPet()
    -- Logic to put away pet
    print("Putting away pet...")
    isPetOut = false
end

function TeleportToLocation(location)
    -- Logic to teleport to different locations
    print("Teleporting to " .. location .. "...")
    
    -- Add teleport logic based on Adopt Me's map coordinates
    local locations = {
        ["Nursery"] = Vector3.new(0, 0, 0),
        ["School"] = Vector3.new(100, 0, 100),
        ["Hospital"] = Vector3.new(-100, 0, 100),
        ["Playground"] = Vector3.new(100, 0, -100),
        ["Campsite"] = Vector3.new(-100, 0, -100),
        ["Hotspring"] = Vector3.new(150, 0, 150),
        ["Home"] = Vector3.new(-150, 0, -150)
    }
    
    if locations[location] then
        -- Teleport character to location
        character:SetPrimaryPartCFrame(CFrame.new(locations[location]))
        print("Teleported to " .. location)
    else
        print("Unknown location: " .. location)
    end
end

-- Initialize
OrionLib:Init()
print("Adopt Me Helper script loaded successfully!")
