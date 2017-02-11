package Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	import Paths.Dir;
	
	public class Enemy extends Entity
	{
		public var 
		direction:int,
		nextPoint:int,
		hp:int,
		maxHP:int,
		predictedDamage:int,
		speed:Number,
		path:Array,
		enemyImg:Image,
		drawPath:Boolean = true,
		alive:Boolean
		;
		
		public function Enemy(path:Array) 
		{
			type = "enemy";
			
			alive = true;
			
			this.path = path;
			x = path[0][0];
			y = path[0][1];
			direction = path[0][2];
			nextPoint = 1;
		}
		override public function update():void {
			
			if (hp <= 0) {
				alive = false;
				destroy();
			}
			
			walk();
			
		}
		
		private function walk():void {
			
			if  (nextPoint + 1 > path.length) {
				return;
			}
			
			switch(direction) {
				case Dir.UP:
					y -= speed * FP.elapsed;
						
					if (y <= path[nextPoint][1]) {
						direction = path[nextPoint][2];
						nextPoint++;
					}
					break;
				case Dir.DOWN: 
					y += speed * FP.elapsed;
						
					if (y >= path[nextPoint][1]) {
						direction = path[nextPoint][2];
						nextPoint++;
					}
					break;
				case Dir.LEFT:
					x -= speed * FP.elapsed;
						
					if (x <= path[nextPoint][0]) {
						direction = path[nextPoint][2];
						nextPoint++;
					}
					break;
				case Dir.RIGHT: 
					x += speed * FP.elapsed;
					
					if (x >= path[nextPoint][0]) {
						direction = path[nextPoint][2];
						nextPoint++;
					}
					break;
			}
		}
		
		override public function render():void {
			super.render();
			if (drawPath) {
				
				for (var i:int = 0; i < path.length - 1; i++) {
					Draw.linePlus(
						path[i][0] + halfWidth, 
						path[i][1] + halfHeight, 
						path[i + 1][0] + halfWidth, 
						path[i + 1][1] + halfHeight,
						0xFFAAFF,
						0.5,
						2
					);
				}
			}
			
			var rectW:int = 25;
			Draw.rectPlus(centerX - rectW / 2, centerY - 18, rectW, 5, 0x555555, 1, true, 1, 3);
			Draw.rectPlus(centerX - rectW / 2, centerY - 18, rectW * hp / maxHP, 5, 0x33AA33, 1, true, 1, 3);
			
		}
		
		public function destroy():void {
			alive = false;
			FP.world.recycle(this);
		}
		
	}

}