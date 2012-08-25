package org.alwaysinbeta.games.debug {
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;

	import com.artemis.EntityManager;
	import com.artemis.World;


	public final class Monitor extends Sprite {
		private var _text : TextField;
		private var _world : World;
		private var _background : Quad;

		public function Monitor(world : World = null) {
			super();

			_world = world;

			initialize();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function initialize() : void {
			_background = new Quad(100, 62, 0x0);
			_text = new TextField(100, 62, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true);
			_text.hAlign = HAlign.LEFT;
//			_text.multiline = false;
//			_text.autoSize = TextFieldAutoSize.LEFT;
//			_text.defaultTextFormat = new TextFormat('_sans', 10, 0xFFFFFF, true);
//			_text.embedFonts = false;
//			_text.width = 120;
//			_text.height = 120;
			addChild(_background);
			addChild(_text);
			blendMode = BlendMode.NONE;
//			bitmapData = new BitmapData(100, 62, false, 0xff000000);
		}

		private function onAddedToStage(event : Event) : void {
			event;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			if(_world) startMonitoring();
		}

		private function onRemovedFromStage(event : Event) : void {
			event;
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stopMonitoring();
		}

		// MONITORING
		public function startMonitoring() : void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function stopMonitoring() : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void {
			event;
			var entityManager : EntityManager = _world.getEntityManager();
			var info : String = "";
			info += "ENTITIES: " + "\n";
			info += "COUNT: " + entityManager.getEntityCount() + "\n";
			info += "CREATED: " + entityManager.getTotalCreated() + "\n";
			info += "REMOVED: " + entityManager.getTotalRemoved() + "\n";
			info += "DELTA: " + _world.getDelta() + "ms" + "\n";
			_text.text = info;

//			bitmapData.fillRect(bitmapData.rect, 0xFF000000);
			// bitmapData.draw(_text);
		}

		public function set world(world : World) : void {
			_world = world;
			if(_world) startMonitoring();
		}
	}
}