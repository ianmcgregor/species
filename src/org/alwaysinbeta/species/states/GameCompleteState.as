package org.alwaysinbeta.species.states {
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;

	import com.artemis.World;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.games.utils.QuickText;
	import org.alwaysinbeta.species.Species;
	import org.alwaysinbeta.species.constants.StateConstants;

	/**
	 * @author McFamily
	 */
	public class GameCompleteState implements IState {
//		private var _world : World;
		private var _container : GameContainer;
		private var _menu : Sprite;
		private var _main : Species;
		private var _title : QuickText;
		private var _body : QuickText;
		private var _button : QuickText;

		public function GameCompleteState(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		public function init() : void {
			
			_container.addChild(_menu = new Sprite());
			_menu.addChild(_title = new QuickText(100, 10, "YOU WON"));
			_title.scaleX = _title.scaleY = 6;
			_menu.addChild(_body = new QuickText(200, 100, "Thanks for playing!"));
			_body.scaleX = _body.scaleY = 2;

			_menu.addChild(_button = new QuickText(200, 50, "PRESS X TO PLAY AGAIN"));
			_button.scaleX = _button.scaleY = 2;
			
			_title.x = ( _container.getWidth() - _title.width ) * 0.5;
			_title.y = 40;
			
			_body.x = ( _container.getWidth() - _body.width ) * 0.5;
			_body.y = 90;
			
			_button.x = ( _container.getWidth() - _button.width ) * 0.5;
			_button.y = 270;
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onButtonTriggered);
		}

		private function onButtonTriggered(event : KeyboardEvent) : void {
			if(event.keyCode == Keyboard.X){
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onButtonTriggered);
			_container.removeChild(_menu);
			_main.changeState(StateConstants.PLAY);
			}
        }
		public function update(container : GameContainer, delta : int) : void {
			container, delta;
		}

		public function get world() : World {
			return null;
		}
	}
}
