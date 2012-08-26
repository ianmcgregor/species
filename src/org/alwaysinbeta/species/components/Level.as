package org.alwaysinbeta.species.components {
	import flash.geom.Point;
	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public class Level extends Component {
		
		public var map : Array;
		public var hero : Point;
		public var enemies : Vector.<Point>;
		
		public function Level(xml: XML) {
			
			var string : String = xml.descendants('Solids').valueOf();
			string = string.replace(/\r\n|\n|\r|\t/g, '');
			var array : Array = string.split('');
			
			map =  [];
			var row: Array;
			var l: int = array.length;
			for (var i : int = 0; i < l; ++i) {
				if(i % 40 == 0){
//					trace(map.length, ': ',row);
					row = [];
					map[map.length] = row;
				}
				row[row.length] = array[i];
			}
			
			
			var heroXML: XML = xml.descendants('Hero')[0];
			hero = new Point(heroXML.@x, heroXML.@y);
			
			enemies = new Vector.<Point>();
			var enemyXMLList: XMLList = xml.descendants('Enemy');
			for each (var node : XML in enemyXMLList) {
				enemies[enemies.length] = new Point(node.@x, node.@y);
			}
		}
		
		public function collides(x: int, y: int): Boolean {
			 var i: int = int(y / 16);
			 var j: int = int(x / 16);
			 if(i < 0 || i > map.length -1) return true;
			 if(j < 0 || j > (map[i] as Array).length -1) return true;
			 return map[i][j] == 1;
		}
	}
}
