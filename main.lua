local functions = require("functions")
local mode1 = require( "modeone")
local mode2 = require( "modetwo")
local mode3 = require( "modethree")
local licensing = require( "licensing" )
licensing.init( "google" )

local function licensingListener( event )

    if not ( event.isVerified ) then
        -- Failed to verify app from the Google Play store; print a message
        pirates = display.newText( "Looks like this game isn't downloaded from the Play Store :(", display.contentCenterX, display.contentCenterY, "arial", 60 )
    else
    	GameName()
    end
end

--licensing.verify( licensingListener )


display.setStatusBar(display.HiddenStatusBar)



GameName()