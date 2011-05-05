package template.model.context
{
	import template.model.context.events.SizeEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * Many Thanks to @matanube
	 * @author silvio paganini | s2paganini.com
	 */
	public class ModelSize extends Actor
	{
		protected var contextView : DisplayObjectContainer;
		protected var _width : Number;
		protected var _height : Number;
		protected var _center : Point;

		[Inject]
		
		public function ModelSize(contextView : DisplayObjectContainer)
		{
			this.contextView = contextView;
			
			_center = new Point();

			eventMap.mapListener(contextView.stage, Event.RESIZE, stage_resize_handler, Event);
		}

		private function stage_resize_handler(event : Event) : void
		{
			updateSize(contextView.stage.stageWidth, contextView.stage.stageHeight);
		}

		private function updateSize(w : int, h : int) : void
		{
			_width = w;
			_height = h;

			_center.x = Math.round(_width / 2);
			_center.y = Math.round(_height / 2);
			
			dispatchResize(SizeEvent.STAGE_RESIZE);
		}

		private function dispatchResize(type : String) : void
		{
			var e : SizeEvent = new SizeEvent(type);
			e.width = _width;
			e.height = _height;
			e.center = _center;
			
			dispatch(e);
		}
	}
}
