package  
{
	import net.flashpunk.FP;
	import Enemies.*;
	import Paths.*;
	
	public class Wave 
	{
		private var
		waveArray:Array = new Array(),
		enemyToBeAddedIndex:uint = 0,
		amountToBeAddedIndex:uint = 0,
		spawnRate:Number = 0.5,
		timer:Number = 0,
		spawningWave:Boolean = false
		;
		
		
		public function Wave() 
		{
			
		}
		
		public function addEnemy(type:Class, amount:uint):void {
			waveArray.push([type, amount]);
		}
		
		public function spawnWave(spawnRate:Number = -1):void {
			if (spawnRate <= 0) {
				spawnRate = this.spawnRate;
			}
			this.spawnRate = spawnRate;
			spawningWave = true;
			amountToBeAddedIndex = waveArray[0][1];
			enemyToBeAddedIndex = waveArray[0][0];
		}
		
		public function update():void {
			
			if (spawningWave) {
				if (timer < 0) {
					if (amountToBeAddedIndex <= 0) {
						enemyToBeAddedIndex++;
						if (enemyToBeAddedIndex >= waveArray.length) {
							spawningWave = false;
							return;
						}
						amountToBeAddedIndex = waveArray[enemyToBeAddedIndex][1];
					}
					
					if (waveArray[enemyToBeAddedIndex][0] ==  TestEnemy) {
						FP.world.add(new TestEnemy(Path.path2));
					}
					
					amountToBeAddedIndex--;
					
					timer = 1 / spawnRate;
				}
				else {
					timer -= FP.elapsed;
				}
			}
			
		}
		
	}
}