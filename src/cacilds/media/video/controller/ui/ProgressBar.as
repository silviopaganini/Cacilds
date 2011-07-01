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
	import cacilds.media.video.events.VideoEvents;
	import flash.events.MouseEvent;


	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class ProgressBar extends UIElement
	{
		protected var track : UIElement = new UIElement();
		protected var loading : UIElement = new UIElement();
		protected var progress : UIElement = new UIElement();
		protected var hit : SimpleButton = new SimpleButton();

		public function ProgressBar()
		{
			super();
		}
		
		override protected function draw() : void
		{
			addChild(track);
			addChild(loading);
			addChild(progress);
			addChild(hit);
			
			hit.addEventListener(MouseEvent.MOUSE_DOWN, listenerHit);
		}
		
		private function listenerHit(event : MouseEvent) : void
		{
			var eventProgress : VideoEvents;

			switch(event.type)
			{
				case "mouseDown":
					hit.addEventListener(MouseEvent.MOUSE_UP, listenerHit);
					hit.addEventListener(MouseEvent.MOUSE_MOVE, listenerHit);
					stage.addEventListener(MouseEvent.MOUSE_UP, listenerHit);
					break;
					
				case "mouseUp":
					hit.removeEventListener(MouseEvent.MOUSE_UP, listenerHit);
					hit.removeEventListener(MouseEvent.MOUSE_MOVE, listenerHit);
					stage.removeEventListener(MouseEvent.MOUSE_UP, listenerHit);
					
					eventProgress = new VideoEvents(VideoEvents.UPDATE_PLAYBACK, true, true);
					eventProgress.pb_progress = hit.mouseX / hit.width;
					dispatchEvent(eventProgress);
					break;
					
				case "mouseMove":
					eventProgress = new VideoEvents(VideoEvents.UPDATE_PLAYBACK, true, true);
					eventProgress.pb_progress = hit.mouseX / hit.width;
					dispatchEvent(eventProgress);
					break;
			}
		}
		
		public function set _playbackProgress(n : Number) : void {
			progress.scaleX = n;
		}

		public function set _loadingProgress(n : Number) : void {
			loading.scaleX = n;
		}
	}
}
