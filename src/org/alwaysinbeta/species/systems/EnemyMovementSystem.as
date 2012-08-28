package org.alwaysinbeta.species.systems {
	import org.alwaysinbeta.species.components.CollisionRect;
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
		private var _jumpedAt : int;
		private var _rectMapper : ComponentMapper;
		
		public function EnemyMovementSystem(container : GameContainer) {
			super(Transform, [Enemy]);
			_container = container;
		}
		
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
			_jumpedAt = getTimer();
		}
		
		override protected function processEntity(e : Entity) : void {
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			var level: Level = _levelMapper.get(levelEntity);
			var transform : Transform = _transformMapper.get(e);
			var rect : CollisionRect = _rectMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);
			velocity.velocityX = velocity.velocityY = 0;
			if(velocity.speed == 0) {
				velocity.speed = 0.06 + Math.random() * 0.04;
			}
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroTransform : Transform = _transformMapper.get(hero);
			var distance: int = transform.getDistanceTo(heroTransform);
			var approach : Boolean = distance > 20 && distance < 320;
			
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
				

				var x: int = rect.rect.x + transform.x;
				var y: int = rect.rect.y + transform.y;
				var w: int = rect.rect.width;
				var h: int = rect.rect.height;
				
				
//				var topLeft : Boolean = level.collides(x, y);
//				var topRight : Boolean = level.collides(x + w, y);
//				var bottomLeft : Boolean = level.collides(x, y + h);
//				var bottomRight : Boolean = level.collides(x + w, y + h);

			//	var bottomLeft : Boolean = level.collides(transform.x + rect.rect.x, transform.y + rect.rect.height * 0.9);
				//var bottomRight : Boolean = level.collides(transform.x + rect.rect.width + rect.rect.x, transform.y + rect.rect.height * 0.9);
				var bottomLeft : Boolean = level.collides(transform.x + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
				var bottomRight : Boolean = level.collides(transform.x + rect.rect.width + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
				
				if (moveLeft) {
					velocity.velocityX = -amount;
				} else if(moveRight) {
					velocity.velocityX = amount;
				} 
				
				if(moveLeft && level.collides(x + velocity.velocityX, transform.y + rect.rect.height - 1)) {
					moveUp = true;
				}
				
				if(moveRight && level.collides(x + w + velocity.velocityX, transform.y + rect.rect.height - 1)) {
					moveUp = true;
				}
				
				if(!_isJumping && !bottomLeft && !bottomRight) {
					moveDown = true;
				}
	
				
//				trace('getTimer() - _jumpedAt: ' + (getTimer() - _jumpedAt));
				if (_isJumping) {
					_jumpPower -= 0.05;
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					if(getTimer() - _moveUpTime > 200){
						_isJumping = false;
					}
				} else  if (getTimer() - _jumpedAt > 1000 && moveUp && ( level.collides(x, y + h + 2 ) || level.collides(x + w, y + h + 2 ) )) {
//					trace('>> jump! <<');
					_jumpPower = 0.4;
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					_isJumping = true;
					moveDown = false;
					_moveUpTime = _jumpedAt = getTimer();
				} 
				if(moveDown) {
					velocity.velocityY = amount;
				}
			}
		}
	}
}
