function secondbackground(  )

	require( "jaimaharashtra")
	require( "levels")
	local score = 0
	local centerX = display.contentWidth/2
	local centerY = display.contentHeight/2
	local magnitude = 0.035

	file = filenamenpath( )

if file then
	scanvariables( )
else
	createfile()
	file = filenamenpath( )
	scanvariables()
end


	local multipliertime = 7000

	function gameStart(  )

	sound("modetwoloop",mute)
	local physicsData = (require "shapedefs").physicsData(1.0)
	initialcoinnumber = coinsnumber
	math.randomseed( os.time() )		
	shinde = true
	timersathiflag = false
	multipliersathiflag = false
	sizesathiflag = false
	objective = levelchecker("modetwo",score)
		------------------------------------------------physics------------
		local physics = require( "physics")
		physics.start()
		physics.setGravity( 0, 0 )

		-------------------------------------background-----------------------------------------

		m2background = display.newImage( "CityLights_Backdrop.jpg",display.contentCenterX,display.contentCenterY )
		m2background.width = 2*centerX
		m2background.height = 2*centerY
		--m2background:setFillColor( 0.933,0.953,0.97 )
		

		---------------------------------------------scorer circle -------------------------------


		--scroreroutcircle = display.newCircle( 0, 0, 200 )
		--scorerincircle = display.newCircle( 0, 0, 190 )
		--scroreroutcircle:setFillColor( 0.94,0.65,0.95 )
		--scorerincircle:setFillColor( 0.933,0.953,0.97 )
		scorercircle = display.newImage( "ScorerCircle.png" )
		scorercirclegroup = display.newGroup( )
		scorercirclegroup:insert( scorercircle )
		--scorercirclegroup:insert( scroreroutcircle )
		--scorercirclegroup:insert( scorerincircle )
		scorercirclegroup.x = centerX
		scorercirclegroup.y = centerY
		---------------------------------------------create planet-------------------------------

		local planet = display.newImage( "Bubble.png",centerX,centerY )
		local currentcolorvalue = {0.01*math.random( 0,80 ) , 0.01*math.random( 80,100 ), 0.01*math.random( 80,100 )}
		--planet:setFillColor( currentcolorvalue[1],currentcolorvalue[2],currentcolorvalue[3])

		-------------------------------------------add planet as physics-----------------------
		physics.addBody( planet, "static",physicsData:get("Bubble"))

		--------------------------------------------planet movement------------------------------
		

		function planetmovement( event )

			local t = event.target

				local phase = event.phase
				if "began" == phase then
					display.getCurrentStage():setFocus( t )
					t.isFocus = true

					-- Store initial position
					t.x0 = event.x - t.x
					t.y0 = event.y - t.y
					
				elseif t.isFocus then

					if "moved" == phase then

								t.x = event.x - t.x0
								t.y = event.y - t.y0

					elseif "ended" == phase or "cancelled" == phase then

						display.getCurrentStage():setFocus( nil )
						t.isFocus = false
						
					end
				end
		end
		planet:addEventListener("touch", planetmovement)
		-----------------------------------------------------planet boundary handling------------------
		

		function Boundary()

			if planet.x < planet.contentHeight/2  then
				planet.x = planet.contentWidth/2
			end
			if planet.x > display.contentWidth-planet.contentHeight/2  then
				planet.x = display.contentWidth-planet.contentHeight/2
			end
			if planet.y < planet.contentHeight/2  then
				planet.y = planet.contentHeight/2
			end
			if planet.y > display.contentHeight-planet.contentHeight/2  then
				planet.y = display.contentHeight-planet.contentHeight/2
			end
	
		end
		Runtime:addEventListener("enterFrame", Boundary)


		--------------------------------------------spawn enemies-------------------------

		

		function spawnEnemy(  )



			local leftspawn = {math.random(-900,-400),math.random(-400, centerY+400)}
			local topspawn = {math.random(-900,2*centerX+900),math.random(-900, -400)}
			local rightspawn = {math.random(2*centerX+400,2*centerX+900),math.random(-400,centerY+400)}
			local spawnchoice = math.random( 1,3 )
			--print( spawnchoice )
			--print( leftspawn[1]..","..leftspawn[2] )
			--print( topspawn[1]..","..topspawn[2] )



				if spawnchoice == 1 then
					print( "leftspawn" )
					enemyx = leftspawn[1]
					enemyy = leftspawn[2]
				elseif spawnchoice == 2 then

					print( "top spawn" )
					enemyx = topspawn[1]
					enemyy = topspawn[2]
				elseif spawnchoice == 3 then
					enemyx = rightspawn[1]
					enemyy = rightspawn[2]
				end
				local enemylist = {"Pin1","Shu1","Shu2",}

			local rectorcirc = math.random( 1,3 )

				if rectorcirc == 1 then
					enemy = display.newImage("Pin1.png")
					--enemy:setFillColor(0.01*math.random( 40,90 ) , 0.01*math.random( 40,90 ), 0.01*math.random( 40,90 ))

				elseif rectorcirc == 3 then
					enemy = display.newImage("Shu2.png")
					--enemy:setFillColor(0.01*math.random( 40,90 ) , 0.01*math.random( 40,90 ), 0.01*math.random( 40,90 ))

				elseif rectorcirc == 2 then

					enemy = display.newImage("Shu1.png")
					--enemy:setFillColor(0.01*math.random( 40,90 ) , 0.01*math.random( 40,90 ), 0.01*math.random( 40,90 ))

				end

			enemy.name = "enemy"	
			physics.addBody( enemy, "dynamic",physicsData:get(enemylist[rectorcirc]))

			enemy.x = enemyx
			enemy.y = enemyy

			forcex = planet.x - enemy.x
			forcey = planet.y - enemy.y

				if rectorcirc  then

					enemy:applyAngularImpulse( 1000)

				end

			enemy:applyLinearImpulse( magnitude*forcex, magnitude*forcey, enemy.x, enemy.y )

		end
	
		starter = timer.performWithDelay( 750, spawnEnemy ,-1 )

		

		------------------------------------------------enemy boundaries and removal---------------------------------------------

		function enemyboundaries(  )

			local seperation = 2000
			leftboundary	=	display.newRect( -seperation, centerY, 1, display.contentHeight + 2*seperation )
			rightboundary	=	display.newRect( display.contentWidth + seperation, centerY, 1, display.contentHeight + 2*seperation )
			topboundary	=	display.newRect( centerX, -1*seperation, display.contentWidth + 2*seperation, 1)
			bottomboundary	=	display.newRect( centerX, display.contentHeight + seperation, display.contentWidth + 2*seperation, 1)
			boundaries = display.newGroup()

			boundaries:insert( leftboundary)
			boundaries:insert( rightboundary )
			boundaries:insert( topboundary )
			boundaries:insert( bottomboundary )


			physics.addBody( leftboundary, "static", {friction = 0.2, bounce = 1} )
			physics.addBody( rightboundary, "static", {friction = 0.2, bounce = 1} )
			physics.addBody( topboundary, "static", {friction = 0.2, bounce = 1} )
			physics.addBody( bottomboundary, "static", {friction = 0.2, bounce = 1} )


			function removeenemies( event )

				display.remove( event.other )
						
			end

			leftboundary:addEventListener( "collision", removeenemies )
			rightboundary:addEventListener( "collision", removeenemies )
			topboundary:addEventListener( "collision", removeenemies )
			bottomboundary:addEventListener( "collision", removeenemies )

		end

		enemyboundaries()

