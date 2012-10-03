package  
{
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	
	public class IntermissionState extends FlxState {
		
		public const FADE_TIME:uint = 1;
		public const SHOW_TIME:uint = 1;
		public var game:GameStruct;
		
		override public function IntermissionState(game:GameStruct) {
			this.game = game;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			var msg:FlxText = new FlxText(0, (FlxG.height - 8) / 2, FlxG.width, "Level " + game.level);
			msg.alignment = "center";
			add(msg);
			FlxG.flash(0xff000000, FADE_TIME, pauseTimer);
		}
		
		public function pauseTimer():void {
			new FlxTimer().start(SHOW_TIME, 1, fadeOut);
		}
		
		public function fadeOut(t:FlxTimer):void {
			t.stop();
			t.destroy();
			FlxG.fade(0xff000000, FADE_TIME, startLevel);
		}
		
		public function startLevel():void {
			FlxG.switchState(new PlayState(game));
		}
	}

}