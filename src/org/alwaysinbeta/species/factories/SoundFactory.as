package org.alwaysinbeta.species.factories {
	import org.alwaysinbeta.games.audio.Audio;
	import org.alwaysinbeta.species.assets.Sounds;
	/**
	 * @author McFamily
	 */
	public class SoundFactory {
		private static const _explosions : Array = [Sounds.Explosion11, Sounds.explode, Sounds.Explosion4];
		private static const _bullets : Array = [Sounds.Laser_Shoot14, Sounds.Laser_Shoot36];
		private static const _acheivement : Array = [Sounds.Default, Sounds.Randomize29, Sounds.Randomize28];

		private static function getRandom(array : Array) : Class {
			return array[Math.floor( array.length * Math.random() )];
		}
		
		public static function explode(): void {
			Audio.play(getRandom(_explosions));
		}
		public static function shoot(): void {
			Audio.play(getRandom(_bullets));
		}
		public static function startLevel(): void {
			Audio.play(getRandom(_acheivement));
		}
		public static function grapple(): void {
			Audio.play(Sounds.Randomize20);
		}
	}
}
