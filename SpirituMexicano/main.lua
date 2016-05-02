require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local base = require("utilerias.base" )


centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
width = display.contentWidth
height = display.contentHeight
play = true
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"


local background = display.newImageRect( "images/cic.png", width, height )
background.x, background.y = centerX, centerY

local function logo()
   background:removeSelf() 
   background = nil
   
    -- load menu screen
    composer.gotoScene( "scenes.presentacion" )

end

timer.performWithDelay( 3500, logo )



------HANDLE SYSTEM EVENTS------
function systemEvents(event)
   print("systemEvent " .. event.type)
   if ( event.type == "applicationSuspend" ) then
      print( "suspending..........................." )
   elseif ( event.type == "applicationResume" ) then
      print( "resuming............................." )
   elseif ( event.type == "applicationExit" ) then
      --Cerrar la base de datos
      base.cerrar()
      print( "exiting.............................." )
   elseif ( event.type == "applicationStart" ) then
      base.abrir()
            
   end
   return true
end

Runtime:addEventListener( "system", systemEvents )
