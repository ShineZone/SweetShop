package project.events
{
	import flash.events.Event;
	
	public class BaseEvent extends Event
	{
		public var data:Object;
		public function BaseEvent(type:String,data:Object = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		override public function clone() : Event
		{
			return new BaseEvent(this.type, this.data,this.bubbles,this.cancelable);
		}
	}
}