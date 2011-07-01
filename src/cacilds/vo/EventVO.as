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
 
package cacilds.vo
{
	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class EventVO
	{
		public var type : String;
		public var listener : Function;
		public var useCapture : Boolean;

		public function EventVO(params : Object)
		{
			for(var n : String in params)
			{
				this[n] = params[n];
			}
		}
		
		public function toString() : String {
			return "EventVO type ->" + type;
		}

	}
}
