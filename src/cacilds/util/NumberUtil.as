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
	public class NumberUtil
	{
		public static function zeroFormat(number : Number, n : Number = 2, decimal : Boolean = false, trim : Boolean = false) : String
		{
			var numberConverted : String = "";
			var i : int;

			if (!decimal) {
				if (number.toString().length < n) {
					for ( i = number.toString().length;i < n;i++)
					{
						numberConverted += "0";
					}

					numberConverted = numberConverted + number;

					return numberConverted;
				} else {
					return trim ? number.toString().substr(0, n) : number.toString();
				}
			} else {
				if (number.toString().length < number.toString().length + n) {
					for (i = 0;i < n;i++)
					{
						numberConverted += "0";
					}

					numberConverted = number + "." + numberConverted;

					return numberConverted;
				} else {
					return number.toString();
				}
			}
		}

		public static function convertMilliseconds(milliseconds : int, showSeconds : Boolean = false, showHours : Boolean = false) : String
		{
			var seconds : int = (milliseconds / 1000) % 60;
			var strSeconds : String = zeroFormat(seconds);

			var minutes : int = ((milliseconds / 1000) / 60) % 60;
			var strMinutes : String = zeroFormat(minutes);

			var hours : int = ((milliseconds / 1000) / 60) / 60;
			var strHours : String = zeroFormat(hours);

			var result : String = "";
			if (showHours && !showSeconds) result = strHours + ":" + strMinutes;
			if (showSeconds && !showHours) result = strMinutes + ":" + strSeconds;
			if (showHours && showSeconds) result = strHours + ":" + strMinutes + ":" + strSeconds;

			return result;
		}
                
                // format "##.##"
		public static function formatNumber(n : Number, format : String) : String
		{
			var a : int,b : int,i : int;
			var c : String,d : String,resultC : String,resultD : String;
			var sString : String = n.toString();
			var cZero : String = "";

			if (format.indexOf(".") > -1) {
				var formatSplit : Array = format.split(".");
				a = formatSplit[0].length;
				b = formatSplit[1].length;

				if (sString.indexOf(".") > -1) {
					var nSringSplit : Array = sString.split(".");
					c = nSringSplit[0];
					d = nSringSplit[1];

					if (c.length < a) {
						for (i = 0; i < a - c.length; i++) cZero += "0";
						resultC = cZero + c.substr(0, a);
					} else {
						resultC = cZero + c.substr(0, a);
					}

					cZero = "";

					if (d.length < b) {
						for (i = 0; i < b - d.length; i++) cZero += "0";
						resultD = d.substr(0, b) + cZero;
					} else {
						resultD = d.substr(0, b);
					}
				} else {
					cZero = '';
					resultC = sString.substr(0, a);
					for (i = 0; i < a - resultC.length; i++) cZero += "0";
					resultC = cZero + resultC;

					cZero = '';
					for (i = 0; i < b; i++) cZero += "0";
					resultD = cZero;
				}

				return resultC + "." + resultD;
			} else {
				a = format.length;
				sString = sString.split(".").join("");

				if (sString.length < a) {
					for (i = -1; i < a - sString.length; i++) cZero += "0";
					return cZero + sString;
				} else {
					return sString.substr(0, a);
				}
			}

			return sString;
		}

		public static function toRad(n : Number) : Number
		{
			return n * Math.PI / 180;
		}
	}
}
