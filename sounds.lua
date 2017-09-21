

function sound( name,mute )

	tap = audio.loadSound( "tap.wav")
	pop = audio.loadSound( "pop.mp3")
	ppop = audio.loadSound( "ppop.mp3")
	modeoneloop = audio.loadSound( "modeoneloop.mp3")
	coins = audio.loadSound( "coins.wav")
	explode = audio.loadSound( "explode.wav")
	object = audio.loadSound( "object.wav")
	shield = audio.loadSound( "shield.wav")
	size = audio.loadSound( "size.wav")
	solid = audio.loadSound( "solid.wav")
	modetwoloop = audio.loadSound( "modetwoloop.mp3"  )
	modethreeloop = audio.loadSound( "modethreeloop.mp3"  )
	score= audio.loadSound( "score.wav")
	scoremultiplier = audio.loadSound( "scoremultiplier.wav")


	if mute == false then

		if (name=="tap") then
			audio.play(tap, {loops = 0})
		end
		if (name=="pop") then

			local pooop = math.random( 1,2 )

			if pooop == 1 then
				audio.play(pop, {loops = 0})
			elseif pooop == 2 then
				audio.play(ppop, {loops = 0})
			end
		end

		if (name=="modeoneloop") then
			audio.play( modeoneloop,{loops = -1, channel=1} )
		end

		if (name== "coins") then
			audio.play( coins,{loops = 0})
		end

		if (name== "explode") then
			audio.play( explode,{loops = 0})
		end

		if (name== "object") then
			audio.play( object,{loops = 0})
		end

		if (name== "shield") then
			audio.play( shield,{loops = 0})
		end

		if (name== "size") then
			audio.play( size,{loops = 0})
		end
		if (name== "solid") then
			audio.play( solid,{loops = 0})
		end
		if (name=="modetwoloop") then
			audio.play( modetwoloop,{loops = -1, channel = 1}  )
		end
		if (name=="modethreeloop") then
			audio.play( modethreeloop,{loops = -1, channel = 1}  )
		end
		if (name=="score") then
			audio.play( score,{loops=-1, channel = 2})
		end
		if (name=="scoremultiplier") then
			audio.play( scoremultiplier,{loops=-1, channel = 3})
		end

	end
	
end

