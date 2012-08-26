package org.alwaysinbeta.species.states {
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.Species;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.constants.StateConstants;
	import org.alwaysinbeta.species.factories.EntityFactory;
	import org.alwaysinbeta.species.systems.BulletCollisionSystem;
	import org.alwaysinbeta.species.systems.CollisionSystem;
	import org.alwaysinbeta.species.systems.EnemyMovementSystem;
	import org.alwaysinbeta.species.systems.EnemyShooterSystem;
	import org.alwaysinbeta.species.systems.ExpirationSystem;
	import org.alwaysinbeta.species.systems.HealthBarRenderSystem;
	import org.alwaysinbeta.species.systems.LevelInitializeSystem;
	import org.alwaysinbeta.species.systems.MovementSystem;
	import org.alwaysinbeta.species.systems.PlayerControlSystem;
	import org.alwaysinbeta.species.systems.RenderSystem;

	/**
	 * @author McFamily
	 */
	public class PlayState implements IState {
		private var _world : World;
		private var _container : GameContainer;
		private var _main : Species;
		private var _playerControlSystem : EntitySystem;
		private var _collisionSystem : EntitySystem;
		private var _enemyMovementSystem : EntitySystem;
		private var _renderSystem : EntitySystem;
		private var _expirationSystem : EntitySystem;
//		private var _enemySpawnSystem : EntitySystem;
		private var _movementSystem : EntitySystem;
		private var _bulletCollisionSystem : EntitySystem;
		private var _healthBarRenderSystem : EntitySystem;
		private var _enemyShooterSystem : EntitySystem;
		private var _levelInitializeSystem : EntitySystem;

		public function PlayState(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		
		public function init() : void {
			if(_world){
				reset();
				return;
			}
			
			_world = new World();
			
			// init systems
			
			var systemManager : SystemManager = _world.getSystemManager();
			
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_container));
			_collisionSystem = systemManager.setSystem(new CollisionSystem());
			_enemyMovementSystem = systemManager.setSystem(new EnemyMovementSystem(_container));
			_renderSystem = systemManager.setSystem(new RenderSystem(_container));
			_expirationSystem = systemManager.setSystem(new ExpirationSystem());
//			_enemySpawnSystem = systemManager.setSystem(new EnemySpawnSystem(2000, _container));
			_movementSystem = systemManager.setSystem(new MovementSystem(_container));
			_bulletCollisionSystem = systemManager.setSystem(new BulletCollisionSystem());
			_healthBarRenderSystem = systemManager.setSystem(new HealthBarRenderSystem());
			_enemyShooterSystem = systemManager.setSystem(new EnemyShooterSystem());
			_levelInitializeSystem = systemManager.setSystem(new LevelInitializeSystem());
			
			systemManager.initializeAll();
			
			// init entities
			
			EntityFactory.createLevel(_world, 1);
			EntityFactory.createHero(_world);
		}
		
		public function update(container : GameContainer, delta : int) : void {
			container;
			
			_world.loopStart();

			_world.setDelta(delta);
			
			// check for game over
			
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			if(!hero) {
				_main.changeState(StateConstants.GAME_OVER);
				return;
			}
			
			// process systems
			_levelInitializeSystem.process();
			_collisionSystem.process();
			_playerControlSystem.process();
			_enemyMovementSystem.process();
			_expirationSystem.process();
//			_enemySpawnSystem.process();
			_movementSystem.process();
			_bulletCollisionSystem.process();
			_healthBarRenderSystem.process();
			_enemyShooterSystem.process();
			
			// render
			
			_renderSystem.process();
		}
		
		private function reset() : void {
		}

		public function get world() : World {
			return _world;
		}

	}
}
