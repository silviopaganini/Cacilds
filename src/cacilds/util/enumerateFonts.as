package cacilds.util
{
	import flash.text.Font;

	/**
	 * @author @silviopaganini | s2paganini.com
	 */
	public function enumerateFonts() : void
	{
		var embeddedFonts : Array = Font.enumerateFonts(false);
		embeddedFonts.sortOn("fontName", Array.CASEINSENSITIVE);
		trace("\n----- Enumerate Fonts -----");
		for (var i : int = 0;i < embeddedFonts.length;i++)
		{
			trace(embeddedFonts[i].fontName);
		}
		trace("---------------------------\n");
	}
}
