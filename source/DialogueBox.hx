package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var portraitLeftVacio:FlxSprite;
	var portraitLeftKoishi:FlxSprite;
	var portraitLeftKoishiHappy:FlxSprite;
	var portraitLeftKoishiWeird:FlxSprite;
	var portraitRightBf:FlxSprite;
	var portraitRightGf:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'heart-stirring':
				FlxG.sound.playMusic(Paths.music('based', "koishi"), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'unknown-x':
				FlxG.sound.playMusic(Paths.music('based', "koishi"), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'hartmanns':
				FlxG.sound.playMusic(Paths.music('based', "koishi"), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(400, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('ui/dialogueBox','koishi');
				box.animation.addByPrefix('normalOpen', 'dialogue_box', 24, false);
				box.animation.addByIndices('normal', 'dialogue_box', [1],"" , 24);
				box.x = 250;
				box.y = 380;

			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);


		}
		

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftVacio = new FlxSprite(-20, 40);
		portraitLeftVacio.frames = Paths.getSparrowAtlas('portraits/vacioPortrait', 'koishi');
		portraitLeftVacio.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftVacio.updateHitbox();
		portraitLeftVacio.scrollFactor.set();
		add(portraitLeftVacio);
		portraitLeftVacio.visible = false;

		portraitLeftKoishi = new FlxSprite(-20, 40);
		portraitLeftKoishi.frames = Paths.getSparrowAtlas('portraits/koishiPortrait', 'koishi');
		portraitLeftKoishi.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftKoishi.updateHitbox();
		portraitLeftKoishi.scrollFactor.set();
		add(portraitLeftKoishi);
		portraitLeftKoishi.visible = false;

		portraitLeftKoishiHappy = new FlxSprite(-20, 40);
		portraitLeftKoishiHappy.frames = Paths.getSparrowAtlas('portraits/koishiPortraitHappy', 'koishi');
		portraitLeftKoishiHappy.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftKoishiHappy.updateHitbox();
		portraitLeftKoishiHappy.scrollFactor.set();
		add(portraitLeftKoishiHappy);
		portraitLeftKoishiHappy.visible = false;

		portraitLeftKoishiWeird = new FlxSprite(-20, 40);
		portraitLeftKoishiWeird.frames = Paths.getSparrowAtlas('portraits/koishiPortraitWeird', 'koishi');
		portraitLeftKoishiWeird.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftKoishiWeird.updateHitbox();
		portraitLeftKoishiWeird.scrollFactor.set();
		add(portraitLeftKoishiWeird);
		portraitLeftKoishiWeird.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitRightBf = new FlxSprite(0, 40);
		portraitRightBf.frames = Paths.getSparrowAtlas('portraits/bfPortrait', 'koishi');
		portraitRightBf.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBf.updateHitbox();
		portraitRightBf.scrollFactor.set();
		add(portraitRightBf);
		portraitRightBf.visible = false;

		portraitRightGf = new FlxSprite(0, 40);
		portraitRightGf.frames = Paths.getSparrowAtlas('portraits/gfPortrait', 'koishi');
		portraitRightGf.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightGf.updateHitbox();
		portraitRightGf.scrollFactor.set();
		add(portraitRightGf);
		portraitRightGf.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 1));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
			{
				//box.flipX = false;
			}
		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Laila Bold';
		dropText.color = 0xFF1C1B17;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Laila Bold';
		swagDialogue.color = 0x1C1B17;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
                #if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end
		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'hartmanns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitLeftVacio.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitRightGf.visible = false;
				portraitLeftKoishi.visible = false;
				portraitLeftKoishiHappy.visible = false;
				portraitLeftKoishiWeird.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'koishi':
				portraitLeftVacio.visible = false;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitRightGf.visible = false;
				portraitLeftKoishiHappy.visible = false;
				portraitLeftKoishiWeird.visible = false;

				if (!portraitLeftKoishi.visible)
				{
					portraitLeftKoishi.visible = true;
					portraitLeftKoishi.animation.play('enter');
				}
				
			case 'koishiHappy':
				portraitLeftVacio.visible = false;
				portraitLeft.visible = false;
				portraitLeftKoishi.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitRightGf.visible = false;
				portraitLeftKoishiWeird.visible = false;

				if (!portraitLeftKoishiHappy.visible)
				{
					portraitLeftKoishiHappy.visible = true;
					portraitLeftKoishiHappy.animation.play('enter');
				}

			case 'koishiWeird':
				portraitLeftVacio.visible = false;
				portraitLeft.visible = false;
				portraitLeftKoishi.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitRightGf.visible = false;
				portraitLeftKoishiHappy.visible = false;

				if (!portraitLeftKoishiWeird.visible)
				{
					portraitLeftKoishiWeird.visible = true;
					portraitLeftKoishiWeird.animation.play('enter');
				}

			case 'bfPixel':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bf':
					portraitLeftVacio.visible = false;
					portraitLeft.visible = false;
					portraitLeftKoishi.visible = false;
					portraitLeftKoishiHappy.visible = false;
					portraitRight.visible = false;
					portraitRightGf.visible = false;
					portraitLeftKoishiWeird.visible = false;
	
					if (!portraitRightBf.visible)
					{
						portraitRightBf.visible = true;
						portraitRightBf.animation.play('enter');
					}
			
			case 'gf':
				portraitLeftVacio.visible = false;
				portraitLeft.visible = false;
				portraitLeftKoishi.visible = false;
				portraitLeftKoishiHappy.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitLeftKoishiWeird.visible = false;
	
				if (!portraitRightGf.visible)
				{
					portraitRightGf.visible = true;
					portraitRightGf.animation.play('enter');
				}
			case "vacio":
				portraitRightGf.visible = false;
				portraitLeft.visible = false;
				portraitLeftKoishi.visible = false;
				portraitLeftKoishiHappy.visible = false;
				portraitRight.visible = false;
				portraitRightBf.visible = false;
				portraitLeftKoishiWeird.visible = false;
	
				if (!portraitLeftVacio.visible)
				{
					portraitLeftVacio.visible = true;
					portraitLeftVacio.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
