package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public const HERD_SIZE:uint = 10;
		[Embed(source = "../img/heart.png")] private var ImgH:Class;
		
		public var player:Panda;
		public var herd:FlxGroup;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff009900;
			createHerd();
			player = new Panda(FlxG.width / 2, FlxG.height / 2);
			add(player);
			add(new FlxText(0, 0, 100, "Tomato Boots"));

		}
		
		protected function createHerd():void
		{
			herd = new FlxGroup(HERD_SIZE);
			for (var i:uint = 0; i < HERD_SIZE; i++) {
				var bison:Bison = new Bison(
					FlxG.random() * FlxG.width,
					FlxG.random() * FlxG.height);
				herd.add(bison);
			}
			add(herd);
		}
		
		override public function update():void
		{
			FlxG.overlap(herd, player, gotcha);
			super.update();
		}
		
		protected function gotcha(bison:FlxObject, playa:FlxObject):void
		{
			var splosion:FlxEmitter = new FlxEmitter();
			splosion.x = bison.x + bison.width / 2;
			splosion.y = bison.y + bison.height / 2;
			splosion.setXSpeed(-150, 150);
			splosion.setYSpeed(-200, 0);
			splosion.setRotation(0, 0);
			splosion.bounce = 0.5;
			splosion.setSize(bison.width * 2, bison.height * 2);
			splosion.gravity = 900;
			splosion.makeParticles(ImgH, 5);
			bison.kill();
			add(splosion);
			splosion.start(true, 1000);
			
		}
	}
}