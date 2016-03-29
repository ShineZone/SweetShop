/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午12:20:14
 **/
package project.view.friends
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import smartfish.robotlegs.base.View;
	import smartfish.ui.MovieButton;
	import smartfish.ui.multiList.MultiList;
	
	public class FriendsPanel extends View
	{

		private var list:MultiList;
		
		/**
		 * Constructor
		 **/
		public function FriendsPanel()
		{
			super();
		}
		
		override public function initialization():void
		{
			var panel:MovieClip = _assetsFactory.getMovieClip("friendsPanel");
			addChild( panel );
			panel.y = 650 - panel.height;
			
			var leftButton:MovieClip = _assetsFactory.getMovieClip("leftPage");
			var rightButton:MovieClip = _assetsFactory.getMovieClip("rightPage");
			
			new MovieButton( leftButton );
			new MovieButton( rightButton );
			
			panel.addChild( leftButton );
			panel.addChild( rightButton );
			leftButton.x = 30;
			rightButton.x = 480;
			leftButton.y = rightButton.y = 50;
			leftButton.scaleX = rightButton.scaleX =
			leftButton.scaleY = rightButton.scaleY = .5;
			
			leftButton.addEventListener( MouseEvent.MOUSE_DOWN, onDownLeft );
			rightButton.addEventListener( MouseEvent.MOUSE_DOWN, onDownRight );
			
			//initlization ui component
			list = new MultiList(FriendItem, _assetsFactory.getClass("friendArea"), 1, 6, 0, 4);
			panel.addChild( list );
			list.x = 60;
			list.y = 40;
			
		}
		
		private function onDownRight(event:MouseEvent):void
		{
			
		}
		
		private function onDownLeft(event:MouseEvent):void
		{
			
		}
		
		public function setFriendData( value:Array ):void
		{
			list.data = value; 
		}
		
	}
}