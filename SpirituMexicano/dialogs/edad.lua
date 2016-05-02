local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local base = require("utilerias.base" )

edad = 0

-- metodo para cambiar de pantalla
local function btnTap(event)
	if edad > 0 then
            composer.hideOverlay()
            composer.showOverlay( "dialogs.nombre" ,{ effect = "fade", isModal = true } )
            
        end
	return true
end
 
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
            edad = tonumber(event.text)
            print( event.text )
        else
            edad = 0
        end
        
    end
end

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view

 
	local overlay = scene:crearImagen("images/inst_09.png", display.contentWidth, display.contentHeight+50,centerX,centerY,group)
        overlay:scale( .9, .9)

        ---- pause
        opciones = scene:crearImagen("images/quetzalcoatl478x344.png", 478, 344, centerX, centerY*0.6,group)

        tap = display.newText(group,"Dinos tu edad",centerX, centerY, "fonts/BELLABOO-Regular", 80)
        
        tap:setTextColor(217,233,226)
        
        
        defaultField = native.newTextField( centerX, centerY*1.3, 250, 45 )
        defaultField:addEventListener( "userInput", textListener )
        defaultField.inputType = "number"
        defaultField.placeholder = "dinos tu edad"
        defaultField.align = "center"
        
        local btnGuardar = widget.newButton
        {
            width = 240,
            height = 100,
            defaultFile = "images/button_azul.png",
            overFile = "images/button-over_azul.png",
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            font = "BELLABOO-Regular",
            fontSize = 30,
            label="Continuar" ,
            onEvent = btnTap
        }
        
        -- Center the button
        btnGuardar.x = display.contentCenterX
        btnGuardar.y = display.contentCenterY*1.55	
        
        group:insert(defaultField)
        group:insert(btnGuardar)
		
end
 
 function scene:crearImagen(imagenImg,wTam,hTam,xImag,yImag,grupo)
		ImgNueva = display.newImageRect( imagenImg, wTam, hTam )
	 	ImgNueva.x,ImgNueva.y = xImag, yImag

	 	ImgNueva.xScale=.8
		ImgNueva.yScale=.8
	 	grupo:insert(ImgNueva)

	 	
	 	return ImgNueva
	end 
    
-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view
 
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
 
end
 
-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
 
 	collectgarbage()
    composer.removeScene( "edad",true )
	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks
 
end
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
	local group = self.view
 
 	collectgarbage()

	-- INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene