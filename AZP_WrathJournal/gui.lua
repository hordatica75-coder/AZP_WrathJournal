AZP = AZP or {}
AZP.WrathJournal = AZP.WrathJournal or {}

-- -------------------------------------------------------------
-- VENTANA PRINCIPAL (NEGRO MATE 100% OPACO)
-- -------------------------------------------------------------
local Frame = CreateFrame("Frame", "AZP_WrathJournalUI", UIParent)
Frame:SetSize(880, 580)
Frame:SetPoint("CENTER")
Frame:SetMovable(true)
Frame:EnableMouse(true)
Frame:SetClampedToScreen(true)
Frame:SetFrameStrata("HIGH")
Frame:Hide()

-- Fondo Sólido Negro
local SolidBG = Frame:CreateTexture(nil, "BACKGROUND")
SolidBG:SetAllPoints(Frame)
SolidBG:SetTexture(0, 0, 0, 1)

-- Borde exterior
local Border = CreateFrame("Frame", nil, Frame)
Border:SetAllPoints(Frame)
Border:SetBackdrop({
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})

Frame:RegisterForDrag("LeftButton")
Frame:SetScript("OnDragStart", Frame.StartMoving)
Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)

local Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
Title:SetPoint("TOP", 0, -16)
Title:SetText("|cff80d8ffDiario de Mazmorras 3.3.5a - ICC|r")
Frame.Title = Title

-- Créditos abajo a la izquierda
local Credits = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
Credits:SetPoint("BOTTOMLEFT", 25, 18)
Credits:SetText("|cff80d8ffCréditos: Eficaxx|r")

local CloseBtn = CreateFrame("Button", nil, Frame, "UIPanelCloseButton")
CloseBtn:SetPoint("TOPRIGHT", -5, -5)

-- -------------------------------------------------------------
-- 1. PANEL IZQUIERDO: IMAGEN DEL JEFE
-- -------------------------------------------------------------
local LeftPanel = CreateFrame("Frame", nil, Frame)
LeftPanel:SetSize(240, 480)
LeftPanel:SetPoint("TOPLEFT", 25, -50)

local Model = CreateFrame("DressUpModel", "AZP_BossModel", LeftPanel)
Model:SetSize(240, 400)
Model:SetPoint("TOP", LeftPanel, "TOP", 0, 0)
Frame.Model = Model

local BossImage = LeftPanel:CreateTexture(nil, "ARTWORK")
BossImage:SetSize(240, 400)
BossImage:SetPoint("TOP", LeftPanel, "TOP", 0, 0)
BossImage:Hide()
Frame.BossImage = BossImage

-- -------------------------------------------------------------
-- 2. PANEL CENTRAL: TEXTO CON SCROLL ESTILO NAVEGADOR
-- -------------------------------------------------------------
local InfoScrollFrame = CreateFrame("ScrollFrame", "AZP_InfoScrollFrame", Frame)
InfoScrollFrame:SetSize(360, 480)
InfoScrollFrame:SetPoint("TOPLEFT", LeftPanel, "TOPRIGHT", 20, 0)
InfoScrollFrame:EnableMouseWheel(true)

-- BARRA DE SCROLL MANUAL ESTILO NAVEGADOR WEB
local ScrollBar = CreateFrame("Slider", "AZP_InfoScrollBar", InfoScrollFrame)
ScrollBar:SetSize(16, 480)
ScrollBar:SetPoint("TOPRIGHT", InfoScrollFrame, "TOPRIGHT", 18, 0)
ScrollBar:SetOrientation("VERTICAL")
ScrollBar:SetMinMaxValues(0, 100)
ScrollBar:SetValue(0)
ScrollBar:SetValueStep(1)

local TrackBG = ScrollBar:CreateTexture(nil, "BACKGROUND")
TrackBG:SetAllPoints(ScrollBar)
TrackBG:SetTexture(0.12, 0.15, 0.20, 1)

local Thumb = ScrollBar:CreateTexture(nil, "OVERLAY")
Thumb:SetSize(14, 40)
Thumb:SetTexture(0.25, 0.55, 0.75, 1)
ScrollBar:SetThumbTexture(Thumb)

ScrollBar:SetScript("OnValueChanged", function(self, value)
    InfoScrollFrame:SetVerticalScroll(value)
end)

InfoScrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local current = ScrollBar:GetValue()
    local minVal, maxVal = ScrollBar:GetMinMaxValues()
    local step = 35
    
    if delta < 0 then
        ScrollBar:SetValue(math.min(maxVal, current + step))
    else
        ScrollBar:SetValue(math.max(minVal, current - step))
    end
