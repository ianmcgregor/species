package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Transform;
	import org.alwaysinbeta.species.constants.EntityTag;


	public class HealthBarRenderSystem extends EntityProcessingSystem {
		private var _healthMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;

		public function HealthBarRenderSystem() {
			super(Health, [Transform]);
		}

		override public function initialize() : void {
			_healthMapper = new ComponentMapper(Health, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
//			trace("HealthBarRenderSystem.processEntities(",entities,entities.size(),")");
			super.processEntities(entities);
		}

		override protected function processEntity(e : Entity) : void {
//			trace("HealthBarRenderSystem.processEntity(",e,")");
			e;
			
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroHealth : Health = _healthMapper.get(hero);

			var bar : Entity = _world.getTagManager().getEntity(EntityTag.HEALTH_BAR);
			var barHealth : Health = _healthMapper.get(bar);

			barHealth.setHealth(heroHealth.getHealth());
		}
	}
}