display.setStatusBar( display.HiddenStatusBar )

--====================================================================--
-- DIRECTOR CLASS SAMPLE
--====================================================================--

--[[

 - Version: 1.4
 - Made by Ricardo Rauber Pereira @ 2010
 - Blog: http://rauberlabs.blogspot.com/
 - Mail: ricardorauber@gmail.com

******************
 - INFORMATION
******************

  - This is a little sample of what Director Class does.
  - If you like Director Class, please help us donating at Ricardo's blog, so he can
	keep doing it for free. http://rauberlabs.blogspot.com/

--]]

--====================================================================--
-- IMPORT DIRECTOR CLASS
--====================================================================--

require "globals"
local director = require("director")
local downPress = false


--====================================================================--
-- CREATE A MAIN GROUP
--====================================================================--

local mainGroup = display.newGroup()

--====================================================================--
-- MAIN FUNCTION
--====================================================================--

local main = function ()

	------------------
	-- Add the group from director class
	------------------
	setupGlobals()
	loadFoodData()


	mainGroup:insert(director.directorView)

	------------------
	-- Change scene without effects
	------------------

	director:changeScene("home")

	------------------
	-- Return
	------------------

	return true
end

--====================================================================--
-- BEGIN
--====================================================================--


--------------------------------------------------------------------------------
-- Android "restart" Wakeup Code (forces a display update after 250 msec)
--
-- If applicationStart then fire a 250 ms timer.
-- After 250 ms, changes the Alpa value of the Current Stage (group)
-- This forces a display update to wake up the screen
-------------------------------------------------------------------------
local function onBackButtonPressed(e)
    if (e.phase == "down" and e.keyName == "back") then
        downPress = true
        else if (e.phase == "up" and e.keyName == "back" and downPress) then
            -- do whatever (generally changing scene)
            -- also don't forget to do this if changing scene: Runtime:removeEventListener( key,onBackButtonPressed)
        end
    end
    return true
end

local function onAndroidSystemEvent( event ) 
        
        local timerEnd = function()
                local t = display.getCurrentStage()
                t.alpha = 0.9           -- force a display update
                timer.performWithDelay( 1, function() t.alpha = 1.0 end ) -- wait one frame
        end
        
        local appEnd = function()
                --print("app exit hit")
                local t = display.getCurrentStage()
                t.alpha = 1           -- begin fade out...
                timer.performWithDelay( 1, function() t.alpha = 0.5 end ) -- wait one frame
        end        
        
        -- Start timer if this is an application start event
        if "applicationStart" == event.type then
                timer.performWithDelay( 250, timerEnd )
        elseif "applicationExit" == event.type then
           timer.performWithDelay(250, appEnd)
        end
end
 
-- Add the System callback event if Android
if "Android" == system.getInfo( "platformName" ) then
   Runtime:addEventListener( "system", onAndroidSystemEvent )
   Runtime:addEventListener( "key", onBackButtonPressed )
end
------------------------------------------------------------------------


main()

-- It's that easy! :-)
