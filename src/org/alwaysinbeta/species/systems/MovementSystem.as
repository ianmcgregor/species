package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Level;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.constants.EntityTag;


	public class MovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _velocityMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _levelMapper : ComponentMapper;
		private var _rectMapper : ComponentMapper;

		public function MovementSystem(container : GameContainer) {
			super(Transform, [Velocity]);
			_container = container;
		}

		override public function initialize() : void {
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_levelMapper = new ComponentMapper(Level, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
		}

		override protected function processEntity(e : Entity) : void {
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			var level: Level = _levelMapper.get(levelEntity);
			var velocity : Velocity = _velocityMapper.get(e);
			var velocityX : Number = velocity.velocityX;
			var velocityY : Number = velocity.velocityY;
			var transform : Transform = _transformMapper.get(e);
			var rect : CollisionRect = _rectMapper.get(e);
			var x: int = transform.x;
			var y: int = transform.y;
//			if(rect){
//				x -= rect.rect.x;
//				y -= rect.rect.y;
//			}
			var w: int = rect != null ? rect.rect.width : 32;
			var h: int = rect != null ? rect.rect.height : 32;
			
			var targetX: int = x + velocityX;
//			trace('velocityX: ' + (velocityX));
			var targetY: int = y + velocityY;
//			trace('velocityY: ' + (velocityY));
			
			var newX: int;
			var newY: int;
			var margin : int = 3;
			
			if(targetX > x){
				newX = x;
				while (newX < targetX && !level.collides(newX + w + rect.rect.x, y - margin) && !level.collides(newX + w + rect.rect.x, y + h - margin)) {
					newX ++;
				}
				targetX = newX;
			} else if(targetX < x){
				newX = x;
				while(newX > targetX && !level.collides(newX + rect.rect.x, y - margin) && !level.collides(newX + rect.rect.x, y + h - margin)){
					newX --;
				}
				targetX = newX;
			}
			if (targetY > y) {
				newY = y;
				while(newY < targetY && !level.collides(targetX + margin, newY + h + rect.rect.y) && !level.collides(targetX + w - margin, newY + h + rect.rect.y)){
					newY ++;
//					trace('newY: ' + (newY));
				}
				targetY = newY;
			} else if(targetY < y){
				newY = y;
				while(newY > targetY && !level.collides(targetX + margin, newY + rect.rect.y) && !level.collides(targetX + w - margin, newY + rect.rect.y)){
					newY --;
				}
				targetY = newY;
			}
			
//			trace('is Y still colliding?: ',  !(  !level.collides(targetX, newY + h) && !level.collides(targetX + w, newY + h)  ) && !level.collides(targetX, newY) && !level.collides(targetX + w, newY));
			
			transform.setLocation(targetX, targetY);
//			var r : Number = velocity.getAngleAsRadians();
//			var xn : Number = transform.getX() + (Math.cos(r) * v * _world.getDelta());
//			var yn : Number = transform.getY() + (Math.sin(r) * v * _world.getDelta());
//			transform.setLocation(xn, yn);
		}
	}
}