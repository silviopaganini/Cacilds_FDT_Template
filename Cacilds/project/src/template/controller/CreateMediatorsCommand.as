package ${namespace}.controller
{
	import ${namespace}.view.mediators.ContentMediator;
	import ${namespace}.view.content.ContentMananger;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class CreateMediatorsCommand extends Command
	{
		override public function execute() : void
		{
			mediatorMap.mapView(ContentMananger, ContentMediator);
		}
	}
}
