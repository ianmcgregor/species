package org.alwaysinbeta.species.components {
	import flash.geom.Rectangle;
	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public class CollisionRect extends Component {
		private var _rect : Rectangle;
		public function CollisionRect(x: int, y: int, width: int, height: int) {
			_rect = new Rectangle(x, y, width, height);
		}

		public function get rect() : Rectangle {
			return _rect;
		}
		
	}
}
