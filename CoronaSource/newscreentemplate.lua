module(..., package.seeall)

--====================================================================--
-- SCENE: [MASTER TEMPLATE]
--====================================================================--

--[[

 - Version: [1.0]
 - Made by: [Fully Croisened, NJR Studios LLC - Nathanial Ryan]
 - Website: [www.fullycroisened.com]
 - Mail: [croisened@gmail.com]

******************
 - INFORMATION
******************

  - [XXXXXXXXXX]

--]]


--[[
Don't forget to include params in the constructor if we intend to pass them in from another scene...
EX: new = function(params)
--]]

new = function ()

	------------------
	-- Imports, Include any external references that this scenes needs
	-- Example: local ui = require ( "ui" )
	------------------


	-------------------------------------------------
	-- Handle any Params that get passed to the Scene
	-------------------------------------------------

	local vLabel = ""
	local vReload = false
	--
	if type( params ) == "table" then
		--
		if type( params.label ) == "string" then
			vLabel = params.label
		end
		--
		if type( params.reload ) == "boolean" then
			vReload = params.reload
		end
		--
	end


	------------------
	-- Groups
	------------------

	local localGroup = display.newGroup()


    ------------------
    -- Local Variable Definitions
    -------------------
	local backGround = display.newImage( "bg.png", true )

	------------------
	-- Functions
	------------------


    -------------------
    --Change Scene-----
    -------------------
    local moveToScene = function(event)

      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )


    end

	------------------
	-- GUI Components
	------------------
    local homeButton = ui.newButton{
    	default = "homebutton.png",
	    over = "homebuttonover.png",
	    onRelease = moveToScene,
    }	
    
    

	--====================================================================--
	-- INITIALIZE, Every Display Object must get shoved into the local Display Group
	-- Example:	localGroup:insert( background )
	--====================================================================--
	local initVars = function ()

      localGroup:insert(backGround)

	  localGroup:insert(homeButton)
      homeButton.x = display.contentWidth / 2
      homeButton.y = 100   
      
      
    end



    --Clean up local variables, etc...
	clean = function()
	  print("Cleaning")
	end


   	------------------
	-- INITIALIZE variables
	------------------
	initVars()

	------------------
	-- MUST return a display.newGroup()
	------------------
	return localGroup

end
