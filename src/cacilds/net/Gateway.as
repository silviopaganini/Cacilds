package cacilds.net
{
	import cacilds.util.trace2;

	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;

	/**
	 * Gateway.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012. All rights reserved.
	 */
	public class Gateway extends EventDispatcher
	{
		private var connection : NetConnection;
		private var responder : Responder;
		
		public function Gateway()
		{
			responder = new Responder(onResult, onFault);
			
			connection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3;
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
		}

		protected function onFault(result : Object) : void
		{
			trace2(result);
		}

		protected function onResult(result : Object) : void
		{
			trace2(result);
		}
		
		public function connect(url : String) : void
		{
			connection.connect(url);
		}
		
		public function call(command : String, ...args) : void
		{
			connection.call(command, responder, args);
		}

		protected function securityError(event : SecurityErrorEvent) : void
		{
			trace2(event.text);
		}

		protected function ioError(event : IOErrorEvent) : void
		{
			trace2(event.text);
		}

		protected function netStatusHandler(event : NetStatusEvent) : void
		{
		}
	}
}
