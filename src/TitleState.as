package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	public class TitleState extends FlxState {
		
		[Embed(source = "../img/title.png")] private var ImgTitle:Class;
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			var title:FlxSprite = new FlxSprite(0, 0);
			title.loadGraphic(ImgTitle);
			FlxG.flash(0xffffffff, 1);			
			add(title);
		}
		override public function update():void {
			if (FlxG.keys.SPACE) {
				FlxG.switchState(new IntermissionState(1));
			}
		}
	}

}