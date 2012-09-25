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
			setXSpeed(-75, 75);
			setYSpeed(-50, -250);
			setRotation(0, 0);
			bounce = 0.5;
			gravity = 500;
			for (var i:int = 0; i < maxSize; i++) {
				add(new pClass);
			}
		}
	
	}

}