/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午12:41:43
 **/
package project.view.userpanel
{
	import flash.display.MovieClip;
	
	import smartfish.robotlegs.base.View;
	import smartfish.utils.DisplayObjectUtils;
	
	public class UserPanel extends View
	{
		/**
		 * Constructor
		 **/
		public function UserPanel()
		{
			super();
		}
		
		override public function initialization():void
		{
			var _skin:MovieClip = _assetsFactory.getMovieClip( "userView" );
			DisplayObjectUtils.mapSymbol( _skin, this );
			addChild( _skin );
			x = 20;
			y = 10;
			
			
		}
	}
}