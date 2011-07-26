package cacilds.util
{
	import flash.text.Font;
	/**
	 * @author @silviopaganini | s2paganini.com
	 */
	public function enumerateFonts() : void
	{
		var embeddedFonts : Array = Font.enumerateFonts(false);
		for (var i : Number = 0;i < embeddedFonts.length;i++)
		{
			trace(embeddedFonts[i].fontName);
		}
	}
}
