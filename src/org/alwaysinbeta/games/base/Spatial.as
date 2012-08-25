package org.alwaysinbeta.games.base {
	import com.artemis.Entity;
	import com.artemis.World;



	public class Spatial {
		protected var _world : World;
		protected var _owner : Entity;

		public function Spatial(world : World, owner : Entity) {
			_world = world;
			_owner = owner;
		}

		public function initalize() : void {
		}

		public function render(g : Canvas) : void {
		}

		public function remove(g : Canvas) : void {
		}
	}
}