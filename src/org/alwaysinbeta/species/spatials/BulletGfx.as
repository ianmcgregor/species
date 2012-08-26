package org.alwaysinbeta.species.spatials {
	import org.alwaysinbeta.species.components.Expires;
	import starling.display.Quad;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.Transform;



	public class BulletGfx extends Spatial {
		private var _transform : Transform;
		private var _quad : Quad;
		private var _expires : Expires;
		private var _initialLifeTime : int;

		public function BulletGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);
			
			var expiresMapper : ComponentMapper = new ComponentMapper(Expires, _world);
			_expires = expiresMapper.get(_owner);
			_initialLifeTime = _expires.getLifeTime();
			
			_quad = new Quad(2, 2);
			_quad.color = 0xffffff;
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_quad.alpha = _expires.getLifeTime() / _initialLifeTime;
			_quad.x = x;
			_quad.y = y;
			if(!g.contains(_quad)){
				g.addChild(_quad);
			}
			
			if (_expires.getLifeTime() / _initialLifeTime <= 0) {
				g.removeChild(_quad);
			}
		}

		override public function remove(g : Canvas) : void {
			if (g.contains(_quad)) {
				g.removeChild(_quad);
			}
		}

	}
}