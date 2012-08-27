package org.alwaysinbeta.species.spatials {
	import starling.display.Quad;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Transform;

	/**
	 * @author McFamily
	 */
	public class WallGfx extends Spatial {
		private var _transform : Transform;
		private var _gfx : Quad;
		private var _rect : CollisionRect;

		public function WallGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			var rectMapper : ComponentMapper = new ComponentMapper(CollisionRect, _world);
			_transform = transformMapper.get(_owner);
			_rect = rectMapper.get(_owner);

			_gfx = new Quad(_rect.rect.width, _rect.rect.height);
			_gfx.color = 0xffffff;
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_gfx.x = x;
			_gfx.y = y;
			if (!g.contains(_gfx)) {
				g.addChild(_gfx);
			}
		}

		override public function remove(g : Canvas) : void {
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
