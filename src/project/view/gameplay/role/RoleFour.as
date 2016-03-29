/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午5:11:37
 **/
package project.view.gameplay.role
{
	import flash.display.DisplayObject;
	
	import smartfish.isometric.core.api.IIsoSprite;
	import smartfish.isometric.core.ext.IIsoSpriteExtension;
	import smartfish.isometric.extensions.pathfinding.api.IPathfinding;
	import smartfish.robotlegs.extensions.assets.api.IAssetsFactory;
	import smartfish.spritesheet.SpriteSheet;
	import smartfish.utils.Direction;
	
	/**
	 * 四方向角色 
	 * @author rayyee
	 */	
	public class RoleFour implements IIsoSpriteExtension
	{
		private var _isoSprite:IIsoSprite;
		private var _walkLeft:DisplayObject;
		private var _walkRight:DisplayObject;
		private var _pathfinding:IPathfinding;
		private var _assetsFactory:IAssetsFactory;

		private var spriteSheetLeft:SpriteSheet;
		private var spriteSheetRight:SpriteSheet;
		
		/**
		 * Constructor
		 **/
		public function RoleFour( assetsFactory:IAssetsFactory )
		{
			_assetsFactory = assetsFactory;
		}
		
		public function extend( value : IIsoSprite ):void
		{
			_isoSprite = value;
			
			spriteSheetLeft = new SpriteSheet();
			spriteSheetLeft.fps = 30;
			spriteSheetLeft.initMovieClip(_assetsFactory.getMovieClip( "mc_walk_left" ), "person_walk_left");
			spriteSheetRight = new SpriteSheet();
			spriteSheetRight.fps = 30;
			spriteSheetRight.initMovieClip(_assetsFactory.getMovieClip( "mc_walk_right" ), "person_walk_right");
			
			setWalkAction( spriteSheetLeft, spriteSheetRight );
			
			_pathfinding = value.getExtension( IPathfinding );
			if ( _pathfinding )
			{
				_pathfinding.changeDirectionMsg.add( onMoveToNode );
				_pathfinding.inSceneViewMsg.add( onInScene );
				_pathfinding.outSceneViewMsg.add( onOutScene );
			}
		}
		
		private function onOutScene():void
		{
			spriteSheetLeft.stop();
			spriteSheetRight.stop();
		}
		
		private function onInScene():void
		{
			spriteSheetLeft.play();
			spriteSheetRight.play();
		}
		
		public function setWalkAction( left:DisplayObject, right:DisplayObject ):void
		{
			_walkLeft = left;
			_walkRight = right;
			_isoSprite.container.addChild( _walkLeft );
			_isoSprite.container.addChild( _walkRight );
			_walkLeft.visible = _walkRight.visible = false;
		}
		
		private function onMoveToNode( direction : int ):void
		{
			if ( direction == Direction.SOUTHWEST )
			{
				_walkLeft.scaleX = 1;
				_walkLeft.visible = true;
				_walkRight.visible = false;
			}
			else if ( direction == Direction.SOUTHEAST )
			{
				_walkLeft.scaleX = -1;
				_walkLeft.visible = true;
				_walkRight.visible = false;
			}
			else if ( direction == Direction.NORTHWEST )
			{
				_walkRight.scaleX = -1;
				_walkRight.visible = true;
				_walkLeft.visible = false;
			}
			else if ( direction == Direction.NORTHEAST )
			{
				_walkRight.scaleX = 1;
				_walkRight.visible = true;
				_walkLeft.visible = false;
			}
		}
	}
}