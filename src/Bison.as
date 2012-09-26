package  
{
	import org.flixel.*;
	
	public class Bison extends FlxSprite
	{	
		public const MAX_VEL:uint = 150;
		public const DASH_CHANCE:Number = 0.001;
		public const DASH_TIME:Number = 0.5;
		public const SIZE:uint = 13;
		public const RUNNING:String = "running";
		public const STANDING:String = "standing";
		public var coins:uint;
		
		[Embed(source = "../img/bison_cropped.png")] private var ImgA:Class;
		[Embed(source = "../snd/goatbah.mp3")] private var SndBah:Class;
	
		public function Bison(X:int, Y:int) {
			super(X, Y);
			loadGraphic(ImgA, true, true, SIZE, SIZE);	// animated, reversable
			addAnimation(RUNNING, [0, 1], 8, true);
			addAnimation(STANDING, [0], 0, false);
			play(STANDING);
			facing = (FlxG.random() < 0.5) ? LEFT : RIGHT;
			color = 0xcc3300; // regular ranga bison
			coins = 3 + FlxG.random() * 3; // 3 to 5 coins
		}
		
		override public function update():void {				
			runAi();
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
		
		public function isRunning():Boolean {
			return RUNNING == _curAnim.name;
		}		
		
		protected function runAi():void {
			if (!isRunning()) { // Artificial unintelligence
				if (FlxG.random() < DASH_CHANCE) {
					FlxG.play(SndBah);
					velocity.x = FlxG.random() * MAX_VEL - MAX_VEL / 2;
					velocity.y = FlxG.random() * MAX_VEL - MAX_VEL / 2;
					dash(DASH_TIME, halt);
				}
			}			
		}
		
		protected function dash(time:Number, callback:Function):void {			
			play(RUNNING);
			facing = velocity.x < 0 ? LEFT : RIGHT;
			var stop:FlxTimer = new FlxTimer();
			stop.start(time, 1, callback);
		}
		
		protected function halt(t:FlxTimer):void {
			velocity.x = 0;
			velocity.y = 0;
			play(STANDING);
			t.stop();
			t.destroy();			
		}
	}

}