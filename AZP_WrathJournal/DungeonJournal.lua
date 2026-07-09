AZP = AZP or {}
AZP.WrathJournal = AZP.WrathJournal or {}

local Frame = CreateFrame("Frame", "AZP_WrathJournalUI", UIParent)
Frame:SetSize(780, 520)
Frame:SetPoint("CENTER")
Frame:SetMovable(true)
Frame:EnableMouse(true)
Frame:SetClampedToScreen(true)
Frame:Hide()

Frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})

Frame:RegisterForDrag("LeftButton")
Frame:SetScript("OnDragStart", Frame.StartMoving)
Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)

local Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
Title:SetPoint("TOP", 0, -16)
Title:SetText("Diario de Mazmorras 3.3.5a - ICC")
Frame.Title = Title

local CloseBtn = CreateFrame("Button", nil, Frame, "UIPanelCloseButton")
CloseBtn:SetPoint("TOPRIGHT", -5, -5)

-- Panel 3D Ajustado
local Model = CreateFrame("DressUpModel", "AZP_BossModel", Frame)
Model:SetSize(240, 340)
Model:SetPoint("TOPLEFT", 20, -50)
Model:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
Model:SetBackdropColor(0, 0, 0, 0.7)
Frame.Model = Model

-- Panel Derecho con Scroll para Texto Largo
local InfoScrollFrame = CreateFrame("ScrollFrame", "AZP_InfoScrollFrame", Frame, "UIPanelScrollFrameTemplate")
InfoScrollFrame:SetSize(310, 420)
InfoScrollFrame:SetPoint("TOPLEFT", Model, "TOPRIGHT", 15, 0)

local InfoContent = CreateFrame("Frame", nil, InfoScrollFrame)
InfoContent:SetSize(290, 1500)
InfoScrollFrame:SetScrollChild(InfoContent)

local BossName = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium")
BossName:SetPoint("TOPLEFT", 0, 0)
BossName:SetText("Selecciona un Jefe")

local BossDesc = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
BossDesc:SetPoint("TOPLEFT", BossName, "BOTTOMLEFT", 0, -6)
BossDesc:SetWidth(280)
BossDesc:SetJustifyH("LEFT")

local DetailsText = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
DetailsText:SetPoint("TOPLEFT", BossDesc, "BOTTOMLEFT", 0, -10)
DetailsText:SetWidth(280)
DetailsText:SetJustifyH("LEFT")

-- Panel de Lista de Jefes
local BossScrollFrame = CreateFrame("ScrollFrame", "AZP_BossScrollFrame", Frame, "UIPanelScrollFrameTemplate")
BossScrollFrame:SetSize(150, 420)
BossScrollFrame:SetPoint("TOPRIGHT", -35, -50)

local BossScrollContent = CreateFrame("Frame", nil, BossScrollFrame)
BossScrollContent:SetSize(150, 600)
BossScrollFrame:SetScrollChild(BossScrollContent)

function AZP.WrathJournal:SelectBoss(encounterID)
    local data = AZP.WrathJournal.RetailSectionData and AZP.WrathJournal.RetailSectionData[encounterID]
    
    if not data then return end

    BossName:SetText("|cff00ff00" .. (data.name or "") .. "|r")
    BossDesc:SetText(data.description or "")

    -- Cargar y escalar modelo 3D
    if Frame.Model then
        Frame.Model:ClearModel()
        if data.displayID then
            Frame.Model:SetCreature(data.displayID)
            local scale = data.modelScale or 1.0
            Frame.Model:SetModelScale(scale)
            Frame.Model:SetPosition(0, 0, data.modelZ or 0)
        end
    end

    local txt = ""
    if data.abilities then
        txt = txt .. "|cffffcc00[ HABILIDADES ]|r\n"
        for _, ab in ipairs(data.abilities) do
            txt = txt .. "• |cffffd100" .. ab.name .. ":|r " .. ab.desc .. "\n"
        end
        txt = txt .. "\n"
    end

    if data.heroic then
        txt = txt .. "|cffff4444[ CAMBIOS EN HEROICO ]|r\n" .. data.heroic .. "\n\n"
    end

    if data.strategy then
        txt = txt .. "|cff00ffff[ ESTRATEGIA Y POSICIONAMIENTO ]|r\n" .. data.strategy .. "\n"
    end

    DetailsText:SetText(txt)
    InfoContent:SetHeight(DetailsText:GetStringHeight() + 100)
