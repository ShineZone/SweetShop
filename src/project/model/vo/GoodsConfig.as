package project.model.vo
{
	import mx.utils.ObjectUtil;

	public class GoodsConfig extends Object
	{
		public var sku:String;
		public var name:String;
		public var price:Number;
		public var image:String;
		
		public function clone():GoodsConfig{
			return ObjectUtil.clone(this) as GoodsConfig;
		}
	}
}