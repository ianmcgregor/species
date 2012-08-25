package org.alwaysinbeta.games.debug {
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	import flash.system.System;
	import flash.utils.getTimer;


	public final class FPS extends Sprite {
		private var _text : TextField;
		private var _background : Quad;

		public function FPS() {
			super();

			initialize();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function initialize() : void {
			addChild( _background = new Quad(80, 52, 0x0) );
			addChild( _text = new TextField(80, 52, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true) );
			_text.hAlign = HAlign.LEFT;
			blendMode = BlendMode.NONE;
//			_text = new TextField();
//			_text.multiline = false;
//			_text.autoSize = TextFieldAutoSize.LEFT;
//			_text.defaultTextFormat = new TextFormat('_sans', 10, 0xFFFFFF, true);
//			_text.embedFonts = false;
//			_text.width = 120;
//			_text.height = 120;
//
//			bitmapData = new BitmapData(80, 52, false, 0xff000000);
		}

		private function onAddedToStage(event : Event) : void {
			event;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			startMonitoring();
		}

		private function onRemovedFromStage(event : Event) : void {
			event;
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stopMonitoring();
		}

		// MONITORING
		public function startMonitoring() : void {
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		public function stopMonitoring() : void {
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : EnterFrameEvent) : void {
			event;
			updateFps();
			updateMem();

			var info : String = "";
			var frameRate : Number = Starling.current.nativeStage.frameRate;
			info += "FPS: " + _currentFps + "/" + frameRate + "\n";
			info += "AVE: " + _averageFps + "/" + frameRate + "\n";
			info += "MEM: " + _mem + "\n";
			info += "MAX: " + _memMax + "\n";
			_text.text = info;

//			bitmapData.fillRect(bitmapData.rect, 0xFF000000);
//			bitmapData.draw(_text);
		}

		// FPS
		private var _timer : uint;
		private var _ms : uint;
		private var _fps : uint;
		private var _currentFps : uint;
		private var _averageFps : uint;
		private var _ticks : uint;
		private var _total : uint;

		private function updateFps() : void {
			_timer = getTimer();

			if (_timer - 1000 > _ms) {
				_ms = _timer;
				_currentFps = _fps;
				_fps = 0;
				
				if (_currentFps > 1) {
					_ticks ++;
					_total += _currentFps;
					_averageFps = Math.round(_total / _ticks);
				}
			}

			_fps++;
		}

		// MEMORY
		private var _mem : Number = 0;
		private var _memMax : Number = 0;

		private function updateMem() : void {
			_mem = Number((System.totalMemory * 0.000000954).toFixed(3));
			_memMax = _memMax > _mem ? _memMax : _mem;
		}
	}
}