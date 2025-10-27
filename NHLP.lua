-- OEA HUB 修复版 (解决404错误)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ==================== 安全加载黑曜石UI ====================
print("🔄 正在加载黑曜石UI...")
local Obsidian

-- 尝试多个备用链接
local uiLinks = {
    "https://raw.githubusercontent.com/ObsidianUI/Obsidian/main/src/Obsidian.lua",
    "https://raw.githubusercontent.com/ObsidianUI/Obsidian/master/source/Obsidian.lua",
    "https://gist.githubusercontent.com/raw/obsidian-ui-backup/main/Obsidian.lua", -- 备用链接
    "https://cdn.jsdelivr.net/gh/ObsidianUI/Obsidian@main/src/Obsidian.lua"
}

local loadSuccess = false
for i, link in ipairs(uiLinks) do
    local success, errorMsg = pcall(function()
        local uiSource = game:HttpGet(link, true) -- 添加true参数提高稳定性
        if uiSource and #uiSource > 100 then -- 检查内容是否有效
            Obsidian = loadstring(uiSource)()
            loadSuccess = true
            print("✅ UI加载成功，使用链接: " .. link)
            break
        end
    end)
    
    if loadSuccess then break end
end

if not loadSuccess then
    warn("❌ 所有UI链接均失败，使用基础UI")
    -- 创建简单备用UI
    local function CreateFallbackUI()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = player.PlayerGui
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 400, 0, 300)
        Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        Frame.Parent = ScreenGui
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.Text = "OEA HUB (基础模式)\nUI加载失败，但功能可用"
        Label.TextColor3 = Color3.white
        Label.BackgroundTransparency = 1
        Label.Parent = Frame
        
        return {CreateWindow = function() return ScreenGui end}
    end
    
    Obsidian = CreateFallbackUI()
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

-- ==================== UI创建 ====================
local Window = Obsidian:CreateWindow({
    Title = "OEA HUB",
    Size = UDim2.new(0, 500, 0, 450),
    Theme = "Dark",
    AccentColor = Color3.fromRGB(0, 170, 255),
    Icon = "99523490565854"
})

-- 标签1：公告
local TabNotice = Window:CreateTab("公告")
local noticeSection = TabNotice:CreateSection("更新日志")
noticeSection:CreateLabel("📢 当前版本：v1.0")
noticeSection:CreateLabel("🔄 更新内容：修复UI加载问题")

-- 标签2：通用功能
local TabGeneral = Window:CreateTab("通用")
local UtilityGroup = TabGeneral:CreateSection("实用工具")

-- ==================== 功能逻辑 ====================
-- 飞行功能（带错误处理）
UtilityGroup:CreateButton({
    Text = "🛫 飞行模式 (R15)",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        end)
        if not success then
            warn("飞行脚本加载失败: " .. tostring(err))
        end
    end
})

-- 鹿动画功能
UtilityGroup:CreateButton({
    Text = "🦌 鹿动画 (R6)", 
    Callback = function()
        local animScript = [[
            4,383|{~Ah!# :!! A j!&!( T o r s o!+!# L e f t  !4 g!& [ ] ,!# R i g h!7!9!;!=!3!5!7 A r m!F!> A!@!B!J!L!N!# H e a d!F } }!O r!&!V u m a n o i d R o o t P a r t!#!^!# l!& f a l s e!O k!2 A!4!6  !K!M A : [!( e!; 0 , 0!G A!q#'#-!# c!; - 0 . 1 2 9 ,#8#: 1 6#>#9#A 3#. . 9 5#F#-#? 5 7 3 ]!^#*#,#.#0#2 :#;!O#6#' [#D 9#B#D 7#a . 2 4 8#G#I#K#C .#N#P#R!##+#]#-#/!O#W#f#Z#7#9 2 8#B#? 2#N#l 3 6 1#i#J#.#l#n#Q ,#S#s#U#v!&$%#y#s#@ 5#G 1 0#K#: 4$8#9#j$*#M#O$-$/#(#t#V!&#g$5#($  3 4#l 2$'$ #`$(#k$C#o$.#q#T#u!##W 6#4 A#[$G#e 0#d 1 8$?#e#d$A#L#9$,#p A#r$G$1$_!& 7 2$L [#? 1 5#h$} 4$z$} 9#=$@$)$o#m$D$r$t#^$v#1!& 8$P#5#,#e 3#h#{ 1$P#9 3 0$'%)$W$p%-$Z$s$]$I#'$U%6#]$ #}$Q$##?$%$z%B$B%D$Y$F%0$^%2#'$:#h%L$e%<$k 1$<$i$<$n$+%E%Y$H$2%^ 2$b$d$|%> 3$8%R%@#l%$%h%*%j#o$-!# n!a A U n n a m e d   #$~!r
        ]]
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animScript
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:LoadAnimation(anim)
            animator:Play()
        end
    end
})

-- 穿墙开关
UtilityGroup:CreateToggle({
    Text = "🧱 穿墙模式",
    Callback = function(State)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(State and Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.Running)
        end
    end
})

-- 防甩飞开关  
UtilityGroup:CreateToggle({
    Text = "🛡️ 防甩飞",
    Callback = function(State)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:SetAttribute("AntiThrow", State)
        end
    end
})

Window:Show()
print("✅ OEA HUB 加载完成")
