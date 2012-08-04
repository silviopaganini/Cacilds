package cacilds.util
{
	/**
	 * ArrayUtil.as
	 * @author silvio paganini | s2paganini.com
	 * Copyright (c) 2012. All rights reserved.
	 */
	public class ArrayUtil
	{
		/**
		 * Shuffles and returns a new array
		 */
		public static function shuffle(arr : Array) : Array
		{
			var newArray : Array = new Array();
			while (arr.length > 0)
			{
				var index : Number = Math.floor(Math.random() * arr.length);
				var block : * = arr[index];
				newArray.push(block);
				arr.splice(index, 1);
			}
			return newArray;
		}
	}
}
