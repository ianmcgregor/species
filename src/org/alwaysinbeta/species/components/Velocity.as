package org.alwaysinbeta.species.components {
	import com.artemis.Component;

	public class Velocity extends Component {
		private var _velocityX : int;
		private var _velocityY : Number;
		private var _speed : Number;

		public function Velocity(velocityX : Number = 0, velocityY : Number = 0, speed : Number = 0) {
			_velocityX = velocityX;
			_velocityY = velocityY;
			_speed = speed;
		}

		public function get velocityX() : Number {
			return _velocityX;
		}

		public function set velocityX(velocityX : Number) : void {
			_velocityX = velocityX;
		}

		public function get velocityY() : Number {
			return _velocityY;
		}

		public function set velocityY(velocityY : Number) : void {
			_velocityY = velocityY;
		}

		public function get speed() : Number {
			return _speed;
		}

		public function set speed(speed : Number) : void {
			_speed = speed;
		}

	}
}