package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	public class QuickPlayState extends FlxState {
		
		override public function create():void {
			FlxG.switchState(new PlayState(new GameStruct()));
		}
	}

}