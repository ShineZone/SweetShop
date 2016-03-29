/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午5:01:47
 **/
package project.controller
{
	import flash.events.IEventDispatcher;
	
	import project.events.context.ContextEvent;
	import project.model.FriendProxy;
	import project.model.vo.FriendVO;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.framework.api.ILogger;
	
	import smartfish.robotlegs.extensions.facebook.api.IFacebookFriends;
	import smartfish.robotlegs.extensions.facebook.impl.FacebookConst;
	
	public class GetFacebookFriendsCommand implements ICommand
	{
		[Inject] public var log:ILogger;
		[Inject] public var friendDatas:FriendProxy;
		[Inject] public var eventDispatcher:IEventDispatcher;
		[Inject] public var directCommadMap:IDirectCommandMap;
		[Inject] public var facebookFriendService:IFacebookFriends;
		
		/**
		 * Constructor
		 **/
		public function GetFacebookFriendsCommand()
		{
			
		}
		
		public function execute():void
		{
			directCommadMap.detain( this );
			
			//Local test
			FacebookConst.Access_Token = "CAAFlGK6rMc8BAMlnSHH8SWDZAYN0Pig5Pzdk6uptLAZAF0F8cWKOI0KPmv3OvZCes3PM55BjrLQC3YT0eIUWBBHYSBVnq7DgPWw12DtrvqPjPUnpSZAlhWQ5gWQdpm7awEW5R9yI7Ry2E7RJDVfg"
			
			//Default use  facebookFriend.call().complete( onGetComplete );
			//facebookFriend.call( FacebookQuery.NORMAL, FacebookQuery.ONLINESTATE_LIVE ).complete( onGetComplete );
			
			//Diy use
			facebookFriendService
				.call( "uid, is_app_user, name, sex", "('active', 'offline')" )
				.complete( onGetComplete )
				.reject( onError );
		}
		
		private function onError( value : String ):void
		{
			directCommadMap.release( this );
			
			log.debug( value );
		}
		
		private function onGetComplete( value : Object ):void
		{
			directCommadMap.release( this );
			
			var friend:FriendVO;
			//对应 selectCondition
			for each (var fdata:* in value)
			{
				friend = new FriendVO;
				if (!(fdata is int) && !(fdata is String))
				{
					if (fdata.is_app_user == true)
					{
						friend.id = fdata.uid;
						friend.name = fdata.name;
						friendDatas.allFriends.push(friend);
					}
					else {}
				}
			}
			
			log.debug(friendDatas.allFriends);
			
			eventDispatcher.dispatchEvent( new ContextEvent(ContextEvent.GET_ALL_FRIEND_DATA) );
		}
	}
}