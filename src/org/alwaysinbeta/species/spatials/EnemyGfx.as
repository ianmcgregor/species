package org.alwaysinbeta.species.spatials {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.assets.Assets;
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.components.Weapon;

	/**
	 * @author McFamily
	 */
	public class EnemyGfx extends Spatial {
		private var _transform : Transform;
		private var _velocity : Velocity;
		// private var _gfx : Quad;
		private var _gfx : MovieClip;

		public function EnemyGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			var velocityMapper : ComponentMapper = new ComponentMapper(Velocity, _world);
			var weaponMapper : ComponentMapper = new ComponentMapper(Weapon, _world);
			_transform = transformMapper.get(_owner);
			_velocity = velocityMapper.get(_owner);
			var weapon: Weapon = weaponMapper.get(_owner);
			var textures : Vector.<Texture> = new Vector.<Texture>();
			trace('weapon: ' + (weapon));
			if (weapon != null) {
				textures.push(Assets.enemyGunTexture1, Assets.enemyGunTexture2);
			} else {
				textures.push(Assets.enemyMoustacheTexture1, Assets.enemyMoustacheTexture2);
			}

			// _gfx = new Quad(32, 32);
			// _gfx.color = 0xff0000;

			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
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

		override public function remove(g : Canvas) : void {
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
				Starling.current.juggler.remove(_gfx);
			}
		}
	}
}
