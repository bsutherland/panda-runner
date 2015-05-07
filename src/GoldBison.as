package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	
	public class GoldBison extends Bison 
	{
		public const COURSE_CHANGE_INTERVAL_MIN:Number = 2;
		public const COURSE_CHANGE_INTERVAL_RANGE:Number = 2;
		public const DASH_VEL:uint = 50;
		
		public function GoldBison(X:int, Y:int, player:FlxSprite) {
			super(X, Y, player);
			color = 0xdaa520;
			coins = 8 + FlxG.random() * 5;	// 8 to 12 coins
			charge(null);
		}
		
		override protected function runAi():void {
			
		}
		
		protected function charge(t:FlxTimer):void {
			var p:FlxPoint = _player.getMidpoint()
			var vx:Number = x - p.x
			var vy:Number = y - p.y;
			var m:Number = Math.sqrt(vx * vx + vy * vy);
			velocity.x = -DASH_VEL * vx / m;
			velocity.y = -DASH_VEL * vy / m;
			var interval:Number = COURSE_CHANGE_INTERVAL_MIN
				+ FlxG.random() * COURSE_CHANGE_INTERVAL_RANGE;
			dash(interval, charge);
			if (null != t) {
				t.stop();
				t.destroy();
			}
		}
		
	}

}