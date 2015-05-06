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
			"Head Count:         ",
			"Toes Tagged:        ",
			"Unlucky Punks:      ",
			"Foes Vanquished:    ",
			"Subjects Terminated:",
		];
		
		public function GameOverState(game:GameStruct) {
			this.game = game;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			var fmt:String = 
			    "          *** GAME OVER ***\n\n" +
				"      Level Reached:        %3d\n\n" +
				"      Coins Collected:      %3d\n\n" +
				"      %s  %3d";
			var fmtd:String = printf(fmt, game.level, game.coins, FlxU.getRandom(DEATH_NOTES), game.kills);
			var msg:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, fmtd);
			msg.alignment = "left";
			msg.font = "Adore64";
			msg.size = 8;
			add(msg);
			FlxG.play(Resources.SndGameOver);
		}
	}
}