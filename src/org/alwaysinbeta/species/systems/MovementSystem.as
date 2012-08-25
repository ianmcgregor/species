package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;


	public class MovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _velocityMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;

		public function MovementSystem(container : GameContainer) {
			super(Transform, [Velocity]);
			_container = container;
		}

		override public function initialize() : void {
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function processEntity(e : Entity) : void {
			var velocity : Velocity = _velocityMapper.get(e);
			var velocityX : Number = velocity.velocityX;
			var velocityY : Number = velocity.velocityY;
			var transform : Transform = _transformMapper.get(e);
			var x: int = transform.x + velocityX;
			var y: int = transform.y + velocityY;
			transform.setLocation(x, y);
//			var r : Number = velocity.getAngleAsRadians();
//			var xn : Number = transform.getX() + (Math.cos(r) * v * _world.getDelta());
//			var yn : Number = transform.getY() + (Math.sin(r) * v * _world.getDelta());
//			transform.setLocation(xn, yn);
		}
	}
}