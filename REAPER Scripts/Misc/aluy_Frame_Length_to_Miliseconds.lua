

-- get project and current framerate
_, proj_name = reaper.EnumProjects(-1 , "")
project_framerate = reaper.TimeMap_curFrameRate(_)
half_fps = project_framerate / 2
double_fps = project_framerate * 2

-- functions
function calc_fps_ms(framerate)
    local ms = 0
    ms = 1000 / framerate
    return ms
end

function calc_ms_per_frame(fps_ms, framerate)
  local framelength = 0
  framelength = calc_fps_ms(framerate) * fps_ms
  return framelength
end

function frame_length_string(int, framelength)
    local string = ""
    if int == half_fps then
        string = string.format("Half your FPS (%.0f) to ms: %.2fms\n", int, framelength)
    elseif int == double_fps then
        string = string.format("Double your FPS (%.0f) to ms: %.2fms\n", int, framelength)
    else string = string.format("%f Frames to ms: %.2fms\n", int, framelength)
    end
    return string
end

function main()
    local ms_fps = calc_fps_ms(project_framerate)
    local two_frame = frame_length_string(2,calc_ms_per_frame(2, project_framerate))
    local five_frame = frame_length_string(5, calc_ms_per_frame(5, project_framerate))
    local ten_frame = frame_length_string(10, calc_ms_per_frame(10, project_framerate))
    local fifteen_frame = frame_length_string(15, calc_ms_per_frame(15, project_framerate))
    local half_frame = frame_length_string(half_fps, calc_ms_per_frame(half_fps, project_framerate))
    local twice_frame = frame_length_string(double_fps, calc_ms_per_frame(double_fps, project_framerate))
    local project_data = string.format("Project File: %s\n \nProject Framerate: %d\n", proj_name, project_framerate)
    local fps_data = string.format("%f Frames to ms: %.2fms per frame\n", project_framerate, ms_fps)
    local frame_length_data = string.format("%s\n%s\n%s\n%s\n%s\n%s\n", two_frame, five_frame, ten_frame, fifteen_frame, half_frame, twice_frame)

    local message_box_string = string.format("%s\n%s\n%s", project_data, fps_data,frame_length_data)
    reaper.ShowMessageBox(message_box_string, "FPS to Miliseconds Guide", 0)
    
end
-- reaper.ShowConsoleMsg(string.format("Project File: %s\n", proj_name))
-- reaper.ShowConsoleMsg(string.format("\nProject Framerate: %d\n", project_framerate))
-- --reaper.ShowConsoleMsg(string.format("%0d Frames to MS: %.2fms\n", project_framerate, ms_fps))

-- reaper.ShowConsoleMsg(string.format("2 Frames to MS: %.2fms\n", calc_ms_per_frame(2, project_framerate)))
main()
--reaper.ShowConsoleMsg(string.format(" Half FPS %.0f\n",half_fps))
--reaper.ShowConsoleMsg(string.format("X2 FPS%.0f \n",double_fps))
