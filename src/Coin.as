package  
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxG;
	
	public class Coin extends FlxParticle {
		
		public function Coin() {
			super();
			loadGraphic(Resources.ImgCoin);
		}
		
		override public function update():void {
			super.update();
			if (y > FlxG.height) {
				FlxG.play(Resources.SndBling, 0.5);
				kill();
				(FlxG.state as PlayState).pennyDropped();
			}			
		}
	}

}