/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午12:47:33
 **/
package project.events.context
{
	import flash.events.Event;
	
	public class ContextEvent extends Event
	{
		public var data:*;
		
		public static const START_UP:String = "Startup";
		
		public static const GET_ALL_FRIEND_DATA:String = "getAllFriendData";
		
		public static const ISOVIEW_ZOOM:String = "isoveiwZoom";
		
		public static const SOME_PROXY_UPDATE:String = "SOME_PROXY_UPDATE";

		public static const PURCHASE_ITEM:String = "PURCHASE_ITEM";
		
		
		
		/**
		 * Constructor
		 **/
		public function ContextEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}