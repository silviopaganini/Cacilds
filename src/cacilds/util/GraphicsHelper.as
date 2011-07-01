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
	import flash.display.BitmapData;
	import flash.display.Graphics;
	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class GraphicsHelper
	{
		static public function drawSquare(clear : Boolean, target : *, w : Number, h : Number, col : Number = 0x000000, a : Number = 1, startX : Number = 0, startY : Number = 0, bitmapFill : BitmapData = null) : void 
		{
			var graphics : Graphics = target.graphics;
			
			if(clear) graphics.clear();
			
			if(col == -1) {
				graphics.beginBitmapFill(bitmapFill, null, true, true);	
			} else {
				graphics.beginFill(col, a);
			}
			graphics.drawRect(startX, startY, w, h);
			graphics.endFill();
		}
		
		static public function drawTriangle(clear : Boolean, target : *, w : Number, h : Number, col : Number = 0, a : Number = 1) : void
		{
			var graphics : Graphics = target.graphics;
			if(clear) graphics.clear();
			
			graphics.beginFill(col, a);
			graphics.lineTo(0, w);
			graphics.lineTo(h, w / 2);
			graphics.lineTo(h, w / 2);
			graphics.endFill();
		}
	}
}
