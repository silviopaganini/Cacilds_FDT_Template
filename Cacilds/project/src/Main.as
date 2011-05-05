package
{
	import template.SiteContext;

	import flash.display.Sprite;
	import flash.events.Event;

	[Frame(factoryClass="FactoryClass")]
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="960", height="550")]
	
	public class Main extends Sprite
	{
		private var context : SiteContext;

		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event = null) : void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, init);
			context = new SiteContext(this);
		}
	}
}
