package  
{
	import org.flixel.*;
	
	public class Panda extends FlxSprite {
	
		public const MAX_VEL:uint = 100;
		
		[Embed(source = "../img/panda_cropped.png")] private var ImgA:Class;
		[Embed(source = "../snd/step_down.mp3")] private var SndDown:Class;
		[Embed(source = "../snd/step_up.mp3")] private var SndUp:Class;
		
		public var stepUpSnd:FlxSound;
		public var stepDownSnd:FlxSound;
		
		public function Panda(X:int, Y:int) {
			super(X, Y);
			loadGraphic(ImgA, true, true, 10, 16);	// animated, reversable
			addAnimation("walking", [0, 1], 4, true);
			addAnimation("standing", [0], 0, false);
			addAnimationCallback(animationCallback);
			play("walking");
			stepUpSnd = new FlxSound();
			stepUpSnd.loadEmbedded(SndUp, false);
			stepDownSnd = new FlxSound();
			stepDownSnd.loadEmbedded(SndDown, false);
			flicker(3);	// start ethereal to allow player to get their bearings
		}
	
		public function animationCallback(name:String, frame_no:uint, frame_idx:uint):void {
			if ("walking" == name) {
				if (frame_idx % 2 == 1) {
					stepUpSnd.play();
				} else {
					stepDownSnd.play();
				}
			} else {
				stepUpSnd.stop();
				stepDownSnd.stop();
			}
		}
		
		override public function update():void {
			velocity.x = velocity.y = 0;
			if (FlxG.keys.LEFT) {
				facing = LEFT;
				velocity.x -= MAX_VEL;
			}
			if (FlxG.keys.RIGHT) {
				velocity.x += MAX_VEL;
				facing = RIGHT;
			}
			if (FlxG.keys.UP)
				velocity.y -= MAX_VEL;
			if (FlxG.keys.DOWN)
				velocity.y += MAX_VEL;
				
			if (velocity.x != 0 || velocity.y != 0) {
				play("walking");
			} else {
				play("standing");
			}
				
			super.update();
			
			if (x > FlxG.width - width)
				x = FlxG.width - width;
			else if (x < 0)
				x = 0;
			if (y > FlxG.height - height)
				y = FlxG.height - height;
			else if (y < 0)
				y = 0;
		}
	}

}