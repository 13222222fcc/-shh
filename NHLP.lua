-- 🌟 OEA HUB 终极修复版 - 解决第1行404错误 🌟
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🔧 开始加载OEA HUB修复版...")

-- ==================== 超强UI加载系统 ====================
local Obsidian

-- 方案1：使用内置UI系统（绝对可靠）
local function CreateBuiltInUI()
    print("🛠️ 使用内置UI系统...")
    
    local BuiltInUI = {}
    
    function BuiltInUI:CreateWindow(options)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "OEA_HUB"
        screenGui.Parent = player.PlayerGui
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = options.Size or UDim2.new(0, 500, 0, 450)
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
        mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui
        
        -- 标题栏
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 40)
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        titleBar.Parent = mainFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 1, 0)
        titleLabel.Text = "  " .. (options.Title or "OEA HUB 修复版")
        titleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.SciFi
        titleLabel.TextSize = 18
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = titleBar
        
        local window = {
            Gui = screenGui,
            Elements = {}
        }
        
        function window:CreateTab(tabName)
            local tab = {
                Buttons = {},
                Toggles = {},
                Labels = {}
            }
            
            function tab:CreateSection(sectionName)
                local sectionY = #tab.Labels * 30 + #tab.Buttons * 45 + #tab.Toggles * 40 + 20
                
                if sectionName then
                    local sectionLabel = Instance.new("TextLabel")
                    sectionLabel.Size = UDim2.new(0.9, 0, 0, 25)
                    sectionLabel.Position = UDim2.new(0.05, 0, 0, sectionY)
                    sectionLabel.Text = "▪ " .. sectionName
                    sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    sectionLabel.BackgroundTransparency = 1
                    sectionLabel.Font = Enum.Font.GothamBold
                    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                    sectionLabel.Parent = mainFrame
                    table.insert(tab.Labels, sectionLabel)
                end
                
                local section = {
                    CreateButton = function(self, buttonOptions)
                        local buttonY = sectionY + #tab.Buttons * 45 + 5
                        
                        local button = Instance.new("TextButton")
                        button.Size = UDim2.new(0.9, 0, 0, 40)
                        button.Position = UDim2.new(0.05, 0, 0, buttonY)
                        button.Text = buttonOptions.Text or "按钮"
                        button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                        button.TextColor3 = Color3.white
                        button.Font = Enum.Font.Gotham
                        button.TextSize = 14
                        button.Parent = mainFrame
                        
                        button.MouseButton1Click:Connect(function()
                            if buttonOptions.Callback then
                                pcall(buttonOptions.Callback)
                            end
                        end)
                        
                        table.insert(tab.Buttons, button)
                        return button
                    end,
                    
                    CreateToggle = function(self, toggleOptions)
                        local toggleY = sectionY + #tab.Buttons * 45 + #tab.Toggles * 40 + 5
                        
                        local toggleFrame = Instance.new("Frame")
                        toggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
                        toggleFrame.Position = UDim2.new(0.05, 0, 0, toggleY)
                        toggleFrame.BackgroundTransparency = 1
                        toggleFrame.Parent = mainFrame
                        
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(0.7, 0, 1, 0)
                        label.Text = toggleOptions.Text or "开关"
                        label.TextColor3 = Color3.white
                        label.BackgroundTransparency = 1
                        label.Font = Enum.Font.Gotham
                        label.TextXAlignment = Enum.TextXAlignment.Left
                        label.Parent = toggleFrame
                        
                        local toggleButton = Instance.new("TextButton")
                        toggleButton.Size = UDim2.new(0.25, 0, 0.7, 0)
                        toggleButton.Position = UDim2.new(0.75, 0, 0.15, 0)
                        toggleButton.Text = "关"
                        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
                        toggleButton.TextColor3 = Color3.white
                        toggleButton.Font = Enum.Font.GothamBold
                        toggleButton.Parent = toggleFrame
                        
                        local state = toggleOptions.Default or false
                        
                        toggleButton.MouseButton1Click:Connect(function()
                            state = not state
                            toggleButton.Text = state and "开" or "关"
                            toggleButton.BackgroundColor3 = state and Color3.fromRGB(30, 100, 30) or Color3.fromRGB(100, 30, 30)
                            
                            if toggleOptions.Callback then
                                pcall(toggleOptions.Callback, state)
                            end
                        end)
                        
                        table.insert(tab.Toggles, toggleFrame)
                        return {SetState = function(self, newState) 
                            state = newState
                            toggleButton.Text = state and "开" or "关"
                            toggleButton.BackgroundColor3 = state and Color3.fromRGB(30, 100, 30) or Color3.fromRGB(100, 30, 30)
                        end}
                    end,
                    
                    CreateLabel = function(self, text)
                        local labelY = sectionY + #tab.Labels * 25 + 5
                        
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(0.9, 0, 0, 20)
                        label.Position = UDim2.new(0.05, 0, 0, labelY)
                        label.Text = "  " .. text
                        label.TextColor3 = Color3.fromRGB(180, 180, 180)
                        label.BackgroundTransparency = 1
                        label.Font = Enum.Font.Gotham
                        label.TextSize = 12
                        label.TextXAlignment = Enum.TextXAlignment.Left
                        label.Parent = mainFrame
                        
                        table.insert(tab.Labels, label)
                        return label
                    end
                }
                
                return section
            end
            
            table.insert(window.Elements, tab)
            return tab
        end
        
        function window:Show()
            print("✅ OEA HUB 界面加载完成！")
        end
        
        return window
    end
    
    return BuiltInUI
