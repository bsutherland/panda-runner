package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class SpeechBubble extends FlxSprite {
		
		public function SpeechBubble() {
			super();
			// reversible
			loadGraphic(Resources.ImgSpeechBubble, false, true);
		}
		
		public function killAndDestroy():void {
			kill(); destroy();
		}
	}
}