package  
{
	import org.flixel.*;
	import Resources;
	
	public class Bison extends FlxSprite
	{	
		public const MAX_VEL:uint = 150;
		public const DASH_CHANCE:Number = 0.002;
		public const DASH_TIME:Number = 0.5;
		public const SIZE:uint = 13;
		public const RUNNING:String = "running";
		public const STANDING:String = "standing";
		public var coins:uint;
		
		protected var _player:FlxSprite;
		
		public const SECS_PREPARE_TO_RUN:Number = 1;
		private var _secsUntilRun:Number;
		private var _speechBubble:SpeechBubble;

		public function Bison(X:int, Y:int, player:FlxSprite) {
			super(X, Y);
			loadGraphic(Resources.ImgBisonAnim, true, true, SIZE, SIZE);	// animated, reversible
			addAnimation(RUNNING, [0, 1], 8, true);
			addAnimation(STANDING, [0], 0, false);
			play(STANDING);
			facing = (FlxG.random() < 0.5) ? LEFT : RIGHT;
			color = 0xcc3300; // regular ranga bison
			coins = 2 + FlxG.random() * 3; // 2 to 4 coins
			_secsUntilRun = -1;
			_speechBubble = null;
			_player = player;
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
		
		override public function kill():void {
			if (null != _speechBubble) {
				_speechBubble.killAndDestroy();
			}
			super.kill();
		}
		
		public function isRunning():Boolean {
			return RUNNING == _curAnim.name;
		}
		
		public function isIdling():Boolean {
			return !isRunning() && _secsUntilRun < 0;
		}
		
		protected function prepareToRun():void {
			FlxG.play(Resources.SndBah, 0.7);
			_speechBubble = new SpeechBubble();
			_speechBubble.x = LEFT == facing ? x - _speechBubble.width : x + width;
			_speechBubble.y = y;
			_speechBubble.facing = facing;
			FlxG.state.add(_speechBubble);
			_secsUntilRun = SECS_PREPARE_TO_RUN;
		}
		
		protected function runAi():void {
			if (isIdling()) { // Artificial unintelligence
				if (FlxG.random() < DASH_CHANCE) {
					prepareToRun();
				}
			} else if (_secsUntilRun >= 0) {
				_secsUntilRun -= FlxG.elapsed;
				if (_secsUntilRun < 0) {
					_speechBubble.killAndDestroy();
					randomDash();
				}
			}
		}

		protected function randomDash():void {
			velocity.x = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			velocity.y = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			dash(DASH_TIME, halt);			
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