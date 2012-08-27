package org.alwaysinbeta.species.spatials {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.Transform;

	import flash.display.BitmapData;

	/**
	 * @author McFamily
	 */
	public class EnemyShipGfx extends Spatial {
		private var _transform : Transform;
		private var _gfx : MovieClip;

		public function EnemyShipGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);
			var textures : Vector.<Texture> = new Vector.<Texture>();
//			if (weapon != null) {
//				textures.push(Assets.enemyGunTexture1, Assets.enemyGunTexture2);
//			} else {
//				textures.push(Assets.enemyMoustacheTexture1, Assets.enemyMoustacheTexture2);
//			}
			textures.push( Texture.fromBitmapData( new BitmapData(64, 48, true, 0xFFFF0000)));

			// _gfx = new Quad(32, 32);
			// _gfx.color = 0xff0000;

			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
		}

		override public function render(g : Canvas) : void {
			trace("EnemyShipGfx.render(",g,")");
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_gfx.x = x;
			_gfx.y = y;
			if (!g.contains(_gfx)) {
				g.addChild(_gfx);
			}
		}

		override public function remove(g : Canvas) : void {
			trace("EnemyShipGfx.remove(",g,")");
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
				Starling.current.juggler.remove(_gfx);
			}
		}
	}
}
