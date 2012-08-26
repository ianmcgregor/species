package org.alwaysinbeta.species.systems {
	import org.alwaysinbeta.species.factories.EntityFactory;
	import flash.geom.Point;
	import org.alwaysinbeta.species.constants.EntityTag;
	import org.alwaysinbeta.species.components.Transform;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.species.components.Level;

	/**
	 * @author McFamily
	 */
	public class LevelInitializeSystem extends EntityProcessingSystem {
		private var _processLevel : Boolean;
		private var _levelMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
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
			heroTransfrom.x = level.hero.x;
			heroTransfrom.y = level.hero.y;
			
			var enemies: Vector.<Point> = level.enemies;
			var l: int = enemies.length;
			for (var i : int = 0; i < l; ++i) {
				var enemy: Entity = EntityFactory.createEnemy(_world);
				Transform(enemy.getComponent(Transform)).setLocation(enemies[i].x, enemies[i].y);
				enemy.refresh();
			}
			
			_processLevel = false;
		}

		override protected function checkProcessing() : Boolean {
			return _processLevel;
		}


	}
}
