-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local base = require("utilerias.base" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local btnConstruir
local btnJugar
local nombre = ""
local defaultField
-- metodo para escuchar un textfield
local function textListener( event )

    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- do something with defaultField text
        print( event.target.text )

    elseif ( event.phase == "editing" ) then
        
        if tonumber(event.text) ~= nil then 
            nombre = ""
        else
            nombre = event.text
            
        end
        
    end
end

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
        
        if nombre ~= nil then
            base.update([[UPDATE usuario SET name=']]..nombre..[[' WHERE id=1;]])
            -- go to level1.lua scene
            composer.gotoScene( "scenes.menu", "fade")
	end
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "images/fondo.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	--[[local titleLogo = display.newImageRect( "images/logo.png", 576, 446 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 150
        titleLogo:scale(0.5,0.5)]]
        
       
      --[[ local btnConstruir = widget.newButton
        {
            width = 240,
            height = 120,
            defaultFile = "images/button.png",
            overFile = "images/button-over.png",
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            font = "BELLABOO-Regular",
            fontSize = 30,
            label="Construir" ,
            onEvent = onBuildBtnRelease
        }

        -- Center the button
        btnConstruir.x = display.contentCenterX*0.5
        btnConstruir.y = display.contentCenterY]]
        
        
        
         local btnJugar = widget.newButton
        {
            width = 240,
            height = 120,
            defaultFile = "images/button.png",
            overFile = "images/button-over.png",
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            font = "BELLABOO-Regular",
            fontSize = 30,
            label="Jugar" ,
            onEvent = onPlayBtnRelease
        }


        -- Center the button
        btnJugar.x = display.contentCenterX
        btnJugar.y = display.contentCenterY*1.5

       
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	--sceneGroup:insert( titleLogo )
	--sceneGroup:insert( btnConstruir )
        sceneGroup:insert( btnJugar )
        
        row=base.selectCustomFrom("select count( * ) numR from usuario;")
	print( "numero de filas:".. row.numR)
        
        if row.numR == 0 then
            composer.showOverlay( "dialogs.edad" ,{ isModal = true, effect = "fade" } )
        else
            local rowNombre = base.selectCustomFrom("select nombre from usuario;")
            nombreBase = rowNombre.nombre
          --[[  tap = display.newText(sceneGroup,""..nombreBase.."",centerX, centerY*1.2, "fonts/BELLABOO-Regular", 25)
            tap:setTextColor(217,233,226)]]
            
            defaultField = native.newTextField( centerX, centerY*1.2, 250, 45 )
            defaultField:addEventListener( "userInput", textListener )
            defaultField.text = nombreBase
            defaultField.placeholder = "nombre"
            defaultField.align = "center"
            sceneGroup:insert( defaultField )
        end
    
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
                
	elseif phase == "did" then
		-- Called when the scene is now off screen
                sceneGroup:removeSelf()
                sceneGroup = nil
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	sceneGroup:removeSelf()
        sceneGroup = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene