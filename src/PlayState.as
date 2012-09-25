package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 10;
		[Embed(source = "../img/heart.png")] private var ImgHeart:Class;
		[Embed(source = "../snd/splosion.mp3")] private var SndExplode:Class;
		
		public var player:Panda;
		public var herd:FlxGroup;
		public var splosionSnd:FlxSound;
		public var statusTxt:FlxText;
		public var coins:uint;
		
		override public function create():void {
			FlxG.bgColor = 0xff009900;
			coins = 0;
			createHerd();
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			statusTxt = new FlxText(0, 0, FlxG.width);
			add(statusTxt);
			updateStatus();
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
				asplode(bison, playa, Coin);
			} else {
				asplode(playa, bison, Heart);
			}
			updateStatus();
		}
		
		protected function updateStatus():void {
			statusTxt.text = "Herd size: " + herd.countLiving()
			               + "\nCoins: " + coins;
		}
		
		protected function asplode(loser:FlxSprite, winna:FlxSprite, img:Class):void {
			FlxG.play(SndExplode);
			var splosion:Splosion = new Splosion(winna.x + winna.width / 2, winna.y, img);
			loser.kill();	
			add(splosion);
			splosion.start(true, 1000);	
		}
		
		public function pennyDropped():void {
			coins++;
			updateStatus();
		}
	}
}