local player = game.Players.LocalPlayer

--========================
-- SUPPORT ONLY BUILD A BOAT FOR TREASURE
--========================
if game.PlaceId ~= 537413528 then
    player:Kick(
        "⚠️ GAME NOT SUPPORTED\n✅ Support : Build A Boat For Treasure"
    )
    return
end

--========================
-- AUTO FARM SETTINGS
--========================
local autoFarm = false
local travelling = false
local delayTime = 2.8

local positions = {
    Vector3.new(-61.65, 60.63, 1346.09),
    Vector3.new(-72.49, 97.79, 2113.09),
    Vector3.new(-43.95, 107.98, 2889.09),
    Vector3.new(-63.83, 80.14, 3658.09),
    Vector3.new(-89.93, 76.23, 4427),
    Vector3.new(-144.72, 68.66, 5972.09),
    Vector3.new(-89.09, 55.64, 5200.09),
    Vector3.new(-47.94, 23.96, 6734.59),
    Vector3.new(-55.7, 59.17, 7486.59),
    Vector3.new(-50.61, 81.01, 8271.59),
    Vector3.new(-55.03, -358.19, 9484.86)
}

--========================
-- FLOOR BESAR
--========================
local floor = Instance.new("Part")

floor.Size = Vector3.new(500,10,500)
floor.Position = Vector3.new(0,-10,0)

floor.Anchored = true
floor.CanCollide = true

floor.Material = Enum.Material.SmoothPlastic
floor.Color = Color3.fromRGB(50,50,50)

floor.Name = "BigFloor"
floor.Parent = workspace

--========================
-- MARKER
--========================
for _, pos in ipairs(positions) do

    local box = Instance.new("Part")

    box.Size = Vector3.new(5,5,5)
    box.Position = pos

    box.Anchored = true
    box.CanCollide = true
    box.CanTouch = true
    box.CanQuery = false

    box.Material = Enum.Material.Neon
    box.Color = Color3.fromRGB(255,0,0)
    box.Transparency = 0.3

    box.Parent = workspace
end

--========================
-- GET HRP
--========================
local function getHRP()

    local char =
        player.Character
        or player.CharacterAdded:Wait()

    return char:WaitForChild("HumanoidRootPart")
end

--========================
-- GUI
--========================
local gui = Instance.new("ScreenGui")
gui.Name = "DragonCihuyGUI"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui

frame.Size = UDim2.new(0,240,0,160)
frame.Position = UDim2.new(0.5,-120,0.5,-80)

frame.BackgroundColor3 = Color3.fromRGB(0,0,0)

frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0,20)

local title = Instance.new("TextLabel")
title.Parent = frame

title.Size = UDim2.new(1,-10,0,55)
title.Position = UDim2.new(0,5,0,5)

title.BackgroundTransparency = 1

title.Text =
    "Auto Farm | By DragonCihuy\nYouTube : @DragonCihuyRblx"

title.TextColor3 = Color3.fromRGB(255,255,255)

title.TextWrapped = true
title.TextScaled = true

local btn = Instance.new("TextButton")
btn.Parent = frame

btn.Size = UDim2.new(1,-20,0,50)
btn.Position = UDim2.new(0,10,0,90)

btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
btn.TextColor3 = Color3.fromRGB(255,255,255)

btn.Text = "AUTO FARM : OFF"

Instance.new("UICorner", btn).CornerRadius =
    UDim.new(0,15)

--========================
-- AUTO FARM
--========================
local function startFarm()

    if travelling then
        return
    end

    travelling = true

    task.spawn(function()

        while autoFarm do

            local hrp = getHRP()

            for i, pos in ipairs(positions) do

                if not autoFarm then
                    break
                end

                hrp.CFrame = CFrame.new(
                    pos.X,
                    pos.Y + 3,
                    pos.Z
                )

                -- LAST POSITION
                if i == #positions then

                    task.wait(1)

                    player.Character:BreakJoints()

                    task.wait(1)

                else

                    task.wait(delayTime)

                end
            end
        end

        travelling = false

    end)
end

--========================
-- BUTTON
--========================
btn.MouseButton1Click:Connect(function()

    autoFarm = not autoFarm

    btn.Text =
        autoFarm
        and "AUTO FARM : ON"
        or "AUTO FARM : OFF"

    if autoFarm then
        startFarm()
    end
end)

--========================
-- RESPAWN FIX
--========================
player.CharacterAdded:Connect(function()

    travelling = false

    task.wait(1)

    if autoFarm then
        startFarm()
    end
end)
