package org.alwaysinbeta.species.spatials {
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.assets.Assets;
	import org.alwaysinbeta.species.components.Expires;
	import org.alwaysinbeta.species.components.Transform;



	public class BombGfx extends Spatial {
		private var _transform : Transform;
		private var _expires : Expires;
		private var _initialLifeTime : int;
		private var _particleSystem : PDParticleSystem;
		private var _life : Number;

		public function BombGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);
			
			var expiresMapper : ComponentMapper = new ComponentMapper(Expires, _world);
			_expires = expiresMapper.get(_owner);
			_initialLifeTime = _expires.getLifeTime();
			
//			_quad = new Quad(4, 4);
//			_quad.color = 0xff2222;
			
			var pex : XML =Assets.fireBall2Pex;
			var texture : Texture = Assets.fireBall2Texture;
			_particleSystem = new PDParticleSystem(pex, texture);
			Starling.juggler.add(_particleSystem);
			_particleSystem.start();
		}

		override public function render(g : Canvas) : void {
			_life = _expires.getLifeTime() / _initialLifeTime;
			
			if(!g.contains(_particleSystem))
			{
				g.addChild(_particleSystem);
			}
			
			_particleSystem.emitterX = _transform.x;
			_particleSystem.emitterY = _transform.y + 10;

			if (_life <= 0) {
				_particleSystem.stop();
				Starling.juggler.remove(_particleSystem);
				g.removeChild(_particleSystem);
			}
		}
		
		override public function remove(g : Canvas) : void {
			if (g.contains(_particleSystem)) {
				g.removeChild(_particleSystem);
				_particleSystem.stop();
				Starling.juggler.remove(_particleSystem);
			}
		}

	}
}