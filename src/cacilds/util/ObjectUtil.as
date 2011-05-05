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
 
package cacilds.util
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Thanks to
	 * @author keita
	 */
	public class ObjectUtil
	{
		private static const OBJECT_PATTERN : RegExp = /\s*([^;]*?)\s*:\s*('|")?([^;'"]+)['"]?;?/igx;

		static public function stringToObject(value : String) : Object
		{
			if (!value) return null;
			if (value.length == 0) return null;
			OBJECT_PATTERN.lastIndex = 0;
			var obj : Object = {};
			var m : Object;
			while ((m = OBJECT_PATTERN.exec(value)))
			{
				obj[m[1]] = (m[2] == null) ? Number(m[3]) : m[3];
			}
			return obj;
		}

		static public function setPropertiesFromObject(target : *, input : Object) : void
		{
			var v : String;
			var cn : String;
			var c : Object;
			for (var p:String in input)
			{
				if (!target.hasOwnProperty(p)) continue;
				v = input[p];
				try {
					cn = getQualifiedClassName(target[p]);
					c = getDefinitionByName(cn);
					switch(c)
					{
						case Boolean:
							if (!isNaN(Number(v))) {
								target[p] = (Number(v) != 0);
							} else if (v is Boolean) {
								target[p] = v;
							} else {
								target[p] = v.toLowerCase() == "true" || v != "0";
							}
							break;
						case Array:
							target[p] = v.replace(/\[(.*?)\]/, "$1").split(",");
							break;
						case int:
							target[p] = Number(v);
							break;
						default:
							target[p] = c(v);
							break;
					}
				} catch(e : Error)
				{
					continue;
				}
			}
		}

		static public function objectToString(obj : Object, level : int = 0) : String
		{
			var o : String = "";
			var t : String = "";
			var i : int = level;
			while (i-- > 0) t += "\t";

			for (var p:String in obj)
			{
				if (obj[p] is String || obj[p] is Number) {
					o += t + p + ": " + obj[p].toString() + "\n";
				} else {
					o += t + p + ":\n" + objectToString(obj[p], level + 1);
				}
			}

			return o;
		}
	}
}