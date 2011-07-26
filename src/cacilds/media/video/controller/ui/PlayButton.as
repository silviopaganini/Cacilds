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
 
package cacilds.media.video.controller.ui
{
	import cacilds.display.SimpleButton;
	import cacilds.display.UIElement;
	import cacilds.media.states.VideoState;
	import cacilds.media.video.events.VideoEvents;
	import flash.events.MouseEvent;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class PlayButton extends SimpleButton
	{
		protected var state : String;
		protected var playSprite : UIElement = new UIElement();
		protected var pauseSprite : UIElement = new UIElement();

		public function PlayButton()
		{
			super();
		}

		override protected function draw() : void
		{
			addChild(playSprite);
			addChild(pauseSprite);
			super.draw();
		}

		public function set _state(state : String) : void {
			this.state = state;
			
			switch(state)
			{
				case VideoState.PLAYING:
					dispatchEvent(new VideoEvents(VideoEvents.PLAY, true, true));
					showPauseButton();
					break;
					
				case VideoState.STOPPED:
				case VideoState.PAUSED:
					dispatchEvent(new VideoEvents(VideoEvents.PAUSE, true, true));
					showPlayButton();
					break;
			}
		}
		
		override protected function onClick(event : MouseEvent = null) : void
		{
			toogleState();
		}

		protected function showPauseButton() : void
		{
			playSprite.visible = false;
			pauseSprite.visible = true;
		}
		
		protected function showPlayButton() : void
		{
			playSprite.visible = true;
			pauseSprite.visible = false;
		}
		
		protected function toogleState() : void
		{
			_state = state == VideoState.PLAYING ? VideoState.PAUSED : VideoState.PLAYING; 
		}
	}
}
