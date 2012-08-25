package org.alwaysinbeta.games.debug {
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author ian
	 */
	public class DriverInfoDisplay extends Sprite {
		private var _background : Quad;
		private var _textField : TextField;

		// show information about rendering method (hardware/software)

		public function DriverInfoDisplay() {
			var driverInfo : String = Starling.context.driverInfo;

			_textField = new TextField(120, 9, driverInfo, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff);
			_background = new Quad(_textField.textBounds.width + 3, 10, 0x0);
			_textField.x = 2;
			_textField.hAlign = HAlign.LEFT;
			_textField.vAlign = VAlign.TOP;

			addChild(_background);
			addChild(_textField);

			blendMode = BlendMode.NONE;

			flatten();
		}
	}
}
