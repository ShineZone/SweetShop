/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午4:00:11
 **/
package project.view
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import smartfish.robotlegs.extensions.assets.api.IAssetsLoader;
	import smartfish.robotlegs.extensions.assets.api.IAssetsService;
	import smartfish.robotlegs.extensions.assets.impl.AssetInfo;
	import smartfish.robotlegs.extensions.assets.impl.AssetsConfigVO;
	
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundManager;
	
	public class SoundMediator extends Mediator
	{
		
		[Inject] public var assetsService:IAssetsService;
		[Inject] public var assetsLoader:IAssetsLoader;

		private var musicGroup:SoundManager;
		
		/**
		 * Constructor
		 **/
		public function SoundMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			musicGroup = SoundAS.group("game");
			
			var soundConfigs:Vector.<AssetsConfigVO> = assetsService.configCache.getAssetsConfigByLabel( "sounds" );
			
			for each (var i:AssetsConfigVO in soundConfigs)
			{
				assetsLoader.load( i.path ).addComplete( onLoadSoundComplete, [i] );
			}
		}
		
		private function onLoadSoundComplete( assetInfo:AssetInfo, config:AssetsConfigVO ):void
		{
			musicGroup.addSound( config.id, assetInfo.content );
			musicGroup.play( config.id );
		}
	}
}