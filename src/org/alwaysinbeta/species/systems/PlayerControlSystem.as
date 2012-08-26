package org.alwaysinbeta.species.systems {
	import flash.utils.setTimeout;
	import flash.utils.getTimer;
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
		private var _level : Level;
		private var _moveUpTime : int;
		private var _isJumping : Boolean;
		private var _jumpPower : Number;
		private var _lastDirection : int;

		public function PlayerControlSystem(container : GameContainer) {
			super(Transform, [Hero]);
			_container = container;
		}

		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_container.getInput().addKeyListener(this);
			_lastDirection = 1;
		}

		override protected function processEntity(e : Entity) : void {
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			_level = _levelMapper.get(levelEntity);

			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);
			velocity.velocityX = velocity.velocityY = 0;

			var amount : Number = _world.getDelta() * SPEED;

			var topLeft : Boolean = _level.collides(transform.x, transform.y);
			var topRight : Boolean = _level.collides(transform.x + 32, transform.y);
			var bottomLeft : Boolean = _level.collides(transform.x, transform.y + 32);
			var bottomRight : Boolean = _level.collides(transform.x + 32, transform.y + 32);

			if (!_isJumping && !bottomLeft && !bottomRight) {
				_moveDown = true;
			}

			if (_isJumping) {
				_jumpPower -= 0.05;
				velocity.velocityY = _world.getDelta() * -_jumpPower;
				if(getTimer() - _moveUpTime > 200){
					_isJumping = false;
				}
			} else  if (_moveUp && ( _level.collides(transform.x, transform.y + 33 ) || _level.collides(transform.x + 32, transform.y + 33 ) )) {
				_jumpPower = 0.8;
				velocity.velocityY = _world.getDelta() * -_jumpPower;
				_isJumping = true;
				_moveDown = false;
				_moveUpTime = getTimer();
			} 
			if (_moveDown) {
				velocity.velocityY = amount;
			}
			if (_moveLeft) {
				velocity.velocityX = -amount;
				_lastDirection = -1;
			}
			if (_moveRight) {
				velocity.velocityX = amount;
				_lastDirection = 1;
			}
			
//			moveBy(velocity.velocityX, velocity.velocityY, transform, velocity);
			
			if (_shoot) {
				var direction : int = _lastDirection;
				var bulletX: int = direction > 0 ? transform.x + 34 : transform.x - 2;
				var bullet : Entity = EntityFactory.createBullet(_world);
				Transform(bullet.getComponent(Transform)).setLocation(bulletX, transform.y);
				Velocity(bullet.getComponent(Velocity)).velocityX = 10 * direction;
				Velocity(bullet.getComponent(Velocity)).velocityY = -2 + Math.random() * 4;
				bullet.refresh();

//				_shoot = false;
			}
		}

		private function moveBy(x : int, y : int, transform : Transform, velocity: Velocity) : void {
			trace("PlayerControlSystem.moveBy(",x, y, transform,")");
			var sign : int;
			if (x != 0 && rectCollides(transform.x + x, transform.y, 31, 31)) {
				sign = x > 0 ? 1 : -1;
				while (x != 0) {
					if (!rectCollides(transform.x + sign, transform.y, 31, 31)) {
						transform.x += sign;
					}
					x -= sign;
				}
			} else {
				transform.x += x;
			}
			
			transform.y += y;
		}
		
		private function rectCollides(x: int, y: int, width: int, height: int) : Boolean {
			return _level.collides(x, y) || _level.collides(x + width, y) || _level.collides(x, y + height) || _level.collides(x + width, y + height);
		}

		// input
		public function keyPressed(key : uint, c : String) : void {
			switch(key) {
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = true;
					_moveDown = false;
					break;
				// case Keyboard.S:
				// case Keyboard.DOWN:
				// _moveDown = true;
				// _moveUp = false;
				// break;
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
			switch(key) {
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = false;
					break;
				// case Keyboard.S:
				// case Keyboard.DOWN:
				// _moveDown = false;
				// break;
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
