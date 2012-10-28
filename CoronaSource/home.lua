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
    local MatchUp = {}
    local lblLeftName, lblLeftAddress
    local lblRightName, lblRightAddress
    local leftButton, rightButton, nextButton
    local leftImage, rightImage
    local Unavailable = false
    local lblScore

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
	local backGround = display.newImage( "assets/homebg.jpg", true )
  local badge = display.newImage("assets/badge.png",true)
  local standardLabelColors = getGlobal("StandardLabelColors")




	------------------
	-- Functions
	------------------
   local function round2(num, idp)
     return tonumber(string.format("%." .. (idp or 0) .. "f", num))
    end

  --[[
    local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )

             local t = {}

             t = json.decode(event.response)
             print(t["ranking"])
             print(t["total"])


        end
    end
--]]

    local function logSelectionListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )

             local t = {}

             t = json.decode(event.response)

             if t ~= nil then

             print(t["result"])

           end


        end
    end   


    local function matchupListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )

             MatchUp = nil
             MatchUp = json.decode(event.response)

             if MatchUp == nil then
                Unavailable = true

                lblLeftName.text = "Server Unavailable - Try Later"
                lblLeftName.x = display.contentWidth / 2
                lblLeftName.y = 234

                lblLeftAddress.text = ""
                lblLeftAddress.x = display.contentWidth / 2
                lblLeftAddress.y = 270

                lblRightName.text = "Server Unavailable - Try Later" 
                lblRightName.x = display.contentWidth / 2
                lblRightName.y = 590

                lblRightAddress.text = ""
                lblRightAddress.x = display.contentWidth / 2
                lblRightAddress.y = 628                

             else 

             print(MatchUp["restaurant_1"]["name"])

             lblLeftName.text = MatchUp["restaurant_1"]["name"] 
             lblLeftName.x = display.contentWidth / 2
             lblLeftName.y = 590

             lblLeftAddress.text = MatchUp["restaurant_1"]["address"]
             lblLeftAddress.x = display.contentWidth / 2
             lblLeftAddress.y = 628


             lblRightName.text = MatchUp["restaurant_2"]["name"] 
             lblRightName.x = display.contentWidth / 2
             lblRightName.y = 234

             lblRightAddress.text = MatchUp["restaurant_2"]["address"]
             lblRightAddress.x = display.contentWidth / 2
             lblRightAddress.y = 270
           end

        end
    end    




  local GetRestaurants = function()
   
       --GET

       local path = getGlobal("serverpath") .. "matchup"
       --path = "https://encrypted.google.com"
       print(path)

       network.request( path, "GET", matchupListener )


       if tonumber(getGlobal("matchups")) > 0 then
         local yourScore = (getGlobal("score") / getGlobal("matchups") * 100)
         
         print("Your Rating: " .. tostring(round2(yourScore,2)))
         lblScore.text = tostring(round2(yourScore,2))
         lblScore.x = display.contentWidth / 2
         lblScore.y = 780
     end

  end    

    -------------------
    --Change Scene-----
    -------------------
    local moveToAbout = function(event)

      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )

	  director:changeScene( "about", "moveFromLeft" )

    end

    local moveToMap = function(event)

      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )

	    director:changeScene( "map", "moveFromLeft" )

    end    


    local moveToLeaderBoard = function(event)

      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )

	    director:changeScene( "leaderboard", "flip" )

    end

    local GetValue = function(rating)
        if rating == "FAIR" then
          return 1
        elseif rating == "STANDARD" then
          return 2
        elseif rating == "EXELLENT" then
          return 3
        else
          return 4
        end  
    end

    local GetResult = function(selected, compare)

         local selectedval = GetValue(selected)
         local compareval = GetValue(compare)
      
         if selectedval >= compareval then
           setGlobal("score", getGlobal("score") + 1)
           return "winner"
         else
           return "loser"
         end    
    end



    local buttonPressed = function(event)


      if event.target.name == "next" then
         
         
         nextButton.isVisible = false
         leftButton.isVisible = true
         rightButton.isVisible = true
         display.remove(leftImage)
         display.remove(rightImage)
         GetRestaurants()
      else

        local result

        leftImage = display.newImage("assets/" .. MatchUp["restaurant_1"]["rating"] .. ".png", true)
        leftImage.x = display.contentWidth / 2 - (leftImage.width / 2) - 50
        leftImage.y = 370
        localGroup:insert(leftImage)

        rightImage = display.newImage("assets/" .. MatchUp["restaurant_2"]["rating"] .. ".png", true)
        rightImage.x = display.contentWidth / 2 + (leftImage.width / 2) + 50
        rightImage.y = 370
        localGroup:insert(rightImage)

        leftButton.isVisible = false
        rightButton.isVisible = false
        nextButton.isVisible = true

        --Increment the scores
        setGlobal("matchups", getGlobal("matchups") + 1)

        local postData = {}

        if event.target.name == "left" then
          result = GetResult(MatchUp["restaurant_1"]["rating"], MatchUp["restaurant_2"]["rating"])

          postData = {
             ["email"]=getGlobal("email"),
             ["user_result"]=result,
             ["restaurant_1"] = {["name"]=MatchUp["restaurant_1"]["name"], ["address"]=MatchUp["restaurant_1"]["address"], ["choice"]="winner"},
             ["restaurant_2"] = {["name"]=MatchUp["restaurant_2"]["name"], ["address"]=MatchUp["restaurant_2"]["address"], ["choice"]="loser"},
           }
        elseif event.target.name == "right" then
          result = GetResult(MatchUp["restaurant_2"]["rating"], MatchUp["restaurant_1"]["rating"])
          postData = {
             ["email"]=getGlobal("email"),
             ["user_result"]=result,
             ["restaurant_1"] = {["name"]=MatchUp["restaurant_1"]["name"], ["address"]=MatchUp["restaurant_1"]["address"], ["choice"]="loser"},
             ["restaurant_2"] = {["name"]=MatchUp["restaurant_2"]["name"], ["address"]=MatchUp["restaurant_2"]["address"], ["choice"]="winner"},
           }
        end 
      

       local jsonBlob = json.encode(postData)
       local params = {}
       params.body = jsonBlob
       --print(jsonBlob)

       local path = getGlobal("serverpath") .. "matchup"
       --print(path)
       --POST
       network.request( path, "POST", logSelectionListener, params)  


      end  

        
    end      

    --Buttons--
    local aboutButton = ui.newButton{
    	default = "assets/aboutbutton.png",
	    over = "assets/aboutbuttonover.png",
	    onRelease = moveToAbout,
    }

    local mapButton = ui.newButton{
    	default = "assets/mapbutton.png",
	    over = "assets/mapbuttonover.png",
	    onRelease = moveToMap,
    }

    local leaderboardButton = ui.newButton{
    	default = "assets/leaderboardbutton.png",
	    over = "assets/leaderboardbuttonover.png",
	    onRelease = moveToLeaderBoard,
    }    

    leftButton = ui.newButton{
      default = "assets/leftbutton.png",
      over = "assets/leftbuttonover.png",
      onRelease = buttonPressed,
    }      

    rightButton = ui.newButton{
      default = "assets/rightbutton.png",
      over = "assets/rightbuttonover.png",
      onRelease = buttonPressed,
    }      

    nextButton = ui.newButton{
      default = "assets/nextbutton.png",
      over = "assets/nextbuttonover.png",
      onRelease = buttonPressed,
    }


    lblLeftName = display.newText("", 180, 200, labelFont, 24)
    lblLeftName:setTextColor(2, 162, 254)      

    lblLeftAddress = display.newText("", 180, 200, labelFont, 24)
    lblLeftAddress:setTextColor(2, 162, 254)      

    lblRightName = display.newText("", 180, 500, labelFont, 24)
    lblRightName:setTextColor(249, 3, 9)      

    lblRightAddress = display.newText("", 180, 500, labelFont, 24)
    lblRightAddress:setTextColor(249, 3, 9)   

    lblScore = display.newText("", 180, 500, labelFont, 36)
    lblScore:setTextColor(7, 251, 3)   




	------------------
	-- Code here
	------------------



	--====================================================================--
	-- INITIALIZE, Every Display Object must get shoved into the local Display Group
	-- Example:	localGroup:insert( background )
	--====================================================================--
	local initVars = function ()

      --print("Initializing Home")

      --lblLeftName.text = "HERE" 

    leftButton.name = "left"
    rightButton.name = "right"
    nextButton.name = "next"
    nextButton.isVisible = false
      
	  localGroup:insert(backGround)
    localGroup:insert(badge)
    localGroup:insert(lblScore)
	  localGroup:insert(aboutButton)
	  localGroup:insert(mapButton)
	  localGroup:insert(leaderboardButton)

    localGroup:insert(lblLeftName)
    localGroup:insert(lblLeftAddress)
    localGroup:insert(lblRightName)
    localGroup:insert(lblRightAddress)

    localGroup:insert(leftButton)
    localGroup:insert(rightButton)
    localGroup:insert(nextButton)


       --Position Things
       aboutButton.x = display.contentWidth / 2 - 210
       aboutButton.y = 912

       mapButton.x = display.contentWidth / 2
       mapButton.y = 912

       badge.x = display.contentWidth / 2
       badge.y = 760

       leaderboardButton.x = display.contentWidth / 2 + 210
       leaderboardButton.y = 912

       --print(getStandardFoodData("data",9)[9])
       --print(getExcellentFoodData("data",9)[9])
       --print(getSuperiorFoodData("data",9)[9])
       --print(getFeelingLuckyFoodData("data",9)[9])


       leftButton.x = display.contentWidth / 2 - 150
       leftButton.y = 450 

       rightButton.x = display.contentWidth / 2 + 150
       rightButton.y = 450

       nextButton.x = display.contentWidth / 2 + 200
       nextButton.y = 710

       --local postData = "color=red&size=small"
 
       --local params = {}
       --params.body = postData
 
       --POST
       --network.request( "http://127.0.0.1/formhandler.php", "POST", networkListener, params)    



       GetRestaurants()


    end



    --Clean up local variables, etc...
	clean = function()
	  print("Cleaning Home")

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

--[[
local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )
        end
end
 
postData = "color=red&size=small"
 
local params = {}
params.body = postData
 
network.request( "http://127.0.0.1/formhandler.php", "POST", networkListener, params)
]]

--[[

local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )
        end
end
 
-- Access Google over SSL:
network.request( "https://encrypted.google.com", "GET", networkListener )

--]]