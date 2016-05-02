
require "sqlite3"

local base={}

local db

--Abrir la base de datos, si no existe la crea
function base.abrir()
	local path = system.pathForFile("espmxnv1.db", system.DocumentsDirectory)

	

	--Crea la tabla si no existe
	local tablaUsuario = [[ CREATE TABLE IF NOT EXISTS usuario (id INTEGER PRIMARY KEY, nombre, edad);]]
	
        db = sqlite3.open( path )   
	db:exec( tablaUsuario )
        
        row=base.selectCustomFrom("select count( * ) numR from usuario;")
	print( "numero de filas:".. row.numR)
end

-- cerrar base de datos, meterlo en un onSystemEvent
function base.cerrar()
        if db and db:isopen() then
			db:close()
		end
end
--Consulta personalizada
function base.selectCustomFrom(query)
	print( tostring(db) )
	for row in db:nrows(query) do
	  print( "base.selectCustomFrom:"..query );
	 return row
	end
	
end

function  base.update(query)--ejemplo: [[UPDATE test SET name='Big Bird' WHERE id=3;]]
	db:exec( query )
end

function  base.insert(tabla, columnas, valores)--ejemplo: [[insert into test SET name='Big Bird' WHERE id=3;]]
        query = [[insert into ]]..tabla..[[(]]..columnas..[[) values(]]..valores..[[);]]
	db:exec( query )
end



return base
-- --setup the system listener to catch applicationExit
-- Runtime:addEventListener( "system", onSystemEvent )