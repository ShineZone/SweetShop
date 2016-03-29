/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午1:57:45
 **/
package project.configuration
{
	import project.services.Base_Init_Service;
	
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	
	import smartfish.robotlegs.extensions.http.api.IHttpManager;
	import smartfish.robotlegs.extensions.http.api.IHttpServiceFactory;
	
	public class RLServiceConfig implements IConfig
	{
		
		[Inject] public var context:IContext;
		
		[Inject] public var httpManager:IHttpManager;
		
		[Inject] public var serviceFactory:IHttpServiceFactory;
		
		/**
		 * Constructor
		 **/
		public function RLServiceConfig()
		{
		}
		
		public function configure():void
		{
			//register services
			serviceFactory.registerService(Base_Init_Service.NAME, Base_Init_Service);
			
			//http manager initialization
			httpManager.initialize("http://frame.shinezone.com/?dev=daihh&");
		}
	}
}