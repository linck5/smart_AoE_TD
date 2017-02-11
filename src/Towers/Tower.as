package Towers
{
	import Enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import Projectiles.TestProjectile;

	public class Tower extends Structure 
	{
		public var
		towerImg:Image,
		projectileType:Class,
		isBeingPositioned:Boolean = false,
		damage:int
		;
		
		public function Tower() 
		{
			
		}
		
		override public function update():void {
			
			
			if (isBeingPositioned) {
				x = Grid.snapX(Input.mouseX - halfWidth);
				y = Grid.snapY(Input.mouseY - halfHeight);
				
				if (Input.mousePressed) {
					isBeingPositioned = false;
				}
				
				return;
			}
			
			
		}
		
		public function shootEnemy(e:Enemy):void {
			if (!isBeingPositioned) {
				(FP.world.create(projectileType) as projectileType).setupAndShootEnemy(this, e);
				e.predictedDamage += damage;
			}
		}
		
		public function shootToXY(x:int, y:int):void {
			if(!isBeingPositioned){
				(FP.world.create(projectileType) as projectileType).setupAndShootToXY(this, x, y);
			}
		}
		
		public function thereAreEnemeiesInRange():Boolean {
			return false;
		}
		
		public function enemyIsInRange(enemy:Enemy):Boolean {
			return false;
		}
		
	}

}