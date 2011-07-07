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
package cacilds.display
{
	import cacilds.core.IDisplayObject;
	import cacilds.core.IDispose;
	import cacilds.vo.EventVO;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;

	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class UIElement extends Sprite implements IDispose, IDisplayObject
	{
		private var eventList : Vector.<EventVO> = new Vector.<EventVO>();
		private var calledDispose : Boolean = false;

		public function UIElement()
		{
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, added);
			initChildren();
		}

		/**
		 * Override this function to setup children before drawing sprite
		 */
		protected function initChildren() : void
		{
			draw();
		}

		/**
		 * added to stage
		 */
		protected function added(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}

		protected function removedFromStage(event : Event) : void
		{
			if (!calledDispose) dispose();
			System.gc();
		}

		protected function draw() : void
		{
		}

		public function update(data : Object = null) : void
		{
		}

		public function move(x : Number, y : Number) : void
		{
			this.x = x;
			this.y = y;
		}

		public function removeAllListeners() : void
		{
			if (calledDispose || eventList) return;
			while (eventList.length > 0)
			{
				removeEventListener(eventList[0].type, eventList[0].listener, eventList[0].useCapture);
			}
		}

		public function removeAllChildren() : void
		{
			if (calledDispose) return;
			while (numChildren > 0) removeChildAt(0);
		}

		public function dispose() : void
		{
			removeAllListeners();
			removeAllChildren();
			calledDispose = true;
		}

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			var eventVO : EventVO = new EventVO({type:type, listener:listener, useCapture:useCapture});
			eventList.push(eventVO);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			var eventIndex : int = getEventIndex(type);
			if (eventIndex > -1) {
				eventList = eventList.splice(eventIndex, 1);
				super.removeEventListener(type, listener, useCapture);
			}
		}

		private function getEventIndex(eventId : String) : int
		{
			var result : int = -1;
			if (!eventList || eventList.length == 0) return result;

			for (var i : int = 0; i < eventList.length; i++)
			{
				if (eventList[i].type == eventId) {
					result = i;
					break;
				}
			}

			return result;
		}

		/**
		 * GETTERS
		 */
		public function get view() : DisplayObject {
			return this;
		}
	}
}
