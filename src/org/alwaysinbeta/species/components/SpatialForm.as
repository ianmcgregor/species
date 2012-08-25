package org.alwaysinbeta.species.components {
	import com.artemis.Component;

	public class SpatialForm extends Component {
		private var _spatialClass : Class;

		public function SpatialForm(spatialClass : Class) {
			_spatialClass = spatialClass;
		}

		public function getSpatialFormFile() : Class {
			return _spatialClass;
		}
	}
}