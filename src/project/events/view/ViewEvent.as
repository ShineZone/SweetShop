/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午3:03:27
 **/
package project.events.view
{
	import flash.events.Event;
	
	/**
	 * View发出的事件
	 * 只有在map的mediator里面才能侦听
	 * 可以和framework断开耦合 
	 * @author rayyee
	 */	
	public class ViewEvent extends Event
	{
		public var data:*;
		
		//-------------------------------Store-------------------------------------------------------------------------
		public static const TOOL_CLICK_STORE:String = "ViewEvent::tool_click_store";
		
		
		public static const SETTING_CLICK_ZOOM:String = "ViewEvent::setting_click_zoom";
		
		/**
		 * Constructor
		 **/
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}