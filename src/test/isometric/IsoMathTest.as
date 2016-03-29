package test.isometric
{
	import flexunit.framework.Assert;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	import smartfish.isometric.geometry.IsoMath;
	
	public class IsoMathTest
	{		
		[Before]
		public function setUp():void
		{
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
		public function testIsoToScreen():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testRotate():void
		{
			var mtx:Array = IsoMath.rotate( 2, 1, Math.PI * 270 / 180 );
			assertThat( mtx, equalTo([1, -2]) );
		}
		
		[Test]
		public function testScreenToIso():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}