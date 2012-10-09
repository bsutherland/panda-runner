package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxCamera;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.StageDisplayState;
	
	public class TitleState extends FlxState {
		
		private var starting:Boolean;
		private var txt:FlxText;
		private var title:FlxSprite;
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			title = new FlxSprite(0, 0);
			title.loadGraphic(Resources.ImgTitle);
			FlxG.play(Resources.SndWoosh);
			FlxG.flash(0xffffffff, 1, showFlashingMessage);
			add(title);
			starting = false;
			//FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("SPACE") && !starting) {
				starting = true;
				txt.visible = false;
				FlxG.play(Resources.SndStart);
				FlxG.fade(0xff000000, 3, startGame);
			}
		}

		function keyDown(e:KeyboardEvent):void {
			if (e.keyCode == 70) {
				FlxG.play(Resources.Snd1Up);				
				toggleFullscreen();
			}
		}
		
		private function showFlashingMessage():void {
			txt = new FlxText(0, 180, FlxG.width, 'Push space to begin');
			txt.alignment = 'center';
			txt.font = "Adore64";
			txt.size = 8;
			txt.flicker();
			add(txt);
		}
		
		private function startGame():void {
			txt.destroy();
			title.destroy();
			FlxG.switchState(new IntermissionState(new GameStruct()));			
		}
		
        private function toggleFullscreen(ForceDisplayState:String=null):void {
            if (ForceDisplayState) {
                FlxG.stage.displayState = ForceDisplayState;
            } else {
                if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
                    FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
                } else {
                    FlxG.stage.displayState = StageDisplayState.NORMAL;
                }
            }
            window_resized();
        }
 
        private function window_resized(e:Event = null):void {
            FlxG.width = FlxG.stage.stageWidth / FlxCamera.defaultZoom;
            FlxG.height = FlxG.stage.stageHeight / FlxCamera.defaultZoom;
            FlxG.resetCameras(new FlxCamera(0, 0, FlxG.width, FlxG.height)); 
        }		
	}

}