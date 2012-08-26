package org.alwaysinbeta.species.spatials {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.Level;

	import flash.display.BitmapData;

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
			
			_tiles = [Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFF000000)), Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFFFFFFFF))];
			
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
//			var currentX : int;
//			var currentY : int;
//			
//			var map: Array = _level.map;
//			var l: int = map.length;
//			for (var i : int = 0; i < l; ++i) {
//				var index: int = map[i];
//				var tile : Image = new Image(_tiles[index]);
//				tile.x = currentX;
//				tile.y = currentY;
//				_container.addChild(tile);
//				
//				currentX += 16;
//				
//				if(i > 0 && i % 40 == 0){
//					currentX = 0;
//					currentY += 16;
//				}
//			}
			
			_container.flatten();
			
			// 40 / 30
//			var spriteSheet : Texture = Texture.fromBitmap(new Assets.SpriteSheet());
//			var xml:XML = XML(new Assets.SpriteSheetXML());
//
//			_textureAtlas = new TextureAtlas(spriteSheet, xml);
			
		}
		
		override public function render(g : Canvas) : void {
			if(!g.contains(_container)){
				g.addChild(_container);
			}
		}

		override public function remove(g : Canvas) : void {
			if(g.contains(_container)){
				g.removeChild(_container);
			}
		}
	}
}
