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
 
package cacilds.util
{
	/**
	 * @author silvio paganini | s2paganini.com
	 */
	public class ArrayHelper
	{
		public static function mix(arrayToMix : Array) : Array
		{
			var randomizedArr : Array = new Array();
			var numElementsLeft : int = arrayToMix.length;

			while (numElementsLeft) {
				var index : int = Math.floor(Math.random() * numElementsLeft);

				randomizedArr.push(arrayToMix[index]);

				arrayToMix.splice(index, 1);
				numElementsLeft--;
			}

			for (var i : int = 0;i < randomizedArr.length;i++)
			{
				arrayToMix[i] = randomizedArr[i];
			}

			return arrayToMix;
		}

		static public function pushUnique(whichArray : Array, item : *) : Array
		{
			var tempFound : int = 0;

			for each (var i : int in whichArray)
			{
				if (whichArray[i] == item) {
					tempFound++;
				}
			}

			if (tempFound < 1) whichArray.push(item);

			return whichArray;
		}

		static public function deleteArrayItem(whichArray : Array, item : *, paramItemArray : String = null, paramItemArrayToCompare : * = null) : Array
		{
			var resultArray : Array = new Array();

			for (var i : int = 0;i < whichArray.length;i++)
			{
				if (paramItemArrayToCompare) {
					if (whichArray[i][paramItemArray] != paramItemArrayToCompare) {
						resultArray.push(whichArray[i]);
					}
				} else if (paramItemArray) {
					if (whichArray[i][paramItemArray] != item[paramItemArray]) {
						resultArray.push(whichArray[i]);
					}
				} else {
					if (whichArray[i] != item) {
						resultArray.push(whichArray[i]);
					}
				}
			}

			return resultArray;
		}

		static public function getDiffValues(array1 : Array, array2 : Array) : Array
		{
			var result : Array = new Array();

			for (var i : int = 0; i < array1.length; i++)
			{
				var diff : Boolean = false;

				for (var a : int = 0; a < array2.length; a++)
				{
					if (array1[i].toString() == array2[a].toString()) {
						diff = true;
						break;
					}
				}
				
				if (!diff) result.push(array1[i]);
			}

			return result;
		}
	}
}
