package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.components.Enemy;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.constants.EntityTag;


	/**
	 * @author McFamily
	 */
	public class EnemyMovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private const SPEED: Number = 0.2;
		private const MIN_DISTANCE: int = 15;
		
		public function EnemyMovementSystem(container : GameContainer) {
			super(Transform, [Enemy]);
			_container = container;
		}
		
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}
		
		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);

			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroTransform : Transform = _transformMapper.get(hero);
			var distance: int = transform.getDistanceTo(heroTransform);
			var approach : Boolean = distance < 200;
			
			var moveUp : Boolean;
			var moveDown : Boolean;
			var moveLeft : Boolean;
			var moveRight : Boolean;
			if( approach ) {
				moveUp = heroTransform.y < transform.y - MIN_DISTANCE;
				moveDown = heroTransform.y > transform.y + MIN_DISTANCE;
				moveLeft = heroTransform.x < transform.x - MIN_DISTANCE;
				moveRight = heroTransform.x > transform.x + MIN_DISTANCE;
				
				if (moveUp) {
					transform.addY(_world.getDelta() * -SPEED);
				} else if(moveDown) {
					transform.addY(_world.getDelta() * SPEED);
				}
				if (moveLeft) {
					transform.addX(_world.getDelta() * -SPEED);
				} else if(moveRight) {
					transform.addX(_world.getDelta() * SPEED);
				}
			}
			// clamp
//			if (transform.y < 0) {
//				transform.y = 0;
//			} else if(transform.y > _container.getHeight() - 60) {
//				transform.y = _container.getHeight() - 60;
//			}
		}
	}
}
