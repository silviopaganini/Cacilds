package cacilds.util
{
	import flash.display.DisplayObject;
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
		public static function centreX(ref : DisplayObject, obj : DisplayObject) : void
		{
			obj.x = ref.x + ((ref.width - obj.width) >> 1); 
		}
		
		/**
		 * Align centreY
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centreY(ref : DisplayObject, obj : DisplayObject) : void
		{
			obj.y = ref.y + ((ref.height - obj.height) >> 1); 
		}
		
		/**
		 * Align centre
		 * @param ref DisplayObject reference
		 * @param obj Object to be aligned
		 */
		public static function centre(ref : DisplayObject, obj : DisplayObject) : void
		{
			centreX(ref, obj);
			centreY(ref, obj);
		}
	}
}
