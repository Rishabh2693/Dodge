centerX = display.contentWidth/2
centerY = display.contentHeight/2
require("sounds")


function StoreMenu(  )

	require( "modeone")
	require( "modetwo")
	require( "modethree")
	require( "jaimaharashtra")
	require( "IAPbitches")

--ticker = display.newText( "yolo",display.contentWidth/2 , display.contentHeight/4, "arial", 60 )
--ticker:setFillColor( 1,1,1 )

	file = filenamenpath( )

		if file then
			scanvariables( )
		else
			createfile()
			file = filenamenpath( )
			scanvariables()
		end

	display.remove( homepagegroup )
	print( "in the store menu" )

	local storegroup = display.newGroup( )

	
	-------------------------------------------------background og the store page-----------------	

	local background = display.newImage( "LevelScreen.jpg",centerX, centerY)
	background.width = 2*centerX
	background.height = 2*centerY
	storegroup:insert( background)
	--storegroup:insert(ticker)
	------------------------------------------------------Update System-------------------------------------------

	local function updatesystem(  )
		highscore_checker(0,0,0,coinsnumber,gamesizeup,gameshieldup,gamesolidup)
	end


	-------------------------------------------------------buy coins button n label-------------------------

	coinb1= display.newImage( "500Coin.png",8*centerX/8, 0.9*centerY+10 )

	--coinb:setFillColor( 0.6,0.65,0.6 )

	local coinval = display.newText( coinsnumber, coinb1.x+coinb1.width/4+200, 0.6*centerY/2, display.contentWidth/4, display.contentHeight/8, "arial", 80 )
	
	
	coinb1:addEventListener( "tap", purchaseItem1 )
	coinval:setFillColor( 1,1,1)

	storegroup:insert(coinb1)
	storegroup:insert(coinval)

function removecoinb1()
	
	coinb1:removeEventListener( "tap", purchaseItem1 )
end
	-------------------------------------------------------buy coins button n label-------------------------

	coinb2 = display.newImage( "1500Coins.png",12*centerX/8, 0.8*centerY )

	--coinb:setFillColor( 0.6,0.65,0.6 )

	coinb2:addEventListener( "tap", purchaseItem2 )


	storegroup:insert(coinb2)

	function removecoinb2()
	
	coinb2:removeEventListener( "tap", purchaseItem2 )
end

---------------------------------------coins image---------------------------------------------------------------

	coinimage = display.newImage( "coinsmall.png" ,coinb1.x-150, 0.45*centerY/2)

	storegroup:insert(coinimage)

	-------------------------------------------------------powerup size button n label-------------------------

	local powerupsizeb= display.newImage( "Buy3.png",2*centerX/8+100, 0.5*centerY-100)

	--powerupsizeb:setFillColor( 0.6,0.65,0.6 )

	local powerupsizeval = display.newText( gamesizeup, powerupsizeb.x+150, powerupsizeb.y +200 , display.contentWidth/8, display.contentHeight/8, "arial", 60 )

	powerupsizeval:setFillColor( 1,1,1 )

	local function buysize( event )


		if coinsnumber > 60 then
			sound("size",mute)
			gamesizeup = gamesizeup + 4

			coinsnumber = coinsnumber - 60

			powerupsizeval.text = gamesizeup

			coinval.text = coinsnumber

			updatesystem()
			
		end

	end

	powerupsizeb:addEventListener( "tap", buysize )

	storegroup:insert(powerupsizeb)
	storegroup:insert(powerupsizeval)


	-------------------------------------------------------powerup shield button n label-------------------------

	local powerupshieldb= display.newImage( "Buy1.png",2*centerX/8+100, 0.9*centerY-100)

	--powerupshieldb:setFillColor( 0.6,0.65,0.6 )

	local powerupshieldval = display.newText( gameshieldup, powerupshieldb.x+150, powerupshieldb.y+200, display.contentWidth/8, display.contentHeight/8, "arial", 60 )

	powerupshieldval:setFillColor( 1,1,1 )

	local function buyshield( event )

		if coinsnumber > 100 then
			sound("shield", mute)
			gameshieldup = gameshieldup + 4

			coinsnumber = coinsnumber - 100

			powerupshieldval.text = gameshieldup

			coinval.text = coinsnumber

			updatesystem()
			
		end
		
	end

	powerupshieldb:addEventListener( "tap", buyshield )

	storegroup:insert(powerupshieldb)
	storegroup:insert(powerupshieldval)

	-------------------------------------------------------powerup solid button n label-------------------------

	local powerupsolidb= display.newImage( "Buy2.png",2*centerX/8+100, 1.3*centerY-100)

	--powerupsolidb:setFillColor( 0.6,0.65,0.6 )

	local powerupsolidval = display.newText( gamesolidup, powerupsolidb.x+150, powerupsolidb.y+200, display.contentWidth/8, display.contentHeight/8, "arial", 60 )

	powerupsolidval:setFillColor( 1,1,1 )

	local function buysolid( event )

		if coinsnumber > 80 then
			sound("solid",mute)
			gamesolidup = gamesolidup + 4

			coinsnumber = coinsnumber - 80

			powerupsolidval.text = gamesolidup

			coinval.text = coinsnumber

			updatesystem()
			
		end
		
	end
	powerupsolidb:addEventListener( "tap", buysolid )

	storegroup:insert(powerupsolidb)
	storegroup:insert(powerupsolidval)



-------------------------------------------------back button shit-----------------

	local backbutton = display.newImage( "Back.png" )

	backbutton.x = 1.5*centerX 
	backbutton.y = 1.5*centerY


	storegroup:insert( backbutton)

		
	local function gobacktohome(  )

		 		sound("tap",mute)
				backbutton:removeEventListener( "tap", gobacktohome )
				coinb1:removeEventListener( "tap", purchaseItem1 )
				coinb2:removeEventListener( "tap", purchaseItem2 )
				powerupsizeb:removeEventListener( "tap", buysize )
				powerupshieldb:removeEventListener( "tap", buyshield )
				powerupsolidb:removeEventListener( "tap", buysolid )

				
				local function gobackhome1(  )


					display.remove( storegroup )
					HomePage()

				end
			transition.to(storegroup, {time=10, alpha=0.9, onComplete=gobackhome1})

		 end

backbutton:addEventListener( "tap", gobacktohome)
	
	function updateboughtcoins( boughtcoins )
		coinsnumber = coinsnumber + boughtcoins
		updatesystem()
		coinval.text=coinsnumber
	end


end

