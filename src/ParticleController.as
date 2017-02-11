package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
 
	public class ParticleController extends Entity 
	{
		
 
		private var emitter:Emitter;
 
		public function ParticleController() 
		{
			emitter = new Emitter(new BitmapData(3, 3, false, 0xFFEEEE), 3, 3);
			emitter.newType("explosion", [0]);
			emitter.setAlpha("explosion", 1, 0.1);
			graphic = emitter;
			layer = GC.LAYER_PARTICLES;
		}
 
		public function explosion(x:Number, y:Number, particles:int = 20, flipped:Boolean = false):void
		{
			if (flipped) {
				emitter.setMotion("explosion", 320, 10, 0.08, 80, 40, 0.35, Ease.quadOut);
			}
			else {
				emitter.setMotion("explosion", 140, 10, 0.08, 80, 40, 0.35, Ease.quadOut);
			}
			for (var i:uint = 0; i < particles; i++) {
				emitter.emit("explosion", x, y);
			}
		}
		
		public function explosion2(x:Number, y:Number, angle:Number):void
		{
			
			var angleRange:int = 20;
			emitter.setMotion(
				"explosion", 
				angle - angleRange / 2, 
				3, 
				0.033, 
				
				angleRange, 
				25, 
				0.25, 
				Ease.quadOut
			);
			
			for (var i:uint = 0; i < 20; i++) {
				emitter.emit("explosion", x, y);
			}
		}
		
		public function explosion3(x:Number, y:Number, angle:Number):void
		{
			
			var angleRange:int = 80;
			emitter.setMotion(
				"explosion", 
				angle - angleRange / 2, 
				10, 
				0.1, 
				
				angleRange, 
				40, 
				0.4, 
				Ease.quadOut
			);
			
			for (var i:uint = 0; i < 15; i++) {
				emitter.emit("explosion", x, y);
			}
		}
		
		public function explosion4(x:Number, y:Number, range:int):void
		{
			emitter.setMotion(
				"explosion", 
				0, 
				range/3, 
				0.1, 
				
				360, 
				range, 
				0.6, 
				Ease.quadOut
			);
			
			for (var i:uint = 0; i < 30; i++) {
				emitter.emit("explosion", x, y);
			}
		}
	}
}