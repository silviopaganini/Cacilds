/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) May 5, 2011 - Silvio Paganini <s2paganini@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
 
package cacilds.display
{
	import cacilds.core.ISetup;
	import cacilds.core.IAnimate;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class Page extends UIElement implements IAnimate, ISetup
	{
		public function Page()
		{
			super();
		}

		public function animateIn(params : Object = null) : void
		{
		}

		public function animateOut(params : Object = null) : void
		{
		}
		
		// TODO still work in progress
		public function setup() : void
		{
		}
	}
}