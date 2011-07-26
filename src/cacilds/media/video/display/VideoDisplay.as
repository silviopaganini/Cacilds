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
	import cacilds.util.GraphicsUtil;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class VideoDisplay extends UIElement
	{
		public static const STRETCH : String = "stretch";
		public static const WIDTH_ONLY : String = "widthOnly";
		public static const HEIGHT_ONLY : String = "heightOnly";
		public static const NONE : String = "none";
		public static const PROPORTIONAL_OUTSIDE : String = "PROPORTIONAL_OUTSIDE";
		public static const PROPORTIONAL_INSIDE : String = "PROPORTIONAL_INSIDE";
		//
		protected var stream : Stream;
		protected var _netStatus : String;
		protected var video : Video;
		protected var scaleMode : String = "none";
		//
		private var state : String;
		private var shape : Shape;
		private var videoRatio : Number;
		private var displayRatio : Number;

		public function VideoDisplay(w : Number, h : Number, scaleMode : String = "none")
		{
			shape = addChild(new Shape()) as Shape;
			GraphicsUtil.drawSquare(true, shape, w, h);

			this.scaleMode = scaleMode;

			super();
		}

		override protected function draw() : void
		{
			video = new Video();
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

		public function metadataLoaded() : void
		{
			if ("width" in stream._metaData) {
				video.width = Number(stream._metaData.width);
				video.height = Number(stream._metaData.height);
				videoRatio = stream._metaData.width / stream._metaData.height;
			}

			scaleVideo();
		}

		protected function scaleVideo() : void
		{
			if (!video || !stream._metaData) return;

			displayRatio = shape.width / shape.height;

			var w : Number = shape.width;
			var h : Number = shape.height;

			if ((videoRatio < displayRatio && scaleMode == PROPORTIONAL_INSIDE) || (videoRatio > displayRatio && scaleMode == PROPORTIONAL_OUTSIDE)) {
				w = h * videoRatio;
			}
			if ((videoRatio > displayRatio && scaleMode == PROPORTIONAL_INSIDE) || (videoRatio < displayRatio && scaleMode == PROPORTIONAL_OUTSIDE)) {
				h = w / videoRatio;
			}

			if (scaleMode != HEIGHT_ONLY) {
				video.width = stream._metaData.width * (w / stream._metaData.width);
			}
			if (scaleMode != WIDTH_ONLY) {
				video.height = stream._metaData.height * (h / stream._metaData.height);
			}

			switch(scaleMode)
			{
				case STRETCH:
					video.width = w;
					video.height = h;
					break;
				case NONE:
					video.width = Number(stream._metaData.width);
					video.height = Number(stream._metaData.height);
					break;
			}

			video.x = shape.width / 2 - video.width / 2;
			video.y = shape.height / 2 - video.height / 2;
		}

		public function setSize(w : Number, h : Number) : void
		{
			GraphicsUtil.drawSquare(true, shape, w, h);
			scaleVideo();
		}

		override public function dispose() : void
		{
			if (stream) {
				if (stream.hasEventListener(NetStatusEvent.NET_STATUS)) stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				stream.close();
				stream = null;
			}
			super.dispose();
		}

		public function set _scaleMode(scaleMode : String) : void {
			this.scaleMode = scaleMode;
			scaleVideo();
		}
	}
}
