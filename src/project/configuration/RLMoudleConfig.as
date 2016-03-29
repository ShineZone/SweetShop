/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 上午10:41:07
 **/
package project.configuration
{
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
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.viewProcessorMap.api.IViewProcessorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	
	public class RLMoudleConfig implements IConfig
	{
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject] 
		public var viewProcessorMap:IViewProcessorMap;
		
		/**
		 * Constructor
		 **/
		public function RLMoudleConfig()
		{
		}
		
		public function configure():void
		{
			
			//View
			mediatorMap.map(GamePlayView).toMediator(GamePlayMediator);
			mediatorMap.map(FriendsPanel).toMediator(FriendsMediator);
			mediatorMap.map(Store).toMediator(StoreMediator);
			mediatorMap.map(MainTool).toMediator(MainToolMediator);
			mediatorMap.map(SettingPanel).toMediator(SettingMediator);
			mediatorMap.map(UserPanel).toMediator(UserPanelMediator);

			//test mediate
			mediatorMap.map(Main).toMediator(ApplicationMediator);
			
			context.afterInitializing(init);
		}
		
		private function init():void
		{
//			context.injector.injectInto(new ApplicationMediator);
		}
	}
}