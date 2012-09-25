package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class Skull extends FlxSprite {
		[Embed(source = "../img/bison_skull.png")] private var ImgSkull:Class;	
		
		public function Skull() {
			super();
			loadGraphic(ImgSkull);
		}
	}
}