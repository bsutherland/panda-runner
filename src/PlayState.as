package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 10;
		[Embed(source = "../img/heart.png")] private var ImgHeart:Class;
		[Embed(source = "../snd/splosion.mp3")] private var SndExplode:Class;
		
		public var level:uint;
		public var player:Panda;
		public var herd:FlxGroup;
		public var splosionSnd:FlxSound;
		public var statusTxt:FlxText;
		public var coins:uint;
		
		override public function PlayState(level:uint) {
			this.level = level;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff009900;
			coins = 0;
			createHerd();
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			createStatusDisplay();
			updateStatus();
		}
		
		protected function createStatusDisplay():void {
			var sk:FlxSprite = new Skull(); sk.x = 2; sk.y = 3;
			var cn:FlxSprite = new Coin();  cn.x = 2; cn.y = 13;
			add(sk);
			add(cn);
			statusTxt = new FlxText(12, 0, FlxG.width);	
			add(statusTxt);
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
			}
			updateStatus();
		}
		
		protected function updateStatus():void {
			statusTxt.text = herd.countLiving() + "\n" + coins;
		}
		
		protected function asplode(loser:FlxSprite, winna:FlxSprite, img:Class, n:uint):void {
			FlxG.play(SndExplode);
			var splosion:Splosion = new Splosion(winna.x + winna.width / 2, winna.y, img, n);
			loser.kill();	
			add(splosion);
			splosion.start(true, 1000);	
		}
		
		public function pennyDropped():void {
			coins++;
			updateStatus();
			if (herd.countLiving() < 1) {
				new FlxTimer().start(5, 1, nextLevel);
			}
		}
		
		public function nextLevel(t:FlxTimer):void {
			t.stop();
			t.destroy();
			FlxG.switchState(new IntermissionState(level + 1));
		}
	}
}