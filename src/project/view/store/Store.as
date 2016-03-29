/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午4:32:46
 **/
package project.view.store
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	import application.model.DataManager;
	
	import project.model.DataManager;
	import project.model.vo.StoreCateoryInfo;
	import project.view.store.component.StoreItem;
	import project.view.store.component.StoreTabItem;
	import project.view.store.event.StoreEvent;
	
	import smartfish.robotlegs.extensions.popup.impl.PopUpWindow;
	import smartfish.ui.splitPage.SplitPage;
	import smartfish.ui.tabList.TabList;
	import smartfish.utils.DisplayObjectUtils;
	
	public class Store extends PopUpWindow
	{
		
		public var closeBtn:SimpleButton;		
		private var tabList:TabList;
		private var splitPage:SplitPage;
		private var skin:MovieClip;
		
		public function Store()
		{
			super();
		}
		
		
		override public function initilize():void
		{
			skin = getMovieClip("StoreWindowUI");
			this.addChild(skin);
			DisplayObjectUtils.mapSymbol(skin,this);			
			this.closeButton = closeBtn;	
			
			//添加分页组件
			splitPage      = new SplitPage(StoreItem,3,2,30,5,getClass("StoreItemUI"));
			splitPage.x    = 45;
			splitPage.y    = 110;
			splitPage.setControl(skin.nextPage,skin.prevPage);
			this.addChild(splitPage);
			
			//添加一个tab组件
			tabList   = new TabList(StoreTabItem,getClass("StoreTabItemUI"),5,-50);
			tabList.x = 30;
			tabList.data = DataManager.getInstance().storeCategoryData;
			tabList.addEventListener(StoreEvent.CHANGE_TAB,changeTab);
			skin.addChild(tabList);
			
			tabList.setCurrentItem("id",DataManager.getInstance().storeCategoryData[0].id);
		}
		
		protected function changeTab(evt:StoreEvent):void
		{
			var scInfo:StoreCateoryInfo = evt.data as StoreCateoryInfo;
			splitPage.data = DataManager.getInstance().getStoreConfigByCategory(scInfo.id); 
		}
		
		override public function onOpen(params:Object=null):void
		{
			trace(params);
		}

	}
}