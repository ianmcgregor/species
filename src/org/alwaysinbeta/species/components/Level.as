package org.alwaysinbeta.species.components {
	import com.artemis.Component;

	import org.alwaysinbeta.species.assets.Assets;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author McFamily
	 */
	public class Level extends Component {
		
		public var num : int;
		public var map : Array;
		public var hero : Point;
		public var enemies : Vector.<Point>;
		public var exit : Rectangle;
		public var moustacheEnemies : Vector.<Point>;
		public var friends : Vector.<Point>;
		public var ship : Point;

		public function Level(num : int) {
			this.num = num;
			
			var xml: XML = Assets.getLevel(num);
			if( xml ) parseOgmo(xml);
		}
		
		public function parseOgmo(xml : XML) : void {
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

			
			var exitXML: XML = xml.descendants('Exit')[0];
			exit = new Rectangle(exitXML.@x, exitXML.@y, exitXML.@width, exitXML.@height);
			
			var xmlList : XMLList;
			var node : XML;
			
			enemies = new Vector.<Point>();
			xmlList = xml.descendants('Enemy');
			for each (node in xmlList) {
				enemies[enemies.length] = new Point(node.@x, node.@y);
			}

			moustacheEnemies = new Vector.<Point>();
			xmlList = xml.descendants('EnemyMoustache');
			for each (node in xmlList) {
				moustacheEnemies[moustacheEnemies.length] = new Point(node.@x, node.@y);
			}

			friends = new Vector.<Point>();
			xmlList = xml.descendants('Friend');
			for each (node in xmlList) {
				friends[friends.length] = new Point(node.@x, node.@y);
			}

			var shipXML: XML = xml.descendants('Ship')[0];
			ship = shipXML != null ? new Point(shipXML.@x, shipXML.@y) : null;
			
//			<EnemyMoustache id="0" x="528" y="336" />
//    		<EnemyMoustache id="1" x="432" y="384" />
//    		<Hero id="2" x="320" y="0" />
//    		<Exit id="3" x="624" y="112" width="16" height="208" />
		}
		
		public function collides(x: int, y: int): Boolean {
			 var i: int = int(y / 16);
			 var j: int = int(x / 16);
			 if(map == null || i < 0 || i > map.length -1) return true;
			 if(j < 0 || j > (map[i] as Array).length -1) return true;
			 return map[i][j] == 1;
		}
	}
}
