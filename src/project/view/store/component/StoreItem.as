package project.view.store.component
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import project.view.store.event.StoreEvent;
	
	import smartfish.robotlegs.extensions.assets.api.IAssetsFactory;
	import smartfish.robotlegs.extensions.assets.api.IAssetsInjection;
	import smartfish.robotlegs.extensions.assets.api.IAssetsLoader;
	import smartfish.robotlegs.extensions.assets.impl.AssetInfo;
	import smartfish.ui.multiList.ListItem;
	import smartfish.utils.DisplayObjectUtils;
	
	public class StoreItem extends ListItem implements IAssetsInjection
	{
		protected var _assetsLoader:IAssetsLoader;
		protected var _assetsFactory:IAssetsFactory;
		
		public var mcIcon:MovieClip;
		public var mcHighlight:MovieClip;
		public var tfName:TextField;
		public var tfPrice:TextField;
		
		private var previousImageURL:String;
		public function StoreItem()
		{
			super();
		}
		
		override public function setSkin(mov:MovieClip):void{
			super.setSkin(mov);
			DisplayObjectUtils.mapSymbol(skin,this);
			mcHighlight.visible = false;
			skin.buttonMode     = true;
			skin.mouseChildren  = false;
			skin.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			skin.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			skin.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		protected function onMouseClick(evt:MouseEvent):void
		{ 
			this.dispatchEvent(new StoreEvent(StoreEvent.PURCHASE_ITEM,this.data,true));
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.stopPropagation();
			mcHighlight.visible = false;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.stopPropagation();
			mcHighlight.visible = true;
		}
		
		public function initialization():void
		{
			if(data)
				_assetsLoader.load(data.image).addComplete(loadImageDone);	
		}
		
		override public function initlize():void{
			while(mcIcon.numChildren >0){
				mcIcon.removeChildAt(0);
			}
			previousImageURL = data.image;
			if(previousImageURL && _assetsLoader)
				_assetsLoader.load(data.image).addComplete(loadImageDone);		
			tfName.text = data.name;
			tfPrice.text = String(data.price);
		}
		
		private function loadImageDone(o:AssetInfo):void
		{			
			var bitmap:Bitmap = Bitmap(o.content);
			bitmap            = new Bitmap(bitmap.bitmapData);
			bitmap.x          = -bitmap.width/2;
			bitmap.y          = -bitmap.height/2;
			mcIcon.addChild(bitmap);
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