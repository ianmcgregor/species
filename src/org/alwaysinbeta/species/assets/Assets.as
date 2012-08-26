package org.alwaysinbeta.species.assets {
	import starling.textures.Texture;

	import flash.display.BitmapData;
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
		private static const Level1:Class;

		[Embed(source="tilemaps/Level_2.oel", mimeType="application/octet-stream")] 
		private static const Level2:Class;
		
		public static function getLevel(num: int): XML {
			switch(num){
				case 1:
					return XML(new Level1());
					break;
				case 2:
					return XML(new Level2());
					break;
				default:
			}
			return null;
		}
		
		public static const tiles: Array = [Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFF444444)), Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFF6C340B))];
		
		[Embed(source = "characters/LD24_assets0001.png")]
		private static const HeroTexture1:Class;
		[Embed(source = "characters/LD24_assets0002.png")]
		private static const HeroTexture2:Class;

		public static const heroTexture1:Texture = Texture.fromBitmap(new HeroTexture1());
		public static const heroTexture2:Texture = Texture.fromBitmap(new HeroTexture2());
		
		[Embed(source = "characters/LD24_assets0003.png")]
		private static const FriendTexture1:Class;
		[Embed(source = "characters/LD24_assets0004.png")]
		private static const FriendTexture2:Class;

		public static const friendTexture1:Texture = Texture.fromBitmap(new FriendTexture1());
		public static const friendTexture2:Texture = Texture.fromBitmap(new FriendTexture2());

		[Embed(source = "characters/LD24_assets0005.png")]
		private static const EnemyGunTexture1:Class;
		[Embed(source = "characters/LD24_assets0006.png")]
		private static const EnemyGunTexture2:Class;

		public static const enemyGunTexture1:Texture = Texture.fromBitmap(new EnemyGunTexture1());
		public static const enemyGunTexture2:Texture = Texture.fromBitmap(new EnemyGunTexture2());

		[Embed(source = "characters/LD24_assets0007.png")]
		private static const EnemyMoustacheTexture1:Class;
		[Embed(source = "characters/LD24_assets0008.png")]
		private static const EnemyMoustacheTexture2:Class;
		
		public static const enemyMoustacheTexture1:Texture = Texture.fromBitmap(new EnemyMoustacheTexture1());
		public static const enemyMoustacheTexture2:Texture = Texture.fromBitmap(new EnemyMoustacheTexture2());
	}
}
