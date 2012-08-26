package org.alwaysinbeta.species.spatials {
	import org.alwaysinbeta.species.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.Level;

	/**
	 * @author McFamily
	 */
	public class LevelGfx extends Spatial {
		
//		private var _textureAtlas : TextureAtlas;
		private var _container: Sprite;
		private var _tiles : Array;
		private var _level : Level;
		
		public function LevelGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var levelMapper : ComponentMapper = new ComponentMapper(Level, _world);
			_level = levelMapper.get(_owner);
			_tiles = Assets.tiles;
			_container = new Sprite();
			
			var map: Array = _level.map;
			var l: int = map.length;
			for (var i : int = 0; i < l; ++i) {
				var row: Array = map[i];
				var len: int = row.length;
				for (var j : int = 0; j < len; ++j) {
					var index: int = row[j];
					var tile : Image = new Image(_tiles[index]);
					tile.x = j * 16;
					tile.y = i * 16;
//					trace('tile.x: ' + (tile.x),'tile.y: ' + (tile.y));
					_container.addChild(tile);
				}
			}
			
			_container.flatten();
			
			// 40 / 30
//			var spriteSheet : Texture = Texture.fromBitmap(new Assets.SpriteSheet());
//			var xml:XML = XML(new Assets.SpriteSheetXML());
//
//			_textureAtlas = new TextureAtlas(spriteSheet, xml);
			
		}
		
		override public function render(g : Canvas) : void {
			if(!g.contains(_container)){
				g.addChildAt(_container, 0);
			}
		}

		override public function remove(g : Canvas) : void {
			if(g.contains(_container)){
				g.removeChild(_container);
			}
		}
	}
}
