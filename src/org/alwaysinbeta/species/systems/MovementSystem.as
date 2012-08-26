package org.alwaysinbeta.species.systems {
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.components.Level;
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
			var x: int = transform.x + velocityX;
			var y: int = transform.y + velocityY;
			
			var w: int = rect != null ? rect.rect.width : 32;
			var h: int = rect != null ? rect.rect.height : 32;
			
			var newX: int;
			var newY: int;
			
			if(x > transform.x){
				newX = transform.x;
				while(newX < x && !level.collides(newX + w, transform.y) && !level.collides(newX + w, transform.y + h)){
					newX ++;
				}
				x = newX - 1;
			}
			if(x < transform.x){
				newX = transform.x;
				while(newX > x && !level.collides(newX, transform.y) && !level.collides(newX, transform.y + h)){
					newX --;
				}
				x = newX + 1;
			}
			if(y > transform.y){
				newY = transform.y;
				while(newY < y && !level.collides(transform.x, newY + h) && !level.collides(transform.x + w, newY + h)){
					newY ++;
				}
				y = newY - 1;
			}
			if(y < transform.y){
				newY = transform.y;
				while(newY > y && !level.collides(transform.x, newY) && !level.collides(transform.x + w, newY)){
					newY --;
				}
				y = newY + 1;
			}
			
			transform.setLocation(x, y);
//			var r : Number = velocity.getAngleAsRadians();
//			var xn : Number = transform.getX() + (Math.cos(r) * v * _world.getDelta());
//			var yn : Number = transform.getY() + (Math.sin(r) * v * _world.getDelta());
//			transform.setLocation(xn, yn);
		}
	}
}