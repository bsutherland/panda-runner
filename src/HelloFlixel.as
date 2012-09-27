package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#ffffff")]

	public class HelloFlixel extends FlxGame {
		public function HelloFlixel() {
			// Use a zoom factor of two
			super(320, 240, TitleState, 2);
		}
	}
}