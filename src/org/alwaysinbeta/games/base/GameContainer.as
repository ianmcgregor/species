package org.alwaysinbeta.games.base {
	import org.alwaysinbeta.games.utils.Input;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	/**
	 * @author McFamily
	 */
	public class GameContainer extends Sprite {
		private var _width : int;
		private var _height : int;
		private var _input : Input;
		private var _canvas : Canvas;
		
		public function GameContainer(width: int, height: int) {
			trace("GameContainer.GameContainer(",width, height,")");
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void {
			event;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_input = new Input(Starling.current.stage);
			addChild( _canvas = new Canvas() );
		}

		public function getWidth() : int {
			return _width;
		}

		public function getHeight() : int {
			return _height;
		}

		public function getGraphics() : Canvas {
			return _canvas;
		}
		
		public function getInput() : Input {
			return _input;
		}
		
		public function clear(): void {
			while(_canvas.numChildren){
				_canvas.removeChildAt(0);
			}
		}
	}
}
