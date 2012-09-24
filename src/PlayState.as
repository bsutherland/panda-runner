package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var player:Panda;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff009900;
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			add(new FlxText(0, 0, 100, "Tomato Boots"));
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}