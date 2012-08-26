package org.alwaysinbeta.games.debug {
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author ian
	 */
	public class DebugDisplay extends Sprite {
		private var _infoText : DriverInfoDisplay;
		private var _objectPoolMonitor : ObjectPoolMonitor;
		public function DebugDisplay() {
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(event : Event) : void {
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);

			_infoText = new DriverInfoDisplay();
			_infoText.x = 0;
			_infoText.y = 18 / Starling.current.contentScaleFactor;
			_infoText.touchable = false;
			_infoText.scaleX = _infoText.scaleY = 1.0 / Starling.current.contentScaleFactor;
			stage.addChild(_infoText);
			
			_objectPoolMonitor = new ObjectPoolMonitor();
			_objectPoolMonitor.x = 0;
			_objectPoolMonitor.y = 36 / Starling.current.contentScaleFactor;
			_objectPoolMonitor.touchable = false;
			_objectPoolMonitor.scaleX = _objectPoolMonitor.scaleY = 1.0 / Starling.current.contentScaleFactor;
			stage.addChild(_objectPoolMonitor);
			
			Starling.current.showStats = true;
			
			_infoText.visible = Starling.current.showStats;
		}
		
//		private function onRemovedFromStage(event : Event) : void {
//			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
//		}
		
//		private function onKey(event : KeyboardEvent) : void {
//			switch(event.keyCode) {
//				case Keyboard.SPACE:
//					Starling.current.showStats = !Starling.current.showStats;
//					_infoText.visible = Starling.current.showStats;
//					break;
//				case Keyboard.X:
//					Starling.context.dispose();
//					break;
//				default:
//			}
//		}
	}
}
