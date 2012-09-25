package  
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxG;
	
	public class Coin extends FlxParticle {
		[Embed(source = "../img/coin.png")] private var ImgCoin:Class;	
		[Embed(source = "../snd/bling.mp3")] private var SndBling:Class;
		
		public function Coin() {
			super();
			loadGraphic(ImgCoin);
		}
		
		override public function update():void {
			super.update();
			if (y > FlxG.height) {
				FlxG.play(SndBling, 0.5);
				kill();
				(FlxG.state as PlayState).pennyDropped();
			}			
		}
	}

}