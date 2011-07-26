/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Jan 26, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package cacilds.debug
{
	import cacilds.util.NumberUtil;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;

	public class LogBook
	{
		public static var active : Boolean = true;
		private static var _count : Number = 0;
		private static var history : Array = [];
		private static var instance : LogBook;
		private var server : String = "localhost";
		private var socket : XMLSocket;
		private var fieldSeparator : String = " --> ";
		private var _socketFound : Boolean = true;

		public static function log(level : String = LogLevel.TRACE, ...params) : void
		{
			if(!active) return;
			
			if (!instance) instance = new LogBook();

			instance.log(level, params);
		}
		
		private function log(level : String = LogLevel.TRACE, ...params) : void
		{
			socket = new XMLSocket();
			var tempError : Error = new Error();
			var stackTrace : String = tempError.getStackTrace();
			var callerInfo : Array = stackTrace.split("\n");

			var caller : String = String(callerInfo[3]).replace("\t", "");

			caller = caller.substr("at".length);
			caller = caller.substring(1, caller.indexOf("["));

			var divider : String = "";
			divider += " >> ";

			++_count;
			
			var message : String = NumberUtil.zeroFormat(_count, 4) + " " + caller + divider + params.join(', ');
			var logObject : Object = {message:message, level:level};

			if (!_socketFound)
			{
				sendTrace(logObject);
				return;
			}
			else
			{
				if (socket.connected)
				{
					socketSend(logObject);
				}
				else
				{
					if (!socket.hasEventListener("connect"))
					{
						socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
						socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
						socket.addEventListener(Event.CONNECT, onConnect);
					}
					socket.connect(server, 4444);
					history.push(logObject);
				}
			}
		}

		private function onIOError(e : IOErrorEvent) : void
		{
			_socketFound = false;

			for each (var logObject:Object in history)
			{
				sendTrace(logObject);
			}
			history = [];
		}

		private function onSecurityError(e : SecurityErrorEvent) : void
		{
			_socketFound = false;
		}

		private function onConnect(e : Event) : void
		{
			for each (var logObject:Object in history)
			{
				socketSend(logObject);
			}
			history = [];
		}

		private function socketSend(o : Object) : void
		{
			var msg : String = o.message;
			var lines : Array = msg.split("\n");
			var commandType : String = lines.length == 1 ? "showMessage" : "showFoldMessage";
			var key : String = o.level;
			var xmlMessage : XML = <{commandType} key={key} />;

			if (lines.length > 1)
			{
				// set title with first line
				xmlMessage.title = lines[0];

				// remove title from message
				xmlMessage.message = msg.substr(msg.indexOf("\n") + 1, msg.length);

				if (o.date == null)
					xmlMessage.data = o.data;
				if (o.time == null)
					xmlMessage.time = o.time;
				if (o.category == null)
					xmlMessage.category = o.category;
			}
			else
			{
				var prefix : String = "";
				if (o.date != null)
					prefix += o.date + fieldSeparator;
				if (o.time != null)
					prefix += o.time + fieldSeparator;
				if (o.category != null)
					prefix += o.category + fieldSeparator;

				xmlMessage.appendChild(prefix + msg);
			}

			socket.send('!SOS' + xmlMessage.toXMLString() + '\n');
		}

		private function sendTrace(logObject : Object) : void
		{
			var msg : String = logObject.message;
			var key : String = "[" + logObject.level.toString().toUpperCase() + "]";

			trace(key + "\t" + msg);
		}

		public static function divider() : void
		{
			trace("__________________________________________________________________________________________________________________________________________");
		}
	}
}