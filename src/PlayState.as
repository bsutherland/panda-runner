package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 10;
		[Embed(source = "../img/coin.png")] private var ImgCoin:Class;
		[Embed(source = "../img/heart.png")] private var ImgHeart:Class;
		[Embed(source = "../snd/splosion.mp3")] private var SndExplode:Class;
		
		public var player:Panda;
		public var herd:FlxGroup;
		public var splosionSnd:FlxSound;
		
		override public function create():void {
			FlxG.bgColor = 0xff009900;
			createHerd();
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			add(new FlxText(0, 0, 100, "Tomato Boots"));
		}
		
		protected function createHerd():void {
			herd = new FlxGroup(HERD_SIZE);
			for (var i:uint = 0; i < HERD_SIZE; i++) {
				var bison:Bison = new Bison(
					FlxG.random() * (FlxG.width),
					FlxG.random() * (FlxG.height));
				herd.add(bison);
			}
			add(herd);
		}
		
		override public function update():void {
			FlxG.overlap(herd, player, gotcha);
			super.update();
			// TODO: make explosions a class of their own w / collision detection for bounce
		}
		
		protected function gotcha(bison:Bison, playa:Panda):void {
			if (bison.facing == playa.facing) {
				asplode(playa, bison, ImgHeart);
			} else {
				asplode(bison, playa, ImgCoin);
			}
		}
		
		private function asplode(loser:FlxSprite, winna:FlxSprite, img:Class):void {
			FlxG.play(SndExplode);
			var splosion:FlxEmitter = new FlxEmitter();
			splosion.x = winna.x + winna.width / 2;
			splosion.y = winna.y;
			splosion.setXSpeed(-100, 100);
			splosion.setYSpeed(-100, -200);
			splosion.setRotation(0, 0);
			splosion.bounce = 0.5;
			splosion.gravity = 900;
			splosion.makeParticles(img, 3 + FlxG.random() * 3);
			loser.kill();
			add(splosion);
			splosion.start(true, 1000);	
		}
	}
}