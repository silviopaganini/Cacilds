package cacilds.util
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * Align.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public class Align
	{
		/**
		 * Align centreX
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centreX(ref : DisplayObject, obj : DisplayObject, offset : Number = 0) : void
		{
			var w : Number = ref is Stage ? Stage(ref).stageWidth : ref.width;
			obj.x = (ref.x + ((w - obj.width) >> 1)) + offset; 
		}
		
		/**
		 * Align centreY
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centreY(ref : DisplayObject, obj : DisplayObject, offset : Number = 0) : void
		{
			var h : Number = ref is Stage ? Stage(ref).stageHeight : ref.height;
			obj.y = (ref.y + ((h - obj.height) >> 1)) + offset; 
		}
		
		/**
		 * Align centre
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centre(ref : DisplayObject, obj : DisplayObject, offsetX : Number = 0, offsetY : Number = 0) : void
		{
			centreX(ref, obj, offsetX);
			centreY(ref, obj, offsetY);
		}
	}
}
