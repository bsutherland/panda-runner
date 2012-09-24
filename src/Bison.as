package  
{
	import org.flixel.*;
	
	public class Bison extends FlxSprite
	{
	
		public const MAX_VEL:uint = 150;
		
		[Embed(source = "../img/bison_frames.png")] private var ImgA:Class;
		[Embed(source = "../snd/goatbah.mp3")] private var SndBah:Class;
		
		public var bahSnd:FlxSound;
		
		public function Bison(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(ImgA, true, true);	// animated, reversable
			addAnimation("walking", [0, 1], 4, true);
			addAnimation("standing", [0], 0, false);
			play("standing");
			bahSnd = new FlxSound();
			bahSnd.loadEmbedded(SndBah, false);
			facing = (FlxG.random() < 0.5) ? LEFT : RIGHT;
		}
		
		override public function update():void
		{				
			if (velocity.x != 0 || velocity.y != 0) {
				if (FlxG.random() < 0.1 && !bahSnd.active) {
					bahSnd.play();
				}
			}
				
			super.update();
		}
		
	}

}