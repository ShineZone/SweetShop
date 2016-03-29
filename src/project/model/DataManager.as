package project.model 
{
	import flash.utils.Dictionary;
	
	import project.configuration.GameConst;
	import project.model.vo.GoodsConfig;
	import project.model.vo.StoreCateoryInfo;

	/**
	 * 静态配置数据管理器 
	 * @author chenyh
	 * 
	 */	
	public class DataManager
	{
		private var storeData:Dictionary;
		public var storeCategoryData:Array;
				
		private var allData:Dictionary =new Dictionary();
		
		private static var _instance:DataManager;
		public function DataManager(singleton:SingletonEnforcer)
		{
		}
		
		/**
		 * 单例
		 * @return
		 */
		public static function getInstance():DataManager {
			if (!_instance) {
				_instance = new DataManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//=====================================================
		//===================   商店XML  ======================
		//=====================================================
		public function parseStore(xml:XML):void{
			storeData         = new Dictionary();
			storeCategoryData = [];
			var c:GoodsConfig;
			var sc:StoreCateoryInfo;
			for each (var xl:XML in xml..category) 
			{
				if(storeData[String(xl.@id)] == null){
					storeData[String(xl.@id)] = [];
				}
				sc = new StoreCateoryInfo();
				sc.id    = String(xl.@id);
				sc.name  = String(xl.@name);
				sc.image = GameConst.PATH_TO_FLASH + String(xl.@image);
				storeCategoryData.push(sc);
				for each (var x:XML in xl..item) 
				{
					c        = new GoodsConfig();
					c.sku    = String(x.@sku);
					c.name   = String(x);
					c.price  = Number(x.@price);
					c.image  = GameConst.PATH_TO_FLASH + String(x.@image);			
					
					allData[c.sku]                   = c;
					storeData[String(xl.@id)].push(c);
				}				
			}			
		}
		
		public function getStoreConfigBySku(sku:String):GoodsConfig{
			return allData[sku];
		}
		public function getStoreConfigByCategory(category:String):Array{
			return storeData[category];
		}
	}
}
class SingletonEnforcer{

}