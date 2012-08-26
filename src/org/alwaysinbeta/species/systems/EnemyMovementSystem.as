package org.alwaysinbeta.species.systems {
	import flash.utils.getTimer;
	import org.alwaysinbeta.species.components.Level;
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
		private const MIN_DISTANCE : int = 1;
		private var _levelMapper : ComponentMapper;
		private var _isJumping : Boolean;
		private var _jumpPower : Number;
		private var _moveUpTime : int;
		
		public function EnemyMovementSystem(container : GameContainer) {
			super(Transform, [Enemy]);
			_container = container;
		}
		
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}
		
		override protected function processEntity(e : Entity) : void {
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			var level: Level = _levelMapper.get(levelEntity);
			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);
			velocity.velocityX = velocity.velocityY = 0;
			if(velocity.speed == 0) {
				velocity.speed = 0.1 + Math.random() * 0.1;
			}
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroTransform : Transform = _transformMapper.get(hero);
			var distance: int = transform.getDistanceTo(heroTransform);
			var approach : Boolean = distance > 32;
			
			var moveUp : Boolean;
			var moveDown : Boolean;
			var moveLeft : Boolean;
			var moveRight : Boolean;
			if( approach ) {
				//moveUp = heroTransform.y < transform.y - MIN_DISTANCE;
				//moveDown = heroTransform.y > transform.y + MIN_DISTANCE;
				moveLeft = heroTransform.x < transform.x - MIN_DISTANCE;
				moveRight = heroTransform.x > transform.x + 32 + MIN_DISTANCE;
				var amount : Number = _world.getDelta() * velocity.speed;
				

				if (moveLeft) {
					velocity.velocityX = -amount;
				} else if(moveRight) {
					velocity.velocityX = amount;
				}
				
				var topLeft : Boolean = level.collides(transform.x, transform.y);
				var topRight : Boolean = level.collides(transform.x + 32, transform.y);
				var bottomLeft : Boolean = level.collides(transform.x, transform.y + 32);
				var bottomRight : Boolean = level.collides(transform.x + 32, transform.y + 32);
				
				if(moveLeft && level.collides(transform.x + velocity.velocityX, transform.y + 32) && !level.collides(transform.x + velocity.velocityX, transform.y)) {
					moveUp = true;
				}
				if(moveRight && level.collides(transform.x + 32 + velocity.velocityX, transform.y + 32) && !level.collides(transform.x + 32 + velocity.velocityX, transform.y)) {
					moveUp = true;
				}
	
				if (!_isJumping && !bottomLeft && !bottomRight) {
					moveDown = true;
				}
				
				if (_isJumping) {
					_jumpPower -= 0.05;
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					if(getTimer() - _moveUpTime > 200){
						_isJumping = false;
					}
				} else  if (moveUp && ( level.collides(transform.x, transform.y + 33 ) || level.collides(transform.x + 32, transform.y + 33 ) )) {
					trace('jump!');
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					_jumpPower = 0.5;
					_isJumping = true;
					moveDown = false;
					_moveUpTime = getTimer();
				} 
				if(moveDown) {
					velocity.velocityY = amount;
				}
			}
		}
	}
}
