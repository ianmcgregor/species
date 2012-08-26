package org.alwaysinbeta.species.systems {
	import flash.geom.Point;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.components.Level;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.factories.EntityFactory;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import flash.ui.Keyboard;
	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.games.utils.IKeyListener;
	import org.alwaysinbeta.games.utils.Input;
	import org.alwaysinbeta.species.components.Hero;
	import org.alwaysinbeta.species.components.Transform;





	/**
	 * @author McFamily
	 */
	public class PlayerControlSystem extends EntityProcessingSystem implements IKeyListener {
		private var _container : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _levelMapper : ComponentMapper;
		private var _moveUp : Boolean;
		private var _moveDown : Boolean;
		private var _moveLeft : Boolean;
		private var _moveRight : Boolean;
		private var _shoot : Boolean;
		
		private const SPEED : Number = 0.3;
		
		public function PlayerControlSystem(container : GameContainer) {
			super(Transform, [Hero]);
			_container = container;
		}
		
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_container.getInput().addKeyListener(this);
		}
		
		override protected function processEntity(e : Entity) : void {
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			var level: Level = _levelMapper.get(levelEntity);
			
			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);

			var amount : Number = _world.getDelta() * SPEED;
			
			var topLeft : Boolean = level.collides(transform.x, transform.y);
			var topRight :  Boolean = level.collides(transform.x + 32, transform.y);
			var bottomLeft :  Boolean = level.collides(transform.x, transform.y + 32);
			var bottomRight :  Boolean = level.collides(transform.x + 32, transform.y + 32);
			
			if(!bottomLeft && !bottomRight) {
				_moveDown = true;
				_moveUp = false;
			} else {
				_moveDown = false;
			}
			
			if(topLeft || bottomLeft) {
				_moveLeft = false;
			}else if(topRight || bottomRight) {
				_moveRight = false;
			}
			
			if (_moveUp) {
				transform.addY(-amount);
			}
			if (_moveDown) {
				transform.addY(amount);
			}
			if (_moveLeft) {
				transform.addX(-amount);
			}
			if (_moveRight) {
				transform.addX(amount);
			}
			// clamp
//			if (transform.y < 0) {
//				transform.y = 0;
//			} else if(transform.y > _container.getHeight() - 60) {
//				transform.y = _container.getHeight() - 60;
//			}
			
			if (_shoot) {
				var bullet : Entity = EntityFactory.createBullet(_world);
				Transform(bullet.getComponent(Transform)).setLocation(transform.x, transform.y);
				Velocity(bullet.getComponent(Velocity)).velocityX = 10;
				bullet.refresh();

				_shoot = false;
			}
		}
		
		
		// input

		public function keyPressed(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = true;
					_moveDown = false;
					break;
//				case Keyboard.S:
//				case Keyboard.DOWN:
//					_moveDown = true;
//					_moveUp = false;
//					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = true;
					_moveRight = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = true;
					_moveLeft = false;
					break;
				case Keyboard.SPACE:
					_shoot = true;
					break;
				default:
			}
		}

		public function keyReleased(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = false;
					break;
//				case Keyboard.S:
//				case Keyboard.DOWN:
//					_moveDown = false;
//					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = false;
					break;
				case Keyboard.SPACE:
					_shoot = false;
					break;
				default:
			}
		}
		
		public function inputEnded() : void {
		}

		public function inputStarted() : void {
		}

		public function isAcceptingInput() : Boolean {
			return true;
		}

		public function setInput(input : Input) : void {
		}
	}
}