---------------------------------------------------next objective------------------------------

		local objectivecard = display.newText( "Objective: ",0.8*centerX, 0.2*centerY, "Arial",50)

		objectivecard:setFillColor( 0,0,0 )

		------------------------------------------scoring - ---------------------------------





		local scorecard = display.newText( "Score: ",0.4*centerX, 0.2*centerY, "Arial",50)
		scorecard.text = "Score: "..score
		scorecard:setFillColor( 0,0,0 )

		
		
			function scoring( )

				if shinde == true then

					if sizesathiflag == true then
						range = 90
					elseif sizesathiflag == false then
						range = 50
					end

					if math.abs(scorercirclegroup.x - planet.x) <= range and math.abs(scorercirclegroup.y - planet.y) <= range then

						if multipliersathiflag == false then
							
						audio.stop( 2 )
						sound("score",false)

						end

						score = score + 5	
						scorecard.text = "Score: "..score

						nextobjective = levelchecker("modetwo",score)
						objectivecard.text = "Objective: "..nextobjective
					else
						audio.stop( 2 )

					end
				end

			end

		

		--Runtime:addEventListener( "enterFrame", scoring )
		scoretimer1 = timer.performWithDelay( 200, scoring, -1 )	

		-------------------------------------------powers----------------------------------------
		sizeflag = false
		shieldflag = false
		solidflag = false

		local solidtiming = 5000
		local sizetiming = 8000
		local shieldtiming = 5000

		----------------------------sizereduce----------------------------------------------------
		function sizepoweractivate(  )

			if gamesizeup > 0 and shieldflag == false and sizeflag == false and solidflag == false then
			sound("size",false)			
			gamesizeup = gamesizeup - 1

			sizepowercard.text = gamesizeup  	

				sizeflag = true
				
					function sizepowerdeactivate(  )
						
						
						local function retrieveoldplanet(  )


							display.remove( fakeplanet )
							physics.addBody( planet, "static",physicsData:get("Bubble"))
							planet.alpha = 1

							sizesathiflag = false
							return true

						end

						Runtime:removeEventListener("enterFrame",followfakeplanet)
						physics.removeBody( fakeplanet )
						retrieveoldplanet()
						sizeflag = false
						return true
					end

					tempposx = planet.x
					tempposy = planet.y
					physics.removeBody( planet )
					planet.alpha = 0.01
					fakeplanet = display.newImage( "Bubble_Reduced.png" )
					--fakeplanet:setFillColor( currentcolorvalue[1],currentcolorvalue[2],currentcolorvalue[3] )
					physics.addBody( fakeplanet, "static",physicsData:get("Bubble_Reduced"))
					fakeplanet:addEventListener( "collision", removeenemiesplanet )


					local sizepowergroup = display.newGroup( )	

					sizepowergroup:insert( fakeplanet)
					sizepowergroup:insert( planet)
							
					local function followfakeplanet(  )
						fakeplanet.x = planet.x
						fakeplanet.y = planet.y
						return true
					end

					Runtime:addEventListener("enterFrame",followfakeplanet)

					sizetimer = timer.performWithDelay( sizetiming, sizepowerdeactivate, 1 )
					sizesathiflag = true
					--transition.to(fakeplanet, {time=sizetiming, alpha=1, onComplete=sizepowerdeactivate})
					return true

				
			end
		end
		sizepower = display.newImage( "Size.png",centerX/8, 0.5*centerY)
		--sizepower:setFillColor( 0.6,0.6,0.9 )	
		sizepower:addEventListener( "tap", sizepoweractivate )
		sizepowercard = display.newText( gamesizeup, sizepower.x , sizepower.y+200, "Arial", 60 )
		sizepowercard:setFillColor( 0,0,0.0)
		


		--------------------------------------------get a shield---------------------------------------------

		function shieldpoweractivate(  )

			if gameshieldup>0 and shieldflag == false and sizeflag == false and solidflag == false then 
				sound("shield",false)
				gameshieldup = gameshieldup - 1

				shieldpowercard.text = gameshieldup
				shieldflag = true
				
					function shieldpowerdeactivate(  )
						
						local function retrieveoldplanet()
							print( "pochlo re" )

							display.remove( planetshieldouter )
							--display.remove( planetshieldinner )
							physics.addBody(planet, "static",physicsData:get("Bubble"))
						end
						
						Runtime:removeEventListener("enterFrame",followplanetshield)
						physics.removeBody( planetshieldouter )
						retrieveoldplanet()
						shieldflag = false
						return true
					end

					tempposx = planet.x
					tempposy = planet.y
					physics.removeBody( planet )
					planetshieldouter = display.newImage( "BubbleShield.png",tempposx, tempposy, 250 )
					--planetshieldinner = display.newCircle( tempposx, tempposy, 240 )
					--planetshieldouter:setFillColor( 0,0,0 )
					--planetshieldinner:setFillColor( 0.933,0.953,0.97 )
					physics.addBody( planetshieldouter, "static",physicsData:get("BubbleShield"))

					local function powerupdisappearplanet( event )
						if event.other.name~="enemy" then
							removeenemiesplanet( event )
						end
					end

					local shieldpowergroup = display.newGroup( )	

					shieldpowergroup:insert( planetshieldouter)
					--shieldpowergroup:insert( planetshieldinner)
					shieldpowergroup:insert( planet)
					planetshieldouter:addEventListener( "collision", powerupdisappearplanet )
							
					local function followplanetshield(  )
						planetshieldouter.x = planet.x
						planetshieldouter.y = planet.y
						--planetshieldinner.x = planet.x
						--planetshieldinner.y = planet.y
						return true
					end

					Runtime:addEventListener("enterFrame",followplanetshield)
					transition.to(planetshieldouter, {time=shieldtiming, alpha=1, onComplete=shieldpowerdeactivate})

				
			end
			
		end

		shieldpower = display.newImage("Shield.png",centerX/8, centerY)
		--shieldpower:setFillColor( 0.6,0.6,0.9 )	
		shieldpower:addEventListener( "tap", shieldpoweractivate )
		shieldpowercard = display.newText( gameshieldup, shieldpower.x, shieldpower.y+200, "Arial", 60 )
		shieldpowercard:setFillColor( 0,0,0 )
	


		-------------------------------------------------become solid------------------------------------------
		function solidpoweractivate(  )


			if gamesolidup > 0 and shieldflag == false and sizeflag == false and solidflag == false then
				sound("solid",false)
				gamesolidup = gamesolidup - 1

				solidpowercard.text = gamesolidup

				solidflag = true
				
					function solidpowerdeactivate(  )
						planet:addEventListener( "collision", removeenemiesplanet )
						Runtime:removeEventListener("enterFrame",followplanetsoild)
						display.remove( solidimage )
						solidflag = false
						return true
					end

					planet:removeEventListener( "collision", removeenemiesplanet )

					solidimage = display.newImage( "BubbleSolid.png" )

					local function followplanetsolid(  )
						solidimage.x = planet.x
						solidimage.y = planet.y
						return true
					end

					Runtime:addEventListener("enterFrame",followplanetsolid)

					transition.to(planet, {time=solidtiming,onComplete=solidpowerdeactivate})

					return true

				
			end
		end
		solidpower = display.newImage( "Solid.png",centerX/8, 1.5*centerY)
		solidpower:addEventListener( "tap", solidpoweractivate )
		solidpowercard = display.newText( gamesolidup, solidpower.x , solidpower.y+100, "Arial", 60 )
		solidpowercard:setFillColor( 0,0,0 )

		------------------------------------------------bullets disappear on hitting planet and planet life------------------------------------
		
		local hitsremaining = 7

		local hitscard = display.newText( "Hits Remaining: "..hitsremaining,1.2*centerX, 0.2*centerY, "Arial",50)
		
		hitscard:setFillColor( 0,0,0 )

		function removeenemiesplanet( event )


			display.remove( event.other )


			function catagorizer( event )
				
			

				if event.other.name == "enemy" then
					sound("pop",false)
					if hitsremaining>=1 then	
						hitsremaining = hitsremaining-1
						hitscard.text = "Hits Remaining: "..hitsremaining

					else

						endgame()
					end

				elseif	event.other.name == "multiplier" then

					multipliersathiflag = true
					scoretimer2= timer.performWithDelay( 200, scoring, -1 )			
					sound("scoremultiplier",false)
					local function stopmultiplier()
						print("timer thambla")
						timer.cancel( scoretimer2 )
						multipliersathiflag = false
						audio.stop( 3 )
					end

					stopmultipliertimer=timer.performWithDelay( multipliertime, stopmultiplier, 1 )

				elseif	event.other.name == "size" then
					sound("size",false)
					gamesizeup = gamesizeup+1
					sizepowercard.text = gamesizeup
					print( "size: "..gamesizeup )

				elseif	event.other.name == "shield" then
					sound("shield",false)
					gameshieldup = gameshieldup+1
					shieldpowercard.text = gameshieldup
					print( "shield: "..gameshieldup )


				elseif	event.other.name == "solid" then
					sound("solid",false)
					gamesolidup = gamesolidup+1
					solidpowercard.text = gamesolidup
					print( "solid: "..gamesolidup )
					
				elseif	event.other.name == "life" then
					timersathiflag = true
					hitsremaining = hitsremaining+1

					hitscard.text = "Hits Remaining: "..hitsremaining
					print( "life: "..hitsremaining )

				elseif	event.other.name == "coins" then
					sound("coins",false)
					timersathiflag = true
					coinsnumber	 = coinsnumber+coinvalue	
					coincard.text = "Coins: "..coinsnumber						
					
					

				end

			end

			catagorizer(event)
			return hitsremaining
						
		end

		planet:addEventListener( "collision", removeenemiesplanet )
		
		----------- event listener for fakeplanet (size reduction shield is in its own function)--------------------------------


		------------------------------------------random coins and powerups and extra life etc ---------------------------------





