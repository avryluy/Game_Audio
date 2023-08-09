-- Get current Project
local project = reaper.EnumProjects(-1)
-- Global Action Variable
Play_Stop_ID = 40044 --Transport: Play/Stop action

--Check for project running
if project then
    --Get playrate of current project
    local playrate = reaper.Master_GetPlayRate(project)
    --Get playstate of current project
    local playstate = reaper.GetPlayState()

    if playstate == 0 then
        reaper.CSurf_OnPlayRateChange(.5)
        reaper.Main_OnCommandEx(Play_Stop_ID, 0, project)
    else
        reaper.CSurf_OnPlayRateChange(1)
        reaper.Main_OnCommandEx(Play_Stop_ID, 0, project)
    end 
end


