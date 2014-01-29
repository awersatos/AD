/*******************************************************************************

   device.js - JavaScript code for CANopenNode device configurator - utility functions

   Copyright (C) 2007  Janez Paternoster, Slovenia

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


   Author: janez.paternoster@siol.net

*******************************************************************************/

function g_byteToHexString(number){
	var str = number.toString(16).toUpperCase();
	if(str.length == 1) str = "0" + str;
	return str.toUpperCase();
}

function g_wordToHexString(number){
	var str = number.toString(16).toUpperCase();
	str = "000" + str;
	str = str.slice(str.length-4);
	return str.toUpperCase();
}

function g_toEightCharString(string){
	string = string.substring(0, 8).toLowerCase();
	string = string.replace(/\W/g, "_"); //replace all non word characters with "_"
	return string;
}

function g_createListitem(arrayOfColumns){
//function creates new DOM listitem element with multiple columns, which can be appended to listbox
	var item = document.createElement("listitem");
	for(var i=0; i<arrayOfColumns.length; i++){
		var cell = document.createElement("listcell"); cell.setAttribute("label", arrayOfColumns[i]);
		item.appendChild(cell);
	}
	return item;
}

function g_CANopenDataType(dataType){
	switch(parseInt(dataType, 16)){
		//case 0x01: return "01 - BOOLEAN";
		case 0x02: return "02 - INTEGER8";
		case 0x03: return "03 - INTEGER16";
		case 0x04: return "04 - INTEGER32";
		case 0x05: return "05 - UNSIGNED8";
		case 0x06: return "06 - UNSIGNED16";
		case 0x07: return "07 - UNSIGNED32";
		//case 0x08: return "08 - REAL32";
		case 0x09: return "09 - VISIBLE_STRING";
		case 0x0A: return "0A - OCTET_STRING";
		default:  return "";
	}
}

function g_validateValue(value, dataType){
	dataType = dataType.slice(0, 2);
	value = value.replace("$NODEID+", "");
	i = parseInt(value);
	switch(dataType){
		//case 0x01: return "01": //BOOLEAN;
		case "02": //INTEGER8;
			if(!(-128<=i && i<=127)){
				alert("Valid Value for INTEGER8 is between -128 and 127 inclusive!");
				return "0";
			}
			break;
		case "03": //INTEGER16;
			if(!(-32768<=i && i<=32767)){
				alert("Valid Value for INTEGER16 is between -32768 and 32767 inclusive!");
				return "0";
			}
			break;
		case "04": //INTEGER32;
			if(!(-2147483648<=i && i<=2147483647)){
				alert("Valid Value for INTEGER32 is between -2147483648 and 2147483647 inclusive!");
				return "0";
			}
			break;
		case "05": //UNSIGNED8;
			if(!(0<=i && i<=255)){
				alert("Valid Value for UNSIGNED8 is between 0 and 255 inclusive!");
				return "0";
			}
			break;
		case "06": //UNSIGNED16;
			if(!(0<=i && i<=65536)){
				alert("Valid Value for UNSIGNED16 is between 0 and 65535 inclusive!");
				return "0";
			}
			break;
		case "07": //UNSIGNED32;
			if(!(0<=i && i<=4294967295)){
				alert("Valid Value for UNSIGNED32 is between 0 and 4294967295 inclusive!");
				return "0";
			}
			break;
		//case "08": //REAL32;
		case "09": //VISIBLE_STRING;
			break;
		case "0A": //OCTET_STRING;
			//example for allowed formats: '11 AA BB 00 01' or '11AABB0001'
			var oct = value.replace(/[0-9A-F]{2}/gi, ""); //remove all pairs of two hex digits
			var oct = oct.replace(/\s/g, ""); //remove all whitespaces
			if(oct.length){
				alert("Valid Value for OCTET_STRING is: pairs with hex-digits with or without space, for example '11 AA BB 00 01' or '11AABB0001'.");
				return "00";
			}
			break;
		default:  return "0";
	}
	return value;
}
