package template.view.mediators
{
	import template.view.content.ContentMananger;
	import template.model.context.events.SizeEvent;

	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class ContentMediator extends Mediator
	{
		[Inject]
		public var view : ContentMananger;

		public function ContentMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			eventMap.mapListener(eventDispatcher, SizeEvent.STAGE_RESIZE, stageResize);

			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddressChange);
			
			view.setup();
		}

		private function stageResize(e : SizeEvent) : void
		{
			view.update();
		}

		private function handleSWFAddressChange(event : SWFAddressEvent) : void
		{
			var value : String;

			if (SWFAddress.getValue() == "/") {
				// value = CoreDictionary.xml.views.@start.toString();
			} else {
				value = SWFAddress.getValue().split("/").join("");
			}
		}
	}
}
