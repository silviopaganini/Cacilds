package
{
	import cacilds.display.UIElement;
	import cacilds.util.Align;
	import cacilds.util.add;

	/**
	 * Tester.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public class Testerz extends UIElement
	{
		private var test : AAAA;
		private var test1 : *;
		
		public function Testerz()
		{
			super();
		}
		
		
		override protected function draw() : void
		{
			super.draw();
			
			test = add(this, AAAA);
			test.x = 200;
			test.alpha = .1;
			test1 = add(this, AAAA);
			test1.alpha = .5;
			test1.y = 20;
			
			Align.centre(test, test1);
		}
	}
}