-------------------------------------------multiplier---------------------------------------------------

		local function spawnmultiplier(	)

			if shinde == true then
		
				print( "multiplier spawn whaila pahije" )
				
				local leftspawn = {math.random(-1000,-500),math.random(-500, 2*centerY)}
				local topspawn = {math.random(-500,2*centerX),math.random(-1000, -500)}
				local rightspawn = {math.random(2*centerX+500,2*centerX+1000),math.random(-500,2*centerY)}
				local spawnchoice = math.random( 1,3 )

					if spawnchoice == 1 then
						local enemyx = leftspawn[1]
						local enemyy = leftspawn[2]
					elseif spawnchoice == 2 then
						local enemyx = topspawn[1]
						local enemyy = topspawn[2]
					else
						local enemyx = rightspawn[1]
						local enemyy = rightspawn[2]
					end

					multiplier = display.newImage( "2X.png",enemyx, enemyy )
					multiplier.name = "multiplier"

				physics.addBody( multiplier, "dynamic", {bounce = 1, density = 0.1} )

				forcex = planet.x - multiplier.x
				forcey = planet.y - multiplier.y

				multiplier:applyLinearImpulse( magnitude*forcex, magnitude*forcey, multiplier.x, multiplier.y )
				multiplier:applyAngularImpulse( 250 )

			end
		end

