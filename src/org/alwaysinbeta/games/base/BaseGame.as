package org.alwaysinbeta.games.base {
	import starling.display.Sprite;
	import starling.events.Event;

	import org.alwaysinbeta.games.debug.DebugDisplay;


	public class BaseGame extends Sprite {

		public function BaseGame() {
			// The following settings are for mobile development (iOS, Android):
			//
			// You develop your game in a *fixed* coordinate system of 320x480; the game might
			// then run on a device with a different resolution, and the assets class will
			// provide textures in the most suitable format.

//			Starling.current.stage.stageWidth = Sizes.WIDTH;
//			Starling.current.stage.stageHeight = Sizes.HEIGHT;
//			Assets.contentScaleFactor = Starling.current.contentScaleFactor;

			// load general assets

//			Assets.prepareSounds();
//			Assets.loadBitmapFonts();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		protected function onAddedToStage(event : Event) : void {
			event;

//			addChild(new DebugDisplay());
		}

		protected function onRemovedFromStage(event : Event) : void {
		}
	}
}