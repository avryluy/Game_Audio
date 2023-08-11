-- get project and current framerate

-- local script_name = ({reaper.get_action_context()})[2]:match("([^/\\_]+)%.lua$")
_, proj_name = reaper.EnumProjects(-1 , "")
-- Need to store dropframe bool
project_framerate, df = reaper.TimeMap_curFrameRate(_)
half_fps = project_framerate / 2
double_fps = project_framerate * 2

-- functions

-- convert framerate to miliseconds
function calc_fps_ms(framerate)
    local ms = 0
    ms = 1000 / framerate
    return ms
end

-- calculate milisecond length for number of frames
-- based on current project framerate
function calc_ms_per_frame(fps_ms, framerate)
  local framelength = 0
  framelength = calc_fps_ms(framerate) * fps_ms
  return framelength
end

-- string formatter for frames 
function frame_string(int)
    local string = ""
    if df == true then 
        string = string.format("%.2f (DF)", int)
    else
     if project_framerate % 1 ~= 0 then
        string = string.format("%.2f (ND)", int)
     else
        string = string.format("%d", int)     
     end   
    end
    return string
end

function main()
    local ms_fps = calc_fps_ms(project_framerate)
    local two_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(2), calc_ms_per_frame(2, project_framerate))
    local five_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(5), calc_ms_per_frame(5, project_framerate))
    local ten_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(10), calc_ms_per_frame(10, project_framerate))
    local fifteen_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(15) , calc_ms_per_frame(15, project_framerate))
    local half_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(half_fps), calc_ms_per_frame(half_fps, project_framerate))
    local twice_frame = string.format("%s Frames to MS: %.2fms\n", frame_string(double_fps), calc_ms_per_frame(double_fps, project_framerate))
    local project_data = string.format("Project File: %s\n \nProject Framerate: %s\n", proj_name, frame_string(project_framerate))
    local fps_data = string.format("%s Frames to ms: %.2fms per frame\n", frame_string(project_framerate), ms_fps)
    local frame_length_data = string.format("%s\n%s\n%s\n%s\n%s\n%s\n", two_frame, five_frame, ten_frame, fifteen_frame, half_frame, twice_frame)    local message_box_string = string.format("%s\n%s\n%s", project_data, fps_data,frame_length_data)
    reaper.ShowMessageBox(message_box_string, "FPS to Miliseconds Guide", 0)
    
end
-- TODO
-- Replace Messagebox with something that can stay open while working

-- reaper.ShowConsoleMsg(string.format("Project File: %s\n", proj_name))
-- reaper.ShowConsoleMsg(string.format("\nProject Framerate: %d\n", project_framerate))
-- --reaper.ShowConsoleMsg(string.format("%0d Frames to MS: %.2fms\n", project_framerate, ms_fps))

-- reaper.ShowConsoleMsg(string.format("2 Frames to MS: %.2fms\n", calc_ms_per_frame(2, project_framerate)))
reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock(script_name, -1)
reaper.PreventUIRefresh(-1)
--reaper.ShowConsoleMsg(string.format("FPS Data Type: %.3f | %s",project_framerate, df))
-- reaper.ShowConsoleMsg(string.format("FPS Modulo: %.2f div by 1: %.2f",project_framerate, (project_framerate % 1)))
reaper.ShowConsoleMsg(string.format("%s", script_name))
