package project.model.vo
{
	import mx.utils.ObjectUtil;

	public class StoreCateoryInfo extends Object
	{
		public var id:String;
		public var name:String;
		public var image:String;
		
		public function clone():StoreCateoryInfo{
			return ObjectUtil.clone(this) as StoreCateoryInfo;
		}
	}
}