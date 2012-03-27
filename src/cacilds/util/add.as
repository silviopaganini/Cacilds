package cacilds.util
{
	import flash.display.DisplayObjectContainer;
	/**
	 * Add child to display list snippet
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public function add(container : DisplayObjectContainer, clazz : *) : *
	{
		return container.addChild(new clazz());
	}
}
