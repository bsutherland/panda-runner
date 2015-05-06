package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#ffffff")]

	public class PandaRunner extends FlxGame {
		public function PandaRunner() {
			// Use a zoom factor of two
			super(320, 240, TitleState, 2);
		}
	}
}