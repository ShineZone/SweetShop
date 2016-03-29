/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午2:09:36
 **/
package project.events.context
{
	import flash.events.Event;
	
	public class PopupMediatorEvent extends Event
	{
		public var params:Object = null;
		public var modal:Boolean = true;
		public var windowType:int = 0;
		
		public static const OPEN_STORE:String = "openStore";
		
		/**
		 * Constructor
		 **/
		public function PopupMediatorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}