package
{
	import ${namespace}.SiteContext;

	import flash.display.Sprite;
	import flash.events.Event;

	[Frame(factoryClass="FactoryClass")]
	${SWFMetaData}
	
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
