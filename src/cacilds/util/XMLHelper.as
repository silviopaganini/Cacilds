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
	import avmplus.getQualifiedClassName;

	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;

	/**
	 * @author silvio paganini | s2paganini.com
	 * @author keita kuroki
	 */
	public class XMLHelper
	{
		static public function getXMLBoolean(arg : *) : Boolean
		{
			return (arg == 1 || arg == "1" || arg == "true" || arg == true);
		}

		public static function setPropsFromXML(result : Object, node : *) : void
		{
			var attr : XMLList = node.attributes();
			var c : Object;

			var name : String, prop : String, v : String;

			for (name in attr)
			{
				prop = attr[name].name();
				v = attr[name];

				try
				{
					if (result.hasOwnProperty(prop)) {
						c = getDefinitionByName(getQualifiedClassName(result[prop]));

						switch(c)
						{
							case Boolean:
								result[prop] = getXMLBoolean(v);
								break;
							case Array:
								result[prop] = v.replace(/\[(.*?)\]/, "$1").split(",");
								break;
							case int:
								result[prop] = Number(v);
							default:
								result[prop] = v;
								break;
						}
					}
				}
				catch(e : Error)
				{
					trace("could not assign this property ->", prop, v);
				}
			}

			if (node.hasComplexContent()) {
				for (name in node.children())
				{
					prop = node.children()[name].name();
					if (result.hasOwnProperty(prop)) {
						var nodeProp : XML = node.children()[name];

						try
						{
							result[prop] = nodeProp.hasSimpleContent() ? (nodeProp.text().toString().length > 0 ? nodeProp.text() : "") : node.children()[name];
						}
						catch(e : Error)
						{
						}
					}
				}
			}
		}

		/**
		 * Gets instance of object + adds properties
		 * thanks to @keitakun
		 */
		public static function getInstance(node : XML) : DisplayObject
		{
			if (!node.namespace()) return null;

			var ns : String = node.namespace().toString();
			var result : Object = new (getDefinitionByName(ns))();
			var attr : XMLList = node.attributes();
			var c : Object;

			var name : String, prop : String, v : String;

			for (name in attr)
			{
				prop = attr[name].name();
				v = attr[name];

				try
				{
					if (result.hasOwnProperty(prop)) {
						c = getDefinitionByName(getQualifiedClassName(result[prop]));

						switch(c)
						{
							case Boolean:
								result[prop] = getXMLBoolean(v);
								break;
							case Array:
								result[prop] = v.replace(/\[(.*?)\]/, "$1").split(",");
								break;
							case int:
								result[prop] = Number(v);
							default:
								result[prop] = v;
								break;
						}
					}
				}
				catch(e : Error)
				{
					trace("could not assign this property ->", prop, v);
				}
			}

			if (node.hasComplexContent()) {
				for (name in node.children())
				{
					prop = node.children()[name].name();
					if (result.hasOwnProperty(prop)) {
						var nodeProp : XML = node.children()[name];

						try
						{
							result[prop] = nodeProp.hasSimpleContent() ? (nodeProp.text().toString().length > 0 ? nodeProp.text() : "") : node.children()[name];
						}
						catch(e : Error)
						{
						}
					}
				}
			}

			return DisplayObject(result);
		}
	}
}
