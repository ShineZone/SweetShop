/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午3:02:22
 **/
package project.view.toolbar
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import project.events.view.ViewEvent;
	
	import smartfish.robotlegs.base.View;
	import smartfish.ui.MovieButton;
	import smartfish.utils.DisplayObjectUtils;
	
	public class MainTool extends View
	{
		
		public var functionAllBtnArea:MovieClip;
		public var editBtnArea:MovieClip;
		public var marketBtn:MovieClip;
		
		/**
		 * Constructor
		 **/
		public function MainTool()
		{
			super();
		}
		
		override public function initialization():void
		{
			var skin:MovieClip = _assetsFactory.getMovieClip( "mainBtnView" );
			addChild( skin );
			skin.y = 546;
			skin.x = 508;
			
			DisplayObjectUtils.mapSymbol( skin, this );
			functionAllBtnArea.visible = false;
			editBtnArea.visible = false;
			new MovieButton( marketBtn );
			marketBtn.addEventListener( MouseEvent.CLICK, onClickMarket );
		}
		
		private function onClickMarket(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.TOOL_CLICK_STORE ) );
		}
	}
}