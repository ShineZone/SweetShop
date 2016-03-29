/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午6:19:15
 **/
package project.view
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import project.configuration.GameConst;
	import project.view.friends.FriendsPanel;
	import project.view.gameplay.GamePlayView;
	import project.view.settingpanel.SettingPanel;
	import project.view.store.Store;
	import project.view.toolbar.MainTool;
	import project.view.userpanel.UserPanel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	import smartfish.robotlegs.extensions.assets.api.AssetsEvent;
	import smartfish.robotlegs.extensions.popup.api.IPopUpManager;
	
	/**
	 *  
	 * @author rayyee
	 * 
	 */	
	public class ApplicationMediator extends Mediator
	{
		[Inject] public var popup:IPopUpManager;
		[Inject] public var contextView:ContextView;
		
		private var _layersMap:Dictionary 	= new Dictionary;
		private var _layersValue:Array 		= [];
		
		private const MODULE_LAYER:int 		= 100;
		private const DIALOGS_LAYER:int 	= 202;
		private const TOOLTIP_LAYER:int 	= 300;
		private const LOADING_LAYER:int 	= 400;
		
		/**
		 * Constructor
		 **/
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			//侦听Application load assets complete
			addContextListener( AssetsEvent.ASSETS_LOAD_COMPLETE, onLoadAssetsComplete );
		}
		
		private function onLoadAssetsComplete( e:AssetsEvent ):void
		{
			var moduleLayer:Sprite = getLayer(MODULE_LAYER);
			var windowLayer:Sprite = getLayer(DIALOGS_LAYER);
//			var tootipLayer:Sprite = getLayer(TOOLTIP_LAYER);
//			var loadingLayer:Sprite = getLayer(LOADING_LAYER);
			
			//popup initialization
			popup.initialize( windowLayer, GameConst.GMAE_WIDTH, GameConst.GAME_HEIGHT );
			
			//add views
			var gameplay:GamePlayView = new GamePlayView();
			var friends:FriendsPanel = new FriendsPanel();
			var store:Store = new Store();

			windowLayer.addChild( store );			
			moduleLayer.addChild( gameplay );
			moduleLayer.addChild( friends );
			moduleLayer.addChild( new MainTool );	
			moduleLayer.addChild( new SettingPanel );	
			moduleLayer.addChild( new UserPanel );
		}
		
		/**
		 * 获取层级 
		 * @param value
		 * @return 
		 */		
		private function getLayer( value:int ):Sprite
		{
			if ( !_layersMap[value] )
			{
				_layersValue.push( value );
				_layersMap[value] = new Sprite;
				contextView.view.addChild( _layersMap[value] );
				
				//sort
				_layersValue.sort(Array.NUMERIC);
				for (var i:int = 0, len:int = _layersValue.length; i < len; i++)
				{
					var layer:Sprite = _layersMap[_layersValue[i]];
					if(contextView.view.getChildIndex(layer) != i)
					{
						contextView.view.setChildIndex(layer, i);
					}
				}
			}
			return _layersMap[value];
		}		
	}
}