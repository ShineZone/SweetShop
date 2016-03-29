/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午3:40:43
 **/
package project.view.friends
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import project.model.vo.FriendVO;
	
	import smartfish.managers.font.FontManager;
	import smartfish.ui.multiList.ListItem;
	import smartfish.utils.DisplayObjectUtils;
	
	public class FriendItem extends ListItem
	{
		public var newFriendsIcon:MovieClip;
		public var normalFriendsBg:MovieClip;
		public var selectedFriendsBg:MovieClip;
		public var addMeDefaultFaceIcon:MovieClip;
		public var level_text:TextField;
		public var name_text:TextField;
		
		/**
		 * Constructor
		 **/
		public function FriendItem()
		{
			super();
		}
		
		override public function setSkin(mov:MovieClip):void
		{
			super.setSkin( mov );
			DisplayObjectUtils.mapSymbol( skin, this );
			
			FontManager.getInstance().translateTextField( level_text, "Hobo_Std" );
			FontManager.getInstance().translateTextField( name_text, "Star_Jedi" );
		}
		
		override public function initlize():void
		{
			level_text.text = String( (_data as FriendVO).level );
			name_text.text = String( (_data as FriendVO).name )
		}
	}
}