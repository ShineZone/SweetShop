package project.controller
{
	import project.model.DataManager;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import smartfish.robotlegs.extensions.assets.api.IAssetsFactory;
	
	public class LoadAssetsCompleteCommand extends Command
	{
		[Inject]
		public var assetsFactory:IAssetsFactory;
		
		override public function execute():void
		{
			var xml:XML = assetsFactory.getXML("store");
			DataManager.getInstance().parseStore(xml);
		}
	}
}