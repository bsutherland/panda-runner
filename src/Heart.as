package  
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxG;
	
	public class Heart extends FlxParticle {	
		
		public function Heart() {
			super();
			loadGraphic(Resources.ImgHeart);
		}
		
		override public function update():void {
			super.update();
			if (y > FlxG.height) {
				kill();
			}			
		}
	}

}