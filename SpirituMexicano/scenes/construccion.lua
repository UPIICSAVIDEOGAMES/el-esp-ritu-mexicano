-----------------------------------------------------------------------------------------
--
-- construccion.lua
-- Aqui se construyen los niveles arrastrandolos
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local player = require ( "objects.player" )
local bloque = require ("objects.bloque" )
local widget = require "widget"
physics = require( "physics" )
physics.start()

-- 
--------------------------------------------




-- forward declarations and other locals
--local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

boolStart = false -- Nos dice cuando es momento de diseñar, util para valider la funcion de arrastre de cada elemento, esta variable es visible en la carpeta objetos
local contador=1
local function onPlayBtnRelease(event)
    -- Se añaden las fisicas
    
    if event.phase == "ended" then
        if(boolStart) then
            physics.pause()
            boolStart=false
        else
            physics.start()
            boolStart=true
        end
    end
        
end

local function onTouchBloque(event)
    -- Se añaden las fisicas
    
    if event.phase == "began" then
       bloque:new(event.target.name, event.x, event.y,""..contador)
       contador=contador+1
    end
        
end


---------------

-- funciones para crear
---------------

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
        
        -- display a background image
	local background = display.newImageRect( "images/fondo.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
        
         -- display a background image
	local toolbox = display.newImageRect( "images/toolbox.png", display.contentWidth, 120 )
	toolbox.anchorX = 0
	toolbox.anchorY = 0
	toolbox.x, toolbox.y = 0, 0
        
        --Elementos disponibles para elegir en la paleta
        
        bloque1 = display.newImageRect( "images/crate.png",90,90)
	bloque1.x, bloque1.y = centerX *0.2, centerY*0.16
        bloque1.name="crate.png"
        bloque1:addEventListener("touch", onTouchBloque)
        
         --Elementos disponibles para elegir en la paleta
        
        bloque2 = display.newImageRect( "images/tile1.png",90,90)
	bloque2.x, bloque2.y = centerX *0.4, centerY*0.16
        bloque2.name="tile1.png"
        bloque2:addEventListener("touch", onTouchBloque)
        
         --Elementos disponibles para elegir en la paleta
        
        bloque3 = display.newImageRect( "images/tile2.png",90,90)
	bloque3.x, bloque3.y = centerX *0.6, centerY*0.16
        bloque3.name="tile2.png"
        bloque3:addEventListener("touch", onTouchBloque)
        
         --Elementos disponibles para elegir en la paleta
        
        bloque4 = display.newImageRect( "images/tile3.png",90,90)
	bloque4.x, bloque4.y = centerX *0.8, centerY*0.16
        bloque4.name="tile3.png"
        bloque4:addEventListener("touch", onTouchBloque)
        
         --Elementos disponibles para elegir en la paleta
        
        bloque5 = display.newImageRect( "images/tile4.png",90,90)
	bloque5.x, bloque5.y = centerX *1, centerY*0.16
        bloque5.name="tile4.png"
        bloque5:addEventListener("touch", onTouchBloque)
        
         --Elementos disponibles para elegir en la paleta
        
        bloque6 = display.newImageRect( "images/tile5.png",90,90)
	bloque6.x, bloque6.y = centerX *1.2, centerY*0.16
        bloque6.name="tile5.png"
        bloque6:addEventListener("touch", onTouchBloque)
        
       	
        local xScale, yScale=0.5, 0.5
    
         --Se crea el player
        player:new( centerX , centerY,xScale, yScale)
        
                
        -- Boton para jugar
          local btnJugar = widget.newButton
        {
            width = 100,
            height = 90,
            defaultFile = "images/playDefault.png",
            overFile = "images/playover.png",
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            font = "BELLABOO-Regular",
            fontSize = 30,
           -- label="Jugar" ,
            onEvent = onPlayBtnRelease
        }

        -- Center the button
        btnJugar.x = display.contentCenterX*1.8
        btnJugar.y = display.contentCenterY*0.16
        
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
        sceneGroup:insert( toolbox )
        sceneGroup:insert( btnJugar )
	
       
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		--physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		 physics.pause()
	elseif phase == "did" then
		-- Called when the scene is now off screen
               
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

