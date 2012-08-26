package org.alwaysinbeta.species.systems {
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.components.Velocity;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.species.components.Enemy;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Weapon;
	import org.alwaysinbeta.species.factories.EntityFactory;

	import flash.utils.getTimer;

	public class EnemyShooterSystem extends EntityProcessingSystem {
		private var _weaponMapper : ComponentMapper;
		private var _now : int;
		private var _transformMapper : ComponentMapper;

		public function EnemyShooterSystem() {
			super(Transform, [Weapon, Enemy]);
		}

		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(Weapon, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function begin() : void {
			_now = getTimer();
		}

		override protected function processEntity(e : Entity) : void {
			var weapon : Weapon = _weaponMapper.get(e);

			if (weapon.getShotAt() + 100 < _now) {
				
				var transform : Transform = _transformMapper.get(e);
				
				var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
				var heroTransform : Transform = _transformMapper.get(hero);
				var direction : int = heroTransform.x > transform.x ? 1 : -1;
				var bulletX: int = direction > 0 ? transform.x + 34 : transform.x + 2;
				var bullet : Entity = EntityFactory.createBullet(_world);
				Transform(bullet.getComponent(Transform)).setLocation( bulletX, transform.y);
				Velocity(bullet.getComponent(Velocity)).velocityX = 8 * direction;
//				Velocity(missile.getComponent(Velocity)).setAngle(270);
				bullet.refresh();

				weapon.setShotAt(_now);
			}
		}
	}
}