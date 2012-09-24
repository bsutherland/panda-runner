package  
{
	import org.flixel.*;
	
	public class PlayerChar extends FlxSprite
	{
	
		public const MAX_VEL:uint = 100;
		
		[Embed(source = "../img/tomato_boots.png")] private var ImgPlayer:Class;
		[Embed(source = "../snd/step.mp3")] private var SndStep:Class;
		
		public var stepSound:FlxSound;
		
		public function PlayerChar(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(ImgPlayer, false);
			stepSound = new FlxSound();
			stepSound.loadEmbedded(SndStep, true);
		}
	
		override public function update():void
		{
			velocity.x = velocity.y = 0;
			if (FlxG.keys.LEFT)
				velocity.x -= MAX_VEL;
			if (FlxG.keys.RIGHT)
				velocity.x += MAX_VEL;
			if (FlxG.keys.UP)
				velocity.y -= MAX_VEL;
			if (FlxG.keys.DOWN)
				velocity.y += MAX_VEL;
				
			if (velocity.x != 0 || velocity.y != 0)
				stepSound.play();
			else
				stepSound.stop();				
				
			super.update();
			
			if (x > FlxG.width - width)
				x = FlxG.width - width;
			else if (x < 0)
				x = 0;
			if (y > FlxG.height - height)
				y = FlxG.height - height;
			else if (y < 0)
				y = 0;
		}
	}

}