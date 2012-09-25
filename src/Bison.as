package  
{
	import org.flixel.*;
	
	public class Bison extends FlxSprite
	{	
		public const MAX_VEL:uint = 150;
		public const DASH_CHANCE:Number = 0.001;
		public const DASH_TIME:Number = 0.5;
		public const SIZE:uint = 13;
		
		[Embed(source = "../img/bison_cropped.png")] private var ImgA:Class;
		[Embed(source = "../snd/goatbah.mp3")] private var SndBah:Class;
		
		private var stopAt:uint;
		
		public function Bison(X:int, Y:int) {
			super(X, Y);
			loadGraphic(ImgA, true, true, SIZE, SIZE);	// animated, reversable
			addAnimation("running", [0, 1], 8, true);
			addAnimation("standing", [0], 0, false);
			play("standing");
			facing = (FlxG.random() < 0.5) ? LEFT : RIGHT;
		}
		
		public function isRunning():Boolean {
			return "running" == _curAnim.name;
		}
		
		override public function update():void {				
			if (!isRunning()) {
				if (FlxG.random() < DASH_CHANCE) {
					dash();
				}
			}
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
		
		protected function halt(t:FlxTimer):void {
			velocity.x = 0;
			velocity.y = 0;
			play("standing");
			t.stop();
			t.destroy();			
		}
		
		protected function dash():void {
			FlxG.play(SndBah);
			velocity.x = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			velocity.y = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			play("running");
			facing = velocity.x < 0 ? RIGHT : LEFT;
			var stop:FlxTimer = new FlxTimer();
			stop.start(DASH_TIME, 1, halt);
		}
	}

}