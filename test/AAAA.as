package
{
	import cacilds.util.GraphicsUtil;
	import cacilds.display.UIElement;

	/**
	 * AAAA.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public class AAAA extends UIElement
	{
		public function AAAA()
		{
			super();
		}

		override protected function draw() : void
		{
			GraphicsUtil.drawSquare(true, this, 100, 100);
		}
	}
}
