package test.isometric
{
	import org.flexunit.asserts.assertEquals;
	
	import smartfish.isometric.core.IsoSprite;
	import smartfish.isometric.utils.IsoConfig;

	public class IsoSpriteTest
	{		

		private var _isoSprite:IsoSprite;
		
		
		[Before]
		public function setUp():void
		{
			_isoSprite = new IsoSprite(1, 1);	
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function moveToIsoIndex():void
		{
			_isoSprite.moveIndexTo( 2, 3 );
			assertEquals( _isoSprite.x, IsoConfig.SIZE * 2 );
		}
		
		
	}
}