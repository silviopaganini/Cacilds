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
	import flash.events.MouseEvent;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class SimpleButton extends UIElement
	{
		protected var enabled : Boolean = true;
		
		public function SimpleButton()
		{
			super();
		}

		override protected function initChildren() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.CLICK, onClick);
			
			enable();
			
			super.initChildren();
		}

		public function enable(val : Boolean = true) : void
		{
			enabled = val;

			buttonMode = val;
			mouseChildren = !val;
		}

		protected function onClick(event : MouseEvent = null) : void
		{
		}

		protected function onRollOut(event : MouseEvent = null) : void
		{
		}

		protected function onRollOver(event : MouseEvent = null) : void
		{
		}

		public function get _enabled() : Boolean {
			return enabled;
		}

		public function set _enabled(enabled : Boolean) : void {
			this.enabled = enabled;
			enable(this.enabled);
		}
	}
}