end)

local InfoContent = CreateFrame("Frame", nil, InfoScrollFrame)
InfoContent:SetSize(350, 2000)
InfoScrollFrame:SetScrollChild(InfoContent)

local BossName = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium")
BossName:SetPoint("TOPLEFT", 5, 0)
BossName:SetText("Selecciona un Jefe")

local BossDesc = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
BossDesc:SetPoint("TOPLEFT", BossName, "BOTTOMLEFT", 0, -6)
BossDesc:SetWidth(345)
BossDesc:SetJustifyH("LEFT")

local DetailsText = InfoContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
DetailsText:SetPoint("TOPLEFT", BossDesc, "BOTTOMLEFT", 0, -10)
DetailsText:SetWidth(345)
DetailsText:SetJustifyH("LEFT")

-- -------------------------------------------------------------
-- 3. PANEL DERECHO: LISTA DE JEFES CON BOTONES CELESTES Y LETRA AZUL OSCURO
-- -------------------------------------------------------------
local BossScrollFrame = CreateFrame("ScrollFrame", "AZP_BossScrollFrame", Frame)
BossScrollFrame:SetSize(170, 480)
BossScrollFrame:SetPoint("TOPRIGHT", -15, -50)
BossScrollFrame:EnableMouseWheel(true)

local BossScrollContent = CreateFrame("Frame", nil, BossScrollFrame)
BossScrollContent:SetSize(170, 600)
BossScrollFrame:SetScrollChild(BossScrollContent)

BossScrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local current = self:GetVerticalScroll()
    local maxScroll = self:GetVerticalScrollRange()
    local newScroll = current - (delta * 30)
    
    if newScroll < 0 then newScroll = 0 end
    if newScroll > maxScroll then newScroll = maxScroll end
    
    self:SetVerticalScroll(newScroll)
end)

-- -------------------------------------------------------------
-- LÓGICA DE SELECCIÓN DE JEFE
-- -------------------------------------------------------------
function AZP.WrathJournal:SelectBoss(encounterID)
    local data = AZP.WrathJournal.RetailSectionData and AZP.WrathJournal.RetailSectionData[encounterID]
    if not data then return end

    if Frame.BossImage then Frame.BossImage:SetTexture(nil); Frame.BossImage:Hide() end
    if Frame.Model then Frame.Model:ClearModel(); Frame.Model:Hide() end

    BossName:SetText("|cff00e5ff" .. (data.name or "") .. "|r")
    BossDesc:SetText(data.description or "")

    if data.image then
        if Frame.BossImage then
            Frame.BossImage:SetTexture(data.image)
            Frame.BossImage:Show()
        end
    elseif data.displayID then
        if Frame.Model then
            Frame.Model:Show()
            Frame.Model:SetCreature(data.displayID)
            local scale = data.modelScale or 1.0
            Frame.Model:SetModelScale(scale)
            Frame.Model:SetPosition(0, 0, data.modelZ or 0)
        end
    end

    local txt = ""
    if data.abilities then
        txt = txt .. "|cff80d8ff[ HABILIDADES Y FASES ]|r\n"
        for _, ab in ipairs(data.abilities) do
            txt = txt .. "• |cff40c4ff" .. ab.name .. ":|r " .. ab.desc .. "\n\n"
        end
    end

    if data.adds then
        txt = txt .. "|cff00e5ff[ ADDS IMPORTANTES ]|r\n"
        for _, add in ipairs(data.adds) do
            txt = txt .. "• |cff18ffff" .. add.name .. ":|r " .. add.desc .. "\n\n"
        end
    end

    if data.heroic then
        txt = txt .. "|cff00b0ff[ MECÁNICAS HEROICO ]|r\n" .. data.heroic .. "\n\n"
    end

    if data.strategy then
        txt = txt .. "|cff84ffff[ ESTRATEGIA EXHAUSTIVA ]|r\n" .. data.strategy .. "\n"
    end

    DetailsText:SetText(txt)
    
    local totalHeight = DetailsText:GetStringHeight() + BossDesc:GetStringHeight() + 80
    InfoContent:SetHeight(totalHeight)
    
    local maxScroll = math.max(0, totalHeight - InfoScrollFrame:GetHeight())
    ScrollBar:SetMinMaxValues(0, maxScroll)
    ScrollBar:SetValue(0)
end

