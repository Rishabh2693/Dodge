local centerX = display.contentWidth/2
local centerY = display.contentHeight/2


require( "sounds")
function CompanyName()

end


--------------------------------------------------------------------------------------

function GameName(  )

	title = display.newImage("logobw.jpg")
	title.x = centerX
	title.y = centerY
	title.width = 2*centerX
	title.height = 2*centerY

	local function goAway(  )

		transition.to(title, {time=3000, alpha=0.5, onComplete = HomePage})
		--title:removeEventListener("tap", goAway)	
		return true
	end

	goAway()

	--title:addEventListener("tap", goAway)
	
end

---------------------------------------------------------------------------------------------------
local widget = require( "widget" )
local scrollView
local centerX = display.contentWidth/2
local centerY = display.contentHeight/2


function BackgroundSelector(  )

	sound("tap",mute)

	Play:removeEventListener( "tap", BackgroundSelector )
	Store:removeEventListener( "tap", GameStore )
	Credits:removeEventListener( "tap", GameCredits )
	Help:removeEventListener( "tap", GameHelp )
	Sound:removeEventListener( "tap", GameSound )
	--transition.to(homepagegroup, {time=10, alpha=0.9, onComplete=makemenu})
	
	display.remove( homepagegroup )
	

	 function makemenu(  )    
    
    	--

		 backbutton = display.newImage( "Back.png" )

		 backbutton.x = 1.5*centerX 
		 backbutton.y = 1.5*centerY

		
		 function gobacktohome(  )
		 		sound("tap",mute)
		 		Bk1:removeEventListener( "tap", goto )
				Bk2:removeEventListener( "tap", goto )
				Bk3:removeEventListener( "tap", goto )
				backbutton:removeEventListener( "tap", gobacktohome )
				local function gobackhome1(  )
					display.remove( totalview )
					
					HomePage()
				end
				gobackhome1()

		 end

		 backbutton:addEventListener( "tap", gobacktohome )

		    scrollView = widget.newScrollView
		        {
		            width = display.contentWidth,
		            height = display.contentHeight,
		            verticalScrollDisabled = true,
		            backgroundColor = { 0.9,0.9,0.99 }
		        }

		       
		        local scrollViewBackground = display.newRect(3*display.contentWidth/2,display.contentHeight/2, 3 * display.contentWidth, display.contentHeight)
		        scrollViewBackground:setFillColor( 1,1,1 )
		        
		        
		        scrollView:insert( scrollViewBackground )
		        
		        scrollView.x = display.contentWidth/2
		        scrollView.y = display.contentHeight/2
		        Bk1 = display.newImage("Classic.png")
		        Bk1.x = display.contentWidth/2
		        Bk1.y = display.contentHeight/2
		        Bk1.width = 2*centerX
				Bk1.height = 2*centerY
		        Bk1:addEventListener( "tap", goto )
		        scrollView:insert(Bk1)
		        Bk1.name="Bk1"
		        Bk2 = display.newImage("City.jpg")
		        Bk2.x = display.contentWidth + display.contentWidth/2
		        Bk2.y = display.contentHeight/2
		        Bk2.width = 2*centerX
				Bk2.height = 2*centerY
		        Bk2:addEventListener( "tap", goto )
		        scrollView:insert(Bk2)
		        Bk2.name="Bk2"
		        Bk3 = display.newImage("Space.jpg")
		        Bk3.x = 2*display.contentWidth + display.contentWidth/2
		        Bk3.y = display.contentHeight/2
		        Bk3.width = 2*centerX
				Bk3.height = 2*centerY
		        Bk3:addEventListener( "tap", goto )
		        Bk3.name="Bk3"
		        scrollView:insert(Bk3)
		        totalview = display.newGroup( )
		        totalview:insert( scrollView )
		        totalview:insert( backbutton )
	    	
		--
		
	end	
	
--
makemenu()

end

---------------------------------------------------------------------------------------

function HomePage()
	mute = false
	display.remove( title )
	homepage = display.newImage( "Homepage.jpg" )
	homepage.x = centerX
	homepage.y = centerY
	homepage.width = 2*centerX
	homepage.height = 2*centerY
	Play = display.newImage( "Play.png")
	Play.x = centerX
	Play.y = 6*centerY/8
	Store = display.newImage( "Store.png" )
	Store.x = centerX
	Store.y = centerY
	Credits = display.newImage( "Credits.png" )
	Credits.x = centerX
	Credits.y = 10*centerY/8
	Help = display.newImage( "Help.png" )
	Help.x = 1.5*centerX
	Help.y = 10*centerY/8
	Sound = display.newImage( "Sound.png" )
	Sound.x = 0.5*centerX
	Sound.y = 10*centerY/8

	homepagegroup = display.newGroup( )
	homepagegroup:insert(homepage)
	homepagegroup:insert( Play )
	homepagegroup:insert(Store)
	homepagegroup:insert(Credits)
	homepagegroup:insert(Help)
	homepagegroup:insert(Sound)

	Play:addEventListener( "tap", BackgroundSelector )
	Store:addEventListener( "tap", GameStore )
	Credits:addEventListener( "tap", GameCredits )
	Help:addEventListener( "tap", GameHelp )
	Sound:addEventListener( "tap", GameSound )

end



-------------------------------------------------------------------------------------------
function goto( event )
	
	local mode = event.target.name
	print( mode )

	function gotobackground( )

		display.remove( totalview )
		if (mode == "Bk1") then

			firstbackground()
								
			return true

		elseif (mode == "Bk2") then
				
			secondbackground()
				
			return true

		elseif (mode == "Bk3") then
			
			thirdbackground()

			return true
		end

	end

	Bk1:removeEventListener( "tap", goto )
	Bk2:removeEventListener( "tap", goto )
	Bk3:removeEventListener( "tap", goto )
	backbutton:removeEventListener( "tap", gobacktohome )
	gotobackground()

