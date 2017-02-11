package Projectiles 
{
	import Enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import Towers.Tower;
	
	public class Projectile extends Entity 
	{
		
		public var 
		speed:Number,
		speedX:Number,
		speedY:Number,
		angle:Number = 0,
		destinationX:int = 0,
		destinationY:int = 0,
		distanceBetweenTowerAndEnemy:int,
		distanceBetweenProjectileAndEnemy:int,
		progress:Number,
		parent:Tower,
		enemy:Enemy,
		projectileImg:Image
		;
		
		public static const 
		GO_TO_XY:int = 1,
		GO_TO_ENEMY:int = 2,
		STAND_STILL:int = 3,
		DISCARD:int = 4;
		
		protected var 
		action:int;
		
		public function Projectile() 
		{
			action = STAND_STILL;
		}
		
		public function setup(parent:Tower):void {
			if (parent) {
				x = parent.x + (parent as Tower).halfWidth;
				y = parent.y + (parent as Tower).halfHeight;
			}
			
			
		}
		
		override public function update():void {
			
			if (enemy) {
				distanceBetweenTowerAndEnemy = FP.distance(parent.x, parent.y, enemy.x, enemy.y);
				distanceBetweenProjectileAndEnemy = FP.distance(x, y, enemy.x, enemy.y);
				progress = distanceBetweenProjectileAndEnemy / distanceBetweenTowerAndEnemy;
			}
			
			if (
				x < -1000 ||
				y < - 1000 ||
				x > 1500 ||
				x > 1500
			) {
				FP.world.recycle(this);
			}
		}
		
		public function shootToEnemy(e:Enemy):void {
			aimToXY(e.x, e.y);
			GV.particleEmitter.explosion2(this.x, this.y, angle);
			action = GO_TO_ENEMY;
			this.enemy = e;
		}
		
		public function shootToXY(x:int, y:int):void {
			GV.particleEmitter.explosion2(this.x, this.y, angle);
			action = GO_TO_XY;
			destinationX = x;
			destinationY = y;
			
			aimToXY(x, y);
		}
		
		public function aimToXY(x:int, y:int):void {
			
			angle = Math.atan2(
				y - this.y,
				x - this.x
			) * FP.DEG;
		}
		
		public function proceedToAngle(angle:Number):void {
			speedX = Math.cos(angle * FP.RAD) * speed;
			speedY = Math.sin(angle * FP.RAD) * speed;
			
			x += speedX * FP.elapsed;
			y += speedY * FP.elapsed;
		}
		
		public function destroyAndDamage(enemy:Enemy = null):void {
			
		}
		
	}

}