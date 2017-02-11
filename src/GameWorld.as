package  
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	import Paths.Path;
	import Towers.*;
	import Enemies.*;
	/**
	 * ...
	 * @author Felipe Müller
	 */
	public class GameWorld extends World
	{
		public var 
		grid:Grid = new Grid(10, 10),
		tE:TestEnemy,
		path:Array,
		w:Wave
		;
		
		public function GameWorld() 
		{
			GV.particleEmitter = new ParticleController();
			add(GV.particleEmitter);
			
			path = Path.path1;
			
			w = new Wave();
			w.addEnemy(TestEnemy, 15);
			
			
			//var testTower:RegularAreaTower = new RegularAreaTower();
			//testTower.gridX = 20;
			//testTower.gridY = 2;
			//add(testTower);
			//tE = new TestEnemy(path);
			//add(tE);
			
			
		}
		
		override public function update():void {
			super.update();
			w.update();
			
			if (Input.pressed("positionSmartTower")) {
				add(new SmartAreaTower);
			}
			if (Input.pressed("positionRegularTower")) {
				add(new RegularAreaTower);
			}
			if (Input.pressed("spawnWave")) {
				w.spawnWave();
			}
			
		}
		
		
		
	}

}