package cacilds.media.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * SoundElement.as
	 * @author silvio paganini | s2paganini.com
	 */
	public class SoundElement extends Object
	{
		public var position : Number;
		public var channel : SoundChannel;
		public var onComplete : Function = null;
		public var paused : Boolean = true;
		public var sound : Sound;
		private var loops : int = 0;
		private var sndTransform : SoundTransform;

		public function SoundElement(sound : Sound, loops : int = 0, sndTransform : SoundTransform = null)
		{
			this.loops = loops;
			this.sndTransform = sndTransform;
			this.sound = sound;
		}

		public function play(startTime : Number = 0) : void
		{
			if (!paused) return;
			
			paused = false;
			
			resetChannel();
			
			channel = sound.play(startTime, loops, sndTransform);
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function resetChannel() : void
		{
			if (channel){
				if (channel.hasEventListener(Event.SOUND_COMPLETE)) channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				channel.stop();
				channel = null;
			}
		}

		private function onSoundComplete(event : Event) : void
		{
			paused = true;
			resetChannel();
			if (onComplete != null) onComplete.call();
		}

		public function pause() : void
		{
			paused = true;
			position = channel.position;
			channel.stop();
		}

		public function resume() : void
		{
			play(position);
		}

		public function stop() : void
		{
			paused = true;
			resetChannel();
		}
	}
}