end
-----------------------------------------------------------------------------------------------
function GameStore(  )

	require("Buy")
	sound("tap",mute)
	Play:removeEventListener( "tap", BackgroundSelector )
	Store:removeEventListener( "tap", GameStore )
	Credits:removeEventListener( "tap", GameCredits )
	StoreMenu()

	
end
-------------------------------------------------------------------------------------------
function GameCredits(  )
	sound("tap",mute)

	local function removehomepagegroup(  )
		display.remove( homepagegroup )
	end

	local function removecreditgroup(  )

		display.remove( creditgroup )
		HomePage()
	end

	local function backfromcredits(  )
		sound("tap",mute)
		backbutton:removeEventListener("tap",backfromcredits)
		--RohitLad:removeEventListener( "tap", gotoRL )
		--RishabhSinha:removeEventListener( "tap", gotoRS )
		--UditGuru:removeEventListener( "tap", gotoUG )
		removecreditgroup()
	end
	local function gotoRL(  )
		system.openURL( "https://www.facebook.com/be.Carnegie" )
	end
	local function gotoRS(  )
		system.openURL( "https://www.facebook.com/rishabh.sinha.334" )
	end
	local function gotoUG(  )
		system.openURL( "https://www.facebook.com/uditbuzzer19" )
	end
	credits = display.newImage( "Credits.jpg" ,centerX,centerY)
	credits.width = 2*centerX
	credits.height = 2*centerY

	RohitLad = display.newRect( centerX+150,centerY/2, 700, 150 )
	RishabhSinha = display.newRect( centerX+60,1.5*centerY/2+10, 900, 150 )
	UditGuru = display.newRect( centerX+150,2*centerY/2+25, 700, 150 )
	RohitLad:addEventListener( "tap", gotoRL )
	RishabhSinha:addEventListener( "tap", gotoRS )
	UditGuru:addEventListener( "tap", gotoUG )
	RohitLad.alpha=0.01
	UditGuru.alpha = 0.01
	RishabhSinha.alpha=0.01

	removehomepagegroup()

	backbutton = display.newImage( "Back.png" )

		 backbutton.x = 1.515*centerX 
		 backbutton.y = 1.69*centerY
	backbutton:addEventListener("tap",backfromcredits)
	creditgroup = display.newGroup( )
	creditgroup:insert( credits )
	creditgroup:insert(backbutton)
	creditgroup:insert( RohitLad )
	creditgroup:insert( RishabhSinha )
	creditgroup:insert( UditGuru )	
	end
----------------------------------------------------------------------------------------------------


function GameHelp(  )

	sound("tap",mute)




	function makehelpmenu(  )    
    
    	--

		 backbutton1 = display.newImage( "Back.png" )

		 backbutton1.x = 1.5*centerX 
		 backbutton1.y = 1.5*centerY

		
		function gobacktohelphome(  )

		 		sound("tap",mute)
		 		
				backbutton1:removeEventListener( "tap", gobacktohelphome )

				local function gobackhome12(  )
					display.remove( totalhelpview )
					
					HomePage()
				end
				gobackhome12()
				return true
		 end

		 backbutton1:addEventListener( "tap", gobacktohelphome )

		    helpscrollView = widget.newScrollView
		        {
		            width = display.contentWidth,
		            height = display.contentHeight,
		            --scrollWidth = display.contentWidth,
		            --scrollHeight = display.contentHeight,
		            verticalScrollDisabled = true,
		            backgroundColor = { 26/255,43/255,71/255 }
		        }
		       
		       	local scrollViewBackground = display.newRect(2*display.contentWidth/2,display.contentHeight/2, 2 * display.contentWidth, display.contentHeight)
		        scrollViewBackground:setFillColor( 1,1,1 )
		        
		        
		        helpscrollView:insert( scrollViewBackground )
		        helpscrollView.x = display.contentWidth/2
		        helpscrollView.y = display.contentHeight/2


		        help1 = display.newImage("Help13.jpg")
		        help1.x = display.contentWidth
		        help1.y = display.contentHeight/2
		        help1.width = 2*display.contentWidth
		        help1.height = display.contentHeight
		        --help1:addEventListener( "tap", lallan )
		        help1.name="help1"
		        
		        helpscrollView:insert(help1)
		        

		        totalhelpview = display.newGroup( )
		        totalhelpview:insert( helpscrollView )
		        totalhelpview:insert( backbutton1 )
	    	
		--
		display.remove( homepagegroup )
	end	
	

	Play:removeEventListener( "tap", BackgroundSelector )
	Store:removeEventListener( "tap", GameStore )
	Credits:removeEventListener( "tap", GameCredits )
	Help:removeEventListener( "tap", GameHelp )
	Sound:removeEventListener( "tap", GameSound )
	makehelpmenu()
end
----------------------------------------------------------------------------------------------
function GameSound(  )
	
	if mute == false then
		display.remove( Sound )
		Sound = display.newImage( "Mute.png" )
		Sound.x = 0.5*centerX+10
		Sound.y = 10*centerY/8
		mute = true
		print( "yellow" )
		Sound:addEventListener( "tap", GameSound )
		homepagegroup:insert(Sound)
	else
		display.remove( Sound )
		Sound = display.newImage( "Sound.png" )
		Sound.x = 0.5*centerX
		Sound.y = 10*centerY/8
		mute = false
		print( "White" )
		Sound:addEventListener( "tap", GameSound )
		homepagegroup:insert(Sound)	
	end

end
