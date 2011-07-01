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

package cacilds.media.video.events
{
	import flash.events.Event;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class VideoEvents extends Event
	{
		public static const LOAD_START 		: String = "loadStart";
		public static const LOAD_PROGRESS 	: String = "loadProgress";
		public static const METADATA_LOADED : String = "metadataLoaded";
		public static const LOAD_COMPLETE 	: String = "loadComplete";
		
		public static const PLAY 			: String = "play";
		public static const STOP 			: String = "stop";
		public static const PAUSE 			: String = "pause";
		
		public static const PLAY_COMPLETE	: String = "playComplete";
		public static const PLAY_PROGRESS 	: String = "playProgress";
		public static const BUFFER_EMPTY	: String = "bufferEmpty";
		public static const BUFFER_FULL 	: String = "bufferFull";
		public static const UPDATE_PLAYBACK : String = "updatePlayback";
		
		public var pb_progress : Number;
				
		public function VideoEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event
		{
			return new VideoEvents(type);
		}

	}
}
