package org.alwaysinbeta.species.states {
	import com.artemis.World;
	import org.alwaysinbeta.games.base.GameContainer;
	/**
	 * @author McFamily
	 */
	public interface IState {
		function update(container : GameContainer, delta : int) : void;

		function init() : void;
		
		function get world(): World;
	}
}
