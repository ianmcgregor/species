package org.alwaysinbeta.species.systems {
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
			_transformMapper = new ComponentMapper(Transform, _world);
			_container.getInput().addKeyListener(this);
		}
		
		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);

			if (_moveUp) {
				transform.addY(_world.getDelta() * -SPEED);
			}
			if (_moveDown) {
				transform.addY(_world.getDelta() * SPEED);
			}
			if (_moveLeft) {
				transform.addX(_world.getDelta() * -SPEED);
			}
			if (_moveRight) {
				transform.addX(_world.getDelta() * SPEED);
			}
			// clamp
			if (transform.y < 0) {
				transform.y = 0;
			} else if(transform.y > _container.getHeight() - 60) {
				transform.y = _container.getHeight() - 60;
			}
			
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
				case Keyboard.S:
				case Keyboard.DOWN:
					_moveDown = true;
					_moveUp = false;
					break;
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
				case Keyboard.S:
				case Keyboard.DOWN:
					_moveDown = false;
					break;
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
