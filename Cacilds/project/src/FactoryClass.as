package
{
	import cacilds.core.Config;

	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.CSSLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SelfLoader;
	import com.greensock.loading.XMLLoader;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.text.StyleSheet;
	import flash.utils.getDefinitionByName;
	import flash.utils.Dictionary;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class FactoryClass extends MovieClip
	{
		protected var queue : LoaderMax;

		public function FactoryClass()
		{
			super();
			
			setupStage();
			setup();
			appendLoader();
			initLoader();
		}

		protected function setupStage() : void
		{
			stage.quality = StageQuality.BEST;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
		}
		
		protected function setup() : void
		{
			var xmlPath : String = stage.loaderInfo.parameters.xmlPath;
			var cssPath : String = stage.loaderInfo.parameters.cssPath;
//			var fontsPath : String = stage.loaderInfo.parameters.fontsPath;

			Config.pathMainXML = xmlPath ? xmlPath : "../data/content.xml";
			Config.pathMainCSS = cssPath ? cssPath : "../data/styles.css";
//			Config.pathFonts = fontsPath ? fontsPath : "font.swf";

			queue = new LoaderMax({name:"mainQueue"});
			queue.addEventListener(LoaderEvent.COMPLETE, completeHandler);
			queue.addEventListener(LoaderEvent.ERROR, errorHandler);
			queue.addEventListener(LoaderEvent.PROGRESS, progress);
		}
		
		protected function appendLoader() : void
		{
			// append loaders
			queue.append(new SelfLoader(this));
			queue.append(new XMLLoader(Config.pathMainXML, {name:"xmlDoc"}));
			queue.append(new CSSLoader(Config.pathMainCSS, {name:"css"}));
		}
		
		protected function initLoader() : void
		{
			queue.load();
		}
		
		protected function progress(event : LoaderEvent) : void
		{
		}

		protected function errorHandler(event : LoaderEvent) : void
		{
		}

		protected function completeHandler(event : LoaderEvent) : void
		{
			var loadedXML : XML = queue.getContent("xmlDoc") as XML;
			Config.values = new Dictionary(false);
			var v : XMLList = loadedXML..variables.children();

			// GET VARIABLES
			for(var n : String in v) Config.values[v[n].@name.toString()] = v[n];

			// REPLACE VARIABLES
			var tempXML : String = loadedXML.toString();
			for(var a : String in Config.values) tempXML = tempXML.split(a).join(Config.values[a]);

			// STORE CORE OBJECTS
			Config.mainXML = new XML(tempXML);
			Config.mainCSS = queue.getContent("css") as StyleSheet;
			onCompleteLoading();
		}

		protected function onCompleteLoading() : void
		{
			nextFrame();
			
			var MainClass : Class = Class(getDefinitionByName("Main"));

			if (MainClass) {
				var app : Sprite = new MainClass();
				dispose();
				addChildAt(app, 0);
			}
		}

		protected function dispose() : void
		{
			queue.removeEventListener(LoaderEvent.COMPLETE, completeHandler);
			queue.removeEventListener(LoaderEvent.ERROR, errorHandler);
			queue.removeEventListener(LoaderEvent.PROGRESS, progress);
			queue.dispose();
		}
	}
}
