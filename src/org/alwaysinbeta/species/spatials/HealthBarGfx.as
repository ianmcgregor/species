package org.alwaysinbeta.species.spatials {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.games.base.Canvas;
	import org.alwaysinbeta.games.base.Spatial;
	import org.alwaysinbeta.games.utils.QuickText;
	import org.alwaysinbeta.species.components.Health;
	import org.alwaysinbeta.species.components.Transform;

	/**
	 * @author McFamily
	 */
	public class HealthBarGfx extends Spatial {
		
		private var _transform : Transform;
		private var _health : Health;
		private var _container : Sprite;
		private var _bg : Quad;
		private var _bar : Quad;
		
		public function HealthBarGfx(world : World, owner : Entity) {
			super(world, owner);
		}
		
		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);
			
			var healthMapper : ComponentMapper = new ComponentMapper(Health, _world);
			_health = healthMapper.get(_owner);
			
			_container = new Sprite();
			
			_container.addChild( new TextField(35, 10, "HEALTH", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true) );
			
			_bg = new Quad(200, 10);
			_bg.color = 0x333333;
			_bg.x = 37;
			_container.addChild(_bg);
			
			_bar = new Quad(198, 8);
			_bar.color = 0x00ff00;
			_bar.x = _bg.x + 1;
			_bar.y = _bg.y + 1;
			_container.addChild(_bar);
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_container.x = x;
			_container.y = y;
			if (!g.contains(_container)) {
				g.addChild(_container);
			}
			
//			_bar.scaleX = Utils.lerp(_bar.scaleX, _health.getHealthPercentage(), 0.1);
			_bar.scaleX = _health.getHealthPercentage();
			
			if(_bar.scaleX < 0.5) _bar.color = 0xffff00;
			if(_bar.scaleX < 0.2) _bar.color = 0xff0000;
		}
	}
}
