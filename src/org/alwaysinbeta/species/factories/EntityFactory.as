package org.alwaysinbeta.species.factories {
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.species.components.Bomb;
	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Enemy;
	import org.alwaysinbeta.species.components.EnemyShip;
	import org.alwaysinbeta.species.components.Expires;
	import org.alwaysinbeta.species.components.Friend;
	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Hero;
	import org.alwaysinbeta.species.components.Level;
	import org.alwaysinbeta.species.components.SpatialForm;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.components.Weapon;
	import org.alwaysinbeta.species.constants.EntityGroup;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.spatials.BombGfx;
	import org.alwaysinbeta.species.spatials.BulletGfx;
	import org.alwaysinbeta.species.spatials.EnemyGfx;
	import org.alwaysinbeta.species.spatials.EnemyShipGfx;
	import org.alwaysinbeta.species.spatials.ExplosionGfx;
	import org.alwaysinbeta.species.spatials.FirePitGfx;
	import org.alwaysinbeta.species.spatials.FriendGfx;
	import org.alwaysinbeta.species.spatials.HealthBarGfx;
	import org.alwaysinbeta.species.spatials.HeroGfx;
	import org.alwaysinbeta.species.spatials.LevelGfx;
	import org.alwaysinbeta.species.spatials.WallGfx;

	import flash.geom.Rectangle;

	public class EntityFactory {
		
		public static function createLevel(world : World, num: int) : Entity {
			var e : Entity;
			e = world.createEntity();
			e.setTag(EntityTag.LEVEL);
			e.addComponent(new Level(num));
			e.addComponent(new Transform(0, 0));
			e.addComponent(new SpatialForm(LevelGfx));
			e.refresh();

			return e;
		}
		
		public static function createHero(world : World) : Entity {
			var heroHealth: Number = 200;
			
			var e : Entity;
			e = world.createEntity();
			e.setTag(EntityTag.HERO);
			e.addComponent(new Velocity());
			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(HeroGfx));
			e.addComponent(new CollisionRect(5, 4, 22, 28));
			e.addComponent(new Health(heroHealth));
			e.addComponent(new Hero());
			e.addComponent(new Weapon());
			e.refresh();
			
			e = world.createEntity();
			e.setTag(EntityTag.HEALTH_BAR);
			e.addComponent(new SpatialForm(HealthBarGfx));
			e.addComponent(new Health(heroHealth));
			e.addComponent(new Transform(120, 10));
			e.refresh();

			return e;
		}
		
		public static function createBullet(world : World) : Entity {
			SoundFactory.shoot();
			
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.BULLETS);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(BulletGfx));
			e.addComponent(new Velocity());
			e.addComponent(new Expires(1000));
			e.addComponent(new CollisionRect(0, 0, 2, 2));

			return e;
		}
		
		public static function createEnemyBullet(world : World) : Entity {
			SoundFactory.shoot();
			
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMY_BULLETS);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(BulletGfx));
			e.addComponent(new Velocity());
			e.addComponent(new Expires(1000));
			e.addComponent(new CollisionRect(0, 0, 2, 2));

			return e;
		}

		public static function createWeaponisedEnemy(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMIES);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(EnemyGfx));
			e.addComponent(new Health(50));
			e.addComponent(new Weapon());
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(10, 0, 22, 32));

			return e;
		}
		
		public static function createMoustachedEnemy(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMIES);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(EnemyGfx));
			e.addComponent(new Health(50));
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(10, 0, 22, 32));

			return e;
		}
		
		public static function createEnemyShip(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setTag(EntityTag.ENEMY_SHIP);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(EnemyShipGfx));
			e.addComponent(new EnemyShip());
			e.addComponent(new Velocity(8));
			e.addComponent(new Weapon());
			e.addComponent(new CollisionRect(0, 0, 64, 48));

			return e;
		}

		public static function createExplosion(world : World, x : Number, y : Number) : Entity {
			SoundFactory.explode();
			
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.EFFECTS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new SpatialForm(ExplosionGfx));
			e.addComponent(new Expires(1000));

			return e;
		}
		
		public static function createBomb(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.BOMBS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new Velocity());
			e.addComponent(new SpatialForm(BombGfx));
			e.addComponent(new Expires(2000));
			e.addComponent(new CollisionRect(4, 4, 20, 20));
			e.addComponent(new Bomb());

			return e;
		}
		
		public static function createFirePit(world : World) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.FIRES);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(FirePitGfx));
			e.addComponent(new CollisionRect(4, 4, 16, 16));

			return e;
		}
		
		public static function createWall(world : World, rect: Rectangle) : Entity {
			var e : Entity = world.createEntity();

			e.setTag(EntityTag.WALL);

			e.addComponent(new Transform(rect.x, rect.y));
			e.addComponent(new SpatialForm(WallGfx));
			e.addComponent(new CollisionRect(0, 0, rect.width, rect.height));

			return e;
		}

		public static function createFriend(world : World) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.FRIENDS);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(FriendGfx));
			e.addComponent(new Friend());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(0, 0, 32, 32));

			return e;
		}
	}
}