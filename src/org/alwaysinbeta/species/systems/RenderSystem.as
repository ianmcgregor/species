package org.alwaysinbeta.species.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.species.components.SpatialForm;
	import org.alwaysinbeta.species.components.Transform;


	public class RenderSystem extends EntityProcessingSystem {
		private var _graphics : Canvas;
		private var _spatials : Bag;
		private var _spatialFormMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _container : GameContainer;

		public function RenderSystem(container : GameContainer) {
			super(Transform, [SpatialForm]);
			_container = container;
			_graphics = container.getGraphics();

			_spatials = new Bag();
		}

		override public function initialize() : void {
			_spatialFormMapper = new ComponentMapper(SpatialForm, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			// trace("RenderSystem.processEntities(",entities,")");
			super.processEntities(entities);
		}

		override protected function processEntity(e : Entity) : void {
			// trace("RenderSystem.processEntity(",e,")");
			var spatial : Spatial = _spatials.get(e.getId());
			var transform : Transform = _transformMapper.get(e);

			if (transform.x >= 0 
				&& transform.y >= 0 
				&& transform.x < _container.getWidth() 
				&& transform.y < _container.getHeight() 
				&& spatial != null) {
				spatial.render(_graphics);
			}
		}

		override protected function added(e : Entity) : void {
			// trace("RenderSystem.added(",e,")");
			var spatial : Spatial = createSpatial(e);
			if (spatial != null) {
				spatial.initalize();
				_spatials.set(e.getId(), spatial);
			}
		}

		override protected function removed(e : Entity) : void {
			var spatial : Spatial = _spatials.get(e.getId());
			spatial.remove(_graphics);
			_spatials.set(e.getId(), null);
		}

		private function createSpatial(e : Entity) : Spatial {
			// trace("RenderSystem.createSpatial(",e,")");
			var spatialForm : SpatialForm = _spatialFormMapper.get(e);
			var SpatialFormClass : Class = spatialForm.getSpatialFormFile();
			return new SpatialFormClass(_world, e);
		}

		override public function change(e : Entity) : void {
			// trace("RenderSystem.change(",e,")");
			super.change(e);
		}
	}
}