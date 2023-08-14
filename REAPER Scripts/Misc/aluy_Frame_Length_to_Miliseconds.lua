-- TODO
-- Replace Messagebox with something that can stay open while working
------------SCYTHE DATA-----------------
local libPath = reaper.GetExtState("Scythe v3", "libPath")
if not libPath or libPath == "" then
    reaper.MB("Couldn't load the Scythe library. Please install 'Scythe library v3' from ReaPack, then run 'Script: Scythe_Set v3 library path.lua' in your Action List.", "Whoops!", 0)
    return
end
loadfile(libPath .. "scythe.lua")()
local GUI = require("gui.core")
--------------------

-- get last part of script name
local script_name = ({reaper.get_action_context()})[2]:match("([^/\\_]+)%.lua$")
-- get project and current framerate
_, proj_name = reaper.EnumProjects(-1 , "")
-- Need to store dropframe bool
project_framerate, df = reaper.TimeMap_curFrameRate(_)
half_fps = project_framerate / 2
double_fps = project_framerate * 2
docker_id = 0
x, y, w, h = 0, 0, 640, 480
local r, g, b = 255, 188, 188
pad = 8
fontsz = 25
frame_text = ""

---------------GUI------------------

local Font = require("public.font")

--Font.set({"Arial", 3,})

local window = GUI.createWindow({
    name = "Frames to ms Guide",
    w = 720,
    h = 500,
})

local layer = GUI.createLayer({
    name = "BaseLayer"
})

local frame = GUI.createElement({
    name = "frame",
    type = "Frame",
    x= 0,
    y = 0,
    w = 720,
    h = 400,
    text = frame_text,
    font = 2
    --font = Font
})

local button = GUI.createElement({
    name = "Close",
    type = "Button",
    x = 450,
    y = 420,
    w = 200,
    h = 50,
    caption = "Close"
})

button.func = function ()window:close() end


local button_refresh = GUI.createElement({
    name = "Refresh",
    type = "Button",
    x = 150,
    y = 420,
    w = 200,
    h = 50,
    caption = "Refresh"
})

button_refresh.func = function() check_project_frame() end

--------------functions--------------

function check_project_frame()
  if reaper.TimeMap_curFrameRate(_) ~= project_framerate or reaper.TimeMap_curFrameRate(_) ~= df then
      project_framerate, df = reaper.TimeMap_curFrameRate(_)
      frame_text = text_compile()
      reaper.ShowConsoleMsg("df val: " .. tostring(df))
      frame:val(frame_text)
  end

end


function gui_init()
    gfx.clear = rgb2num(r, g, b)
    --gfx.set(r, g, b)
    gfx.init("FPS to Milliseconds Guide", w, h, docker_id, x, y)    

end

function rgb2num(red, green, blue)
  
  green = green * 256
  blue = blue * 256 * 256
  
  return red + green + blue

end


-- convert framerate to milliseconds
function calc_fps_ms(framerate)
    local ms = 0
    ms = 1000 / framerate
    return ms
end

-- calculate millisecond length for number of frames
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
        reaper.ShowConsoleMsg("Float formatted DF")
    else
      if project_framerate % 1 ~= 0 then
         string = string.format("%.2f (ND)", int)
         reaper.ShowConsoleMsg("Float formatted ND")
         reaper.ShowConsoleMsg("DF value: " .. tostring(df))
      else
         string = string.format("%s", int)
         reaper.ShowConsoleMsg("number formatted to int")
      end
    end
    return string
end

function text_compile()
    local ms_fps = calc_fps_ms(project_framerate)
    local two_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(2), calc_ms_per_frame(2, project_framerate))
    local five_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(5), calc_ms_per_frame(5, project_framerate))
    local ten_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(10), calc_ms_per_frame(10, project_framerate))
    local fifteen_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(15) , calc_ms_per_frame(15, project_framerate))
    local half_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(half_fps), calc_ms_per_frame(half_fps, project_framerate))
    local twice_frame = string.format("%s Frames to ms: %.2fms\n", frame_string(double_fps), calc_ms_per_frame(double_fps, project_framerate))
    local project_data = string.format("Project File: %s\n \nProject Framerate: %s\n", proj_name, frame_string(project_framerate))
    local fps_data = string.format("%s Frames to ms: %.2fms per frame\n", frame_string(project_framerate), ms_fps)
    local frame_length_data = string.format("%s\n%s\n%s\n%s\n%s\n%s\n", two_frame, five_frame, ten_frame, fifteen_frame, half_frame, twice_frame)    
    local message_box_string = string.format("%s\n%s\n%s", project_data, fps_data,frame_length_data)
   return message_box_string
end

function main()
   
    --getchar must be in main so the state is updated. otherwise window will close.
    
    frame:val(frame_text)
    
   -- GUI
    local char = gfx.getchar()
    if char ~= 27 and char ~= -1 then
        reaper.defer(main)
    end 
end

reaper.ShowConsoleMsg("Framerate: " .. project_framerate .. "Type: " .. type(project_framerate))
-- reaper.PreventUIRefresh(1)
-- reaper.Undo_BeginBlock()
frame_text = text_compile()
layer:addElements(frame)
layer:addElements(button)
layer:addElements(button_refresh)
window:addLayers(layer)
window:open()
GUI.Main()
main()
-- reaper.Undo_EndBlock(script_name, -1)
-- reaper.PreventUIRefresh(-1)
