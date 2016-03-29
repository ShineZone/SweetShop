/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午3:02:43
 **/
package project.view.toolbar
{
	import project.events.context.PopupMediatorEvent;
	import project.events.view.ViewEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MainToolMediator extends Mediator
	{
		/**
		 * Constructor
		 **/
		public function MainToolMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addViewListener( ViewEvent.TOOL_CLICK_STORE, onClickStrore );
		}
		
		private function onClickStrore( e:ViewEvent ):void
		{
			dispatch(new PopupMediatorEvent( PopupMediatorEvent.OPEN_STORE ));
		}
	}
}