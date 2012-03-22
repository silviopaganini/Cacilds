package cacilds.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * Arrange.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public class Arrange
	{
		public static function sendTop(display : DisplayObject, container : DisplayObjectContainer) : void
		{
			container.swapChildren(display, container.getChildAt(container.numChildren - 1));
		}
		
		public static function sendBack(display : DisplayObject, container : DisplayObjectContainer) : void
		{
			container.swapChildren(display, container.getChildAt(0));
		}
	}
}
