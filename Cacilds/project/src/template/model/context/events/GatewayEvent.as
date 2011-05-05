package template.model.context.events
{
	import flash.events.Event;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class GatewayEvent extends Event
	{
		public static const ERROR 	: String = "GATEWAY_ERROR";
		public static const SUCCESS : String = "GATEWAY_SUCCESS";
		
		public var result : Object;
		public var methodCalled : String;
		
		public function GatewayEvent(type : String, result : Object, methodCalled : String)
		{
			this.result = result;
			this.methodCalled = methodCalled;
			
			super(type, false, false);
		}

		override public function clone() : Event
		{
			return new GatewayEvent(type, result, methodCalled);
		}
		
		override public function toString() : String
		{
			return formatToString("GatewayEvent", "type", "methodCalled");
		}

	}
}
