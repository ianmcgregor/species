package org.alwaysinbeta.species.factories {
	import com.artemis.Entity;
	import com.artemis.World;
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Enemy;
	import org.alwaysinbeta.species.components.Expires;
	import org.alwaysinbeta.species.components.Friend;
	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Hero;
	import org.alwaysinbeta.species.components.SpatialForm;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.components.Weapon;
	import org.alwaysinbeta.species.constants.EntityGroup;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.spatials.BulletGfx;
	import org.alwaysinbeta.species.spatials.EnemyGfx;
	import org.alwaysinbeta.species.spatials.ExplosionGfx;
	import org.alwaysinbeta.species.spatials.FriendGfx;
	import org.alwaysinbeta.species.spatials.HealthBarGfx;
	import org.alwaysinbeta.species.spatials.HeroGfx;

	public class EntityFactory {
		
		public static function createHero(world : World) : Entity {
			var e : Entity;
			e = world.createEntity();
			e.setTag(EntityTag.HERO);
			e.addComponent(new Transform(20, 200));
			e.addComponent(new SpatialForm(HeroGfx));
			e.addComponent(new CollisionRect(0, 0, 20, 20));
			e.addComponent(new Health(1000));
			e.addComponent(new Hero());
			e.refresh();
			
			e = world.createEntity();
			e.setTag(EntityTag.HEALTH_BAR);
			e.addComponent(new SpatialForm(HealthBarGfx));
			e.addComponent(new Health(1000));
			e.addComponent(new Transform(300, 10));
			e.refresh();

			return e;
		}
		
		public static function createBullet(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.BULLETS);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(BulletGfx));
			e.addComponent(new Velocity());
			e.addComponent(new Expires(1000));

			return e;
		}

		public static function createEnemy(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMIES);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(EnemyGfx));
			e.addComponent(new Health(10));
			e.addComponent(new Weapon());
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(0, 0, 20, 20));

			return e;
		}

		public static function createExplosion(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.EFFECTS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new SpatialForm(ExplosionGfx));
			e.addComponent(new Expires(1000));

			return e;
		}

		public static function createFriend(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.FRIENDS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new SpatialForm(FriendGfx));
			e.addComponent(new Health(10));
			e.addComponent(new Friend());
			e.addComponent(new Velocity());

			return e;
		}
	}
}