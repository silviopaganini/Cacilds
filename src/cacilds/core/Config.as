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

package cacilds.core
{
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class Config
	{
		public static var pathMainXML : String;
		public static var pathMainCSS : String;
		public static var pathFonts   : String;
		
		public static var mainXML : XML;
		public static var mainCSS : StyleSheet;
		
		public static var values : Dictionary = new Dictionary();
	}
}
