/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午5:26:12
 **/
package project.events
{
	import flash.events.Event;
	
	public class FacebookEvent extends Event
	{
		/**
		 * 获取好友数据事件 
		 */		
		public static const GET_FRIENDS:String = "FacebookEvent::get_friends";
		
		/**
		 * Constructor
		 **/
		public function FacebookEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}