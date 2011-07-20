package cacilds.util
{
	import flash.display.LoaderInfo;
	import flash.errors.IllegalOperationError;

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
			try
			{
				return loaderInfo.applicationDomain.getDefinition(whichAsset) as Class;
			}
			catch (e : Error)
			{
				throw new IllegalOperationError(whichAsset + " definition not found");
			}

			return null;
		}

		public static function getInstanceByName(loaderInfo : LoaderInfo, whichAsset : String) : *
		{
			try
			{
				var c : Class = getClassByName(loaderInfo, whichAsset);
				return new c();
			}
			catch (e : Error)
			{
				throw new IllegalOperationError(whichAsset + " definition not found");
			}

			return null;
		}
	}
}
