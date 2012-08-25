package org.alwaysinbeta.species.spatials {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.Transform;

	import starling.display.Quad;

	/**
	 * @author McFamily
	 */
	public class FriendGfx extends Spatial {
		private var _transform : Transform;
		private var _quad : Quad;

		public function FriendGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

			_quad = new Quad(20, 20);
			_quad.color = 0x00ffff;
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_quad.x = x;
			_quad.y = y;
			if (!g.contains(_quad)) {
				g.addChild(_quad);
			}
		}
	}
}
