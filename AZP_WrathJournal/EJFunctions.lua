AZP = AZP or {}
AZP.WrathJournal = AZP.WrathJournal or {}

function AZP.WrathJournal:EJGetDifficulty()
    return self.SavedData.CurrentDifficulty or 1
end

function AZP.WrathJournal:EJGetSlotFilter()
    return self.SavedData.CurrentSlotFilter or 0
end

function AZP.WrathJournal:EJGetLootFilter()
    local _, _, classID = UnitClass("player")
    return classID
end

function AZP.WrathJournal:EJCreateSpellLink(sectionID, difficultyID, spellID)
    local spellName = GetSpellInfo(spellID) or "Habilidad"
    return string.format("|cff66bbff|Hjournal:2:%d:%d|h[%s]|h|r", sectionID, difficultyID, spellName)
end

function AZP.WrathJournal:DisplayEncounter(encounterID)
    local data = self.RetailSectionData and self.RetailSectionData[encounterID]
    if not data or not AZP_WrathJournalUI then return end

    if AZP_WrathJournalUI.Title then
        AZP_WrathJournalUI.Title:SetText(data.name or "Desconocido")
    end

    if AZP_WrathJournalUI.Model and data.displayID then
        AZP_WrathJournalUI.Model:SetDisplayInfo(data.displayID)
        AZP_WrathJournalUI.Model:SetPortraitZoom(0.6)
    end
end