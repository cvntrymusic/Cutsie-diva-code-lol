-- Simplified Adopt Me GUI without any external libraries

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local InfiniteJumpConnection = nil
local AutoFarmConnection = nil
local AutoCollectConnection = nil
local AutoHatchConnection = nil
local NoClipConnection = nil
local ESPItems = {}

-- Create GUI
local AdoptMeGUI = Instance.new("ScreenGui")
AdoptMeGUI.Name = "AdoptMeGUI"
AdoptMeGUI.Parent = game:GetService("CoreGui")

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 350, 0, 250)
Main.Position = UDim2.new(0.5, -175, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = AdoptMeGUI

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -30, 0, 20)
Title.Position = UDim2.new(0, 5, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Adopt Me GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

-- Close Button
local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Position = UDim2.new(1, -25, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14
Close.Font = Enum.Font.SourceSansBold
Close.BorderSizePixel = 0
Close.Parent = Main

Close.MouseButton1Click:Connect(function()
    -- Cleanup connections before destroying GUI
    if InfiniteJumpConnection then InfiniteJumpConnection:Disconnect() end
    if AutoFarmConnection then AutoFarmConnection:Disconnect() end
    if AutoCollectConnection then AutoCollectConnection:Disconnect() end
    if AutoHatchConnection then AutoHatchConnection:Disconnect() end
    if NoClipConnection then NoClipConnection:Disconnect() end
    
    -- Remove ESP
    for _, item in pairs(ESPItems) do
        if item and item.Parent then
            item:Destroy()
        end
    end
    
    -- Restore default values
    Humanoid.WalkSpeed = 16
    Humanoid.JumpPower = 50
    
    -- Restore collision
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = true
        end
    end
    
    -- Destroy GUI
    AdoptMeGUI:Destroy()
end)

-- Create Tabs
local TabButtons = {}
local TabContents = {}
local TabNames = {"Player", "Teleport", "Farm", "Pets", "Misc"}

for i, tabName in ipairs(TabNames) do
    -- Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Tab"
    TabButton.Size = UDim2.new(1/#TabNames, 0, 0, 25)
    TabButton.Position = UDim2.new((i-1)/#TabNames, 0, 0, 30)
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.SourceSans
    TabButton.BorderSizePixel = 0
    TabButton.Parent = Main
    
    -- Tab Content
    local TabContent = Instance.new("Frame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, -55)
    TabContent.Position = UDim2.new(0, 0, 0, 55)
    TabContent.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContent.BorderSizePixel = 0
    TabContent.Visible = i == 1
    TabContent.Parent = Main
    
    table.insert(TabButtons, TabButton)
    table.insert(TabContents, TabContent)
    
    -- Tab Button Click
    TabButton.MouseButton1Click:Connect(function()
        for j, content in ipairs(TabContents) do
            content.Visible = i == j
            TabButtons[j].BackgroundColor3 = i == j and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
        end
    end)
end

-- Helper function to create toggles
local function CreateToggle(parent, text, position, callback)
    local toggle = {enabled = false}
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "Toggle"
    ToggleFrame.Size = UDim2.new(0, 150, 0, 25)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent
    
    local ToggleText = Instance.new("TextLabel")
    ToggleText.Name = "Text"
    ToggleText.Size = UDim2.new(0, 100, 1, 0)
    ToggleText.BackgroundTransparency = 1
    ToggleText.Text = text
    ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleText.TextSize = 14
    ToggleText.Font = Enum.Font.SourceSans
    ToggleText.TextXAlignment = Enum.TextXAlignment.Left
    ToggleText.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Button"
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Name = "Indicator"
    ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.Parent = ToggleButton
    
    toggle.UpdateToggle = function()
        if toggle.enabled then
            ToggleIndicator.Position = UDim2.new(1, -18, 0, 2)
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        end
        callback(toggle.enabled)
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        toggle.enabled = not toggle.enabled
        toggle.UpdateToggle()
    end)
    
    return toggle
end

-- Helper function to create buttons
local function CreateButton(parent, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Size = UDim2.new(0, 150, 0, 25)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSans
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

-- Add features to tabs --

-- Player Tab
local PlayerContent = TabContents[1]

-- Walk Speed Toggle
local WalkSpeedToggle = CreateToggle(PlayerContent, "Walk Speed", UDim2.new(0, 10, 0, 10), function(enabled)
    Humanoid.WalkSpeed = enabled and 50 or 16
end)

-- Jump Power Toggle
local JumpPowerToggle = CreateToggle(PlayerContent, "Jump Power", UDim2.new(0, 10, 0, 45), function(enabled)
    Humanoid.JumpPower = enabled and 100 or 50
end)

-- Infinite Jump Toggle
local InfiniteJumpToggle = CreateToggle(PlayerContent, "Infinite Jump", UDim2.new(0, 10, 0, 80), function(enabled)
    if enabled then
        InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    else
        if InfiniteJumpConnection then
            InfiniteJumpConnection:Disconnect()
            InfiniteJumpConnection = nil
        end
    end
end)

-- Teleport Tab
local TeleportContent = TabContents[2]

-- Define common locations in Adopt Me
local locations = {
    {name = "Nursery", position = Vector3.new(-410, 77, -570)},
    {name = "School", position = Vector3.new(-610, 77, -520)},
    {name = "Pizza Place", position = Vector3.new(238, 77, -826)},
    {name = "Pet Shop", position = Vector3.new(296, 77, -596)},
    {name = "Playground", position = Vector3.new(-275, 77, -792)},
    {name = "Hospital", position = Vector3.new(82, 77, -483)},
    {name = "Coffee Shop", position = Vector3.new(359, 77, -474)},
    {name = "Hot Springs", position = Vector3.new(-36, 77, -784)}
}

-- Create teleport buttons
for i, loc in ipairs(locations) do
    local yPos = (i - 1) * 35
    CreateButton(TeleportContent, loc.name, UDim2.new(0, 10, 0, 10 + yPos), function()
        HumanoidRootPart.CFrame = CFrame.new(loc.position)
    end)
end

-- Farm Tab
local FarmContent = TabContents[3]

-- Auto Farm Money Toggle
local AutoFarmToggle = CreateToggle(FarmContent, "Auto Farm Money", UDim2.new(0, 10, 0, 10), function(enabled)
    if enabled then
        AutoFarmConnection = RunService.Heartbeat:Connect(function()
            -- Auto farm logic (simplified)
            for _, child in pairs(workspace:GetChildren()) do
                if child.Name == "MoneyBag" and child:FindFirstChild("Handle") then
                    child.Handle.CFrame = HumanoidRootPart.CFrame
                end
            end
        end)
    else
        if AutoFarmConnection then
            AutoFarmConnection:Disconnect()
            AutoFarmConnection = nil
        end
    end
end)

-- Auto Collect Toggle
local AutoCollectToggle = CreateToggle(FarmContent, "Auto Collect", UDim2.new(0, 10, 0, 45), function(enabled)
    if enabled then
        AutoCollectConnection = RunService.Heartbeat:Connect(function()
            -- Auto collect logic (simplified)
            for _, child in pairs(workspace:GetChildren()) do
                if child:IsA("Model") and child:FindFirstChild("Collectible") then
                    child:MoveTo(HumanoidRootPart.Position)
                end
            end
        end)
    else
        if AutoCollectConnection then
            AutoCollectConnection:Disconnect()
            AutoCollectConnection = nil
        end
    end
end)

-- Pets Tab
local PetsContent = TabContents[4]

-- Auto Hatch Eggs Toggle
local AutoHatchToggle = CreateToggle(PetsContent, "Auto Hatch Eggs", UDim2.new(0, 10, 0, 10), function(enabled)
    if enabled then
        AutoHatchConnection = RunService.Heartbeat:Connect(function()
            -- Auto hatch logic (simplified placeholder)
            local args = {
                [1] = "Royal",  -- Egg type
                [2] = 1         -- Amount to hatch
            }
            
            -- This is a placeholder. In a real implementation, you would need to find
            -- the actual remote event for hatching eggs
            -- local eggEvent = game:GetService("ReplicatedStorage").RemoteEvents.EggOpened
            -- eggEvent:FireServer(unpack(args))
        end)
    else
        if AutoHatchConnection then
            AutoHatchConnection:Disconnect()
            AutoHatchConnection = nil
        end
    end
end)

-- Make Neon Button
CreateButton(PetsContent, "Make All Pets Neon", UDim2.new(0, 10, 0, 45), function()
    -- Make Neon Logic (placeholder)
    -- You would need to find the actual remote event for making pets neon
    -- local makeNeonEvent = game:GetService("ReplicatedStorage").RemoteEvents.MakeNeon
    -- makeNeonEvent:FireServer()
end)

-- Make Mega Button
CreateButton(PetsContent, "Make All Pets Mega", UDim2.new(0, 10, 0, 80), function()
    -- Make Mega Logic (placeholder)
    -- You would need to find the actual remote event for making pets mega
    -- local makeMegaEvent = game:GetService("ReplicatedStorage").RemoteEvents.MakeMega
    -- makeMegaEvent:FireServer()
end)

-- Misc Tab
local MiscContent = TabContents[5]

-- No Clip Toggle
local NoClipToggle = CreateToggle(MiscContent, "No Clip", UDim2.new(0, 10, 0, 10), function(enabled)
    if enabled then
        NoClipConnection = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end)

-- ESP Toggle
local ESPToggle = CreateToggle(MiscContent, "ESP", UDim2.new(0, 10, 0, 45), function(enabled)
    -- Clean up existing ESP items
    for _, item in pairs(ESPItems) do
        if item and item.Parent then
            item:Destroy()
        end
    end
    ESPItems = {}
    
    if enabled then
        -- Create new ESP
        local function CreateESP(player)
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = player.Character
                
                table.insert(ESPItems, highlight)
            end
        end
        
        -- Add ESP to existing players
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                CreateESP(player)
            end
        end
        
        -- Add ESP to new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if ESPToggle.enabled then
                    CreateESP(player)
                end
            end)
        end)
    end
end)

-- Handle character respawning
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Re-apply settings if toggles are enabled
    if WalkSpeedToggle and WalkSpeedToggle.enabled then
        Humanoid.WalkSpeed = 50
    end
    
    if JumpPowerToggle and JumpPowerToggle.enabled then
        Humanoid.JumpPower = 100
    end
    
    if NoClipToggle and NoClipToggle.enabled then
        if NoClipConnection then
            NoClipConnection:Disconnect()
        end
        NoClipConnection = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

-- Return GUI for reference
return AdoptMeGUI
