package project.view.store.component
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import project.view.store.event.StoreEvent;
	
	import smartfish.robotlegs.extensions.assets.api.IAssetsFactory;
	import smartfish.robotlegs.extensions.assets.api.IAssetsInjection;
	import smartfish.robotlegs.extensions.assets.api.IAssetsLoader;
	import smartfish.robotlegs.extensions.assets.impl.AssetInfo;
	import smartfish.ui.tabList.TabItem;
	import smartfish.utils.DisplayObjectUtils;
	
	public class StoreTabItem extends TabItem implements IAssetsInjection
	{
		protected var _assetsLoader:IAssetsLoader;
		protected var _assetsFactory:IAssetsFactory;
		public var mcLock:MovieClip;
		public var mcImageEnabled:MovieClip;
		public function StoreTabItem()
		{
			super();
		}
		
		override public function setSkin(mov:MovieClip):void{
			super.setSkin(mov);
			DisplayObjectUtils.mapSymbol(skin,this);
			this.mouseChildren = false;
		}
		
		override public function set data(o:Object):void{
			_data = o;
			if(o){			
				mcLock.visible = false;
				initlize();						
			}else{
				mcLock.visible = true;
			}
		}
		
		public function initialization():void
		{
			initlize();
		}
		
		override protected function initlize():void{	
			if(_assetsLoader && data)
				_assetsLoader.load(data.image).addComplete(loadImageDone);
		}
		
		private function loadImageDone(o:AssetInfo):void
		{
			while(mcImageEnabled.numChildren >0){
				mcImageEnabled.removeChildAt(0);
			}
			
			var bitmap:Bitmap = Bitmap(o.content);
			bitmap            = new Bitmap(bitmap.bitmapData);
			bitmap.scaleX     = bitmap.scaleY = DisplayObjectUtils.getScale(bitmap,60,60);
			bitmap.x          = -bitmap.width/2;
			bitmap.y          = -bitmap.height/2;
			mcImageEnabled.addChild(bitmap);			
		}
		
		override public function onSelect():void{
			super.onSelect();
			this.dispatchEvent(new StoreEvent(StoreEvent.CHANGE_TAB,this.data,true));
		}
		
		override public function get width():Number{
			return 142;
		}
		
		public function set assetsFactory(value:IAssetsFactory):void
		{
			_assetsFactory = value;
		}
		
		public function set assetsLoader(value:IAssetsLoader):void
		{
			_assetsLoader = value;
		}
	}
}