---------------------------------------------------powerup---------------------------------------------
		local function spawnpowerup(	)

			if shinde == true then
				print( "powerup spawn whaila pahije" )


				
				local leftspawn = {math.random(-1000,-500),math.random(-500, 2*centerY)}
				local topspawn = {math.random(-500,2*centerX),math.random(-1000, -500)}
				local rightspawn = {math.random(2*centerX+500,2*centerX+1000),math.random(-500,2*centerY)}
				local spawnchoice = math.random( 1,3 )

					if spawnchoice == 1 then
						local enemyx = leftspawn[1]
						local enemyy = leftspawn[2]
					elseif spawnchoice == 2 then
						local enemyx = topspawn[1]
						local enemyy = topspawn[2]
					else
						local enemyx = rightspawn[1]
						local enemyy = rightspawn[2]
					end

				local powerupselector= math.random( 1,3 )

				if powerupselector==1 then
					powerup = display.newImage( "Sizesmall.png",enemyx, enemyy )
					
					powerup.name = "size"
				elseif powerupselector==2 then
					powerup = display.newImage( "Shieldsmall.png",enemyx, enemyy )
					
					powerup.name = "shield"
				elseif powerupselector==3 then
					powerup = display.newImage( "Solidsmall.png",enemyx, enemyy )
					
					powerup.name = "solid"
				end

				physics.addBody( powerup, "dynamic", {bounce = 1, density = 0.1} )

				forcex = planet.x - powerup.x
				forcey = planet.y - powerup.y

				powerup:applyLinearImpulse( magnitude*forcex, magnitude*forcey, powerup.x, powerup.y )
				powerup:applyAngularImpulse( 250 )

			end

		end


