/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午12:42:28
 **/
package project.view.friends
{
	import project.events.context.ContextEvent;
	import project.model.FriendProxy;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class FriendsMediator extends Mediator
	{
		[Inject] public var friends:FriendsPanel;
		[Inject] public var friendDatas:FriendProxy;
		
		/**
		 * Constructor
		 **/
		public function FriendsMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(ContextEvent.GET_ALL_FRIEND_DATA, onGetFriendData);
		}
		
		private function onGetFriendData( e : ContextEvent ):void
		{
			friends.setFriendData( friendDatas.allFriends );
		}
	}
}