package org.alwaysinbeta.species.systems {
	import org.alwaysinbeta.species.factories.SoundFactory;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.species.components.CollisionRect;
	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Hero;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.components.Velocity;
	import org.alwaysinbeta.species.constants.EntityGroup;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.factories.EntityFactory;


	/**
	 * @author McFamily
	 */
	public class CollisionSystem extends EntityProcessingSystem {
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _rectMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		public function CollisionSystem() {
			super(Transform, [CollisionRect]);
		}
		
		override public function initialize() : void {
			_healthMapper = new ComponentMapper(Health, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			if(hero != null){
				var transform : Transform = _transformMapper.get(hero);
				var health : Health = _healthMapper.get(hero);
				var enemies : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);
				
				if (enemies != null) {
					enemyLoop:
					for (var a : int = 0; enemies.size() > a; a++) {
						var enemy : Entity = enemies.get(a);
	
						if (collisionExists(hero, enemy)) {
							health.addDamage(1);
							//SoundFactory.grapple();
	
							if (!health.isAlive()) {
	
								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();
	
								_world.deleteEntity(hero);
								continue enemyLoop;
							}
						}
					}
				}
				
				var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
				if (bombs != null) {
					bombsLoop:
					for (var b : int = 0; bombs.size() > b; b++) {
						var bomb : Entity = bombs.get(b);
	
						if (collisionExists(hero, bomb)) {
							
							health.addDamage(50);
							
							if (!health.isAlive()) {
								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();
	
								_world.deleteEntity(hero);
								continue bombsLoop;
							}
						}
					}
				}
				var friends : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.FRIENDS);
				if (friends != null) {
					for (var f : int = 0; friends.size() > f; f++) {
						var friend : Entity = friends.get(f);
	
						if (collisionExists(hero, friend)) {
							var heroComponent: Hero = Hero(hero.getComponent(Hero));
							heroComponent.won = true;
						}
					}
				}
			}
		} 

		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			var t1 : Transform = _transformMapper.get(e1);
			var t2 : Transform = _transformMapper.get(e2);
			var r1 : CollisionRect = _rectMapper.get(e1);
			var r2 : CollisionRect = _rectMapper.get(e2);
			
			r1.rect.x = t1.x;
			r1.rect.y = t1.y;
			
			r2.rect.x = t2.x;
			r2.rect.y = t2.y;
			
			return r1.rect.intersects(r2.rect);
		}
	}
}
