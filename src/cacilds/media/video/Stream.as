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
 
package cacilds.media.video
{
	import cacilds.media.video.events.VideoEvents;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class Stream extends NetStream
	{
		private var nc : NetConnection;
		private var fakeSprite : Sprite = new Sprite();
		private var currentBytesLoaded : Number;
		private var progress : Number;
		//
		protected var metaData : Object;
		public var name : String;
		public var url : String;
		public var _paused : Boolean = false;

		public function Stream(connection : NetConnection = null, peerID : String = "connectToFMS")
		{
			if (!connection)
			{
				nc = new NetConnection();
				nc.connect(null);
				connection = nc;
			}

			super(connection, peerID);
		}

		public function load(url : String) : void
		{
			_paused = false;
			
			this.url = url;
			close();
			client = {onMetaData:metaDataLoader};
				
			play(url);
			seek(0);
			dispatchEvent(new VideoEvents(VideoEvents.LOAD_START));
			startProgressCheck();
		}
		
		public function playVideo() : void
		{
			if(_paused) {
				_paused = false;
				resume();
			}
		}
		
		override public function pause() : void
		{
			_paused = true;
			super.pause();
		}
		
		public function reset() : void
		{
			pause();
			_paused = true;
			seek(0);
		}

		override public function close() : void
		{
			stopProgressCheck();
			currentBytesLoaded = -1;
			metaData = null;
			super.close();
		}

		protected function metaDataLoader(meta : *) : void
		{
			metaData = meta;
			dispatchEvent(new VideoEvents(VideoEvents.METADATA_LOADED));
		}

		protected function startProgressCheck() : void
		{
			if (fakeSprite.hasEventListener(Event.ENTER_FRAME)) return;
			fakeSprite.addEventListener(Event.ENTER_FRAME, progressCheck, false, 0, true);
		}

		protected function progressCheck(e : Event) : void
		{
			if (currentBytesLoaded == bytesLoaded) return;

			currentBytesLoaded = bytesLoaded;
			progress = bytesLoaded / bytesTotal;
			dispatchEvent(new VideoEvents(VideoEvents.LOAD_PROGRESS));

			if (bytesLoaded == bytesTotal)
			{
				stopProgressCheck();
				dispatchEvent(new VideoEvents(VideoEvents.LOAD_COMPLETE));
			}
		}

		private function stopProgressCheck() : void
		{
			fakeSprite.removeEventListener(Event.ENTER_FRAME, progressCheck);
		}

		public function get _currentBytesLoaded() : Number {
			return currentBytesLoaded;
		}

		public function get duration() : Number {
			
			return metaData.duration;
		}

		public function get _metaData() : Object {
			return metaData;
		}

		public function get _progress() : Number {
			return progress;
		}
		
		public function get _pbProgress () : Number
		{
			if(isNaN(duration)) return 0;
			return time / duration;
		}
	}
}
