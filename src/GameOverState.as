package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class GameOverState extends FlxState {
		// TODO: This needs to be animated and moar cool
		// TODO: Refactor all embedded files into a single static class??
		
		[Embed(source = "../font/adore64.ttf", fontFamily = "Adore64", embedAsCFF = "false")] private var FontC64:Class;
		
		protected var game:GameStruct;
		protected const DEATH_NOTES:Array = [
			"Head Count",
			"Toes Tagged",
			"Unlucky Punks",
			"Foes Vanquished",
			"Subjects Terminated",
		];
		
		public function GameOverState(game:GameStruct) {
			this.game = game;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			var msg:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width,
				"Level Reached:   " + game.level + "\n" +
				"Coins Collected: " + game.coins + "\n" +
				FlxU.getRandom(DEATH_NOTES)+ ": " + game.kills);
			msg.alignment = "left";
			msg.font = "Adore64";
			msg.size = 8;
			add(msg);
		}
	}
}