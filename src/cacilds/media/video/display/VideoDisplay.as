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
 
package cacilds.media.video.display
{
	import cacilds.display.UIElement;
	import cacilds.media.states.VideoState;
	import cacilds.media.video.Stream;
	import cacilds.media.video.events.VideoEvents;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;



	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class VideoDisplay extends UIElement
	{
		protected var stream : Stream;
		protected var _netStatus : String;
		protected var video : Video;
		//
		private var state : String;
		private var w : Number;
		private var h : Number;

		public function VideoDisplay(w : Number, h : Number)
		{
			this.w = w;
			this.h = h;
			super();
		}

		override protected function draw() : void
		{
			video = new Video(w, h);
			addChild(video);
			state = VideoState.STOPPED;
		}

		protected function netStatusHandler(e : NetStatusEvent) : void
		{
			_netStatus = e.info.code;
			switch (_netStatus)
			{
				case "NetStream.Play.Start" :
					break;
				case "NetStream.Play.Stop" :
					stop();
					dispatchEvent(new VideoEvents(VideoEvents.PLAY_COMPLETE));
					break;
				case "NetStream.Buffer.Empty" :
					dispatchEvent(new VideoEvents(VideoEvents.BUFFER_EMPTY));
					break;
				case "NetStream.Buffer.Full" :
					dispatchEvent(new VideoEvents(VideoEvents.BUFFER_FULL));
					break;
				case "NetStream.Buffer.Flush" :
					break;
			}
		}

		public function play() : void
		{
			if (state == VideoState.PLAYING) return;
			if (!hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME, onEnterFrame);
			state = VideoState.PLAYING;
			stream.resume();
			dispatchEvent(new VideoEvents(VideoEvents.PLAY));
		}

		private function onEnterFrame(event : Event) : void
		{
			dispatchEvent(new VideoEvents(VideoEvents.PLAY_PROGRESS));
		}

		public function pause() : void
		{
			if (state == VideoState.PAUSED) return;
			state = VideoState.PAUSED;
			stream.pause();
			dispatchEvent(new VideoEvents(VideoEvents.PAUSE));
		}

		public function stop() : void
		{
			if (state == VideoState.STOPPED) return;
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			state = VideoState.STOPPED;
			stream.pause();
			dispatchEvent(new VideoEvents(VideoEvents.STOP));
		}

		public function get _progress() : Number {
			return stream.time / stream.duration;
		}

		public function set _stream(_stream : Stream) : void {
			if (stream) stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

			stream = _stream;
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.pause();
			stream.seek(0);
			video.clear();
			video.attachNetStream(stream);
			state = VideoState.STOPPED;
		}

		override public function dispose() : void
		{
			if (stream)
			{
				if (stream.hasEventListener(NetStatusEvent.NET_STATUS)) stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				stream.close();
				stream = null;
			}
			super.dispose();
		}
	}
}
