package org.alwaysinbeta.games.utils {
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;

	import flash.ui.Keyboard;

	/**
	 * @author ian
	 */
	public class KeyInput implements IKeyInput {
		// phase
		private const UP : uint = 0;
		// private const RELEASED:uint = 0;
		private const JUST_PRESSED : uint = 1;
		// private const PRESSED:uint = 0;
		private const DOWN : uint = 2;
//		private const JUST_RELEASED : uint = 3;
		// vars
		private var _key : Vector.<Boolean> = new Vector.<Boolean>(256, true);
		private var _phase : Vector.<uint> = new Vector.<uint>(256, true);
		private var _lastKey : uint;
		private var _numKeysDown : uint;
		private var _keyString : String = "";

		public function KeyInput(eventDispatcher : EventDispatcher) {
			// starling.events.EventDispatcher
			if (!eventDispatcher) eventDispatcher = Starling.current.stage;
			// starling.events.KeyboardEvent
			eventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			eventDispatcher.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		// public function dispose(): void {
		// _stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		// _stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		// }
		// Apis
		public function down(keyCode : uint) : Boolean {
			return _key[keyCode] == true;
		}

		public function pressed(keyCode : uint) : Boolean {
			return _key[keyCode] == true;
		}

		public function justPressed(keyCode : uint) : Boolean {
			return _phase[keyCode] == 1;
		}

		public function released(keyCode : uint) : Boolean {
			return _key[keyCode] == false;
//			return _phase[keyCode] == 0;
		}

		public function up(keyCode : uint) : Boolean {
			return _key[keyCode] == false;
//			return _phase[keyCode] == 0;
		}

//		public function justReleased(keyCode : uint) : Boolean {
//			return _phase[keyCode] == 3;
//		}

		public function any() : Boolean {
			return _numKeysDown > 0;
		}

		public function clear() : void {
			var i:int = _key.length;
			while (--i > -1) {
				_key[i] = false;
				_phase[i] = 0;
			}
			_numKeysDown = 0;
			_keyString = "";
			_lastKey = 0;
		}

//		public function update() : void {
//		}

		public function get keyString() : String {
			return _keyString;
		}

		public function get lastKey() : uint {
			return _lastKey;
		}
		
		public function get numKeysDown() : uint {
			return _numKeysDown;
		}

//		public function getPhase(keyCode : uint) : uint {
//			return _phase[keyCode];
//		}

		// Utils
		private function onKeyDown(event : KeyboardEvent) : void {
			var keyCode : uint = event.keyCode;
			if (!keyInRange(keyCode)) return;
//			trace("KeyInput.onKeyDown(", keyCode, ")");

			// update the keystring
			updateKeyString(keyCode, event.charCode);
			// store last key
			_lastKey = keyCode;

			// update the keystate
			if (!_key[keyCode]) {
				_key[keyCode] = true;
				_phase[keyCode] = JUST_PRESSED;
				_numKeysDown++;
			} else {
				_phase[keyCode] = DOWN;
			}
		}

		private function onKeyUp(event : KeyboardEvent) : void {
			var keyCode : uint = event.keyCode;
			if (!keyInRange(keyCode)) return;
			
//			trace("KeyInput.onKeyUp(", keyCode ,")");

			if (_key[keyCode]) {
				_key[keyCode] = false;
				_phase[keyCode] = UP;
				_numKeysDown--;
//				_phase[keyCode] = JUST_RELEASED;
// 				To do just released will need to loop through in an onenterframe changing just released to up
			}
		}

		private function keyInRange(keyCode : uint) : Boolean {
			return keyCode <= 255;
		}

		private function updateKeyString(keyCode : uint, charCode : uint) : void {
			if (keyCode == Keyboard.BACKSPACE) {
				_keyString = _keyString.substring(0, _keyString.length - 1);
			} else if (charCode > 31 && keyCode != Keyboard.DELETE) {
				if (keyString.length > 100) _keyString = _keyString.substring(1);
				_keyString += String.fromCharCode(charCode);
			}
		}
	}
}
