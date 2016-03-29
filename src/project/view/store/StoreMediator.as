/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午4:33:02
 **/
package project.view.store
{
	import flash.net.sendToURL;
	
	import project.events.context.ContextEvent;
	import project.events.context.PopupMediatorEvent;
	import project.view.store.event.StoreEvent;
	
	import robotlegs.bender.framework.impl.Context;
	
	import smartfish.robotlegs.extensions.popup.PopupMediator;
	
	public class StoreMediator extends PopupMediator
	{
		
		/**
		 * Constructor
		 **/
		public function StoreMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			addContextListener( PopupMediatorEvent.OPEN_STORE, onOpen );
			addViewListener(StoreEvent.PURCHASE_ITEM,onPurchase);
		}
		
		private function onPurchase(evt:StoreEvent):void
		{
			dispatch(new ContextEvent(ContextEvent.PURCHASE_ITEM,evt.data));
		}
		
		private function onOpen( e : PopupMediatorEvent ):void
		{
			open( e.params, e.modal, e.windowType );
		}
	}
}