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
	import org.alwaysinbeta.species.components.Velocity;

	/**
	 * @author McFamily
	 */
	public class HeroGfx extends Spatial {
		private var _transform : Transform;
//		private var _gfx : Quad;
		private var _gfx : MovieClip;
		private var _velocity : Velocity;

		public function HeroGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			var velocityMapper : ComponentMapper = new ComponentMapper(Velocity, _world);
			_transform = transformMapper.get(_owner);
			_velocity = velocityMapper.get(_owner);
			var textures : Vector.<Texture> = new Vector.<Texture>();
			textures.push(Assets.heroTexture2, Assets.heroTexture1);
			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
//			_gfx = new Quad(32, 32);
//			_gfx.color = 0x00ff00;
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_gfx.x = x;
			_gfx.y = y;
			if (!g.contains(_gfx)) {
				g.addChild(_gfx);
			}
			
			if(_velocity.velocityX < 0) {
				_gfx.scaleX = -1;
			} else if(_velocity.velocityX > 0) {
				_gfx.scaleX = 1;
			}
			
			if(_gfx.scaleX == -1){
				_gfx.x +=_gfx.width;
			}
			
			if(_velocity.velocityX != 0){
				if(!_gfx.isPlaying){
					_gfx.play();
				}
			} else {
				if(_gfx.isPlaying){
					_gfx.pause();
				}
			}
			
//			showCollisionRect(g, _transform.x, _transform.y);
		}
	}
}
