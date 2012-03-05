package cacilds.util
{
	import flash.display.LoaderInfo;
	/**
	 * isLocal.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012 unit9 ltd. www.unit9.com. All rights reserved.
	 */
	public function isLocal(loaderInfo : LoaderInfo) : Boolean
	{
		return (loaderInfo.url.indexOf("file:") > -1) || (loaderInfo.url.indexOf(".local") > -1) || (loaderInfo.url.indexOf(":8888") > -1);
	}
}
