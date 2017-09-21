require( "modeone")
require( "modetwo")
require( "modethree")


function levelchecker( modes,score )

	if modes=="modeone" and highscore1>= score then
		nextobjective = (math.floor(highscore1/100) +1 )*100
	elseif modes=="modeone" and highscore1< score then
		nextobjective = (math.floor(score/100) +1 )*100
	elseif modes=="modetwo" and highscore2>= score then
		nextobjective = (math.floor(highscore2/100) +1 )*100
	elseif modes=="modetwo" and highscore2< score then
		nextobjective = (math.floor(score/100) +1 )*100
	elseif modes=="modethree" and highscore3>= score then
		nextobjective = (math.floor(highscore3/100) +1 )*100
	elseif modes=="modethree" and highscore3< score then
		nextobjective = (math.floor(score/100) +1 )*100
	end

	return nextobjective
	
end	