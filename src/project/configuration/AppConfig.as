package project.configuration
{
	import flash.events.IEventDispatcher;
	
	import project.controller.GetFacebookFriendsCommand;
	import project.controller.LoadAssetsCompleteCommand;
	import project.controller.PurchaseCommand;
	import project.controller.StartupApplicationCommand;
	import project.events.FacebookEvent;
	import project.events.context.ContextEvent;
	import project.model.FriendProxy;
	import project.model.SomeProxy;
	import project.services.GameStartService;
	import project.view.ApplicationMediator;
	import project.view.friends.FriendsMediator;
	import project.view.friends.FriendsPanel;
	import project.view.gameplay.GamePlayMediator;
	import project.view.gameplay.GamePlayView;
	import project.view.settingpanel.SettingMediator;
	import project.view.settingpanel.SettingPanel;
	import project.view.store.Store;
	import project.view.store.StoreMediator;
	import project.view.toolbar.MainTool;
	import project.view.toolbar.MainToolMediator;
	import project.view.userpanel.UserPanel;
	import project.view.userpanel.UserPanelMediator;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.viewProcessorMap.api.IViewProcessorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	
	import smartfish.robotlegs.extensions.assets.api.AssetsEvent;
	import smartfish.robotlegs.extensions.http.api.IHttpManager;
	import smartfish.robotlegs.extensions.http.api.IHttpServiceFactory;
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var context:IContext;
		
		[Inject] 
		public var eventCommandMap:IEventCommandMap;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject] 
		public var httpManager:IHttpManager;
		
		[Inject] 
		public var serviceFactory:IHttpServiceFactory;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject] 
		public var viewProcessorMap:IViewProcessorMap;
		public function AppConfig()
		{
		}
		
		public function configure():void
		{
			//command
			eventCommandMap.map(ContextEvent.START_UP).toCommand(StartupApplicationCommand).once();
			eventCommandMap.map(FacebookEvent.GET_FRIENDS).toCommand(GetFacebookFriendsCommand);
			eventCommandMap.map(AssetsEvent.ASSETS_LOAD_COMPLETE).toCommand(LoadAssetsCompleteCommand);
			eventCommandMap.map(ContextEvent.PURCHASE_ITEM).toCommand(PurchaseCommand);
			
			directCommandMap.map(StartupApplicationCommand).map(GetFacebookFriendsCommand);
			
			//model
			injector.map( FriendProxy ).asSingleton();
			injector.map( SomeProxy ).asSingleton();
			
			//service
			httpManager.initialize(GameConst.PATH_TO_PHP);
			serviceFactory.registerService(GameStartService.NAME, GameStartService);
			
			//mdeiator
			mediatorMap.map(GamePlayView).toMediator(GamePlayMediator);
			mediatorMap.map(FriendsPanel).toMediator(FriendsMediator);
			mediatorMap.map(Store).toMediator(StoreMediator);
			mediatorMap.map(MainTool).toMediator(MainToolMediator);
			mediatorMap.map(SettingPanel).toMediator(SettingMediator);
			mediatorMap.map(UserPanel).toMediator(UserPanelMediator);
			mediatorMap.map(Main).toMediator(ApplicationMediator);
			
			//startup
			context.afterInitializing(startup);
		}
		
		private function startup():void
		{
			dispatcher.dispatchEvent(new ContextEvent(ContextEvent.START_UP));
		}
	}
}