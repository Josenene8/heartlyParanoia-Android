local olas = false
function start (song)

end


function fadeInAndGo()

	
    end
	
function update (elapsed)
     local currentBeat = (songPos / 1000)*(bpm/196)
	 
	 if olas == true then
		 for i=0,7 do
		     setActorY(defaultStrum0Y + 2 * math.cos((currentBeat + i*0.45) * math.pi), i)
		     tweenPosYAngle(i,getActorY(i) - 80,0,0.5)
		 end
		end
	if mover == true then 
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 22 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 22 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
		end
	 end
	
	
function beatHit (beat)
         
end

function stepHit (step)
	if curStep == 516 then
		 olas = true
		 mover = true
   
	end
end
function keyPressed (key)

end