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
    local json = require("json")

	-------------------------------------------------
	-- Handle any Params that get passed to the Scene
	-------------------------------------------------

	local vLabel = ""
	local vReload = false
	local submitButton

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
	local backGround = display.newImage( "assets/leaderbg.jpg", true )
	local instructions = display.newImage("assets/leaderboardinstr.png", true)
  local rankbadge = display.newImage("assets/rankbadge.png")
    --local labelFont = getGlobal("fontname")
    local standardLabelColors = getGlobal("StandardLabelColors")
    local textSize = 80
    local emailField
    local lblScore

	------------------
	-- Functions
	------------------
local function fieldHandler( event )

	if ( "began" == event.phase ) then
		-- This is the "keyboard has appeared" event
		-- In some cases you may want to adjust the interface when the keyboard appears.
	
	elseif ( "ended" == event.phase ) then
		-- This event is called when the user stops editing a field: for example, when they touch a different field
	
	elseif ( "submitted" == event.phase ) then
		-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
		
		-- Hide keyboard
		native.setKeyboardFocus( nil )
	end

end	

   local showValidation = function()
     --rotate the win
       --display.remove(validationImage)
     	-- validationImage = display.newImage( "assets/emailrequired.png", true )
		--   validationImage.x = 320
		--   validationImage.y = 750
		--   localGroup:insert(validationImage)
	  	--   transition.to(validationImage,{rotation = validationImage.rotation + 360,time = 1000})
      lblScore.text = "Invalid Email"
		  emailField.text = ""
    end


    local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )

             --local t = {}

             --t = json.decode(event.response)
             --print(t)


        end
    end    


    local function rankListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )

                local t = {}
                t = json.decode(event.response)

                lblScore.text = t["ranking"] .. " of " .. t["total"]

             --print(t)
        end
    end      



   local GetRank = function()


      local path = getGlobal("serverpath") .. "leaderboard/" .. getGlobal("email")
      --local postData = {["emailaddress"]=getGlobal("email")}
      --local jsonBlob = json.encode(postData)
      --local params = {}
      --params.body = jsonBlob    

      --print(jsonBlob)  

      network.request( path, "GET", rankListener)
   end


    -------------------
    --Change Scene-----
    -------------------
    local pressSubmit = function(event)
       

      local isValidEmail = false
      --local emailAddress = ""
      local emailAddress = emailField.text

      --if (emailAddress:match("^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$")) then
     
      --if (emailAddress:match("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)\b")) then
      if (emailAddress:match("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")) then
      --if (emailAddress:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
        isValidEmail = true
      end  

      print("Email is valid = " .. tostring(isValidEmail))   


      ---[[
      if (emailField.text == "") or (isValidEmail == false) then
        --we need to require these two fields
        showValidation()
		--timer.performWithDelay(removeValidation(), 2000, 1)

      else	

        setGlobal("email", emailField.text)

        --Call the network

       local postData = {["email"]=getGlobal("email")}
       
       local jsonBlob = json.encode(postData)

 
       local params = {}
       params.body = jsonBlob
       print(jsonBlob)

       local path = getGlobal("serverpath") .. "user"
       print(path)
       --POST
       network.request( path, "POST", networkListener, params)  

         lblScore.isVisible = true
         rankbadge.isVisible = true 
         instructions.isVisible = false
         emailField.isVisible = false
         submitButton.isVisible = false

       GetRank()

	  end  
      --]]


    end


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

    submitButton = ui.newButton{
    	default = "assets/submitbutton.png",
	    over = "assets/submitbuttonover.png",
	    onRelease = pressSubmit,
    }    



    local textFieldSize = 48
    local textFieldFontSize = 18
    if system.getInfo("platformName") == "Android" then
      textFieldSize = 96
    end

    emailField = native.newTextField(10, 190, 400, textFieldSize)
    emailField:addEventListener("userInput", fieldHandler)
    emailField.font = native.newFont( native.systemFontBold, textFieldFontSize)
    emailField.inputType = "email"
    emailField:setReferencePoint(display.TopLeftReferencePoint)
    emailField.x = 120
    emailField.y = 430  

    lblScore = display.newText("", 180, 500, labelFont, 44)
    lblScore:setTextColor(7, 251, 3)           
    
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
      print("Initializing Leaderboard")
	  localGroup:insert(backGround)
	  localGroup:insert(instructions)
	  localGroup:insert(homeButton)
	  localGroup:insert(emailField)
	  localGroup:insert(submitButton)
    localGroup:insert(rankbadge)
    localGroup:insert(lblScore)

	  --localGroup:insert(label)
	  --localGroup:insert(label2)


       if getGlobal("email") == "anon" then
         --no email
         lblScore.isVisible = false
         rankbadge.isVisible = false 
         instructions.isVisible = true
         emailField.isVisible = true
         submitButton.isVisible = true
         
       else
         --we already know an email
         lblScore.isVisible = true
         rankbadge.isVisible = true 
         instructions.isVisible = false
         emailField.isVisible = false
         submitButton.isVisible = false
         GetRank()
       end 

       --Position Things
       homeButton.x = display.contentWidth / 2
       homeButton.y = 912
      
       instructions.x = display.contentWidth / 2
       instructions.y = 300

       submitButton.x = display.contentWidth / 2
       submitButton.y = 600

       lblScore.x = display.contentWidth / 2
       lblScore.y = 530

       rankbadge.x = display.contentWidth / 2
       rankbadge.y = 500


       --print(getFoodData("data",9)[10])
      --emailField.text= ""


    end



    --Clean up local variables, etc...
	clean = function()
	  print("Cleaning Leaderboard")
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
