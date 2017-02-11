package  Paths
{
	public class Path 
	{
		public static var 
		path:Path = new Path(),
		testPath:Array,
		path1:Array,
		path2:Array
		;
		
		public function Path() 
		{
			testPath = [
				[200, 0, Dir.DOWN],
				[200, 100, Dir.RIGHT],
				[300, 100, Dir.DOWN],
				[300, 300, Dir.LEFT],
				[50, 300, Dir.DOWN],
				[50, GV.w_height, Dir.DOWN]
			];
			
			path1 = [
				[400, 0, Dir.DOWN],
				[400, 80, Dir.LEFT],
				[100, 80, Dir.DOWN],
				[100, 120, Dir.RIGHT],
				[400, 120, Dir.DOWN],
				[400, 300, Dir.LEFT],
				[200, 300, Dir.UP],
				[200, 150, Dir.RIGHT],
				[250, 150, Dir.DOWN],
				[250, GV.w_height, Dir.DOWN]
			];
			
			path2 = [
				[400, 0, Dir.DOWN],
				[400, 80, Dir.LEFT],
				[100, 80, Dir.DOWN],
				[100, 120, Dir.RIGHT],
				[400, 120, Dir.DOWN],
				[400, 300, Dir.LEFT],
				[200, 300, Dir.UP],
				[200, 150, Dir.RIGHT],
				[250, 150, Dir.DOWN],
				[250, 220, Dir.RIGHT],
				[480, 220, Dir.UP],
				[480, 150, Dir.LEFT],
				[300, 150, Dir.DOWN],
				[300, GV.w_height, Dir.DOWN]
			];
		}
		
		
		
	}

}