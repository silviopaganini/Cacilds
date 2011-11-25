package cacilds.util
{
	import flash.display.LoaderInfo;

	/**
	﻿   * @author siLvio paganini | s2paganini.com
	﻿   * @purpose: Use Embedded Assets
	﻿   */
	public class SWFAsset
	{
		/**
		﻿  ﻿   * @param loaderInfo <code>LoaderInfo</code> for the object that contains the embed assets
		﻿  ﻿   * @param whichAsset Name of the Embed Asset
		﻿  ﻿   * @return <code>Class</code> found in the <code>LoaderInfo</code> 
		﻿  ﻿   */
		public static function getClassByName(loaderInfo : LoaderInfo, whichAsset : String) : Class
		{
			return loaderInfo.applicationDomain.getDefinition(whichAsset) as Class;
		}

		public static function getInstanceByName(loaderInfo : LoaderInfo, whichAsset : String) : *
		{
			var c : Class = getClassByName(loaderInfo, whichAsset);
			return new c();
		}
	}
}
