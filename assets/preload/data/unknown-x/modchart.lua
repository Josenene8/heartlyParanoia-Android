
function start (song)

end

function fadeOutAndGo() 
	move = false
	changeBoyfriendCharacter("bfWeird", 850, 595)
	changeDadCharacter("mary", 25, 450)
	tweenFadeIn('girlfriend', 0, 0.1)
end

function fadeInAndGo()
	move = false
	changeDadCharacter("koishi", 25, 450)
	changeBoyfriendCharacter("bf", 850, 595)
	tweenFadeIn('girlfriend', 1, 0.1)
end
	
function update (elapsed)
     local currentBeat = (songPos / 1000)*(bpm/196)	
	 
	 
	 
	 if mareo == true then
		camHudAngle = 5 * math.sin(currentBeat * 0.504)
	end
	 
	 if cruce then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin(currentBeat * 0.503) + 350, i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin(currentBeat * 0.503) - 275, i)
		end
	end
	 if notasD == true then
	     for i=0,3 do
			tweenFadeOut(i, 0.3, 0.4)
			end
		end
	 if moverDad == true then
	 for i=0,3 do
            setActorY(defaultStrum0Y + 25 * math.cos((currentBeat + i*0.45) * math.pi), i)
		     tweenPosYAngle(i,getActorY(i) - 100,0,0.5)
			 end
		 end
	if moverAll == true then
	for i=0,7 do
            setActorY(defaultStrum0Y + 25 * math.cos((currentBeat + i*0.45) * math.pi), i)
		     tweenPosYAngle(i,getActorY(i) - 100,0,0.5)
			 end
		 end
		
	 
end	
	
function beatHit (beat)
         
end

function stepHit (step)
	if curStep == 3 then
		fadeOutAndGo()
		end
		
	if curStep == 18 then
		fadeInAndGo()
		end
		
	if curStep == 400 then
		moverDad = true
		 end
		 
	if curStep == 528 then
		 moverAll = true
		 end
	if curStep == 960 then
		cruce = true
		notasD = true
		end
	if curStep == 1040 then
		cruce = false
		notasD = false
		
	if curStep == 1104 then
		mareo = true
		end
	if curStep == 1294 then
		mareo = false
		end
	end
end
function keyPressed (key)

end