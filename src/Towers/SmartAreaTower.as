package Towers
{
	import Enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	import Projectiles.*;
	
	public class SmartAreaTower extends Tower
	{
		
		public var 
		aoeRadius:uint = 120,
		fireRate:Number = 1.5,
		shootRange:uint = 200,
		timer:Number = 0,
		drawRange:Boolean,
		targetGroups:Array = new Array()
		;
		
		public function SmartAreaTower() 
		{
			towerImg = new Image(Assets.testTower1);
			towerImg.color = 0x00FFCC;
			setHitbox(Assets.testTower1_W, Assets.testTower1_H);
			
			projectileType = SmartAreaTowerProjectile;
			
			graphic = towerImg;
			layer = GC.LAYER_SMART_AREA_TOWER;
			
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
					
					var targets:Array = new Array();
					var firstEnemy:Boolean = true;
					var maxEnemies:int = 0;
					var nOfEnemiesToTest:int;
					
					if (timer <= 0) {
					
						for each(var e:Enemy in enemyArray) {
							if (enemyIsInRange(e) && e.hp - e.predictedDamage > 0) {
								targets.push(e);
							}
						}
						
						nOfEnemiesToTest = targets.length > 1?
								targets.length / 2: 
								1;
						
						if (checkEnemies(targets, nOfEnemiesToTest)) {
							nOfEnemiesToTest++;
							while (checkEnemies(targets, nOfEnemiesToTest)) {
								nOfEnemiesToTest++;
							}
						}
						else {
							nOfEnemiesToTest--;
							while (!checkEnemies(targets, nOfEnemiesToTest)) {
								nOfEnemiesToTest--;
								if (nOfEnemiesToTest < 1) {
									break;
								}
							}
						}
						
						if (targetGroups.length > 0) {
							shootGroup(targetGroups[0]);
							timer = 1 / fireRate;
						}
						targetGroups = [];
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
		
		public function checkEnemies(testGroup:Array, testEach:int):Boolean {
			return checkEnemies2(testGroup, new Array(), testEach, testEach);
		}
		
		public function checkEnemies2(testGroup:Array, testingStack:Array, testEach:int, testCount:int):Boolean {
			
			var success:Boolean = false;
			
			if (testCount == 0) {
				if (theyAllFit(testingStack)) {
					
					if ((Array)(targetGroups[0]).length < testEach) {
						targetGroups = [];
					}
					targetGroups.push(testingStack);
					return true;
				}
			}
			else if (testingStack.length < testGroup.length) {
				for each(var enemy:Enemy in testGroup) {
					
					if (testingStack.indexOf(testGroup) == -1) {
						var newTestingStack:Array = testingStack.concat();
						newTestingStack.push(enemy);
						if (checkEnemies2(testGroup, newTestingStack, testEach, testCount - 1)) {
							success = true;
						}
					}
					testingStack.push(enemy);
				}	
			}
			return success;
		}
		
		public function theyAllFit(e:Array):Boolean {
			var xValues:Array = new Array, yValues:Array = new Array;
			
			for each(var enemy:Enemy in e) {
				xValues.push(enemy.x + enemy.halfWidth);
				yValues.push(enemy.y + enemy.halfHeight);
			}
			var aoe:Array = endsMean(xValues, yValues);
			aoe = putXYInShootRange(aoe[0], aoe[1]);
			var aoeX:Number = aoe[0], aoeY:Number = aoe[1];
			
			for each(var enemy2:Enemy in e) {
				if (FP.distance(aoeX, aoeY, enemy2.x + enemy2.halfWidth , enemy2.y + enemy2.halfHeight) > aoeRadius) {
					return false;
				}
			}
			return true;
			
		}
		
		public function putXYInShootRange(x:Number, y:Number):Array {
			var distance:Number = FP.distance(this.x + this.halfWidth, this.y + this.halfHeight, x, y);
			if (distance > shootRange) {
				var angle2:Number = Math.atan2(
					(y + halfHeight) - this.y,
					(x + halfWidth) - this.x
				) * FP.DEG;
				x -= Math.cos(angle2 * FP.RAD) * (distance - shootRange);
				y -= Math.sin(angle2 * FP.RAD) * (distance - shootRange);
			}
			
			return [x, y];
		}
		
		override public function thereAreEnemeiesInRange():Boolean {
			var enemyArray:Array = new Array(); 
			FP.world.getClass(Enemy, enemyArray);
			
			for each(var e:Enemy in enemyArray) {
				if (
					FP.distance(
						e.x + e.halfWidth, e.y + e.halfHeight,
						x + halfWidth, y + halfHeight
					) < shootRange + aoeRadius
				) {
					return true;
				}
			}
			return false;
		}
		
		override public function enemyIsInRange(enemy:Enemy):Boolean {
			return FP.distance(
				enemy.x + enemy.halfWidth, enemy.y + enemy.halfHeight,
				x + halfWidth, y + halfHeight
			) < shootRange + aoeRadius;
		}
		
		public function shootGroup(group:Array):void {
			var xValues:Array = new Array();
			var yValues:Array = new Array();
			
			for each(var enemy:Enemy in group) {
				xValues.push(enemy.x + enemy.halfWidth);
				yValues.push(enemy.y + enemy.halfHeight);
			}
			
			var XYToShoot:Array = endsMean(xValues, yValues);
			XYToShoot = putXYInShootRange(XYToShoot[0], XYToShoot[1]);
			var xToShoot:Number = XYToShoot[0], yToShoot:Number = XYToShoot[1];
			
			shootToXY(XYToShoot[0], XYToShoot[1]);
		}
		
		public function centroid(x:Array, y:Array):Array {
			
			if (x.length != y.length) throw new Error("centroid problem 1");
			
			var 
			centroidX:Number = 0, 
			centroidY:Number = 0,
			a:Number = 0,
			partialValue:Number,
			n:int = x.length;
			
			for (var i:int = 0; i < n - 1; i++) {
				
				partialValue = x[i] * y[i + 1] - x[i + 1] * y[i];
				
				centroidX += (x[i] + x[i + 1]) * partialValue;
				centroidY += (y[i] + y[i + 1]) * partialValue;
				
				a += partialValue;
			}
			
			partialValue = x[n - 1] * y[0] - x[0] * y[n - 1];
				
			centroidX += (x[n - 1] + x[0]) * partialValue;
			centroidY += (y[n - 1] + y[0]) * partialValue;
			
			a += partialValue;
			
			a = a / 2;
			centroidX = 1 / (6 * a) * centroidX;
			centroidY = 1 / (6 * a) * centroidY;
			
			return [centroidX, centroidY];
			
		}
		
		public function meanXY(x:Array, y:Array):Array {
			
			if (x.length != y.length) throw new Error("meanXY problem 1");
			
			var sumX:Number = 0, sumY:Number = 0;
			
			for (var i:int = 0; i < x.length; i++) {
				sumX += x[i];
				sumY += y[i];
			}
			
			return [sumX / x.length, sumY / y.length];
		}
		
		public function endsMean(x:Array, y:Array):Array {
			
			if (x.length != y.length) throw new Error("endsMean problem 1");
			
			var
			minX:Number = x[0],
			minY:Number = y[0],
			maxX:Number = x[0],
			maxY:Number = y[0];
			
			for (var i:int = 0; i < x.length; i++) {
				if (x[i] > maxX) maxX = x[i];
				if (y[i] > maxY) maxY = y[i];
				if (x[i] < minX) minX = x[i];
				if (y[i] < minY) minY = y[i];
			}
			
			return [(maxX + minX) / 2, (maxY + minY) / 2];
			
		}
	}

}