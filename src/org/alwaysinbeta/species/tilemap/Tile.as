package org.alwaysinbeta.species.tilemap {
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public class Tile extends Image {
		private var _index : int;

		public function Tile(index : int, texture : Texture) {
			super(texture);
			_index = index;
		}

		public function get index() : int {
			return _index;
		}
		
	}
}
