package  
{
	import net.flashpunk.Entity;
	
	public class Structure extends Entity 
	{
		private var 
		_gridX:uint, 
		_gridY:uint
		;
		
		public function Structure() 
		{
			
		}
		
		public function set gridX(value:uint):void {
			_gridX = value;
			x = _gridX * Grid.xSpacing;
		}
		public function set gridY(value:uint):void {
			_gridY = value;
			y = _gridY * Grid.ySpacing;
		}
		
		public function get gridX():uint {
			return _gridX;
		}
		public function get gridY():uint {
			return _gridY;
		}
		
	}

}