end

local built = false
local function BuildBossList()
    if built then return end
    built = true

    local offsetY = 0
    if not AZP.WrathJournal.Instances then return end

    for _, instData in pairs(AZP.WrathJournal.Instances) do
        local header = BossScrollContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        header:SetPoint("TOPLEFT", 5, -offsetY)
        header:SetText("|cff66bbff" .. instData.name .. "|r")
        offsetY = offsetY + 20

        for _, boss in ipairs(instData.encounters) do
            local btn = CreateFrame("Button", nil, BossScrollContent, "UIPanelButtonTemplate")
            btn:SetSize(130, 22)
            btn:SetPoint("TOPLEFT", 5, -offsetY)
            btn:SetText(boss.name)

            local id = boss.id
            btn:SetScript("OnClick", function()
                AZP.WrathJournal:SelectBoss(id)
            end)

            offsetY = offsetY + 24
        end
    end
end

function AZP.WrathJournal:ToggleUI()
    BuildBossList()
    if Frame:IsShown() then
        Frame:Hide()
    else
        Frame:Show()
    end
end

local function SetupMicroButton()
    if MainMenuExpBar then MainMenuExpBar:Hide() end

    local EJMicroButton = CreateFrame("Button", "AZP_EJMicroButton", MainMenuBar)
    EJMicroButton:SetSize(28, 58)
    EJMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-EJ-Up")
    EJMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-EJ-Down")
    EJMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight")
    
    EJMicroButton:SetScript("OnClick", function()
        AZP.WrathJournal:ToggleUI()
    end)

    local lfgBtn = PVPMicroButton or LookingForGroupMicroButton

    if CharacterMicroButton and HelpMicroButton then
        CharacterMicroButton:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 547, 2)
        SpellbookMicroButton:SetPoint("BOTTOMLEFT", CharacterMicroButton, "BOTTOMRIGHT", -4, 0)
        TalentMicroButton:SetPoint("BOTTOMLEFT", SpellbookMicroButton, "BOTTOMRIGHT", -4, 0)
        AchievementMicroButton:SetPoint("BOTTOMLEFT", TalentMicroButton, "BOTTOMRIGHT", -4, 0)
        QuestLogMicroButton:SetPoint("BOTTOMLEFT", AchievementMicroButton, "BOTTOMRIGHT", -4, 0)
        SocialsMicroButton:SetPoint("BOTTOMLEFT", QuestLogMicroButton, "BOTTOMRIGHT", -4, 0)
        
        local lastButton = SocialsMicroButton

        if lfgBtn then
            lfgBtn:ClearAllPoints()
            lfgBtn:SetPoint("BOTTOMLEFT", lastButton, "BOTTOMRIGHT", -4, 0)
            lastButton = lfgBtn
        end

        EJMicroButton:SetPoint("BOTTOMLEFT", lastButton, "BOTTOMRIGHT", -4, 0)
        MainMenuMicroButton:SetPoint("BOTTOMLEFT", EJMicroButton, "BOTTOMRIGHT", -5, 0)
        HelpMicroButton:SetPoint("BOTTOMLEFT", MainMenuMicroButton, "BOTTOMRIGHT", -4, 0)
    end
end

SLASH_AZPWRATHJOURNAL1 = "/aj"
SLASH_AZPWRATHJOURNAL2 = "/wrathjournal"
SlashCmdList["AZPWRATHJOURNAL"] = function(msg)
    AZP.WrathJournal:ToggleUI()
end

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
EventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        SetupMicroButton()
    end
end)