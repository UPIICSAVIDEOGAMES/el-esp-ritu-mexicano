--Esta clase es para definir los bloques que se arrastran para crear el piso del escenario
--Objetivos de la clase: 
--  Ser escalable pudiendo cambiar la imagen
--  Tener la opcion de tener un cuerpo y de escalar


local bloque={}
local tile
    --[[
            Acciones Maker
            Los siguientes métodos se utilizan cuando se esta creando el nivel
    ]]

    -- touch listener; Para poder poner al personaje donde se desee
    local function onTouch( event )
         if not (boolStart) then -- Si el juego no esta iniciado
            local t = event.target

           local phase = event.phase
           if "began" == phase then
                   display.getCurrentStage():setFocus( t )
                   t.isFocus = true

                   -- Store initial position
                   t.x0 = event.x - t.x
                   t.y0 = event.y - t.y

                   -- Make body type temporarily "kinematic" (to avoid gravitional forces)
                   event.target.bodyType = "kinematic"

                   -- Stop current motion, if any
                   event.target:setLinearVelocity( 0, 0 )
                   event.target.angularVelocity = 0

           elseif t.isFocus then
                   if "moved" == phase then
                           t.x = event.x - t.x0
                           t.y = event.y - t.y0

                   elseif "ended" == phase or "cancelled" == phase then
                           display.getCurrentStage():setFocus( nil )
                           t.isFocus = false
                           event.target.bodyType = "static"


                   end
           end
        end

        return true
    end


 function bloque.new(event, imagenBlqoue, x, y,nombre)
        -- make a crate (off-screen), position it, and rotate slightly
        tile = display.newImageRect( "images/"..imagenBlqoue, 90, 90 )
	tile.x, tile.y = x, y
        tile.name=nombre
        tile:addEventListener("touch", onTouch)
        tile.isPlatform=true
	physics.addBody( tile, "static", { friction=0.5, bounce=0.3 } )


    end
    

return bloque


--[[

 -- create a grass object and add physics (with custom shape)
	local grass = display.newImageRect( "images/grass.png", screenW, 82 )
	grass.anchorX = 0
	grass.anchorY = 1
	grass.x, grass.y = 0, display.contentHeight
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
]]





