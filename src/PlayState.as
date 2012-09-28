package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 10;
		[Embed(source = "../img/heart.png")] private var ImgHeart:Class;
		[Embed(source = "../snd/splosion.mp3")] private var SndExplode:Class;
		[Embed(source = "../img/panda_head.png")] private var ImgPandaHead:Class;
		
		public var player:Panda;
		public var herd:FlxGroup;
		public var splosionSnd:FlxSound;
		public var statusTxt:FlxText;
		public var game:GameStruct;
		
		override public function PlayState(game:GameStruct) {
			this.game = game;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff009900;
			createHerd();
			spawnPlayer();
			createStatusDisplay();
			updateStatus();
		}
		
		protected function spawnPlayer():void {
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
		}
		
		protected function createStatusDisplay():void {
			var sk:FlxSprite = new Skull(); sk.x = 2; sk.y = 3;
			var cn:FlxSprite = new Coin();  cn.x = 2; cn.y = 13;
			var ph:FlxSprite = new FlxSprite(); ph.loadGraphic(ImgPandaHead); ph.x = 2; ph.y = 23;
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
			herd = new FlxGroup(HERD_SIZE);
			for (var i:uint = 0; i < HERD_SIZE; i++) {
				var r:Number = FlxG.random();
				var species:Class = r < 0.8 ? Bison : SilverBison;
				var bison:Bison = new species(
					FlxG.random() * (FlxG.width),
					FlxG.random() * (FlxG.height));
				herd.add(bison);
			}
			add(herd);
		}
		
		override public function update():void {
			FlxG.overlap(herd, player, gotcha);
			super.update();
		}
		
		protected function gotcha(bison:Bison, playa:Panda):void {
			if (bison.facing == playa.facing) {
				asplode(bison, playa, Coin, bison.coins);
			} else {
				asplode(playa, bison, Heart, 10);
				new FlxTimer().start(5, 1, playerDied);
			}
			updateStatus();
		}
		
		protected function asplode(loser:FlxSprite, winna:FlxSprite, img:Class, n:uint):void {
			FlxG.play(SndExplode);
			var splosion:Splosion = new Splosion(winna.x + winna.width / 2, winna.y, img, n);
			loser.kill();	
			add(splosion);
			splosion.start(true, 1000);	
		}
		
		// callbacks
		
		public function playerDied(t:FlxTimer):void {
			t.stop(); t.destroy();
			game.lives--;
			if (game.lives > 0) {
				spawnPlayer();
			} else {
				//FlxG.switchState(new GameOverState(game));
			}
		}
		
		public function pennyDropped():void {
			game.coins++;
			updateStatus();
			if (herd.countLiving() < 1) {
				new FlxTimer().start(5, 1, nextLevel);
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