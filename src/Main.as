/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 上午10:58:09
 **/
package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import project.configuration.AppConfig;
	import project.configuration.GameConst;
	import project.configuration.RLControllerConfig;
	import project.configuration.RLModelConfig;
	import project.configuration.RLServiceConfig;
	import project.configuration.RLViewConfig;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	import smartfish.FPSCounter;
	import smartfish.robotlegs.FrameworkBundle;
	
	[SWF( width = "760", height = "650", frameRate = "30" )]
	//[Frame( factoryClass = "PreLoader" )]
	public class Main extends Sprite
	{

		private var _context:IContext;
		
		/**
		 * Constructor
		 **/
		public function Main()
		{
			addEventListener( Event.ADDED_TO_STAGE, initialization );
		}
		
		protected function initialization(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initialization );
			
			FPSCounter.activate( this.stage );
			stage.scaleMode = "noScale";
			GameConst.initlize(this.loaderInfo.parameters);
			_context = new Context()
				.install( MVCSBundle, FrameworkBundle )
				.configure(AppConfig)
				.configure( new ContextView(this) );
		}
	}
}