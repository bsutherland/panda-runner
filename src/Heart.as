package  
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxG;
	
	public class Heart extends FlxParticle 
	{
		[Embed(source = "../img/heart.png")] private var ImgHeart:Class;	
		
		public function Heart() {
			super();
			loadGraphic(ImgHeart);
		}
		
		override public function update():void {
			super.update();
			if (y > FlxG.height) {
				kill();
			}			
		}
	}

}