package Effects 
{
	
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	
	public class AoEEffect1 extends Effect
	{
		public var 
		duration:Number,
		timer:Number,
		fxAlpha:Number,
		radius:uint,
		color:int
		;
		
		public function AoEEffect1(x:int, y:int, radius:uint) 
		{
			fxAlpha = 0.20;
			color = 0xAAAA33;
			duration = 0.4;
			timer = duration;
			this.radius = radius;
			this.x = x;
			this.y = y;
		}
		
		override public function update():void {
			timer -= FP.elapsed;
			
			if (timer < 0) {
				effectEnded = true;
			}
		}
		
		override public function render():void {
			if (!effectEnded) {
				Draw.circlePlus(x, y, radius, color, fxAlpha * (timer / duration), true);
			}
		}
	}

}