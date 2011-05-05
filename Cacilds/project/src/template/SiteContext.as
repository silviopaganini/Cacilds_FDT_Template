package template
{
	import template.controller.CreateMediatorsCommand;
	import template.controller.MapEventCommands;
	import template.controller.MapModelsCommand;
	import template.controller.StartupCommand;
	import template.controller.StoreDynamicClassesCommand;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class SiteContext extends Context
	{
		public function SiteContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup() : void
		{
			commandMap.mapEvent(ContextEvent.STARTUP, StoreDynamicClassesCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, MapModelsCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, CreateMediatorsCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, MapEventCommands, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
	}
}
