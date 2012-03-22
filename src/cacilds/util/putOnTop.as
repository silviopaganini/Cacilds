package cacilds.util
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	/**
	 * putOnTop.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public function putOnTop(display : DisplayObject, container : DisplayObjectContainer) : void
	{
		container.swapChildren(display, container.getChildAt(container.numChildren - 1));
	}
}
