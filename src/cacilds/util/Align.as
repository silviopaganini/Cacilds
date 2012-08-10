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
		public static function centreX(ref : *, obj : DisplayObject, offset : Number = 0) : void
		{
			var w : Number = ref is Stage ? Stage(ref).stageWidth : (ref is Number ? ref : ref.width);
			var xx : Number = (ref is Number || ref is Stage ? 0 : ref.x);
			obj.x = (xx + ((w - obj.width) >> 1)) + offset; 
		}
		
		/**
		 * Align centreY
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centreY(ref : *, obj : DisplayObject, offset : Number = 0) : void
		{
			var h : Number = ref is Stage ? Stage(ref).stageHeight : (ref is Number ? ref : ref.height);
			var yy : Number = (ref is Number || ref is Stage ? 0 : ref.y);
			obj.y = (yy + ((h - obj.height) >> 1)) + offset; 
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
