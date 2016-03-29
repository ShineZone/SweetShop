/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午12:48:37
 **/
package project.controller
{
	import flash.events.IEventDispatcher;
	
	import project.configuration.GameConst;
	import project.services.GameStartService;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.framework.api.ILogger;
	
	import smartfish.robotlegs.extensions.assets.api.IAssetsService;
	import smartfish.robotlegs.extensions.http.api.IHttpServiceFactory;
	
	/**
	 * 启动应用
	 * @trigger		ContextEvent.START_APPLICATION
	 * @lifecycle	loading -> 完全进入游戏 
	 * @complexity	O(c)
	 * @author 		rayyee
	 */	
	public class StartupApplicationCommand implements ICommand
	{
		[Inject] public var log:ILogger;
		[Inject] public var assetsService:IAssetsService;
		[Inject] public var eventDispatcher:IEventDispatcher;
		[Inject] public var directCommadMap:IDirectCommandMap;
		[Inject] public var serviceFactory:IHttpServiceFactory;
		
		/**
		 * Constructor
		 **/
		public function StartupApplicationCommand()
		{
			super();
		}
		
		public function execute():void
		{
			directCommadMap.detain( this );
				
			//读取config.xml and assets
			assetsService
				.initialize( GameConst.CONFIG_PATH, "" )
				.progress(onApplicationAssetsLoadProgress)
				.complete(onApplicationAssetsLoadComplete)
				.reject(onApplicationAssetsLoadError);
				
		}
		
		private function onApplicationAssetsLoadError( value:String ):void
		{
			log.debug( value );
			directCommadMap.release( this );		
		}
		
		private function onApplicationAssetsLoadProgress( loaded:Number, total:Number ):void
		{
//			log.debug("Application assets loaded: " + loaded + "/" + total);
		}
		
		private function onApplicationAssetsLoadComplete():void
		{
			//首次加载完毕
			//开始读取用户初始化数据
			serviceFactory
				.getEmptyService(GameStartService.NAME)
				.send(["ray11", "yee"])
				.complete(onGetServerInit);
				
			//也可以先进入游戏主界面
			directCommadMap.map(GoHomeCommand).execute();
		}
		
		private function onGetServerInit( value : Object ):void
		{
//			eventDispatcher.dispatchEvent(new FacebookEvent( FacebookEvent.GET_FRIENDS ));
			
			//当读取到初始化数据后，开始读取好友列表数据
			//并且进入游戏
			directCommadMap
				.map(GetFacebookFriendsCommand)
				.map(GoHomeCommand)
				.execute();
			
			directCommadMap.release( this );			
		}
		
	}
}