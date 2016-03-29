/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 上午11:38:45
 **/
package project.configuration
{
	import flash.system.Security;

	public class GameConst
	{
		public static var GMAE_WIDTH:int = 760;
		public static var GAME_HEIGHT:int = 650;
		
		public static var RELEASE_PATH:String;
		public static var CONFIG_PATH:String;
		
		public static var PATH_TO_PHP:String;
		public static var PATH_TO_FLASH:String;
		public static var UID:String;
		public static var PLATFORM:String;
		public static var LANGUAGE:String;
		/**
		 * Constructor
		 **/
		public function GameConst()
		{
		}
		
		public static function initlize(flashVars:Object):void{
			if(!isLocal){
				PATH_TO_FLASH = flashVars.pathToFlash == null?"":flashVars.pathToFlash;				
				PATH_TO_PHP   = flashVars.pathToPhp == null?"":flashVars.pathToPhp;
				LANGUAGE    = flashVars.language;
				UID         = flashVars.uid;				
				PLATFORM    = flashVars.platform;		
			}else{
				PATH_TO_FLASH = "../";
				PATH_TO_PHP   = "http://frame.shinezone.com/?dev=daihh&";
				LANGUAGE    = "en_us";
				UID         = "00000000000000000000000005C3952F";
				PLATFORM    = "facebook";
			}		
			RELEASE_PATH 	= PATH_TO_FLASH + "release/";
			CONFIG_PATH		= RELEASE_PATH + "config.xml";
		}
		
		public static function get isLocal():Boolean
		{
			return Security.REMOTE != Security.sandboxType;
		}

	}
}