package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import Resources;
	
	public class GameOverState extends FlxState {
		// TODO: This needs to be animated and moar cool
		
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
			    "                 GAME OVER" + "\n\n" +
				"         Level Reached:   " + game.level + "\n\n" +
				"         Coins Collected: " + game.coins + "\n\n" +
				"         " + FlxU.getRandom(DEATH_NOTES)+ ": " + game.kills);
			msg.alignment = "left";
			msg.font = "Adore64";
			msg.size = 8;
			add(msg);
		}
	}
}