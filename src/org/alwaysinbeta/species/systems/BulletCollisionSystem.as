package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.constants.EntityGroup;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.factories.EntityFactory;

	public class BulletCollisionSystem extends EntitySystem {
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;

		public function BulletCollisionSystem() {
			super([Transform]);
		}

		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_healthMapper = new ComponentMapper(Health, _world);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
			var bullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BULLETS);
			var enemyBullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMY_BULLETS);
			var enemies : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);

			if (bullets != null && enemies != null) {
				enemyLoop:
				for (var a : int = 0; enemies.size() > a; a++) {
					var enemy : Entity = enemies.get(a);
					for (var b : int = 0; bullets.size() > b; b++) {
						var bullet : Entity = bullets.get(b);

						if (collisionExists(bullet, enemy)) {
							var bulletTransform : Transform = _transformMapper.get(bullet);
							EntityFactory.createExplosion(_world, bulletTransform.x, bulletTransform.y).refresh();
							
//							trace('world.deleteEntity(bullet);: ');
							_world.deleteEntity(bullet);

							var health : Health = _healthMapper.get(enemy);
							health.addDamage(4);

							if (!health.isAlive()) {
								var transform : Transform = _transformMapper.get(enemy);

								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();

//								trace('world.deleteEntity(ship);: ');
								_world.deleteEntity(enemy);
								continue enemyLoop;
							}
						}
					}
				}
			}
			
			if (enemyBullets != null) {
				for (var j : int = 0; enemyBullets.size() > j; j++) {
					var enemyBullet : Entity = enemyBullets.get(j);
	
					if(collisionExists(enemyBullet, hero)) {
						trace('hero shot!');
						
						var heroHealth : Health = _healthMapper.get(hero);
						heroHealth.addDamage(4);
						
						if (!heroHealth.isAlive()) {
							var t : Transform = _transformMapper.get(hero);
							EntityFactory.createExplosion(_world, t.x, t.y).refresh();
							_world.deleteEntity(hero);
						}
					}
				}
			}
		}

		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			var t1 : Transform = _transformMapper.get(e1);
			var t2 : Transform = _transformMapper.get(e2);
			return t1.getDistanceTo(t2) < 15;
		}

		override protected function checkProcessing() : Boolean {
			return true;
		}
	}
}