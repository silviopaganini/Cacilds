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
 
package cacilds.media.video.controller
{
	import cacilds.display.UIElement;
	import cacilds.media.video.controller.ui.PlayButton;
	import cacilds.media.video.controller.ui.ProgressBar;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class Controller extends UIElement
	{
		protected var playPauseButton : PlayButton;
		protected var bar : ProgressBar;
		protected var state : String;

		public function Controller()
		{
			super();
		}

		public function set _playbackProgress(n : Number) : void {
			bar._playbackProgress = n;
		}

		public function set _loadingProgress(n : Number) : void {
			bar._loadingProgress = n;
		}

		public function set _state(s : String) : void {
			state = s;
			playPauseButton._state = state;
		}
	}
}
