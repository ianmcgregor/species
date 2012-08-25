package org.alwaysinbeta.games.base {
	import starling.core.Starling;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
    
    
    public class BaseStartup extends Sprite
    {
        private var mStarling:Starling;
        
        public function BaseStartup(rootClass : Class, width: uint, height: uint)
        {
            // This project requires the sources of the "demo" project. Add them either by 
            // referencing the "demo/src" directory as a "source path", or by copying the files.
            // The "media" folder of this project has to be added to its "source paths" as well, 
            // to make sure the icon and startup images are added to the compiled mobile app.
            
            // set general properties
            
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
//			stage.quality = StageQuality.LOW;

            Starling.multitouchEnabled = false; // useful on mobile devices
            Starling.handleLostContext = true; // required on Android
            
            // create a suitable viewport for the screen size
            
            var viewPort:Rectangle = new Rectangle();
            
//            if (stage.fullScreenHeight / stage.fullScreenWidth < 1.5)
//            {
//                viewPort.height = stage.fullScreenHeight;
//                viewPort.width  = int(viewPort.height / 1.5);
//                viewPort.x = int((stage.fullScreenWidth - viewPort.width) / 2);
//            }
//            else
//            {            
//                viewPort.width = stage.fullScreenWidth; 
//                viewPort.height = int(viewPort.width * 1.5);
//                viewPort.y = int((stage.fullScreenHeight - viewPort.height) / 2);
//            }

			viewPort.height = height;
            viewPort.width = width;
            
            // initialize Starling
            
            mStarling = new Starling(rootClass || BaseGame, stage, viewPort);
            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = false;
			mStarling.showStats = true;
			mStarling.antiAliasing = 1;
            mStarling.start();
            
            // When the game becomes inactive, we pause Starling; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated. 
            
//            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
//                function (e:Event):void { mStarling.start(); });
//            
//            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
//                function (e:Event):void { mStarling.stop(); });
        }
    }
}