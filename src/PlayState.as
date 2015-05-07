package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 8;
		
		protected var player:Panda;
		protected var herd:FlxGroup;
		protected var splosionSnd:FlxSound;
		protected var statusTxt:FlxText;
		protected var game:GameStruct;
		
		override public function PlayState(game:GameStruct) {
			this.game = game;
		}

		override public function create():void {
			FlxG.bgColor = 0xff009900;
			spawnPlayer();
			createHerd();
			createStatusDisplay();
			updateStatus();
		}
		
		protected function spawnPlayer():void {
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			//FlxG._game.rotationZ = 180.0;
		}
		
		protected function createStatusDisplay():void {
			var sk:FlxSprite = new Skull(); sk.x = 2; sk.y = 3;
			var cn:FlxSprite = new Coin();  cn.x = 2; cn.y = 13;
			var ph:FlxSprite = new FlxSprite(); ph.loadGraphic(Resources.ImgPandaHead); ph.x = 2; ph.y = 23;
			add(sk); add(cn); add(ph)
			statusTxt = new FlxText(12, 0, FlxG.width);	
			add(statusTxt);
		}

		protected function updateStatus():void {
			statusTxt.text = herd.countLiving() + '\n'
				+ game.coins + '\n'
				+ game.lives;
		}		
		
		protected function createHerd():void {
			herd = new FlxGroup(HERD_SIZE + game.level);
			for (var k:uint = 0; k < game.level - 1; k += 2) {
				createCritter(herd, GoldBison);
			}
			for (var j:uint = 0; j < game.level; j++) {
				createCritter(herd, SilverBison);
			}			
			for (var i:uint = 0; i < HERD_SIZE; i++) {
				createCritter(herd, Bison);
			}
			add(herd);
		}
		
		protected function createCritter(herd:FlxGroup, species:Class):void {
			var bison:Bison = new species(
				FlxG.random() * (FlxG.width),
				FlxG.random() * (FlxG.height),
				player
			);
			herd.add(bison);			
		}
		
		override public function update():void {
			if (!player.flickering) {
				FlxG.overlap(herd, player, gotcha);
			}
			super.update();
		}
		
		protected function gotcha(bison:Bison, playa:Panda):void {
			if (bison.facing == playa.facing) {
				asplode(bison, playa, Coin, bison.coins);
				game.kills++;
			} else {
				asplode(playa, bison, Heart, 10);
				game.lives--;
				new FlxTimer().start(4, 1, playerDied);
			}
			updateStatus();
		}
		
		protected function asplode(loser:FlxSprite, winna:FlxSprite, img:Class, n:uint):void {
			FlxG.play(Resources.SndExplode, 0.7);
			var splosion:Splosion = new Splosion(winna.x + winna.width / 2, winna.y, img, n);
			loser.kill();
			loser.destroy();			
			add(splosion);
			splosion.start(true, 1000);
		}
		
		// callbacks
		
		public function playerDied(t:FlxTimer):void {
			t.stop(); t.destroy();
			if (game.lives > 0) {
				spawnPlayer();
			} else {
				FlxG.switchState(new GameOverState(game));
			}
		}
		
		public function pennyDropped():void {
			game.coins++;
			if (0 == game.coins % 100) {
				FlxG.play(Resources.Snd1Up);
				game.lives++;
			}
			updateStatus();
			if (herd.countLiving() < 1) {
				new FlxTimer().start(4, 1, nextLevel);
				// play a little tune or something
			}
		}
		
		public function nextLevel(t:FlxTimer):void {
			t.stop();
			t.destroy();
			game.level++;
			FlxG.switchState(new IntermissionState(game));
		}
	}
}