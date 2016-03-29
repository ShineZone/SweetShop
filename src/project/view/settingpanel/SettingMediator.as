/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午1:23:36
 **/
package project.view.settingpanel
{
	import project.events.context.ContextEvent;
	import project.events.view.ViewEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class SettingMediator extends Mediator
	{
		/**
		 * Constructor
		 **/
		public function SettingMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addViewListener( ViewEvent.SETTING_CLICK_ZOOM, onZoom );
		}
		
		private function onZoom( e:ViewEvent ):void
		{
			var event:ContextEvent = new ContextEvent( ContextEvent.ISOVIEW_ZOOM );
			event.data = e.data;
			dispatch( event );
		}
	}
}