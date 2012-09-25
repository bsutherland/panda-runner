package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	
	public class Splosion extends FlxEmitter 
	{
		
		public function Splosion(X:int, Y:int, pClass:Class) {
			super(X, Y, 3 + FlxG.random() * 3);
			x = X;
			y = Y;
			setXSpeed(-100, 100);
			setYSpeed(-100, -200);
			setRotation(0, 0);
			bounce = 0.5;
			gravity = 900;
			for (var i:int = 0; i < maxSize; i++) {
				add(new pClass);
			}
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}