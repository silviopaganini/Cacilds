package cacilds.util
{
	import flash.external.ExternalInterface;
	/**
	 * trace2.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012. All rights reserved.
	 */
	public function trace2(...args) : void
	{
		if(!ExternalInterface.available) 
		{
			trace(args);
			return;
		}
			
		ExternalInterface.call("(function(){" +
			"if(console){" +
				"console.log('"+ (args) +"');" +
			"} else {" +
				"alert('"+ (args) +"')" +
			"}" +
		"})");
	}
}
