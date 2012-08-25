package org.alwaysinbeta.games.base {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * @author ian
	 */
	public class BasicGame extends Sprite {
		private var _time : int;
		private var _width : int;
		private var _height : int;

		public function BasicGame(width : int, height : int) {
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
			
			init();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void {
			var time : int = getTimer();
			var delta : int = time - _time;
			_time = time;
			update(delta);
		}

		public function init() : void {
		}

		public function update(delta : int) : void {
		}
	}
}
