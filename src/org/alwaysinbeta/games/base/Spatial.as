package org.alwaysinbeta.games.base {
	import com.artemis.Entity;
	import com.artemis.World;



	public class Spatial {
		protected var _world : World;
		protected var _owner : Entity;

		public function Spatial(world : World, owner : Entity) {
			_world = world;
			_owner = owner;
		}

		public function initalize() : void {
		}

		public function render(g : Canvas) : void {
		}

		public function remove(g : Canvas) : void {
		}
		
		
//		protected var _rectQuad : Quad;
//		protected function showCollisionRect(g : Canvas, transformX: Number, transformY: Number): void {
//			var rectMapper : ComponentMapper = new ComponentMapper(CollisionRect, _world);
//			var r: CollisionRect = rectMapper.get(_owner);
//			if(r) {
//				if (!g.contains(_rectQuad)) {
//						_rectQuad = new Quad(r.rect.width, r.rect.height);
//						_rectQuad.color = 0x00FFFF;
//						_rectQuad.alpha = 0.6;
//						g.addChild(_rectQuad);
//				}
//				_rectQuad.x = transformX + r.rect.x;
//				_rectQuad.y = transformY + r.rect.y;
//				
////				if (!g.contains(_gfx) && g.contains(_rect)) {
////					g.removeChild(_rect);
////				}
//			}
//		}
	}
}