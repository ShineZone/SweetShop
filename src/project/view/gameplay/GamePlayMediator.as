/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 上午10:53:59
 **/
package project.view.gameplay
{
	import project.events.context.ContextEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogTarget;
	
	public class GamePlayMediator extends Mediator implements ILogTarget
	{
		
		[Inject]
		public var view:GamePlayView;
		
		[Inject]
		public var context:IContext;
		
		/**
		 * Constructor
		 **/
		public function GamePlayMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			context.addLogTarget(this);
			addContextListener( ContextEvent.ISOVIEW_ZOOM, onZoom );
		}
		
		private function onZoom( e:ContextEvent ):void
		{
			view.isoView.zoom( e.data );
		}
		
		public function log(source:Object, level:uint, timestamp:int, message:String, params:Array=null):void
		{
			
		}
	}
}