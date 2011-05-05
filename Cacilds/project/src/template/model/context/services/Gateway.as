package template.model.context.services
{
	import cacilds.core.Config;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import org.robotlegs.mvcs.Actor;
	import template.model.context.events.GatewayEvent;




	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class Gateway extends Actor
	{
		protected static const SERVICE : String = "MainService";
		
		protected var responder : Responder;
		protected var connection : NetConnection;
		protected var methodCalled : String;
		protected var listCommands : Array;
		protected var isBusy : Boolean = false;

		public function Gateway()
		{
			super();
		}

		public function init() : void
		{
			listCommands = [];

			responder = new Responder(onResult, onFault);
			connection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3;
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.connect(Config.values["amf_gateway"]);
		}

		public function call(methodName : String, ...args) : void
		{
			listCommands.push({name:methodName, args:args});

			if (!isBusy) {
				isBusy = true;
				executeCommand();
			}
		}

		protected function onCallComplete() : void
		{
			isBusy = false;
			listCommands.shift();

			if (listCommands.length > 0) executeCommand();
		}

		protected function executeCommand() : void
		{
			methodCalled = listCommands[0].name;
			var args : Array = listCommands[0].args;

			var collectArgs : Array = new Array();
			collectArgs.push(SERVICE + "." + methodCalled);
			collectArgs.push(responder);

			for (var n : String in args) collectArgs.push(args[n]);

			var cF : Function = connection.call;
			cF.apply(connection, collectArgs);
		}

		protected function netStatusHandler(event : NetStatusEvent) : void
		{
			trace("error netStatus: " + event.info.code);
		}

		protected function onFault(result : Object) : void
		{
			dispatch(new GatewayEvent(GatewayEvent.ERROR, result, methodCalled));
			onCallComplete();
		}

		protected function onResult(result : Object) : void
		{
			dispatch(new GatewayEvent(GatewayEvent.SUCCESS, result, methodCalled));
			onCallComplete();
		}
	}
}
