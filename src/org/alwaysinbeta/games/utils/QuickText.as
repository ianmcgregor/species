package org.alwaysinbeta.games.utils {
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * @author McFamily
	 */
	public class QuickText extends Sprite {
		private var _background : Quad;
		private var _textField : TextField;
		public function QuickText(width: int, height: int, text: String = "") {
			super();
			
			addChild( _background = new Quad(width, height, 0x0) );
			addChild( _textField = new TextField(width, height, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true) );
//			_textField.hAlign = HAlign.LEFT;
			blendMode = BlendMode.NONE;
		}
		
		public function set text(value : String): void {
			_textField.text = value;
		}
	}
}
