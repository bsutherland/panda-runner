package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	
	public class SilverBison extends Bison 
	{
		public const MAD_DASH_TIME:Number = 1.0;
		
		public function SilverBison(X:int, Y:int) {
			super(X, Y);
			color = 0xcccccc;
			coins = 5 + FlxG.random() * 4;	// 5 to 8 coins
			madDash(null);
		}
		
		override protected function runAi():void {
			
		}
		
		protected function madDash(t:FlxTimer):void {
			velocity.x = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			velocity.y = FlxG.random() * MAX_VEL - MAX_VEL / 2;
			dash(MAD_DASH_TIME, madDash);
			if (null != t) {
				t.stop();
				t.destroy();
			}
		}
		
	}

}