-------------------------------------------------life------------------------------------------------------------------------------------
		local function spawnlife(	)

			if shinde == true then
				
			
				print( "life spawn whaila pahije" )
				
				local leftspawn = {math.random(-1000,-500),math.random(-500, 2*centerY)}
				local topspawn = {math.random(-500,2*centerX),math.random(-1000, -500)}
				local rightspawn = {math.random(2*centerX+500,2*centerX+1000),math.random(-500,2*centerY)}
				local spawnchoice = math.random( 1,3 )

					if spawnchoice == 1 then
						local enemyx = leftspawn[1]
						local enemyy = leftspawn[2]
					elseif spawnchoice == 2 then
						local enemyx = topspawn[1]
						local enemyy = topspawn[2]
					else
						local enemyx = rightspawn[1]
						local enemyy = rightspawn[2]
					end

					life = display.newImage( "Life.png",enemyx, enemyy )
					life.name = "life"

				physics.addBody( life, "dynamic", {bounce = 1, density = 0.1} )

				forcex = planet.x - life.x
				forcey = planet.y - life.y

				life:applyLinearImpulse( magnitude*forcex, magnitude*forcey, life.x, life.y )
				life:applyAngularImpulse( 250 )

			end

		end

-------------------------------------------------------coins----------------------------------------------------------


		local function spawncoins(	)

			if shinde == true then

				print( "coins spawn whaila pahije" )
				
				local leftspawn = {math.random(-1000,-500),math.random(-500, 2*centerY)}
				local topspawn = {math.random(-500,2*centerX),math.random(-1000, -500)}
				local rightspawn = {math.random(2*centerX+500,2*centerX+1000),math.random(-500,2*centerY)}
				local spawnchoice = math.random( 1,3 )

					if spawnchoice == 1 then
						local enemyx = leftspawn[1]
						local enemyy = leftspawn[2]
					elseif spawnchoice == 2 then
						local enemyx = topspawn[1]
						local enemyy = topspawn[2]
					else
						local enemyx = rightspawn[1]
						local enemyy = rightspawn[2]

					end

					coinvalue = math.random( 1,50 )------------------------------------------------------------------------------------->   choose the value of coil or whatever give a list of coins that can be generated 

					coins = display.newImage( "Coins.png",enemyx, enemyy)
					coins.name = "coins"

				physics.addBody( coins, "dynamic", {bounce = 1, density = 0.1} )

				forcex = planet.x - coins.x
				forcey = planet.y - coins.y

				coins:applyLinearImpulse( magnitude*forcex, magnitude*forcey, coins.x, coins.y )
				coins:applyAngularImpulse( 250 )

			end

		end


			xmultipliertimer = timer.performWithDelay( math.random( 60000,150000), spawnmultiplier , -1 )
			poweruptimer = timer.performWithDelay( math.random(60000,150000), spawnpowerup, -1 )
			lifetimer = timer.performWithDelay( math.random(60000,150000), spawnlife, -1 )
			coinstimer = timer.performWithDelay( math.random(60000,150000), spawncoins, -1 )


