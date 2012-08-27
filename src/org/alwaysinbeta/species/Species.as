package org.alwaysinbeta.species {
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;

	import org.alwaysinbeta.games.base.BaseGame;
	import org.alwaysinbeta.games.base.GameContainer;
	import org.alwaysinbeta.species.constants.StateConstants;
	import org.alwaysinbeta.species.states.GameCompleteState;
	import org.alwaysinbeta.species.states.GameOverState;
	import org.alwaysinbeta.species.states.IState;
	import org.alwaysinbeta.species.states.PlayState;
	import org.alwaysinbeta.species.states.TitlesState;

	import flash.utils.Dictionary;



	/**
	 * @author McFamily
	 */
	
	public final class Species extends BaseGame {
		private var _container : GameContainer;
//		private var _debug : Monitor;
//		private var _fps : FPS;
		private var _state : IState;
		private var _states : Dictionary;
		
		public function Species() {
			super();
		}
		
		override protected function onAddedToStage(event : Event) : void {
			trace("Species.onAddedToStage(",event,")");
			super.onAddedToStage(event);
			
			addChild(_container = new GameContainer( Starling.current.stage.stageWidth, Starling.current.stage.stageHeight));

//			addChild(_debug = new Monitor());
//			_debug.x = _container.getWidth() - _debug.width;
//			
//			addChild(_fps = new FPS());
//			_fps.x = _container.getWidth() - _fps.width;
//			_fps.y = 100;
			
			_states = new Dictionary();
//			_states[StateConstants.TITLES] = new TitlesState(_container, this);
//			_states[StateConstants.PLAY] = new PlayState(_container, this);
//			_states[StateConstants.GAME_OVER] = new GameOverState(_container, this);
			_states[StateConstants.TITLES] = TitlesState;
			_states[StateConstants.PLAY] = PlayState;
			_states[StateConstants.GAME_OVER] = GameOverState;
			_states[StateConstants.WON] = GameCompleteState;

			changeState(StateConstants.TITLES);
		
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		public function changeState(state: String) : void {
			//if(state == _state) return;
			_container.clear();
			_state = new _states[state](_container, this);
			_state.init();
//			if(_state.world) _debug.world = _state.world;
		}

		private function onEnterFrame(event : EnterFrameEvent) : void {
			_state.update(_container, event.passedTime * 1000);
		}
	}
}
