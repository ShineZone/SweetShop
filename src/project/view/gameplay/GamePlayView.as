/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 上午10:51:04
 **/
package project.view.gameplay
{
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import project.view.gameplay.role.RoleFour;
	import project.view.gameplay.role.SimpleRoleAI;
	
	import smartfish.isometric.core.IsoScene;
	import smartfish.isometric.core.IsoSprite;
	import smartfish.isometric.core.IsoView;
	import smartfish.isometric.core.api.IIsoScene;
	import smartfish.isometric.core.api.IIsoSprite;
	import smartfish.isometric.extensions.pathfinding.PathfindingExtension;
	import smartfish.isometric.extensions.pathfinding.api.IPathfinding;
	import smartfish.isometric.geometry.IsoPoint;
	import smartfish.isometric.utils.IsoConfig;
	import smartfish.isometric.utils.IsoCreator;
	import smartfish.robotlegs.base.View;
	import smartfish.robotlegs.extensions.assets.impl.AssetInfo;
	import smartfish.robotlegs.extensions.assets.impl.AssetsConfigVO;
	
	public class GamePlayView extends View
	{
		
		private var _hero:IIsoSprite;
		private var _scene:IIsoScene;
		private var spriter:Bitmap;
		private var _view:IsoView;
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>;
		
		/**
		 * Constructor
		 **/
		public function GamePlayView()
		{
			super();
			
//			var _floorScene:IIsoScene = new IsoScene(30, 30);
			_scene = new IsoScene(50, 50);
			
			var _isoSprite:IIsoSprite;
			_isoSprite = new IsoSprite( 1, 3, 2, 2 );
			_isoSprite.sprites = [IsoCreator.createBox( 1 * IsoConfig.SIZE, 3 * IsoConfig.SIZE, 2, 0x330000, true )];
			_isoSprite.moveIndexTo( 0, 1 );
			_scene.addChild(_isoSprite);
			_isoSprite.z = -10;
			_isoSprite.walkable = false;
			
			_view = new IsoView( 760, 650 );
//			_view.addScene( _floorScene );
			_view.addScene( _scene );
			addChild( _view );
			 
//			_view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			_scene.renderer();
//			_floorScene.renderer();
			
			_view.zoom(1);
			_view.canMapDrag = true;
		}
		
		private function onLoadComplete(value:AssetInfo):void
		{
			spriter = value.content as Bitmap;
		}
		
		override public function initialization():void
		{
			var _items:Vector.<AssetsConfigVO> = _assetsFactory.configCache.getAssetsConfigByLabel("assetsGame");
			for each (var i:AssetsConfigVO in _items)
			{
				_assetsLoader.load(i.path, "assetsGame").addComplete(onLoadItemComplete);
			}
			_assetsLoader.addGroupComplete(onLoadAssetsGameComplete, "assetsGame");
			
			var _timer:Timer = new Timer(1000, 100);
			_timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void
			{
				var _roleFour:RoleFour = new RoleFour(_assetsFactory);
				_hero = new IsoSprite( 1, 1, 80, 3 );
				_scene.addChild(_hero);
				_hero.moveIndexTo( 0, 0 );
				_hero.install( new PathfindingExtension, IPathfinding );
				_hero.install( _roleFour, RoleFour );
				_hero.install( new SimpleRoleAI, SimpleRoleAI );
			});
			_timer.start();
			
			var config:AssetsConfigVO = _assetsFactory.configCache.getAssetsConfigByID( "gamebg" );
			var path:String = config.path;
			_assetsLoader.load( path ).addComplete( onLoadGameBackgroundConfigComplete );
		}
		
		private function onLoadItemComplete(assetInfo:AssetInfo):void
		{
			var _cls:Class = (assetInfo.content as DisplayObject).loaderInfo.applicationDomain.getDefinition("SCENE") as Class;
			var _item:MovieClip = new _cls();
			trace(_item.getBounds(_item));
			_items.push(_item);
			_item.stop();
		}
		
		private function onLoadAssetsGameComplete( e:Event = null ):void
		{
			var x:Number, y:Number;
			var _isoSprite:IIsoSprite;
			var h:Number;
			var bmp:Bitmap;
			var shape:Shape;
			var drawMtx:Matrix = new Matrix;
			var item:MovieClip;
			var itemBounds:Rectangle;
			var itemContainer:Sprite;
			
			for (var i:int = 0, column:int = 30; i < column; i += 1)
			{
				for (var j:int = 0, row:int = 30; j < row; j += 1)
				{
					
					if ( Math.random() > .96 ) 
					{
//						x = (Math.random() * 4 >> 0) + 1;
//						y = (Math.random() * 4 >> 0) + 1;
						x = y = 1;
						h = 5;
//						h = (Math.random() * 40 >> 0) + 60;
						
						item = _items[Math.random() * _items.length >> 0];
						itemBounds = item.getBounds(item);
						bmp = new Bitmap( new BitmapData( itemBounds.width, itemBounds.height, true, 0 ) );
						shape = IsoCreator.createBox( x * IsoConfig.SIZE, y * IsoConfig.SIZE + 40, h, 0x333322, true );
						drawMtx.identity();
						drawMtx.translate(-itemBounds.x, -itemBounds.y);
						bmp.bitmapData.draw( item, drawMtx );
						bmp.x = itemBounds.x >> 0;
						bmp.y = itemBounds.y - (IsoConfig.SIZE >> 1) >> 0;
						if (Math.random() < .5)
						{
							bmp.scaleX = -1;
							bmp.x += itemBounds.width >> 0;
						}
						_isoSprite = new IsoSprite( x, y, h, 3 );
						_isoSprite.sprites = [bmp];
						_isoSprite.moveIndexTo( i, j );
						_scene.addChild(_isoSprite);
						_isoSprite.z = -10;
						_isoSprite.walkable = false;
					}
					
				}
			}		
		}
		
		private function onLoadGameBackgroundConfigComplete( assetInfo : AssetInfo ):void
		{
			var path:String = _assetsFactory.configCache.getAssetsConfigByID( "gamebg" ).folder;
			var gamebgConfig:Object = new JSONDecoder(assetInfo.content as String).getValue();
			for (var i:int = 0; i < 8; i += 1)
			{
				for (var j:int = 0; j < 16; j += 1)
				{
					_assetsLoader.load( path + gamebgConfig[j + "_" + i], "gamebg" ).addComplete( onLoadBgItemComplete, [j, i] ); 
				}	
			}	
			_assetsLoader.addGroupComplete( onLoadGameBackgroundComplete, "gamebg" );
		}
		
		private function onLoadBgItemComplete( assetInfo:AssetInfo, x:int, y:int ):void
		{
			var bgItem:Bitmap = assetInfo.getBitmap();
			_view.backgroundContainer.addChild( bgItem );
			bgItem.x = x * 320;
			bgItem.y = y * 320;
			_view.backgroundContainer.x = -15 * 320 >> 1;
			_view.backgroundContainer.y = -7 * 320 >> 1;
		}
		
		private function onLoadGameBackgroundComplete( e:BulkProgressEvent ):void
		{
			
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			var p3:IsoPoint = _view.localToIso(new Point(event.stageX, event.stageY));
			var pathfinding:IPathfinding = _hero.getExtension( IPathfinding ) as IPathfinding;
			pathfinding && pathfinding.pathFindingTo( p3.x, p3.y );
		}

		public function get isoView():IsoView
		{
			return _view;
		}

		
	}
}