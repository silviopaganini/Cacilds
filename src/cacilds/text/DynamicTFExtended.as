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
 
package cacilds.text
{
	import cacilds.util.CSSUtils;
	import cacilds.util.ObjectUtil;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * @author silviopaganini
	 */
	public class DynamicTFExtended extends TextField
	{
		private var _styleSheet : StyleSheet;
		private var _defaultTextFormat : TextFormat;
		private var _cssDefinition : String;
		private var _css : String;

		public function DynamicTFExtended(cssDefinition : String = null, _ss : StyleSheet = null)
		{
			this.mouseWheelEnabled = false;
			useRichTextClipboard = true;
			this.wordWrap = true;

			_cssDefinition = cssDefinition;
			_styleSheet = _ss;
			applyCSS();
		}
		
		public function move(x : Number, y : Number): void
		{
			this.x = x;
			this.y = y;
		}

		private function applyCSS() : void
		{
			if (_styleSheet)
			{
				if (_cssDefinition)
				{
					var cssObject : Object = _styleSheet.getStyle(_cssDefinition);
					ObjectUtil.setPropertiesFromObject(this, cssObject);
					if (!cssObject) cssObject = _styleSheet.getStyle("." + _cssDefinition);
					if (cssObject)
					{
						var tf : TextFormat = _styleSheet.transform(cssObject);
						this.defaultTextFormat = tf;
					}
				}
				this.styleSheet = _styleSheet;
				if (_cssDefinition) setDefaultDefinition(_cssDefinition);
			}
		}

		private function setDefaultDefinition(cssDefinition : String) : void
		{
			var o : Object = _styleSheet.getStyle(cssDefinition);
			if (!o) o = _styleSheet.getStyle("." + cssDefinition);
			if (!o) return;
			CSSUtils.setCSSDefinition(o, this);
		}

		override public function get defaultTextFormat() : TextFormat {
			return super.defaultTextFormat;
		}

		override public function set defaultTextFormat(value : TextFormat) : void {
			this.styleSheet = null;
			super.defaultTextFormat = value;
			_defaultTextFormat = value;
			this.styleSheet = _styleSheet;
		}

		override public function get type() : String {
			return super.type;
		}

		override public function set type(value : String) : void {
			if (value == TextFieldType.INPUT)
			{
				if (_defaultTextFormat) this.defaultTextFormat = _defaultTextFormat;
				this.styleSheet = null;
			} else {
				this.styleSheet = _styleSheet;
			}

			super.type = value;
		}

		public function dispose() : void
		{
			this.styleSheet = null;
			_styleSheet = null;
		}

		public function get cssDefinition() : String {
			return _cssDefinition;
		}

		public function set cssDefinition(cssDefinition : String) : void {
			_cssDefinition = cssDefinition;
			applyCSS();
		}

		public function get css() : String {
			return _css;
		}

		public function set css(css : String) : void {
			_css = css;
			applyCSS();
		}
	}
}
