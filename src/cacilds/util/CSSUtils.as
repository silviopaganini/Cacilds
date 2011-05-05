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

package cacilds.util {
	import flash.text.TextField;

	/**
	 * ...
	 * Thanks to
	 * @author keita keita.kun_at_gmail.com
	 */
	public class CSSUtils 
	{
		private static const PROPERTIES:Object = {
			alpha: {name: "alpha", type: Number},
			alwaysshowselection: {name: "alwaysShowSelection", type: Boolean},
			antialiastype : {name: "antiAliasType", type: String},
			autosize: {name: "autoSize", type: String},
			background: {name: "background", type: Boolean},
			backgroundcolor: {name: "backgroundColor", type: uint},
			blendmode: {name: "blendMode", type: String},
			border: {name: "border", type: Boolean},
			bordercolor: {name: "borderColor", type: uint},
			condensewhite: {name: "condenseWhite", type: Boolean},
			displayaspassword: {name: "displayAsPassword", type: Boolean},
			embedfonts: {name: "embedFonts", type: Boolean},
			gridfittype: {name: "gridFitType", type: String},
			maxchars: {name: "maxChars", type: int},
			multiline: {name: "multiline", type: Boolean},
			restrict: {name: "restrict", type: String},
			selectable: {name: "selectable", type: Boolean},
			sharpness: {name: "sharpness", type: Number},
			textcolor: {name: "textColor", type: uint},
			thickness: {name: "thickness", type: Number},
			type: {name: "type", type: String},
			wordwrap: {name: "wordWrap", type: Boolean}
		};
		
		public static function setCSSDefinition(object:Object, textField:TextField):void {
			var prop:Object;
			var value:String;
			for (var p:String in object) {
				if ((prop = PROPERTIES[p.toLowerCase()])) {
					value = object[p];
					value = value.split("\"").join("");
					value = value.split("'").join("");
					try{
						if (prop.type == Number) {
							textField[prop.name] = parseFloat(value);
						}else if (prop.type == int || prop.type == uint) {
							if (value.indexOf("#") >= 0) value = value.split("#").join("0x");
							textField[prop.name] = parseInt(value);
						}else if (prop.type == Boolean) {
							textField[prop.name] = Boolean(value.toLowerCase() == "true");
						}else {
							textField[prop.name] = prop.type(value);
						}
					}catch (e:Error) {
						
					}
				}
			}
		}
		
		public static function parseColor(color:String):uint {
			color = color.split("#").join("").split(" ").join("");
			return Number("0x" + color) >> 0;
		}
		
		public static function parseColorArray(colors:String):Array {
			var arr:Array = colors.split("[").join("").split("]").join("").split(",");
			var i:int;
			var l:int = arr.length;
			var rColors:Array = [];
			for (i = 0; i < l; i++) {
				rColors.push(parseColor(arr[i]));
			}
			return rColors;
		}
	}
	
}