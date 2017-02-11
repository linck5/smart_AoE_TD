package Effects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Effect extends Entity
	{
		
		public var effectEnded:Boolean;
		
		public function Effect() 
		{
			effectEnded = false;
		}
		
		override public function update():void {
			if (effectEnded) {
				FP.world.recycle(this);
			}
		}
		
	}

}