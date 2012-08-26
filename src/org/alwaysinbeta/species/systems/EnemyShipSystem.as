package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.components.EnemyShip;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.components.Weapon;
	import org.alwaysinbeta.species.constants.EntityGroup;
	import org.alwaysinbeta.species.factories.EntityFactory;

	import flash.utils.getTimer;

	/**
	 * @author McFamily
	 */
	public class EnemyShipSystem extends EntityProcessingSystem {
		private var _container : GameContainer;	
		private var _weaponMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _now : int;
		
		public function EnemyShipSystem(container: GameContainer) {
			super(EnemyShip, [Transform, Velocity, Weapon]);
			_container = container;
		}
		
		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(Weapon, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}
		
		override protected function begin() : void {
			_now = getTimer();
		}

		override protected function processEntity(e : Entity) : void {
			var weapon : Weapon = _weaponMapper.get(e);
			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);
			if (weapon.getShotAt() + 500 < _now) {
				var bombEntity : Entity = EntityFactory.createBomb(_world, transform.x + 32, transform.y + 48);
				Velocity(bombEntity.getComponent(Velocity)).velocityY = 6;
				bombEntity.refresh();
				weapon.setShotAt(_now);
			}
			if(transform.x < 64) {
				velocity.velocityX = 7;
			}
			if(transform.x > _container.getWidth() - 128) {
				velocity.velocityX = -7;
			}
			
			var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
			if (bombs != null) {
				for (var b : int = 0; bombs.size() > b; b++) {
					var bomb : Entity = bombs.get(b);
					var bombTransform : Transform = _transformMapper.get(bomb);
					if (bombTransform.y > _container.getHeight() - 60) {
						EntityFactory.createExplosion(_world, bombTransform.x, bombTransform.y).refresh();
						_world.deleteEntity(bomb);
					}
				}
			}
		}
	}
}
