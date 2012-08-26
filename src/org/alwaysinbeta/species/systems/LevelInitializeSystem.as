package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.species.components.Level;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.factories.EntityFactory;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author McFamily
	 */
	public class LevelInitializeSystem extends EntityProcessingSystem {
		private var _processLevel : Boolean;
		private var _levelMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _heroRect : Rectangle;
		public function LevelInitializeSystem() {
			super(Level, []);
		}
		
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_processLevel = true;
		}

		override protected function processEntity(e : Entity) : void {
			var level: Level = _levelMapper.get(e);
			
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroTransfrom: Transform = _transformMapper.get(hero);
			
			// check if reached level exit
			if(!_heroRect) _heroRect = new Rectangle(0,0,32,32);
			 _heroRect.x = heroTransfrom.x;
			 _heroRect.y = heroTransfrom.y;
			if(level.exit.intersects(_heroRect)){
				var num: int = level.num + 1;
				_world.getEntityManager().remove(e);
				e = EntityFactory.createLevel(_world, num);
				_processLevel = true;
				level = _levelMapper.get(e);
			}
			
			// set up level
			
			if(_processLevel) {
				//level.parseOgmo( Assets.getLevel(level.num) );
				
				heroTransfrom.x = level.hero.x;
				heroTransfrom.y = level.hero.y;
				
				var entity : Entity;
				var i : int;
				var l: int;
				
				var enemies: Vector.<Point> = level.enemies;
				l = enemies.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createWeaponisedEnemy(_world);
					Transform(entity.getComponent(Transform)).setLocation(enemies[i].x, enemies[i].y);
					entity.refresh();
				}
	
				var moustacheEnemies: Vector.<Point> = level.moustacheEnemies;
				l = moustacheEnemies.length;
				trace('moustacheEnemies.length: ' + (moustacheEnemies.length));
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createMoustachedEnemy(_world);
					Transform(entity.getComponent(Transform)).setLocation(moustacheEnemies[i].x, moustacheEnemies[i].y);
					entity.refresh();
				}
	
				var friends: Vector.<Point> = level.friends;
				l = friends.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createFriend(_world);
					Transform(entity.getComponent(Transform)).setLocation(friends[i].x, friends[i].y);
					entity.refresh();
				}
				
				_processLevel = false;
				e.refresh();
			}
		}

//		override protected function checkProcessing() : Boolean {
//			return _processLevel;
//		}


	}
}
