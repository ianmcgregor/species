package org.alwaysinbeta.species.spatials {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.assets.Assets;
	import org.alwaysinbeta.species.components.Transform;

	/**
	 * @author McFamily
	 */
	public class FriendGfx extends Spatial {
		private var _transform : Transform;
//		private var _gfx : Quad;
			private var _gfx : MovieClip;

		public function FriendGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

//			_gfx = new Quad(20, 20);
//			_gfx.color = 0x00ffff;
var textures : Vector.<Texture> = new Vector.<Texture>();
			textures.push(Assets.friendTexture2, Assets.friendTexture1);
			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
			_gfx.play();
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
	}
}
