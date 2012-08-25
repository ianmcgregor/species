package {
	import org.alwaysinbeta.games.base.BaseStartup;
	import org.alwaysinbeta.species.Species;

	/**
	 * @author McFamily
	 */
	[SWF(backgroundColor="#000000", frameRate="60", width="640", height="480")]
	public class Main extends BaseStartup {
		public function Main() {
			super(Species, 640, 480);
		}
	}
}
