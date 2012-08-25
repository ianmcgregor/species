package org.alwaysinbeta.games.utils {
	/**
	 * @author ian
	 */
	public interface IKeyInput {
		function down(keyCode : uint) : Boolean

		function pressed(keyCode : uint) : Boolean

		function justPressed(keyCode : uint) : Boolean

		function released(keyCode : uint) : Boolean

//		function justReleased(keyCode : uint) : Boolean

		function any() : Boolean;

		function clear() : void

//		function update() : void;

		function get keyString() : String;

		function get lastKey() : uint;
		
		function get numKeysDown() : uint;

//		function getPhase(keyCode : uint) : uint
	}
}
