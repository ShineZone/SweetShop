package project.view.store.event
{
	import project.events.BaseEvent;
	
	
	public class StoreEvent extends BaseEvent
	{
		public static const CHANGE_TAB:String = "CHANGE_TAB";
		public static const PURCHASE_ITEM:String = "PURCHASE_ITEM";
		
		public function StoreEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}