-----------------------------------------------gameend------------------------------------------


		function endgame(  )

			audio.stop( 1 )
			audio.stop( 2 )
			audio.stop( 3 )

			shinde = false

			function Removelisteners(  )

				planet:removeEventListener("touch", planetmovement)
				Runtime:removeEventListener("enterFrame", Boundary)
				--leftboundary:removeEventListener( "collision", removeenemies )
				--rightboundary:removeEventListener( "collision", removeenemies )
				--topboundary:removeEventListener( "collision", removeenemies )
				--bottomboundary:removeEventListener( "collision", removeenemies )
				sizepower:removeEventListener( "tap", sizepoweractivate )
				shieldpower:removeEventListener( "tap", shieldpoweractivate )
				solidpower:removeEventListener( "tap", solidpoweractivate )
				planet:removeEventListener( "collision", removeenemiesplanet )

			end

			function removeImages(  )

				m2background:removeSelf( )
				scorercirclegroup:removeSelf( )
				enemy:removeSelf( )
				scorecard:removeSelf( )
				objectivecard:removeSelf( )
				sizepower:removeSelf( )
				shieldpower:removeSelf( )
				solidpower:removeSelf( )
				sizepowercard:removeSelf( )
				shieldpowercard:removeSelf( )
				solidpowercard:removeSelf( )				
				hitscard:removeSelf( )
				boundaries:removeSelf( )
				planet:removeSelf( )
				coincard:removeSelf( )

				if multiplier == true then
					multiplier:removeSelf( )
				end

				if powerup == true then
					powerup:removeSelf( )
				end

				if life == true then
					life:removeSelf( )
				end

				if coins == true then
					coins:removeSelf( )
				end
				
			end

			function stopcounters(  )
				
				timer.cancel( starter )
				timer.cancel( scoretimer1 )				
						
				timer.cancel( xmultipliertimer )
				timer.cancel( poweruptimer )
				timer.cancel( coinstimer )
				timer.cancel( lifetimer )
							
				
				if multipliersathiflag == true then

					timer.cancel( stopmultipliertimer )
					timer.cancel( scoretimer2 )
					print( "multipliersathiflag canceled" )

				end

				if sizesathiflag == true then

					sizepowerdeactivate()
					timer.cancel( sizetimer )

				end
		
			end

			
			stopcounters()
			Removelisteners()
			removeImages()
			farewell()

			
		end

		--------------------------------------------end game----------------------------------------------------------
		function farewell()
			print( "ddfdd"..objective )
			print( "dfadf"..nextobjective )
			
			if objective~= nextobjective then

				farewellobjective = display.newText( "Bonus Coins Earned: "..(nextobjective - objective)/10 + (nextobjective - objective)*nextobjective/10000, centerX, 0.4*centerY, "Arial", 100 )

				farewellobjective:setFillColor( 0.6,0.6,0.6)

				totalcoinsearned = display.newText( "Total Coins Earned: "..(coinsnumber + (nextobjective - objective)/10 + (nextobjective - objective)*nextobjective/10000) - initialcoinnumber, centerX, 0.8*centerY, "Arial", 100 )

				totalcoinsearned:setFillColor( 0.6,0.6,0.6)

			else
				farewellobjective = display.newText( "Bonus Coins Earned: 0", centerX, 0.4*centerY, "Arial", 100 )

				farewellobjective:setFillColor( 0.6,0.6,0.6)

				totalcoinsearned = display.newText( "Total Coins Earned: "..(coinsnumber  - initialcoinnumber), centerX, 0.8*centerY, "Arial", 100 )

				totalcoinsearned:setFillColor( 0.6,0.6,0.6)
			end





			local highscore = highscore_checker(0,score,0,coinsnumber + (nextobjective - objective)/10 + (nextobjective - objective)*nextobjective/10000,gamesizeup,gameshieldup,gamesolidup)
			

			local farewellpagebg =  display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )

				farewellpagebg:setFillColor( 0.933,0.953,0.97 )


			local farewellscore = display.newText( "Score: "..score, centerX, 1.2*centerY, "Arial", 100 )


			farewellscore:setFillColor( 0.6,0.6,0.6)

			local farewellhscore = display.newText( "HighScore: "..highscore, centerX, 1.6*centerY, "Arial", 100 )


			farewellhscore:setFillColor( 0.6,0.6,0.6)

			local farewellgroup = display.newGroup( )

			farewellgroup:insert( farewellpagebg )
			farewellgroup:insert( farewellscore )
			farewellgroup:insert( farewellhscore )
			farewellgroup:insert( farewellobjective )
			farewellgroup:insert( totalcoinsearned )

			local function temptransition(  )
				farewellgroup:removeSelf( )
				makemenu()
			end

			local function farewelltransition(  )

				farewellgroup:removeEventListener( "tap", farewelltransition )
				transition.to(farewellgroup,{time=20, alpha=0.9, onComplete=temptransition})
			end

			farewellgroup:addEventListener( "tap", farewelltransition )

		end
--------------------------------------------------------------------------------remember to turn shinde and the other variable to true

---------------------------------------------- display coins--------------------------------------------

					coincard = display.newText( "Coins: "..coinsnumber	, 1.6*centerX, 0.2*centerY, "Arial", 60 )
					--scorercirclegroup:insert(coincard)
					coincard:setFillColor( 0,0,0 )
	
	end



	gameStart()

	return true
end