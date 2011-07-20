package ${namespace}.controller
{
	import ${namespace}.view.content.ContentMananger;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class StartupCommand extends Command
	{
		override public function execute() : void
		{
			contextView.addChild(new ContentMananger());
		}
	}
}
