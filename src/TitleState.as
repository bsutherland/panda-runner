package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	public class TitleState extends FlxState {
		
		public var starting:Boolean;
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			var title:FlxSprite = new FlxSprite(0, 0);
			title.loadGraphic(Resources.ImgTitle);
			FlxG.play(Resources.SndWoosh);
			FlxG.flash(0xffffffff, 1, showFlashingMessage);
			add(title);
			starting = false;
		}
		
		override public function update():void {
			if (FlxG.keys.SPACE && !starting) {
				starting = true;
				FlxG.play(Resources.SndStart);
				FlxG.fade(0xff000000, 3, startGame);
			}
		}
		
		private function showFlashingMessage():void {
			var txt:FlxText = new FlxText(0, 180, FlxG.width, 'Push space to begin');
			txt.alignment = 'center';
			txt.font = "Adore64";
			txt.size = 8;
			txt.flicker();
			add(txt);
		}
		
		private function startGame():void {
			FlxG.switchState(new IntermissionState(new GameStruct()));			
		}
	}

}