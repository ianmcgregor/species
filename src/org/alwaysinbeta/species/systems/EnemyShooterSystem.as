package org.alwaysinbeta.species.systems {
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

			if (weapon.getShotAt() + 2000 < _now) {
				var transform : Transform = _transformMapper.get(e);

				var missile : Entity = EntityFactory.createBullet(_world);
				Transform(missile.getComponent(Transform)).setLocation(transform.x, transform.y + 20);
//				Velocity(missile.getComponent(Velocity)).setVelocity(-0.5);
//				Velocity(missile.getComponent(Velocity)).setAngle(270);
				missile.refresh();

				weapon.setShotAt(_now);
			}
		}
	}
}