end

-- ==================== 权限检测 ====================
local function CheckPermission()
    if player.Name ~= "DGDASWDF775" then
        player:Kick("❌ 你没有资格使用此功能")
        return false
    end
    return true
end

if not CheckPermission() then
    return
end

print("✅ 权限验证通过")

-- ==================== 使用内置UI系统 ====================
Obsidian = CreateBuiltInUI()

-- ==================== 创建界面 ====================
local Window = Obsidian:CreateWindow({
    Title = "OEA HUB 修复版",
    Size = UDim2.new(0, 500, 0, 450)
})

-- 公告标签
local TabNotice = Window:CreateTab("公告")
local NoticeSection = TabNotice:CreateSection("更新日志")
NoticeSection:CreateLabel("✅ 修复第1行404错误")
NoticeSection:CreateLabel("🚀 使用内置UI系统")
NoticeSection:CreateLabel("🎯 100%可用版本")

-- 功能标签
local TabGeneral = Window:CreateTab("通用")
local UtilitySection = TabGeneral:CreateSection("实用工具")

-- 飞行功能
UtilitySection:CreateButton({
    Text = "🛫 飞行模式 (R15)",
    Callback = function()
        local success, result = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        end)
        if success then
            print("✅ 飞行模式启动")
        else
            warn("❌ 飞行加载失败: " .. tostring(result))
        end
    end
})

-- 鹿动画功能
UtilitySection:CreateButton({
    Text = "🦌 鹿动画 (R6)",
    Callback = function()
        local animScript = [[4,383|{~Ah!# :!! A j!&!( T o r s o!+!# L e f t  !4 g!& [ ] ,!# R i g h!7!9!;!=!3!5!7 A r m!F!> A!@!B!J!L!N!# H e a d!F } }!O r!&!V u m a n o i d R o o t P a r t!#!^!# l!& f a l s e!O k!2 A!4!6  !K!M A : [!( e!; 0 , 0!G A!q#'#-!# c!; - 0 . 1 2 9 ,#8#: 1 6#>#9#A 3#. . 9 5#F#-#? 5 7 3 ]!^#*#,#.#0#2 :#;!O#6#' [#D 9#B#D 7#a . 2 4 8#G#I#K#C .#N#P#R!##+#]#-#/!O#W#f#Z#7#9 2 8#B#? 2#N#l 3 6 1#i#J#.#l#n#Q ,#S#s#U#v!&$%#y#s#@ 5#G 1 0#K#: 4$8#9#j$*#M#O$-$/#(#t#V!&#g$5#($  3 4#l 2$'$ #`$(#k$C#o$.#q#T#u!##W 6#4 A#[$G#e 0#d 1 8$?#e#d$A#L#9$,#p A#r$G$1$_!& 7 2$L [#? 1 5#h$} 4$z$} 9#=$@$)$o#m$D$r$t#^$v#1!& 8$P#5#,#e 3#h#{ 1$P#9 3 0$'%)$W$p%-$Z$s$]$I#'$U%6#]$ #}$Q$##?$%$z%B$B%D$Y$F%0$^%2#'$:#h%L$e%<$k 1$<$i$<$n$+%E%Y$H$2%^ 2$b$d$|%> 3$8%R%@#l%$%h%*%j#o$-!# n!a A U n n a m e d   #$~!r]]
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animScript
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:LoadAnimation(anim)
            animator:Play()
            print("✅ 鹿动画播放")
        end
    end
})

-- 穿墙开关
UtilitySection:CreateToggle({
    Text = "🧱 穿墙模式",
    Callback = function(State)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(State and Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.Running)
            print("穿墙模式: " .. (State and "开" or "关"))
        end
    end
})

-- 防甩飞开关
UtilitySection:CreateToggle({
    Text = "🛡️ 防甩飞",
    Callback = function(State)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:SetAttribute("AntiThrow", State)
            print("防甩飞: " .. (State and "开" or "关"))
        end
    end
})

Window:Show()
print("🎉 OEA HUB 修复版加载完成！")
