package  
{
	import flash.display.Shape;
	import net.flashpunk.Entity;
	
	public class Grid extends Entity
	{
		private static var 
		_xSpacing:uint, 
		_ySpacing:uint,
		_grid:Shape
		;
			
		public function Grid(xSpacing:uint, ySpacing:uint) 
		{
			Grid._xSpacing = xSpacing;
			Grid._ySpacing = ySpacing;
			
			_grid = new Shape();
			_grid.graphics.lineStyle(3, 0xFFFFFF, .08);
			Grid.drawGrid();
			
			Main.instance.addChild(_grid);
			
		}
		
		private static function drawGrid():void {
			
			for (var i:int = 0; i < GV.w_height / _ySpacing; i++) {
				_grid.graphics.moveTo(0, i * _ySpacing);
				_grid.graphics.lineTo(GV.w_width, i * _ySpacing);
			}
			for (var j:int = 0; j < GV.w_width / _xSpacing; j++) {
				_grid.graphics.moveTo(j * _ySpacing, 0);
				_grid.graphics.lineTo(j * _xSpacing, GV.w_height);
			}
			
		}
		
		public static function setGridSpacing(xSpacing:uint, ySpacing:uint):void {
			
			Grid._xSpacing = xSpacing;
			Grid._ySpacing = ySpacing;
			
			_grid = new Shape();
			Grid.drawGrid();
			
		}
		
		public static function snapX(x:int):int {
			return Math.round(x / xSpacing) * xSpacing;
		}
		
		public static function snapY(y:int):int {
			return Math.round(y / ySpacing) * ySpacing;
		}
		
		public static function get xSpacing():uint {
			return _xSpacing;
		}
		
		public static function get ySpacing():uint {
			return _ySpacing;
		}
		
		public static function set visible( b:Boolean ):void { 
			_grid.visible = b; 
		}
		
		override public function update():void {
			
		}
		
	}

}