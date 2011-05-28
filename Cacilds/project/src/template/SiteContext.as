package ${namespace}
{
	import ${namespace}.controller.CreateMediatorsCommand;
	import ${namespace}.controller.MapEventCommands;
	import ${namespace}.controller.MapModelsCommand;
	import ${namespace}.controller.StartupCommand;
	import ${namespace}.controller.StoreDynamicClassesCommand;

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
