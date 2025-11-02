local url = "https://raw.githubusercontent.com/makarloxezz-cpu/goldffram/refs/heads/main/main.lua"
local orig = game:HttpGet(url)
-- Замена 'local' на глобальные переменные для доступа из внешнего кода
orig = orig:gsub("local%s+Library%s*=", "Library =")
orig = orig:gsub("local%s+Window%s*=", "Window =")
orig = orig:gsub("local%s+Tabs%s*=", "Tabs =")

local appended = [[

local packets = (game:GetService("ReplicatedStorage").Modules and require(game:GetService("ReplicatedStorage").Modules.Packets)) or (packets)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local httpservice = game:GetService("HttpService")
local tspmo = game:GetService("TweenService")

local function ClearOldBoardsAndHelpers()
    local b = workspace:FindFirstChild("Board")
    if b then b:Destroy() end
    local vFolder = workspace:FindFirstChild("WalkerSpheres")
    if vFolder then vFolder:Destroy() end
    local folder = workspace:FindFirstChild("RedSticks")
    if folder then folder:Destroy() end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("MeshPart") and obj.MeshId and tostring(obj.MeshId):find("4823036") then
            obj:Destroy()
        elseif obj:IsA("Part") then
            for _, m in ipairs(obj:GetChildren()) do
                if m:IsA("SpecialMesh") and m.MeshId and tostring(m.MeshId):find("4823036") then
                    obj:Destroy()
                    break
                end
            end
        elseif obj.Name == "Old Boards" then
            obj:Destroy()
        end
    end
end

local function CreateWideStick(group, parent, name)
    local startPoint = group[1]
    local endPoint = group[#group]
    if not (startPoint and endPoint) then return end
    local direction = (endPoint - startPoint).Unit
    local distance = (endPoint - startPoint).Magnitude
    local midPoint = (startPoint + endPoint) / 2
    local right = Vector3.new(direction.Z, 0, -direction.X)
    midPoint = midPoint + right * 2
    if name ~= "SigmoPart_3" then
        midPoint = midPoint - Vector3.new(0, 1.2, 0)
    else
        midPoint = midPoint - Vector3.new(0, 0.5, 0)
    end
    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 0.6, distance)
    part.Anchored = true
    part.CanCollide = true
    part.Material = Enum.Material.Neon
    part.Color = Color3.new(1, 0, 0)
    part.Transparency = 0
    part.Reflectance = 0.05
    part.Name = name
    part.Parent = parent
    part.CFrame = CFrame.new(midPoint, midPoint + direction)
end

local function LoadTweensConfig_CreateVisuals()
    local groups = {
        {
            Vector3.new(-126.3696, -31.9996, -193.4935),
            Vector3.new(-125.4963, -27.6570, -197.6518),
            Vector3.new(-125.5180, -20.3162, -197.8057),
            Vector3.new(-124.5315, -6.9844, -207.8662),
        },
        {
            Vector3.new(-202.3378, 4.8070, -622.1143),
            Vector3.new(-206.2624, 17.9093, -624.6749),
            Vector3.new(-210.2882, 22.7560, -625.7983),
        },
        {
            Vector3.new(-52.6669, -120.2267, -393.7919),
            Vector3.new(-45.2733, -95.8739, -384.5992),
            Vector3.new(-43.7066, -89.2775, -380.1008),
        },
        {
           Vector3.new(-147.6, -34.3, -114.5),
           Vector3.new(-144.8, -35.0, -125.0),
           Vector3.new(-142.1, -35.2, -134.9),
           Vector3.new(-139.4, -35.1, -145.1),
           Vector3.new(-136.6, -35.0, -155.4),
           Vector3.new(-137.9, -35.0, -162.1),
           Vector3.new(-141.8, -34.9, -164.0),
           Vector3.new(-150.8, -33.1, -166.1),
           Vector3.new(-142.1, -34.8, -164.1),
           Vector3.new(-150.5, -33.3, -166.1),
           Vector3.new(-141.5, -34.9, -164.0),
           Vector3.new(-151.1, -32.8, -166.2),
           Vector3.new(-140.2, -35.0, -163.8),
           Vector3.new(-150.3, -33.2, -166.2),
           Vector3.new(-138.6, -35.0, -163.4),
           Vector3.new(-129.5, -35.0, -167.4),
           Vector3.new(-119.5, -35.0, -173.6),
           Vector3.new(-113.1, -33.6, -175.9),
           Vector3.new(-107.7, -28.2, -178.1),
           Vector3.new(-103.0, -25.7, -183.4),
           Vector3.new(-109.3, -26.6, -190.8),
           Vector3.new(-102.7, -25.5, -183.0),
           Vector3.new(-109.5, -26.6, -191.0),
           Vector3.new(-103.1, -25.6, -183.5),
           Vector3.new(-108.9, -26.6, -190.3),
           Vector3.new(-103.5, -25.7, -184.0),
           Vector3.new(-110.9, -26.5, -190.0),
           Vector3.new(-116.9, -26.1, -191.1),
           Vector3.new(-119.9, -26.7, -191.3),
           Vector3.new(-122.3, -23.9, -194.4),
           Vector3.new(-122.0, -17.5, -199.6),
           Vector3.new(-121.7, -11.3, -203.8),
           Vector3.new(-122.4, -6.4, -207.8),
           Vector3.new(-128.0, -6.4, -209.4),
           Vector3.new(-134.9, -6.5, -207.0),
           Vector3.new(-127.8, -6.6, -209.2),
           Vector3.new(-121.6, -5.9, -208.8),
           Vector3.new(-128.0, -6.6, -209.2),
           Vector3.new(-135.2, -6.8, -206.2),
           Vector3.new(-129.8, -5.9, -210.3),
           Vector3.new(-121.8, -5.4, -209.8),
           Vector3.new(-134.3, -6.6, -207.4),
           Vector3.new(-126.1, -4.6, -213.1),
           Vector3.new(-116.1, -3.0, -219.8),
           Vector3.new(-104.9, -3.0, -225.4),
           Vector3.new(-95.6, -3.0, -231.5),
           Vector3.new(-86.1, -3.0, -237.7),
           Vector3.new(-76.7, -3.0, -243.8),
           Vector3.new(-68.0, -3.0, -249.5),
           Vector3.new(-63.0, -3.0, -252.8),
           Vector3.new(-57.3, -3.0, -258.4),
           Vector3.new(-48.2, -3.0, -264.1),
           Vector3.new(-36.6, -3.0, -269.3),
           Vector3.new(-24.6, -3.0, -274.7),
           Vector3.new(-11.2, -3.0, -280.6),
           Vector3.new(1.2, -3.0, -286.2),
           Vector3.new(14.4, -3.0, -292.1),
           Vector3.new(27.3, -3.0, -297.8),
           Vector3.new(39.4, -3.0, -303.3),
           Vector3.new(51.4, -3.0, -308.6),
           Vector3.new(63.0, -3.0, -313.8),
           Vector3.new(73.3, -3.0, -318.4),
           Vector3.new(82.8, -3.0, -326.7),
           Vector3.new(91.6, -3.0, -336.3),
           Vector3.new(106.0, -3.0, -345.1),
           Vector3.new(119.3, -3.0, -354.1),
           Vector3.new(129.8, -3.0, -361.1),
           Vector3.new(141.5, -3.0, -369.0),
           Vector3.new(153.9, -3.0, -377.3),
           Vector3.new(164.7, -3.0, -384.6),
           Vector3.new(176.5, -3.0, -392.6),
           Vector3.new(185.5, -3.0, -398.6),
           Vector3.new(204.0, -3.0, -402.5),
           Vector3.new(218.5, -3.0, -401.0),
           Vector3.new(234.4, -3.0, -399.4),
           Vector3.new(252.1, -5.2, -398.0),
           Vector3.new(267.5, -7.1, -396.9),
           Vector3.new(282.2, -7.8, -396.0),
           Vector3.new(297.5, -7.6, -395.0),
           Vector3.new(310.8, -7.7, -394.1),
           Vector3.new(324.7, -7.0, -393.2),
           Vector3.new(340.9, -7.1, -392.1),
           Vector3.new(358.0, -7.0, -391.0),
           Vector3.new(374.2, -7.8, -389.9),
           Vector3.new(391.0, -7.5, -388.8),
           Vector3.new(408.4, -7.1, -387.7),
           Vector3.new(425.7, -7.3, -386.6),
           Vector3.new(441.4, -7.3, -385.5),
           Vector3.new(457.0, -7.1, -384.5),
           Vector3.new(474.8, -7.8, -383.3),
           Vector3.new(489.4, -7.0, -382.4),
           Vector3.new(506.7, -5.0, -383.0),
           Vector3.new(519.1, -3.6, -384.3),
           Vector3.new(530.7, -3.1, -385.5),
           Vector3.new(537.7, 2.0, -386.2),
           Vector3.new(545.1, 10.0, -387.0),
           Vector3.new(560.5, 9.9, -388.5),
           Vector3.new(571.9, 7.5, -389.7),
           Vector3.new(581.4, 2.5, -389.5),
           Vector3.new(589.9, -3.4, -386.2),
           Vector3.new(600.5, -4.9, -383.1),
           Vector3.new(617.4, -7.2, -386.4),
           Vector3.new(606.9, -5.6, -384.0),
           Vector3.new(618.4, -7.2, -386.6),
           Vector3.new(607.0, -6.0, -383.9),
           Vector3.new(616.7, -7.2, -386.2),
           Vector3.new(606.8, -5.6, -383.8),
           Vector3.new(618.4, -7.2, -386.5),
           Vector3.new(623.6, -7.7, -381.3),
           Vector3.new(633.5, -7.3, -377.1),
           Vector3.new(639.4, -6.5, -367.9),
           Vector3.new(636.7, -7.0, -379.4),
           Vector3.new(639.2, -6.6, -368.6),
           Vector3.new(636.6, -6.9, -379.8),
           Vector3.new(639.4, -6.7, -367.7),
           Vector3.new(636.6, -6.9, -379.4),
           Vector3.new(639.0, -6.8, -369.0),
           Vector3.new(634.9, -7.0, -362.1),
           Vector3.new(630.6, -6.1, -356.8),
           Vector3.new(626.4, -6.9, -355.9),
           Vector3.new(617.7, -7.4, -353.9),
           Vector3.new(627.8, -6.7, -356.3),
           Vector3.new(617.1, -7.3, -353.8),
           Vector3.new(627.8, -6.5, -356.3),
           Vector3.new(618.2, -7.5, -354.1),
           Vector3.new(627.4, -6.7, -356.3),
           Vector3.new(616.0, -7.3, -353.7),
           Vector3.new(604.8, -7.2, -354.1),
           Vector3.new(612.3, -7.3, -350.2),
           Vector3.new(605.6, -7.2, -353.8),
           Vector3.new(612.2, -7.1, -349.8),
           Vector3.new(605.4, -7.1, -352.8),
           Vector3.new(612.4, -6.9, -349.6),
           Vector3.new(604.0, -7.4, -355.8),
           Vector3.new(599.4, -8.7, -366.3),
           Vector3.new(595.1, -7.4, -374.9),
           Vector3.new(590.6, -3.4, -382.7),
           Vector3.new(586.6, -2.1, -385.2),
           Vector3.new(581.5, 1.4, -387.3),
           Vector3.new(569.4, 8.1, -391.9),
           Vector3.new(558.4, 11.8, -396.1),
           Vector3.new(549.1, 12.5, -399.6),
           Vector3.new(548.7, 16.2, -408.2),
           Vector3.new(547.7, 22.7, -412.9),
           Vector3.new(547.7, 29.5, -420.5),
           Vector3.new(555.2, 35.6, -424.2),
           Vector3.new(560.3, 41.6, -423.1),
           Vector3.new(568.3, 44.8, -419.8),
           Vector3.new(578.8, 48.2, -416.9),
           Vector3.new(591.2, 48.7, -413.6),
           Vector3.new(605.2, 48.9, -409.8),
           Vector3.new(617.4, 52.0, -406.4),
           Vector3.new(629.2, 52.2, -407.1),
           Vector3.new(639.2, 56.5, -410.0),
           Vector3.new(646.4, 62.7, -411.2),
           Vector3.new(654.6, 67.8, -412.7),
           Vector3.new(661.1, 75.5, -413.8),
           Vector3.new(670.2, 81.4, -413.4),
           Vector3.new(677.4, 84.2, -406.6),
           Vector3.new(685.1, 84.3, -399.8),
           Vector3.new(687.9, 87.4, -392.2),
           Vector3.new(684.6, 82.9, -387.0),
           Vector3.new(690.4, 88.1, -391.8),
           Vector3.new(686.1, 85.4, -397.5),
           Vector3.new(691.4, 89.4, -390.1),
           Vector3.new(686.9, 86.0, -388.1),
           Vector3.new(691.3, 88.4, -393.9),
           Vector3.new(685.4, 85.2, -398.4),
           Vector3.new(690.5, 88.4, -390.2),
           Vector3.new(686.9, 87.0, -387.3),
           Vector3.new(682.4, 81.1, -383.9),
           Vector3.new(679.4, 80.0, -376.7),
           Vector3.new(673.8, 76.3, -369.4),
           Vector3.new(674.1, 71.2, -362.5),
           Vector3.new(674.5, 66.1, -355.8),
           Vector3.new(675.2, 59.7, -345.1),
           Vector3.new(676.0, 56.2, -332.7),
           Vector3.new(677.5, 53.0, -319.7),
           Vector3.new(683.5, 48.4, -311.1),
           Vector3.new(690.0, 41.6, -305.4),
           Vector3.new(697.3, 35.3, -298.9),
           Vector3.new(707.8, 31.3, -295.7),
           Vector3.new(716.8, 26.1, -291.9),
           Vector3.new(723.6, 23.4, -283.7),
           Vector3.new(729.0, 24.0, -273.6),
           Vector3.new(729.9, 23.2, -261.2),
           Vector3.new(728.9, 22.2, -249.4),
           Vector3.new(729.5, 23.4, -239.4),
           Vector3.new(725.2, 25.4, -229.5),
           Vector3.new(719.3, 27.2, -219.9),
           Vector3.new(714.5, 24.8, -210.8),
           Vector3.new(706.4, 26.4, -201.7),
           Vector3.new(697.9, 28.3, -194.4),
           Vector3.new(690.1, 29.1, -186.8),
           Vector3.new(682.8, 32.9, -180.4),
           Vector3.new(672.6, 32.9, -179.8),
           Vector3.new(662.9, 32.7, -184.2),
           Vector3.new(668.6, 33.7, -192.4),
           Vector3.new(659.7, 32.0, -186.9),
           Vector3.new(668.0, 33.6, -192.0),
           Vector3.new(659.4, 32.0, -186.6),
           Vector3.new(668.9, 33.9, -192.4),
           Vector3.new(658.9, 31.8, -186.3),
           Vector3.new(668.0, 33.5, -191.8),
           Vector3.new(658.2, 31.5, -185.8),
           Vector3.new(653.5, 31.0, -182.8),
           Vector3.new(643.8, 28.9, -177.4),
           Vector3.new(632.2, 32.2, -180.1),
           Vector3.new(626.3, 32.8, -184.2),
           Vector3.new(614.2, 31.6, -189.1),
           Vector3.new(600.8, 21.0, -194.5),
           Vector3.new(594.3, 9.9, -197.1),
           Vector3.new(583.7, -0.4, -201.4),
           Vector3.new(574.1, -3.8, -205.2),
           Vector3.new(564.9, -6.8, -208.9),
           Vector3.new(555.4, -7.7, -212.7),
           Vector3.new(544.1, -7.0, -217.3),
           Vector3.new(533.2, -7.1, -221.7),
           Vector3.new(523.0, -7.0, -225.8),
           Vector3.new(511.0, -7.4, -230.6),
           Vector3.new(495.1, -7.5, -238.9),
           Vector3.new(481.5, -7.1, -246.8),
           Vector3.new(469.3, -7.1, -254.1),
           Vector3.new(455.8, -7.4, -262.0),
           Vector3.new(443.5, -7.0, -269.2),
           Vector3.new(431.6, -7.7, -276.2),
           Vector3.new(420.7, -7.2, -282.7),
           Vector3.new(408.1, -7.9, -290.1),
           Vector3.new(397.1, -7.0, -296.5),
           Vector3.new(387.1, -7.5, -302.5),
           Vector3.new(375.0, -7.5, -309.6),
           Vector3.new(364.1, -7.9, -316.0),
           Vector3.new(353.5, -7.3, -322.3),
           Vector3.new(343.2, -7.0, -328.3),
           Vector3.new(333.7, -7.0, -333.9),
           Vector3.new(323.5, -7.3, -339.9),
           Vector3.new(312.7, -7.1, -346.3),
           Vector3.new(301.8, -7.0, -352.7),
           Vector3.new(291.0, -7.0, -359.1),
           Vector3.new(280.7, -7.0, -365.1),
           Vector3.new(270.5, -7.0, -371.1),
           Vector3.new(260.2, -7.0, -377.2),
           Vector3.new(251.1, -3.9, -382.6),
           Vector3.new(241.3, -3.0, -388.4),
           Vector3.new(230.7, -3.0, -394.6),
           Vector3.new(221.8, -3.0, -399.8),
           Vector3.new(211.6, -3.0, -405.9),
           Vector3.new(202.3, -3.0, -411.3),
           Vector3.new(192.6, -3.0, -417.0),
           Vector3.new(180.4, -6.9, -426.1),
           Vector3.new(169.6, -7.5, -435.2),
           Vector3.new(157.8, -7.5, -438.3),
           Vector3.new(144.4, -7.6, -441.9),
           Vector3.new(130.8, -7.4, -445.5),
           Vector3.new(118.1, -7.8, -448.9),
           Vector3.new(106.9, -7.2, -451.9),
           Vector3.new(95.0, -7.1, -455.0),
           Vector3.new(83.3, -7.0, -458.1),
           Vector3.new(70.8, -7.6, -461.4),
           Vector3.new(58.6, -7.3, -464.7),
           Vector3.new(46.1, -7.0, -468.0),
           Vector3.new(34.5, -4.6, -471.1),
           Vector3.new(22.6, -3.0, -474.3),
           Vector3.new(12.1, -3.0, -477.1),
           Vector3.new(-0.2, -3.0, -480.3),
           Vector3.new(-10.9, -3.0, -483.2),
           Vector3.new(-21.7, -3.0, -486.1),
           Vector3.new(-33.7, -3.0, -489.3),
           Vector3.new(-44.6, -3.0, -492.1),
           Vector3.new(-58.7, -3.0, -496.5),
           Vector3.new(-75.0, -1.1, -502.5),
           Vector3.new(-82.1, 2.7, -505.0),
           Vector3.new(-96.4, 5.0, -508.3),
           Vector3.new(-104.5, 5.0, -512.1),
           Vector3.new(-112.0, 5.0, -514.9),
           Vector3.new(-124.6, 5.0, -519.1),
           Vector3.new(-131.0, 5.0, -521.3),
           Vector3.new(-137.1, 5.0, -528.1),
           Vector3.new(-151.3, 5.0, -544.2),
           Vector3.new(-160.1, 5.0, -554.3),
           Vector3.new(-170.4, 5.0, -566.2),
           Vector3.new(-179.4, 5.0, -576.5),
           Vector3.new(-187.7, 5.0, -590.2),
           Vector3.new(-192.6, 5.0, -609.1),
           Vector3.new(-199.6, 5.5, -615.3),
           Vector3.new(-202.7, 9.8, -617.4),
           Vector3.new(-204.2, 14.9, -621.4),
           Vector3.new(-205.8, 20.6, -625.8),
           Vector3.new(-209.5, 21.5, -629.3),
           Vector3.new(-215.9, 21.5, -626.0),
           Vector3.new(-209.0, 21.5, -629.7),
           Vector3.new(-216.3, 21.5, -625.8),
           Vector3.new(-208.9, 21.5, -629.7),
           Vector3.new(-216.3, 21.5, -625.7),
           Vector3.new(-209.3, 21.5, -629.4),
           Vector3.new(-216.8, 21.5, -625.4),
           Vector3.new(-210.4, 21.5, -628.8),
           Vector3.new(-208.3, 21.5, -630.9),
           Vector3.new(-203.1, 5.6, -633.6),
           Vector3.new(-202.1, -1.2, -638.3),
           Vector3.new(-209.1, -3.0, -644.9)
        }
    }
    
    local oldFolder = workspace:FindFirstChild("RedSticks")
    if oldFolder then oldFolder:Destroy() end
    local folder = Instance.new("Folder")
    folder.Name = "RedSticks"
    folder.Parent = workspace
    for i, group in ipairs(groups) do
        if #group >= 2 then
            CreateWideStick(group, folder, "SigmoPart_" .. i)
        end
    end
    
    local success, raw = pcall(function() return readfile("TweensCFG1.json") end)
    if not success then _G.walkPts = _G.walkPts or {} return end
    local ok, data = pcall(function() return httpservice:JSONDecode(raw) end)
    if not ok or not data or not data.position then _G.walkPts = _G.walkPts or {} return end
    
    local out = {}
    local folder2 = Instance.new("Folder", workspace)
    folder2.Name = "WalkerSpheres"
    for i, p in ipairs(data.position) do
        local vec = Vector3.new(p.X, p.Y, p.Z)
        out[#out + 1] = vec
        local part = Instance.new("Part", folder2)
        part.Shape = Enum.PartType.Ball
        part.Anchored = true
        part.CanCollide = false
        part.Size = Vector3.new(1.5, 1.5, 1.5)
        part.Position = vec
        part.Color = Color3.new(1, 0, 0)
        part.Transparency = 0.25
        part.Name = "WalkerDot_" .. i
    end
    _G.walkPts = out
end

local isWalking = false
local currentTween = nil
local WalkConn = nil
local StartPos = nil

local function StartWalkingLoop()
    if isWalking then return end
    isWalking = true
    
    LoadTweensConfig_CreateVisuals()
    
    if #(_G.walkPts or {}) == 0 then
        warn("No walking points loaded. Auto Walk stopped.")
        isWalking = false
        return
    end

    local currentIndex = 1
    
    local function GetNextPos()
        if currentIndex > #_G.walkPts then
            currentIndex = 1
        end
        local pos = _G.walkPts[currentIndex]
        currentIndex = currentIndex + 1
        return pos
    end

    local function WalkTo(targetPos)
        if not hum or hum.Health <= 0 then isWalking = false return end
        local dist = (root.Position - targetPos).Magnitude
        local duration = math.max(0.2, dist / 40) 

        local tweenInfo = TweenInfo.new(
            duration,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.In,
            0,
            false,
            0
        )
        
        currentTween = tspmo:Create(root, tweenInfo, { CFrame = CFrame.new(targetPos) })
        
        local finished = false
        currentTween.Completed:Connect(function(playbackState)
            if playbackState == Enum.PlaybackState.Completed then
                finished = true
            end
        end)
        
        currentTween:Play()
        
        local waitTime = duration + 0.1
        local start = tick()
        while not finished and isWalking and (tick() - start < waitTime) do
            task.wait(0.05)
        end
        
        if currentTween and currentTween.PlaybackState ~= Enum.PlaybackState.Completed then
            currentTween:Cancel()
        end
        currentTween = nil
    end

    task.spawn(function()
        while isWalking do
            local nextPos = GetNextPos()
            WalkTo(nextPos)
            task.wait(0.1)
        end
    end)
end

local function StopWalkingLoop()
    isWalking = false
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    ClearOldBoardsAndHelpers()
end

local isFarming = false
local farmLoop = nil

local function StartFarmingLoop(range, cooldown)
    if isFarming then return end
    isFarming = true
    
    farmLoop = task.spawn(function()
        while isFarming do
            -- Проверка на смерть
            if not char or not char:FindFirstChild("HumanoidRootPart") then 
                task.wait(1) 
                local new_char = plr.Character or plr.CharacterAdded:Wait() 
                if new_char then 
                    char = new_char 
                    root = char:WaitForChild("HumanoidRootPart") 
                end
                goto continue
            end
            
            local targets = {}
            for _, ent in ipairs(workspace:GetDescendants()) do
                if ent:IsA("BasePart") and ent:GetAttribute("EntityID") then
                    local name = ent.Name or ""
                    local lowered = name:lower()
                    -- Цели для фарма (деревья, руды и т.д.)
                    if lowered:find("mine") or lowered:find("tree") or lowered:find("rock") then
                        local dist = (ent.Position - root.Position).Magnitude
                        if dist <= (range or 30) then
                            table.insert(targets, { eid = ent:GetAttribute("EntityID"), dist = dist })
                        end
                    end
                end
            end
            
            table.sort(targets, function(a, b) return a.dist < b.dist end)
            
            local sel = {}
            for i = 1, math.min(6, #targets) do
                table.insert(sel, targets[i].eid)
            end
            
            -- Атака цели
            if #sel > 0 then
                if packets and packets.SwingTool and packets.SwingTool.send then 
                    packets.SwingTool.send(sel) 
                end
            end

            -- Сбор золота (Pickup Gold)
            if packets and packets.Pickup and packets.Pickup.send then
                for _, itm in ipairs(workspace:GetChildren()) do
                    if (itm:IsA("BasePart") or itm:IsA("MeshPart")) and itm.GetAttribute and itm:GetAttribute("EntityID") then
                        local name = itm.Name or ""
                        local lowered = name:lower()
                        if lowered:find("gold") or lowered:find("coin") then
                            local eid = itm:GetAttribute("EntityID")
                            local dist = (itm.Position - root.Position).Magnitude
                            if dist <= (range or 30) then
                                pcall(function() packets.Pickup.send(eid) end)
                            end
                        end
                    end
                end
            end
            
            ::continue::
            task.wait(cooldown)
        end
    end)
end

local function StopFarmingLoop()
    isFarming = false
    if farmLoop then
        task.cancel(farmLoop)
        farmLoop = nil
    end
end

-- ===============================================
-- GUI Integration
-- ===============================================

-- Проверка, что GUI из удаленного скрипта загрузился
if Library and Window and Tabs then
    -- Движение
    local movementTab = Tabs.Movement or Tabs.General -- Ищем вкладку "Movement" или используем "General"
    if movementTab then
        local autowalktoggle = movementTab:CreateToggle("autowalktoggle", {
            Title = "Auto Walk (Sigmo)",
            Default = false
        })
        
        autowalktoggle:OnChanged(function(value)
            if value then
                pcall(StartWalkingLoop)
            else
                pcall(StopWalkingLoop)
            end
        end)
        
        movementTab:CreateButton({ 
            Title = "Load Waypoints (BoogaX Config)", 
            Callback = function() 
                pcall(LoadTweensConfig_CreateVisuals) 
            end 
        })
    end

    -- Фарминг
    local farmingTab = Tabs.Farming or Tabs.General -- Ищем вкладку "Farming" или используем "General"
    if farmingTab then 
        local autofarmgoldtoggle = farmingTab:CreateToggle("autofarmgoldtoggle", { 
            Title = "Auto Farm Gold", 
            Default = false 
        }) 
        local autofarmgoldrange = farmingTab:CreateSlider("autofarmgoldrange", { 
            Title = "Range", 
            Min = 5, 
            Max = 200, 
            Rounding = 1, 
            Default = 30 
        }) 
        local autofarmgoldcooldown = farmingTab:CreateSlider("autofarmgoldcooldown", { 
            Title = "Swing Delay (s)", 
            Min = 0.01, 
            Max = 1.5, 
            Rounding = 2, 
            Default = 0.12 
        }) 
        
        local function UpdateFarmLoop()
            local range = tonumber(autofarmgoldrange.Value) or 30
            local cooldown = tonumber(autofarmgoldcooldown.Value) or 0.12
            if autofarmgoldtoggle.Value then
                pcall(StopFarmingLoop)
                pcall(function() StartFarmingLoop(range, cooldown) end)
            end
        end
        
        autofarmgoldtoggle:OnChanged(function(value)
            if value then
                pcall(UpdateFarmLoop)
            else
                pcall(StopFarmingLoop)
            end
        end)
        
        autofarmgoldrange:OnChanged(UpdateFarmLoop)
        autofarmgoldcooldown:OnChanged(UpdateFarmLoop)
    end
end

]]

-- ===============================================
-- ИСПРАВЛЕНИЕ ОШИБКИ СИНТАКСИСА
-- ===============================================
-- Вставка ";\n" заставит компилятор завершить любую незавершенную 
-- команду в конце оригинального скрипта, предотвращая ошибку.
local merged = orig .. ";\n" .. appended 

local fn,err = loadstring(merged)
if not fn then
    error("Failed to compile merged script: "..tostring(err))
else
    fn()
end
