/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午1:42:57
 **/
package project.services
{
	import project.model.SomeProxy;
	
	import robotlegs.bender.framework.api.ILogger;
	
	import smartfish.robotlegs.extensions.http.impl.HttpService;

	public class GameStartService extends HttpService 
	{
		[Inject] 
		public var log:ILogger;
		
		[Inject]
		public var someProxy:SomeProxy;
		
		public static const NAME:String = "test.try";
		
		public function GameStartService()
		{
			super(NAME);
		}
		
		override public function success(value:Object):void
		{
			log.debug("Base_Init_Service success.");
			propagate(value);
		}
		
		override public function fault(value:Object):void
		{
			log.debug("Base_Init_Service fault.");
			_reject && _reject();
		}
	}
}