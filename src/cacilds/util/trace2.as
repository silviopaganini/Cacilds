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
		if(args is Object)
		{
			var res : String = "";
			for(var n : String in args) res += n + " - " + args[n] + ",";
		}
		
		if(!ExternalInterface.available) 
		{
			trace(res || args);
			return;
		}
			
		ExternalInterface.call("(function(){" +
			"if(console){" +
				"console.log('"+ (res || args) +"');" +
			"} else {" +
				"alert('"+ (res || args) +"')" +
			"}" +
		"})");
	}
}
