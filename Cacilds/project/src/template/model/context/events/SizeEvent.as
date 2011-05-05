package template.model.context.events
{
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class SizeEvent extends Event
	{
		public static var STAGE_RESIZE : String = "stageResize";
		
		public var width : Number;
		public var height : Number;
		public var center : Point;
		
		public function SizeEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event
		{
			return new SizeEvent(type);
		}

	}
}
