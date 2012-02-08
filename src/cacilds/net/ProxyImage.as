package cacilds.net
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author silvio paganini | keita kuroki
	 */
	public class ProxyImage extends EventDispatcher
	{
		private var urlLoader : URLLoader;
		private var url : String;
		private var bmd : BitmapData;
		public var name : String;

		public function ProxyImage(n : String, url : String)
		{
			this.name = n;
			this.url = url;

			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, urlLoaderComplete);
		}

		public function start() : void
		{
			urlLoader.load(new URLRequest(url));
		}

		private function urlLoaderComplete(event : Event) : void
		{
			urlLoader.removeEventListener(Event.COMPLETE, urlLoaderComplete);
			event.stopImmediatePropagation();

			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, photoComplete);
			loader.loadBytes(event.target.data as ByteArray);
		}

		private function photoComplete(e : Event) : void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, photoComplete);
			bmd = Bitmap(e.target.content).bitmapData.clone();
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function get _bitmapData() : BitmapData {
			return bmd.clone();
		}

		public function get _bitmap() : Bitmap {
			return new Bitmap(bmd.clone());
		}
	}
}