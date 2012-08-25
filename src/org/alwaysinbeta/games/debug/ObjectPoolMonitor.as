package org.alwaysinbeta.games.debug {
	import flash.utils.Dictionary;
	import org.alwaysinbeta.games.utils.ObjectPool;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author McFamily
	 */
	public class ObjectPoolMonitor extends Sprite {
		private var _background : Quad;
		private var _textField : TextField;
		public function ObjectPoolMonitor() {
			super();
			
			_textField = new TextField(120, 50, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff);
			_background = new Quad(120, 50, 0x0);
			_textField.x = 2;
			_textField.hAlign = HAlign.LEFT;
			_textField.vAlign = VAlign.TOP;

			addChild(_background);
			addChild(_textField);

			blendMode = BlendMode.NONE;

			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
		}
		
		private function update(event: EnterFrameEvent) : void {
			event;
			var text: String = "Object Pools:\n";
			var pools : Dictionary = ObjectPool.pools;	
			for (var key : Object in pools) {
				var array : Array = pools[key];
				text += key + ': ' + array.length + "\n";
			}
			_textField.text = text;
		}
	}
}
