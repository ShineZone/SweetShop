package project.model
{
	import flash.events.IEventDispatcher;
	
	import project.events.context.ContextEvent;

	public class SomeProxy
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		private var _someData:Array;
		public function SomeProxy()
		{
		}
		
		public function set someData(value:Array):void
		{
			_someData = value;
			eventDispatcher.dispatchEvent(new ContextEvent(ContextEvent.SOME_PROXY_UPDATE,_someData));
		}
		
	}
}