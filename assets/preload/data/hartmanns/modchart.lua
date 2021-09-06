local marea = false
local olas = false
local giros = false
local swayingForce = 1;
local waitForTween = false
local notasD = false
local notasA = false

function start (song)
         print("succesfully initialized our song (hartmann)")
		 
		 aa = makeSprite('Aa','aa', true)
		 setActorX(0,'aa')
		 setActorY(170,'aa')
		 setActorAlpha(0,'aa')
		 setActorScale(1.6,'aa')
		 
		 
end

function setDefault(id)
	swayingForce = 0
	_G['defaultStrum'..id..'X'] = getActorX(id)
	print('angle 0')
	setActorAngle(0,id)
end
function resetTween()
	waitForTween = false
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
	 
	 if cruce then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin(currentBeat * 0.503) + 350, i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin(currentBeat * 0.503) - 275, i)
		end
	end
	 
	 if mareo == true then
		camHudAngle = 5 * math.sin(currentBeat * 0.594)
	end
	 
	 if notasD == true then
	     for i=0,3 do
			tweenFadeOut(i, 0.3, 0.4)
			end
		end
		if notasA == true then
	     for i=0,3 do -- fade out the first 4 receptors (the ai receptors)
			tweenFadeIn(i,1,0.1)
			end
		end
		
	 if olas == true then
		 for i=0,7 do
		     setActorY(defaultStrum0Y + 25 * math.cos((currentBeat + i*0.45) * math.pi), i)
		     tweenPosYAngle(i,getActorY(i) - 120,0,0.5)
		 end
	 end

	 if marea == true then 
		 for i=0,7 do
		setActorX(_G['defaultStrum'..i..'X'] + 50 * math.sin((currentBeat + i*0.25) * math.pi), i)
		setActorY(_G['defaultStrum'..i..'Y'] + 50 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
	end
	
	if giros == true then 
		for i=0,7 do
		 tweenPosXAngle(i, _G['defaultStrum'..i..'X'],setActorAngle(getActorAngle(i) + 5, i))
		end
	end
	
	if girosNormal == true then
	     tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
	     end
		 
	if tsunami == true then
		for i=0,7 do
		     setActorX(_G['defaultStrum'..i..'X'] + 30 * math.sin((currentBeat + i*0.5) * math.pi), i)
	         setActorY(_G['defaultStrum'..i..'Y'] + 30 * math.cos((currentBeat + i*0.5) * math.pi), i)
		     end
		 end
	
    end
	
	
	
	
function beatHit (beat)
         
end

function stepHit (step)
         if curStep == 133 then
             olas = true
		 end
		 
		 if curStep == 390 then
		     olas = false
			 for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'],i)
			setActorAngle(0, i)
            end
			 
			 showOnlyStrums = true
			 resetTween()
	     end

		 if curStep == 500 then
		 
			 notasD = true
	     end

		 if curStep == 527 then
			 marea = true
			 fadeOutAndGo()
		 end
		 
		 if curStep == 655 then
			 giros = true
			 mareo = true
		 end
		 
		 if curStep == 782 then
			 for i = 0, 7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
        end
			 olas = true
			 mareo = false
			 camHudAngle = 0
			 giros = false
			 showOnlyStrums = false
			 notasD = false
			 marea = false
			 olas = true
			 notasA = true
			 fadeInAndGo()
			 resetTween()
			 
			 
		end
		
		if (step >= 912 and step < 1166) then
		cruce = true
		notasD = true
		
		end
		
		if curStep == 1168 then
			 cruce = false
			 notasD = false
			 notasA = true
			 for i=0,3 do
			tweenFadeIn(i, 1, 0.4)
		end
		
			 olas = false
			 showOnlyStrums= true
			 for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'],i)
			setActorAngle(0, i)
            end
			 
			 
		end
		
		if curStep == 1232 then
		
			 giros = true
			 
		 end
		 
		 if curStep == 1312 then 
		 
		     marea = true
			 mareo=true
			 fadeOutAndGo()
			 giros = false
			  for i = 0, 7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
        end
			 
		 end
		 
		 if curStep == 1440 then
		     marea = false
			 
		     tsunami = true
		end
		
		if curStep == 1560 then
		
			 fadeInAndGo()
			 giros = false
			 tsunami = false
			 mareo = false
			 camHudAngle = 0
			 showOnlyStrums = false
			  for i = 0, 7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
        end
			 resetTween()
		 end
		 
	end

function keyPressed (key)

end