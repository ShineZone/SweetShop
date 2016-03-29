/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午1:23:14
 **/
package project.view.settingpanel
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import project.configuration.GameConst;
	import project.events.view.ViewEvent;
	
	import smartfish.robotlegs.base.View;
	import smartfish.ui.MovieButton;
	import smartfish.ui.RadioButton;
	import smartfish.utils.DisplayObjectUtils;
	
	public class SettingPanel extends View
	{
		
		public var soundMc:MovieClip;
		public var voiceMc:MovieClip;
		public var magnifyMc:MovieClip;
		public var reduceMc:MovieClip;
		public var openModelMc:MovieClip;
		public var fullScreenModelMc:MovieClip;
		
		private var _isOpenedModel:Boolean;
		
		/**
		 * Constructor
		 **/
		public function SettingPanel()
		{
			super();
		}
		
		override public function initialization():void
		{
			var _skin:MovieClip = _assetsFactory.getMovieClip( "settingView" );
			DisplayObjectUtils.mapSymbol( _skin, this );
			addChild( _skin );
			x = GameConst.GMAE_WIDTH - _skin.width - 10;
			y = GameConst.GAME_HEIGHT - 500;
			
			new MovieButton( soundMc );
			new MovieButton( voiceMc );
			new MovieButton( magnifyMc );
			new MovieButton( reduceMc );
			new MovieButton( openModelMc );
			new MovieButton( fullScreenModelMc );
			
			new RadioButton( magnifyMc, "zoom" );
			new RadioButton( reduceMc, "zoom" );
			
			reduceMc.addEventListener( MouseEvent.CLICK, onClickZoomReduce );
			magnifyMc.addEventListener( MouseEvent.CLICK, onClickZoomMagnify );
			openModelMc.addEventListener( MouseEvent.CLICK, onClickOpenModel );
			
			soundMc.mouseEnabled = voiceMc.mouseEnabled = fullScreenModelMc.mouseEnabled = false;
			soundMc.gotoAndStop("Down");
			voiceMc.gotoAndStop("Down");
			fullScreenModelMc.gotoAndStop("Down");
			soundMc.visible = voiceMc.visible = magnifyMc.visible = reduceMc.visible = fullScreenModelMc.visible = false;
		}
		
		private function onClickZoomReduce(event:MouseEvent):void
		{
			var e:ViewEvent = new ViewEvent( ViewEvent.SETTING_CLICK_ZOOM );
			e.data = .7;
			dispatchEvent( e );
		}
		
		private function onClickZoomMagnify(event:MouseEvent):void
		{
			var e:ViewEvent = new ViewEvent( ViewEvent.SETTING_CLICK_ZOOM );
			e.data = 1;
			dispatchEvent( e );
		}
		
		private function onClickOpenModel(event:MouseEvent):void
		{
			if ( _isOpenedModel )
			{
				soundMc.visible = voiceMc.visible = magnifyMc.visible = reduceMc.visible = fullScreenModelMc.visible = false;
				_isOpenedModel = false;
			}
			else
			{
				soundMc.visible = voiceMc.visible = magnifyMc.visible = reduceMc.visible = fullScreenModelMc.visible = true;
				_isOpenedModel = true;
			}
			
		}
	}
}