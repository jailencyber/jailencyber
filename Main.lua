local dropdownButton = script.Parent:WaitForChild("SelectFruitButton")  -- Button to open fruit selection
local dropdownFrame = script.Parent:WaitForChild("FruitDropdown")  -- Dropdown frame
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- List of Blox Fruits
local fruitList = {
    "Yeti", "Kitsune", "Shadow", "Portal", "String", "Control", "Gravity",
    "T-Rex", "Flame", "Magma", "Dark", "Love", "Sand", "Quake", "Rumble", "Rubber",
    "Falcon", "Barrier", "Spin", "Diamond",
    "Smoke", "Spike", "Spring"
}

-- Function to spawn the selected fruit
local function spawnFruit(fruitName)
    local fruitModel = game.ServerStorage:FindFirstChild(fruitName)
    
    if not fruitModel then
        warn("Fruit model not found: " .. fruitName)
        return
    end
    
    local fruitClone = fruitModel:Clone()
    local position = character.HumanoidRootPart.Position + (character.HumanoidRootPart.CFrame.LookVector * 5)
    fruitClone:SetPrimaryPartCFrame(CFrame.new(position))
    fruitClone.Parent = workspace
    print(fruitName .. " spawned successfully.")
end

-- Toggle dropdown visibility when the button is clicked
dropdownButton.MouseButton1Click:Connect(function()
    dropdownFrame.Visible = not dropdownFrame.Visible
end)

-- Create buttons for each fruit in the dropdown
for _, fruitName in ipairs(fruitList) do
    local fruitButton = Instance.new("TextButton")
    fruitButton.Size = UDim2.new(1, 0, 0, 60)
    fruitButton.Text = fruitName
    fruitButton.Parent = dropdownFrame
    fruitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    -- Set up button interaction
    fruitButton.MouseButton1Click:Connect(function()
        spawnFruit(fruitName)
        dropdownFrame.Visible = false  -- Close dropdown after selection
    end)
end

-- Close the dropdown if clicked outside
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePosition = input.Position
        if dropdownFrame.Visible and
           not (dropdownFrame.AbsolutePosition.X <= mousePosition.X and mousePosition.X <= dropdownFrame.AbsolutePosition.X + dropdownFrame.AbsoluteSize.X and
                dropdownFrame.AbsolutePosition.Y <= mousePosition.Y and mousePosition.Y <= dropdownFrame.AbsolutePosition.Y + dropdownFrame.AbsoluteSize.Y) then
            dropdownFrame.Visible = false  -- Close if clicked outside
        end
    end
end)