local built = false
local function BuildBossList()
    if built then return end
    built = true

    local offsetY = 0
    if not AZP.WrathJournal.Instances then return end

    for _, instData in pairs(AZP.WrathJournal.Instances) do
        local header = BossScrollContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        header:SetPoint("TOPLEFT", 2, -offsetY)
        header:SetText("|cff00e5ff" .. instData.name .. "|r")
        offsetY = offsetY + 22

        for _, boss in ipairs(instData.encounters) do
            local btn = CreateFrame("Button", nil, BossScrollContent)
            btn:SetSize(160, 22)
            btn:SetPoint("TOPLEFT", 2, -offsetY)

            -- Fondo Celeste Claro / Azul Hielo
            local bg = btn:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints(btn)
            bg:SetTexture(0.20, 0.55, 0.80, 0.90)
            btn.bg = bg

            -- Borde Fino Celeste Brillante
            local border = btn:CreateTexture(nil, "BORDER")
            border:SetPoint("TOPLEFT", -1, 1)
            border:SetPoint("BOTTOMRIGHT", 1, -1)
            border:SetTexture(0.40, 0.85, 1.00, 0.90)
            bg:SetPoint("TOPLEFT", 1, -1)
            bg:SetPoint("BOTTOMRIGHT", -1, 1)

            -- TEXTO EN AZUL OSCURO (Máxima Legibilidad)
            local btnText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            btnText:SetPoint("CENTER", 0, 0)
            btnText:SetWidth(150)
            btnText:SetText("|cff001c33" .. boss.name .. "|r")
            btnText:SetShadowColor(0, 0, 0, 0.3)
            btnText:SetShadowOffset(1, -1)

            -- Interacción con Ratón
            btn:SetScript("OnEnter", function(self)
                self.bg:SetTexture(0.35, 0.70, 0.95, 0.95)
            end)
            btn:SetScript("OnLeave", function(self)
                self.bg:SetTexture(0.20, 0.55, 0.80, 0.90)
            end)
            btn:SetScript("OnMouseDown", function(self)
                self.bg:SetTexture(0.12, 0.40, 0.65, 0.95)
            end)
            btn:SetScript("OnMouseUp", function(self)
                self.bg:SetTexture(0.35, 0.70, 0.95, 0.95)
            end)

            local id = boss.id
            btn:SetScript("OnClick", function()
                AZP.WrathJournal:SelectBoss(id)
            end)

            offsetY = offsetY + 25
        end
    end

    BossScrollContent:SetHeight(offsetY + 20)
end

function AZP.WrathJournal:ToggleUI()
    BuildBossList()
    if Frame:IsShown() then
        Frame:Hide()
    else
        Frame:Show()
        AZP.WrathJournal:SelectBoss(1)
    end
end

-- -------------------------------------------------------------
-- BOTÓN EN LA BARRA PRINCIPAL (MICROBUTTON)
-- -------------------------------------------------------------
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

-- -------------------------------------------------------------
-- BOTÓN EN EL MINIMAPA
-- -------------------------------------------------------------
local MinimapButton = CreateFrame("Button", "AZP_MinimapButton", Minimap)
MinimapButton:SetSize(34, 34)
MinimapButton:SetFrameStrata("MEDIUM")
MinimapButton:SetFrameLevel(10)
MinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 10, -10)
MinimapButton:EnableMouse(true)
MinimapButton:RegisterForDrag("LeftButton")

local Icon = MinimapButton:CreateTexture(nil, "ARTWORK")
Icon:SetSize(24, 24)
Icon:SetPoint("CENTER", 0, 0)
Icon:SetTexture("Interface\\Icons\\INV_Misc_Skull_01")

local Border = MinimapButton:CreateTexture(nil, "OVERLAY")
Border:SetAllPoints(MinimapButton)
Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
Border:SetVertexColor(0.2, 0.7, 1.0, 1)

MinimapButton:SetScript("OnClick", function()
    AZP.WrathJournal:ToggleUI()
end)

MinimapButton:SetScript("OnDragStart", function(self)
    self:LockHighlight()
    self:SetScript("OnUpdate", function()
        local xpos, ypos = GetCursorPosition()
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
        xpos = xmin - xpos/UIParent:GetScale() + 70
        ypos = ypos/UIParent:GetScale() - ymin - 70
        local angle = math.atan2(ypos, xpos)
        self:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (80 * math.cos(angle)), (80 * math.sin(angle)) - 52)
    end)
end)

MinimapButton:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
    self:UnlockHighlight()
end)

MinimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("|cff00e5ffDiario de ICC|r\n|cffffffffClic para abrir (/icc)|r")
    GameTooltip:Show()
end)
MinimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

-- -------------------------------------------------------------
-- COMANDOS DE CHAT (/icc)
-- -------------------------------------------------------------
SLASH_AZPWRATHJOURNAL1 = "/icc"
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