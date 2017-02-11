package Projectiles 
{
	import Enemies.Enemy;
	import Towers.*;
	import Paths.Dir;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	import Effects.*;
	
	public class SmartAreaTowerProjectile extends Projectile 
	{
		
		public var areaDamage:Boolean = true;
		
		public function SmartAreaTowerProjectile() 
		{
			super();
			
			projectileImg = new Image(Assets.testProjectile1);
			setHitbox(Assets.testProjectile1_W, Assets.testProjectile1_H);
			projectileImg.centerOO();
			
			graphic = projectileImg;
			
			setup(null);
		}
		
		override public function setup(parent:Tower):void {
			
			super.setup(parent);
			
			if (parent) {
				x = parent.centerX;
				y = parent.centerY;
			}
			
			this.parent = parent;
			
			speed = 500;
		}
		
		public function setupAndShootEnemy(parent:Tower, e:Enemy):void {
			setup(parent);
			shootToEnemy(e);
		}
		
		public function setupAndShootToXY(parent:Tower, x:int, y:int):void {
			setup(parent);
			shootToXY(x, y);
		}
		
		override public function update():void {
			super.update();
			
			var oldX:Number = x, oldY:Number = y;
			
			switch(action) {
			case GO_TO_XY:
				proceedToAngle(angle);
				break;
			case GO_TO_ENEMY:
				if (enemy != null && enemy.alive) {
					
					var forethroughX:Number = 0, forethroughY:Number = 0;
					var proximityFactor:Number = distanceBetweenTowerAndEnemy * speed;
					var proximity2:Number = proximityFactor * 10;
					switch(enemy.direction) {
						case Dir.UP:
							forethroughY = progress * enemy.speed / proximity2 * -10;
						case Dir.DOWN:
							forethroughY = progress * enemy.speed / proximity2 * 10;
						case Dir.LEFT:
							forethroughX = progress * enemy.speed / proximity2 * -10;
						case Dir.RIGHT:
							forethroughX = progress * enemy.speed / proximity2 * 10;
					}
					
					aimToXY(enemy.centerX + forethroughX, enemy.centerY + forethroughY);
					proceedToAngle(angle);
				}
				else {
					action = DISCARD;
				}
				break;
			case STAND_STILL:
				break;
			case DISCARD:
				projectileImg.color = 0xAA3333;
				projectileImg.alpha -= 0.3 * FP.elapsed
				angle += Math.random() > 0.5? 7: -7;
				proceedToAngle(angle);
				if (projectileImg.alpha <= 0) {
					FP.world.recycle(this);
				}
				break;
			}
			
			if (reachedDestination(oldX, oldY) && action != DISCARD) {
				
				if(enemy){
					enemy.predictedDamage -= parent.damage;
				}
				destroyAndDamage();
			}
			
			
			projectileImg.angle = this.angle;
		}
		
		private function reachedDestination(oldX:Number, oldY:Number):Boolean {
			
			var passedInX:Boolean, passedInY:Boolean;
			if (action == GO_TO_ENEMY) {
				destinationX = enemy.centerX;
				destinationY = enemy.centerY;
			}
			
			if (x > oldX) {
				passedInX = x >= destinationX;
			}
			else {
				passedInX = x <= destinationX;
			}
			
			if (y > oldY) {
				passedInY = y >= destinationY;
			}
			else {
				passedInY = y <= destinationY;
			}
				
			
			return passedInX && passedInY;
		}
		
		override public function render():void {
			super.render();
			//Draw.circle(x, y, 2);
		}
		
		override public function destroyAndDamage(enemy:Enemy = null):void {
			
			if (!enemy) {
				enemy = this.enemy;
			}
			
			if (areaDamage) {
				var enemyArray:Array = new Array();
				FP.world.getClass(Enemy, enemyArray);
				var area:int = (parent as SmartAreaTower).aoeRadius;
				for each (var e:Enemy in enemyArray) {
					if (FP.distance(x, y, e.x, e.y) <= area) {
						e.hp -= parent.damage;
						
						GV.particleEmitter.explosion3(
							e.x + e.halfWidth, 
							e.y + e.halfHeight, 
							Math.atan2(e.y - y, e.x - x) * FP.DEG
						);
					}
				}
				FP.world.add(new AoEEffect1(x, y, area));
				
				GV.particleEmitter.explosion4(x, y, area/1.5);
			}
			else if (enemy) {
				enemy.hp -= parent.damage;
			}
			
			FP.world.recycle(this as SmartAreaTowerProjectile);
		}
		
		
	}

}