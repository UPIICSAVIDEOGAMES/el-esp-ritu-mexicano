

local player = {}

-- 1st image sheet
local sheetRobotBoyIdle = 
{
    width=275, height=275, numFrames=30, sheetContentWidth=2048, sheetContentHeight=2048 
}

local sheet1 = graphics.newImageSheet( "images/RobotBoyIdleSprite.png", sheetRobotBoyIdle )

-- 2nd image sheet
local sheetRobotBoyCrouch = 
{
     width=275, height=275, numFrames=21, sheetContentWidth=2048, sheetContentHeight=2048 
}
local sheet2 = graphics.newImageSheet( "images/RobotBoyCrouchSprite.png", sheetRobotBoyCrouch )

-- 3rd image sheet
local sheetRobotBoyCrouch = 
{
    width=275, height=275, numFrames=30, sheetContentWidth=2048, sheetContentHeight=2048 
}
local sheet3 = graphics.newImageSheet( "images/RobotBoyDeathSprite.png", sheetRobotBoyCrouch )


-- In your sequences, add the parameter 'sheet=', referencing which image sheet the sequence should use
local sequenceData = 
{
    { name="BoyIdle", sheet=sheet1, start=1, count=30, time=3000, loopCount=0 },
    { name="BoyCrouch", sheet=sheet2, start=1, count=21, time=3000, loopCount=0 },
    { name="BoyDeath", sheet=sheet3, start=1, count=30, time=3000, loopCount=0 }
}
 local sprite=nil;
--[[
        Acciones Maker
        Los siguientes métodos se utilizan cuando se esta creando el nivel
]]

-- touch listener; Para poder poner al personaje donde se desee
local function onTouch( event )
    if not (boolStart) then -- Si el juego no esta iniciado
        if event.phase == "began" then

            local posIniX = sprite.x    -- store x location of object
            local posIniY = sprite.y    -- store y location of object
            display.getCurrentStage():setFocus( sprite, event.id )
            sprite.isFocus = true
            sprite:toFront()
        elseif event.phase == "moved" then
            -- Ajuste
            if posIniX==nil then
                posIniX = sprite.x
            end

            if posIniY==nil then
                posIniY = sprite.y
            end

            local x = (event.x - event.xStart) + posIniX
            local y = (event.y - event.yStart) + posIniY

            sprite.x, sprite.y = x, y    -- move object based on calculations above
        elseif event.phase == "ended" or event.phase == "cancelled" then
            posIniX=nil
            posIniY=nil
            display.getCurrentStage():setFocus( sprite, nil )
            sprite.isFocus = false
        end
    end
    
    return true
end


--[[ Metodos generales de player ]]
-- Constructor del player
function player.new(event,x,y, xScale, yScale)
    sprite = display.newSprite( sheet1, sequenceData )
    sprite.x = centerX
    sprite.y = centerY
    sprite:play()
    
    -- make 'myObject' listen for touch events
    sprite:addEventListener( "touch", onTouch )
    local forma={-275,-38,275,-34,144,256,144,38}
    
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
    local halfW = sprite.contentWidth/7
    local altoSprite=sprite.contentHeight*0.45
                        
    --Escalamiento
    if xScale and yScale then
        halfW=halfW*xScale
        altoSprite=altoSprite*yScale
    end
    
    local grassShape = { -halfW,-altoSprite, halfW,-altoSprite, halfW,altoSprite, -halfW,altoSprite }
        
    physics.addBody( sprite ,{shape=grassShape,density=3.0, friction=0.5, bounce=0.3 } )
    
    sprite:scale(xScale, yScale)

end

 

-- Sirve para conocer cambiar el sheet del personaje
function player.swapSheet(movimiento)
        if movimiento == nil then
            movimiento = "BoyIdle"
        end
    
        sprite:setSequence(movimiento)
        sprite:play()
end

 

return player