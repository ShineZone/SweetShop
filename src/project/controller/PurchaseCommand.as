package project.controller
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class PurchaseCommand extends Command
	{
		override public function execute():void
		{
			//verify money,level and any other conditional.
			trace("[command] purchase");
		}
		
	}
}