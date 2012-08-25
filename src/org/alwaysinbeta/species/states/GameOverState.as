package org.alwaysinbeta.species.states {
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
	public class GameOverState implements IState {
//		private var _world : World;
		private var _container : GameContainer;
		private var _menu : Sprite;
		private var _main : Species;
		private var _title : QuickText;
		private var _body : QuickText;

		public function GameOverState(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		public function init() : void {
			
			_container.addChild(_menu = new Sprite());
			_menu.addChild(_title = new QuickText(100, 20, "GAME OVER"));
			_menu.addChild(_body = new QuickText(200, 100, ""));

//			var buttonTexture : Texture = Assets.getTexture("ButtonBig");
			var buttonTexture : Texture = Texture.fromBitmapData(new BitmapData(200, 40, false, 0xffff00));
			var count : int = 0;

			var buttons : Array = ["PLAY AGAIN"];

			for each (var buttonName:String in buttons) {

				var button : Button = new Button(buttonTexture, buttonName);
				button.x = ( _container.getWidth() - button.width ) * 0.5;
				button.y = 150 + count * 52;
				button.name = buttonName;
				button.addEventListener(Event.TRIGGERED, onButtonTriggered);
				_menu.addChild(button);
				++count;
			}
			
			
			_title.x = ( _container.getWidth() - _title.width ) * 0.5;
			_title.y = 40;
			
			_body.x = ( _container.getWidth() - _body.width ) * 0.5;
			_body.y = 70;
			
			//showScene(null);
		}

		private function onButtonTriggered(event : Event) : void {
			var button : Button = event.target as Button;
			showScene(button.name);
		}
		
		private function showScene(name:String):void
        {
            trace("TitlesState.showScene(",name,")");
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
