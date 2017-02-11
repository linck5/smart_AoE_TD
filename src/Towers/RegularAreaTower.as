package Towers
{
	import Enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	import Projectiles.TestProjectile;
	
	public class RegularAreaTower extends Tower
	{
		
		public var 
		aoeRadius:uint = 120,
		shootRange:uint = 200,
		fireRate:Number = 1.5,
		timer:Number = 0,
		drawRange:Boolean
		;
		
		public function RegularAreaTower() 
		{
			towerImg = new Image(Assets.testTower1);
			towerImg.color = 0x33BBEE;
			setHitbox(Assets.testTower1_W, Assets.testTower1_H);
			
			projectileType = TestProjectile;
			
			graphic = towerImg;
			layer = GC.LAYER_REGULAR_AREA_TOWER;
			
			isBeingPositioned = true;
			drawRange = false;
			
			damage = 7;
		}
		
		override public function update():void {
			super.update();
			
			if (!isBeingPositioned) {
				if (thereAreEnemeiesInRange()) {
					var enemyArray:Array = new Array();
					FP.world.getClass(Enemy, enemyArray);
					enemyArray.reverse();
					for each(var e:Enemy in enemyArray) {
						if (enemyIsInRange(e) && e.hp - e.predictedDamage > 0) {
							if (timer <= 0) {
								shootEnemy(e);
								timer = 1 / fireRate;
								break;
							}
						}
					}
					timer -= FP.elapsed;
				}
				drawRange = collidePoint(x, y, Input.mouseX, Input.mouseY);
			}
			else{
				drawRange = true;
			}
		}
		
		override public function render():void {
			super.render();
			if (drawRange) {
				Draw.circle(x + halfWidth, y + halfHeight, shootRange, 0xFFFFFF);
				Draw.circle(x + halfWidth, y + halfHeight, shootRange + aoeRadius, 0xAAFFAA);
			}
		}
		
		override public function thereAreEnemeiesInRange():Boolean {
			var enemyArray:Array = new Array(); 
			FP.world.getClass(Enemy, enemyArray);
			
			
			for each(var e:Enemy in enemyArray) {
				if (FP.distance(e.x, e.y, x, y) < shootRange) {
					return true;
				}
			}
			return false;
		}
		
		override public function enemyIsInRange(enemy:Enemy):Boolean {
			return FP.distance(enemy.x, enemy.y, x, y) < shootRange;
		}
		
		
		
	}

}