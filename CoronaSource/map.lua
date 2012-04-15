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

new = function ()

	------------------
	-- Imports, Include any external references that this scenes needs
	-- Example: local ui = require ( "ui" )
	------------------
    local ui = require ( "ui" )

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
	local backGround = display.newImage( "assets/mapbg.jpg", true )
    local labelFont = "MaroonedOnMarsBB"
    local standardLabelColors = getGlobal("StandardLabelColors")
    local textSize = 48
    local mapPath


	------------------
	-- Functions
	------------------
    local openMap = function(event)

      --system.openURL( event.target.mapURL )

      if not webView then
        webView = native.newWebView( 20, 100, 450, 500)
        webView:addEventListener( 'urlRequest', webListener ) 
        webView:request( event.target.url)
        --webView:request( event.target.mapURL, system.ResourceDirectory)
        return true
      end

    end

    local openBrowser = function(event)
  	  system.openURL( event.target.url )     
    end    

    -------------------
    --Change Scene-----
    -------------------
    local moveToScene = function(event)

      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )

	  director:changeScene( "home", "moveFromRight" )
	  return true

    end

    --UI Stuff--
    local homeButton = ui.newButton{
    	default = "assets/homebutton.png",
	    over = "assets/homebuttonover.png",
	    onRelease = moveToScene,
    }

    local standardButton = ui.newButton{
    	default = "assets/standardbutton.png",
	    over = "assets/standardbuttonover.png",
	    onRelease = openBrowser,
    } 

    local superiorButton = ui.newButton{
    	default = "assets/superiorbutton.png",
	    over = "assets/superiorbuttonover.png",
	    onRelease = openBrowser,
    }

    local excellentButton = ui.newButton{
    	default = "assets/excellentbutton.png",
	    over = "assets/excellentbuttonover.png",
	    onRelease = openBrowser,
    }                
    
     local feelingLuckyButton = ui.newButton{
    	default = "assets/feelingluckybutton.png",
	    over = "assets/feelingluckybuttonover.png",
	    onRelease = openBrowser,
    }      

  
    
    --local label = display.newText("This is an example of using a custom font! ", 100, 250, labelFont, textSize )
    --label:setTextColor(0, 0, 0)

    --Each time we change scenes we will add to the global "Score"
    --local label2 = display.newText("Current Score is: " .. getGlobal("Score"), 200, 350, labelFont, textSize + 10 )
    --label2:setTextColor(0, 0, 0)
    --label2:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"])
    

	------------------
	-- Code here
	------------------

	--====================================================================--
	-- INITIALIZE, Every Display Object must get shoved into the local Display Group
	-- Example:	localGroup:insert( background )
	--====================================================================--
	local initVars = function ()
      print("Initializing Map")
      standardButton.url = "http://g.co/maps/jktqd"
      superiorButton.url = "http://g.co/maps/ng9hj"
      excellentButton.url = "http://g.co/maps/y9322"
      feelingLuckyButton.url = "http://g.co/maps/bwtcg"


	  localGroup:insert(backGround)
	  localGroup:insert(homeButton)
	  localGroup:insert(standardButton)
	  localGroup:insert(superiorButton)
	  localGroup:insert(excellentButton)
	  localGroup:insert(feelingLuckyButton)
	  --localGroup:insert(label)
	  --localGroup:insert(label2)

       --Position Things
       homeButton.x = display.contentWidth / 2
       homeButton.y = 912

       standardButton.x = display.contentWidth / 2
       standardButton.y = 600

       superiorButton.x = display.contentWidth / 2
       superiorButton.y = 300

       excellentButton.x = display.contentWidth / 2
       excellentButton.y = 450

       feelingLuckyButton.x = display.contentWidth / 2
       feelingLuckyButton.y = 750

       --print(getFoodData("data",9)[10])



    end



    --Clean up local variables, etc...
	clean = function()
	  print("Cleaning Map")
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
