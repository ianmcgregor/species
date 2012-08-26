package org.alwaysinbeta.species.assets {
	/**
	 * @author McFamily
	 */
	public class Assets {
		
//		[Embed(source = "tiles/trimmed/assets.png")]
//		public static const SpriteSheet : Class;
//		[Embed(source="tiles/trimmed/assets.xml", mimeType="application/octet-stream")] 
//		public static const SpriteSheetXML:Class;

		// embed configuration XML
		[Embed(source="particles/particle.pex", mimeType="application/octet-stream")]
		public static const ParticlePex:Class;
		 
		// embed particle texture
		[Embed(source = "particles/texture.png")]
		public static const ParticleTexture:Class;
		
		[Embed(source="tilemaps/Level_1.oel", mimeType="application/octet-stream")] 
		public static const Level1:Class;
	}
}
