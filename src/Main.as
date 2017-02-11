package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.GraphicElement;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class Main extends Engine
	{
		private static var 
		instanceVar:Main;
		
		public function Main():void 
		{
			super(GV.w_width, GV.w_height, 60, false);
			instanceVar = this;
		}
		
		override public function init():void 
		{
			super.init();
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("positionRegularTower", Key.R);
			Input.define("positionSmartTower", Key.E);
			Input.define("spawnWave", Key.Q);
			FP.console.enable();
			FP.console.visible = true;
			
			
			
			FP.world = new GameWorld();
		}
		
		public static function get instance():Main {
			return instanceVar;
		}
	}
	
}