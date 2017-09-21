function encrypt(input)

	local chars= { string.byte(input,1,#tostring(input))}

	local	series = ""

	for i = 1,#tostring(input) do

		local function twlfconfirm(tag)

			if string.len(tag)<15 then
				tag = tag + 10^-12*1111

			elseif string.len(tag)>15 then
				tag = math.floor(tag*10^12)/10^12	
			end	
			return tag

		end
		series = series..string.reverse(twlfconfirm(tostring(math.log(2*chars[i]^3)))*10^12)

	end

	return string.reverse(series)


end


function decrypt( series )

	local init = 1
	local final = 14
	local hashed = {}
	answer=""
	series = string.reverse(series)
	for i=1,string.len( series )/15 + 1 do

		
		hashed[i]=string.reverse(string.sub( series,init,final ))*10^-12
		init = final+1
		final = init + 13	
		hashed[i]=string.char(math.exp((hashed[i]-math.log(2))/3))
		answer=answer..hashed[i]
	end

	return answer
end


function encryptRSA(input)
	local enc = 1
	local p=161
	local n=1825507 ----------------------------------------------------------> add a condition for score and coins less than n
	for i = 1, p do
	enc= (enc * input)%n 
end
	
	return enc 


end


function decryptRSA( serie )
	local dec = 1
	local priv=11321
	local n =1825507
	for i = 1, priv do
	dec= (dec * serie)%n
end
	if (dec>99999) then
		return 0
	else
	return dec
	end 
end




--------------------========================================================================================================
function filenamenpath(  )
	
	filepath = system.pathForFile( "MAHRS.TRA" ,system.DocumentsDirectory )


	file = io.open( filepath, "r" )

	return file
end

function createfile(  )
			
		
			print( "Creating file..." )
			file = io.open( filepath, "w" )
			file:write((encryptRSA(0)).."\n")---------------score1
			file:write((encryptRSA(0)).."\n")------------------score2
			file:write((encryptRSA(0)).."\n")-----------------score3
			file:write((encryptRSA(0)).."\n")--------------------coins
			file:write((encryptRSA(10)).."\n")-----------------size
			file:write((encryptRSA(10)).."\n")------------------shield
			file:write((encryptRSA(10)).."\n")---------------------solid
			io.close( file )

end

function scanvariables()

			local contents = (file:read( "*l" ))

			highscore1 = tonumber((decryptRSA(contents)) )

			local contents = (file:read( "*l"))

			highscore2 = tonumber((decryptRSA(contents)) )

			local contents = (file:read( "*l"))

			highscore3 = tonumber((decryptRSA(contents)) )

		 	local contents = (file:read( "*l"))

			coinsnumber = tonumber((decryptRSA(contents)) )

		 	local contents = (file:read( "*l"))

			gamesizeup = tonumber((decryptRSA(contents)) )

			local contents = (file:read( "*l"))

			gameshieldup = tonumber((decryptRSA(contents)) )
		 
			local contents = (file:read( "*l"))

			gamesolidup = tonumber((decryptRSA(contents)) )

			io.close( file )

end



function highscore_checker(score1,score2,score3,coins,size,shield,solid)

	filepath = system.pathForFile( "MAHRS.TRA" ,system.DocumentsDirectory )
	local centerX = display.contentCenterX
	local centerY = display.contentCenterY


	file = filenamenpath()


	if file then
		
		scanvariables()

		

				if score1 > highscore1 then
					highscore1 = score1
				else 
					highscore1 = highscore1
				end

				if score2 > highscore2 then
					highscore2 = score2
				else
					highscore2 = highscore2
				end

				if score3 > highscore3 then
					highscore3 = score3
				else
					highscore3 = highscore3
				end



					coinsnumber = coins
					gamesizeup = size
					gameshieldup = shield
					gamesolidup = solid

					local file = io.open( filepath, "w" )
					file:write( (encryptRSA(highscore1)).."\n")
					file:write( (encryptRSA(highscore2)).."\n")
					file:write( (encryptRSA(highscore3)).."\n")
					file:write( (encryptRSA(coinsnumber)).."\n")
					file:write( (encryptRSA(gamesizeup)).."\n")
					file:write( (encryptRSA(gameshieldup)).."\n")
					file:write( (encryptRSA(gamesolidup)).."\n")
					io.close( file )


	else

				createfile()
	end

	if score1 ~= 0 then
		return highscore1
	elseif score2 ~= 0 then
		return highscore2
	elseif score3 ~=0 then
		return highscore3
	end

end



