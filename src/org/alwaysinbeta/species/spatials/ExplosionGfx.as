package org.alwaysinbeta.species.spatials {
	import starling.core.Starling;

	import org.alwaysinbeta.species.assets.Assets;

	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Expires;
	import org.alwaysinbeta.games.base.Spatial;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	public class ExplosionGfx extends Spatial {
		private var _transform : Transform;
		private var _expires : Expires;
		private var _initialLifeTime : int;
		private var _life : Number;
		private var _particleSystem : PDParticleSystem;

		public function ExplosionGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

			var expiresMapper : ComponentMapper = new ComponentMapper(Expires, _world);
			_expires = expiresMapper.get(_owner);
			_initialLifeTime = _expires.getLifeTime();

			// instantiate embedded objects
			var pex : XML = XML(new Assets.ParticlePex());
			var texture : Texture = Texture.fromBitmap(new Assets.ParticleTexture());

			// create particle system
			_particleSystem = new PDParticleSystem(pex, texture);
			// ps.x = 160;
			// ps.y = 240;

			// add it to the stage and the juggler
		//	Starling.current.stage.addChild(ps);
			Starling.juggler.add(_particleSystem);

			// change position where particles are emitted
			// ps.emitterX = 20;
			// ps.emitterY = 40;

			// start emitting particles
			_particleSystem.start();

			// emit particles for two seconds, then stop
			// ps.start(2.0);
			 
			// stop emitting particles
			// ps.stop();
		}

		override public function render(g : Canvas) : void {
			_life = _expires.getLifeTime() / _initialLifeTime;
			
			if(!g.contains(_particleSystem))
			{
				g.addChild(_particleSystem);
			}
			
			// ps.x = _transform.x;
			// ps.y = _transform.y;
			_particleSystem.emitterX = _transform.x;
			_particleSystem.emitterY = _transform.y;

			if (_life <= 0) {
				_particleSystem.stop();
				Starling.juggler.remove(_particleSystem);
				g.removeChild(_particleSystem);
			}
		}
		
		override public function remove(g : Canvas) : void {
			if (g.contains(_particleSystem)) {
				g.removeChild(_particleSystem);
			}
		}
	}
}