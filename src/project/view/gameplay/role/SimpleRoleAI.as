/**
 * Copyright (c) 2013 rayyee. All rights reserved. 
 * 
 * @author rayyee
 * Created 下午6:12:24
 **/
package project.view.gameplay.role
{
	import smartfish.isometric.core.api.IIsoSprite;
	import smartfish.isometric.core.ext.IIsoSpriteExtension;
	import smartfish.isometric.extensions.pathfinding.api.IPathfinding;
	import smartfish.isometric.utils.IsoConfig;
	import smartfish.pathfinding.astar.AStarNode;
	
	public class SimpleRoleAI implements IIsoSpriteExtension
	{
		private var _isoSprite:IIsoSprite;

		private var _pathfinding:IPathfinding;
		
		/**
		 * Constructor
		 **/
		public function SimpleRoleAI()
		{
		}
		
		public function extend(value:IIsoSprite):void
		{
			_isoSprite = value;
			_pathfinding = _isoSprite.getExtension( IPathfinding );
			_pathfinding.pathToOverMsg.add( onPathfindingTo );
			onPathfindingTo();
		}
		
		private function onPathfindingTo():void
		{
			var _rand:int = Math.random() * _isoSprite.isoScene.grid.nodes.length >> 0;
			var nodes:Object = _isoSprite.isoScene.grid.nodes[ _rand ];
			_rand = Math.random() * nodes.length >> 0;
			var _astarNode:AStarNode = nodes[ _rand ]; 
			if (!_pathfinding.pathFindingTo( _astarNode.position.x * IsoConfig.SIZE, _astarNode.position.y * IsoConfig.SIZE )) onPathfindingTo();
		}
	}
}