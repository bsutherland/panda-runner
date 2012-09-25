package  
{
	import org.flixel.FlxParticle;
	
	public class Coin extends FlxParticle 
	{
		[Embed(source = "../img/coin.png")] private var ImgCoin:Class;		
		
		public function Coin() {
			super();
			loadGraphic(ImgCoin);
			//exists = false;
		}

//		override public function onEmit():void {
//			
//		}
	}

}