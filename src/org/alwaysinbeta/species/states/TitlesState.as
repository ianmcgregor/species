package org.alwaysinbeta.species.states {
	import starling.core.Starling;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.text.BitmapFont;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import com.artemis.World;

	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.games.utils.QuickText;
	import org.alwaysinbeta.species.Species;
	import org.alwaysinbeta.species.constants.StateConstants;

	import flash.display.BitmapData;

	/**
	 * @author McFamily
	 */
	public class TitlesState implements IState {
//		private var _world : World;
		private var _container : GameContainer;
		private var _menu : Sprite;
		private var _main : Species;
		private var _title : QuickText;
		private var _body : QuickText;
		private var _button : QuickText;

		public function TitlesState(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		public function init() : void {
			
			_container.addChild(_menu = new Sprite());
			_menu.addChild(_title = new QuickText(40, 10, "SPECIES"));
			_title.scaleX = _title.scaleY = 6;
			_menu.addChild(_body = new QuickText(200, 100, "Humans have evolved into 2 separate species. The aggressive, dominant species are keeping the good natured species imprisoned underground working for them. \nYou lead the rebellion!"));
			_body.scaleX = _body.scaleY = 2;

			_menu.addChild(_button = new QuickText(200, 50, "PRESS ANY KEY TO START\nUSE ARROW KEYS TO MOVE \n SPACE TO SHOOT"));
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
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onButtonTriggered);
			_container.removeChild(_menu);
			_main.changeState(StateConstants.PLAY);
        }
		
		public function update(container : GameContainer, delta : int) : void {
			container, delta;
		}

		public function get world() : World {
			return null;
		}
	}
}
