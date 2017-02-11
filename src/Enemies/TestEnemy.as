package Enemies 

{
	import net.flashpunk.graphics.Image;
	
	public class TestEnemy extends Enemy 
	{
		
		public function TestEnemy(path:Array) 
		{
			super(path);
			speed = 50;
			maxHP = 180;
			hp = maxHP;
			
			type = "testEnemy";
			predictedDamage = 0;
			
			enemyImg = new Image(Assets.testTower1);
			setHitbox(Assets.testTower1_W, Assets.testTower1_H);
			
			graphic = enemyImg;
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}