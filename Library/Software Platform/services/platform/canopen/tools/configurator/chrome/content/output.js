/*******************************************************************************

   output.js - JavaScript code for CANopenNode device configurator

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

//global variables
	//g_project is assigned by parent window
	//fileCO_OD_H
		var CO_OD_H_info = [];
		var CO_OD_H_macros = [];
		var CO_OD_H_typedefs = [];
		var CO_OD_H_RAM = [];
		var CO_OD_H_EEPROM = [];
		var CO_OD_H_ROM = [];
		var CO_OD_H_aliases = [];
	//fileCO_OD_C
		var CO_OD_C_initRAM = [];
		var CO_OD_C_initEEPROM = [];
		var CO_OD_C_initROM = [];
		var CO_OD_C_records = [];
		var CO_OD_C_functions = ["UNSIGNED32 CO_ODF(UNSIGNED16, UNSIGNED8, unsigned char, unsigned char, unsigned char, void*, ROM void*);\n"];
		var CO_OD_C_OD = [];
	//fileEDSspec
		var EDSspec_info = [];
		var EDSspec_optObj = ["SupportedObjects=xx"];
		var EDSspec_manufObj = ["SupportedObjects=xx"];
		var EDSspec_objList = [];
	//fileXMLspec
		var XMLspec_objList = <></>;
	//fileDOC
		var DOCidentity = <></>;
		var DOCfeaturesIndex = <></>;
		var DOCfeatures = <></>;
		var DOCobjDictCommIndex = <></>;
		var DOCobjDictComm = <></>;
		var DOCobjDictManufIndex = <></>;
		var DOCobjDictManuf = <></>;
		var DOCobjDictProfileIndex = <></>;
		var DOCobjDictProfile = <></>;

	//other
		var errorMessages = [];
		var associatedObjectList = {};

function generateFiles(){
	//textboxes for output text
	var fileDeviceDescription = document.getElementById("fileDeviceDescription");

	if(typeof(g_project) != "xml"){
		alert("No project is found, closing window!");
		window.close();
		return;
	}

	//set title to codeName
	var codeName = g_project.other.codeName.@name.toString();
	document.title = codeName + " output - CANopenNode";

	//output g_project directly
	fileDeviceDescription.value = "<?xml version=\"1.0\"?>\n" + g_project.toXMLString();

	//calculate the contents
	calculateDeviceIdentity();
	calculateFeatures();
	calculateObjects();

	//generate final outputs
	generateCO_OD_H();
	generateCO_OD_C();
	generateUSER_C();
	generateEDSspec();
	generateXMLspec();
	generateDOC();

	//Finish
	//remove 'please wait ...' text
	document.getElementById("introNote").hidden = true;
	if(errorMessages.length){
		var err = "Output files are generated with errors or warnings:\n\n" + errorMessages.join("\n");
		document.getElementById("errors").removeAttribute("hidden");
		document.getElementById("errors").value = err;
		alert(err);
	}
	else alert("All output files are generated successfully without errors or warnings.");
}

function saveFile(idBuf, strFile){
    const nsIFilePicker = Components.interfaces.nsIFilePicker;
    const nsILocalFile = Components.interfaces.nsILocalFile; 
    var filePicker = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
    var dir = Components.classes["@mozilla.org/file/local;1"].createInstance(nsILocalFile); 
    if (g_embpath)
        dir.initWithPath(g_embpath);
    else
        dir = Components.classes["@mozilla.org/file/directory_service;1"].getService(Components.interfaces.nsIProperties).get("Pers",
        Components.interfaces.nsILocalFile);
    filePicker.displayDirectory = dir;
    filePicker.init(window, "Save", nsIFilePicker.modeSave);
    filePicker.defaultString = strFile;
    filePicker.appendFilters(filePicker.filterAll);

    var res = filePicker.show();
    if (res == nsIFilePicker.returnOK || res == nsIFilePicker.returnReplace){
        var thefile = filePicker.file;
        var foStream = Components.classes["@mozilla.org/network/file-output-stream;1"]
                        .createInstance(Components.interfaces.nsIFileOutputStream);
        foStream.init(thefile, 0x02 | 0x08 | 0x20, 0666, 0); // write, create, truncate
        foStream.write(document.getElementById(idBuf).value, document.getElementById(idBuf).value.length);
        foStream.close();
    }
}

function calculateDeviceIdentity(){
	var idt = g_project.other.DeviceIdentity;
	var vendorName = idt.vendorName.toString();
	var vendorID = idt.vendorID.toString();
	var vendorText = idt.vendorText;
	var productName = idt.productName.toString();
	var productFamily = idt.productFamily.toString();
	var productID = idt.productID.toString();
	var productText = idt.productText;
	var deviceFamily = idt.deviceFamily;
	var buildDate = idt.buildDate.toString();
	var specificationRevision = idt.specificationRevision.toString();
	var instanceName = idt.instanceName.toString();
	
	/*** Generate contents CO_OD - c source code ***/
	CO_OD_H_info.push("      VendorName:     "+vendorName);
	CO_OD_H_info.push("      VendorNumber:   "+(vendorID?vendorID:"0"));
	CO_OD_H_info.push("      ProductName:    "+productName);
	CO_OD_H_info.push("      ProductNumber:  "+(productID?productID:"0"));

	/*** Generate contents for EDS specification ***/
	EDSspec_info.push(
		"VendorName="+vendorName+"\n"+
		"VendorNumber="+(vendorID?vendorID:"0")+"\n"+
		"ProductName="+productName+"\n"+
		"ProductNumber="+(productID?productID:"0")+"\n"+
		"RevisionNumber=0\n"+
		"OrderCode=0\n"+
		"BaudRate_10=1\n"+
		"BaudRate_20=1\n"+
		"BaudRate_50=1\n"+
		"BaudRate_125=1\n"+
		"BaudRate_250=1\n"+
		"BaudRate_500=1\n"+
		"BaudRate_800=1\n"+
		"BaudRate_1000=1\n"+
		"SimpleBootUpMaster=0\n"+
		"SimpleBootUpSlave=1\n"+
		"Granularity=8\n"+
		"DynamicChannelsSupported=0\n"+
		"GroupMessaging=0\n"+
		"NrOfRXPDO="+g_project.features.feature.(@name=="RPDO").@value.toString()+"\n"+
		"NrOfTXPDO="+g_project.features.feature.(@name=="TPDO").@value.toString()+"\n"+
		"LSS_Supported=0\n"
	);

	/*** Generate contents for Documentation ***/
	if(vendorName) vendorName = <tr><td><b>Vendor name</b></td><td>{vendorName}</td></tr>;
	if(vendorID) vendorID = <tr><td><b>Vendor ID</b></td><td>{vendorID}</td></tr>;
	if(vendorText.length()) vendorText = <tr><td><b>Vendor Text</b></td><td>{extractLabels(vendorText)}</td></tr>;
	if(productName) productName = <tr><td><b>Product Name</b></td><td>{productName}</td></tr>;
	if(productFamily) productFamily = <tr><td><b>Product Family</b></td><td>{productFamily}</td></tr>;
	if(productID) productID = <tr><td><b>Product ID</b></td><td>{productID}</td></tr>;
	if(productText.length()) productText = <tr><td><b>Product Text</b></td><td>{extractLabels(productText)}</td></tr>;
	if(deviceFamily.length()) deviceFamily = <tr><td><b>Device Family</b></td><td>{extractLabels(deviceFamily)}</td></tr>;
	if(buildDate) buildDate = <tr><td><b>Build Date</b></td><td>{buildDate}</td></tr>;
	if(specificationRevision) specificationRevision = <tr><td><b>Specification Revision</b></td><td>{specificationRevision}</td></tr>;
	if(instanceName) instanceName = <tr><td><b>Instance Name</b></td><td>{instanceName}</td></tr>;

	var orderNumber = <></>;
	for each(var el in idt.orderNumber)
		orderNumber += <div>{el}</div>
	if(orderNumber.length()) orderNumber = <tr><td><b>Order Number</b></td><td>{orderNumber}</td></tr>;

	var version = <></>;
	for each(var el in idt.version)
		version += <div>Version Type={el.@versionType}, version={el.toString()}</div>
	if(version.length()) version = <tr><td><b>Version</b></td><td>{version}</td></tr>;

	DOCidentity =
		<table border="1" style="margin-left:2em">
			{vendorName}
			{vendorID}
			{vendorText}
			{productName}
			{productFamily}
			{productID}
			{productText}
			{deviceFamily}
			{orderNumber}
			{version}
			{buildDate}
			{specificationRevision}
			{instanceName}
		</table>;
}

function calculateFeatures(){
	for each(var feature in g_project.features.feature){
		var name = feature.@name.toString();
		var macroName = name.replace(/\W/g, "_").toUpperCase();
		var value = feature.@value.toString();
		var valueVal = parseInt(value);

		/*** Generate contents CO_OD - c source code ***/
		var ao = [];
		if(value != "0"){
			for each(var obj in feature.associatedObject){
				var index = obj.@index.toString();
				var indexMax = obj.@indexMax.toString();
				if(indexMax){
					var lastObject = parseInt(index, 16) + valueVal - 1;
					var indexMaxVal = parseInt(indexMax, 16);
					if(lastObject > indexMaxVal) lastObject = indexMaxVal;
					lastObject = lastObject.toString(16).toUpperCase()
					associatedObjectList[index] = lastObject;
					ao.push(index+".."+lastObject);
				}
				else{
					ao.push(index);
				}
			}
		}
		if(ao.length) ao = "//Associated objects: " + ao.join(", "); else ao = "";
		CO_OD_H_macros.push("   #define CO_NO_" + indent(macroName, 25) + indent(value.toString(), 4) + ao);

		/*** Generate contents for Documentation ***/
		if(value != "0"){
			var href = "feature_" + macroName;
			var objects = <></>;
			var table = <></>
			for each(var obj in feature.associatedObject){
				var index = obj.@index.toString();
				var indexMax = obj.@indexMax.toString();
				objects +=
					<tr>
						<td>{g_project.CANopenObjectList.CANopenObject.(@index==index).@name}</td>
						<td>{index}</td>
						<td>{indexMax}</td>
					</tr>;
			}
			if(objects.length()){
				table =
					<table border="1">
						<caption>Associated objects:</caption>
						<tr>
							<th>Name</th>
							<th>Index</th>
							<th>Max Index</th>
						</tr>
						{objects}
					</table>+
					<br/>;
			}

			DOCfeaturesIndex += <li><a href={"#"+href}>{name}</a> (value = {value})</li>
			DOCfeatures +=
				<div style="page-break-inside: avoid;">
					<a name={href}/>
					<h3>{name}, value = {value}</h3>
					<div style="margin-left:2em">
						{table}
						{extractLabels(feature)}
					</div>
					<br/>
				</div>
		}
	}
}

function calculateObjects(){
	var accessFunctionNameArray = [];
	var OD_nameArray = [];
	//Variable below is used for Objects, which are listed in associatedObjectList. If curent object
	//is normal object, then property index is 0. If curent object is combined with it's neighbours into
	//an array, then index is the index of first object and lastIndex is the indeh of the last object in array.
	var isCombinedObject = {index:"", lastIndex:"", count:"", curentCount:"", br1:" ", br2:"", data:{}};

	for each(var object in g_project.CANopenObjectList.CANopenObject){
		if(object.@disabled != "true"){
			var index = object.@index.toString();
			var indexVal = parseInt("0x"+index);
			var name = object.@name.toString();
			var nameNoSpace = name2c_code(name);
			var objectType = object.@objectType.toString();
			var subNumber = object.@subNumber.toString();
			var subNumberVal = parseInt(subNumber);
			var memoryType = object.@memoryType.toString();
			var dataType = g_byteToHexString(parseInt(object.@dataType.toString(), 16));
			var accessType = object.@accessType.toString();
			var PDOmapping = object.@PDOmapping.toString();
			var TPDOrequestCapable = object.@TPDOrequestCapable.toString();
			var defaultValue = object.@defaultValue.toString();
			var actualValue = object.@actualValue.toString();
			var accessFunctionName = object.@accessFunctionName.toString();
			var accessFunctionPreCode = object.accessFunctionPreCode.toString();
			var accessFunctionPostCode = object.accessFunctionPostCode.toString();

			/*** SDO Server access function ***/
			var DOCaccessSDOoverride = <></>;
			if(accessFunctionName){ //external function
				DOCaccessSDOoverride = <div><b>{"Default SDO Server access to object is replaced by external function: \""+accessFunctionName+"\"."}</b><br/><br/></div>;
				if(accessFunctionNameArray.indexOf(accessFunctionName)<0){ //prevent duplicate decalrations
					CO_OD_C_functions.push("UNSIGNED32 "+accessFunctionName+"(UNSIGNED16, UNSIGNED8, unsigned char, unsigned char, unsigned char, void*, ROM void*);\n");
					accessFunctionNameArray.push(accessFunctionName);
				}
			}
			else if(accessFunctionPreCode || accessFunctionPostCode){
				//add two spaces to the beginning of the every line
				if(accessFunctionPreCode) accessFunctionPreCode = accessFunctionPreCode.replace(/^(.*)/gm, "  $1") + "\n";
				if(accessFunctionPostCode) accessFunctionPostCode = accessFunctionPostCode.replace(/^(.*)/gm, "  $1") + "\n";
				var func =
					"UNSIGNED32 CO_ODF_"+index+"(UNSIGNED16 index, UNSIGNED8 subindex, unsigned char attribute, unsigned char length, unsigned char dir, void* dataBuff, ROM void* pData){\n" +
					"  UNSIGNED32 abortCode;\n" +
					accessFunctionPreCode +
					"  abortCode = CO_ODF(index, subindex, attribute, length, dir, dataBuff, pData);\n" +
					accessFunctionPostCode +
					"  return abortCode;\n" +
					"}"
				DOCaccessSDOoverride =
					<div><b>Default SDO Server access to object is overrode by user defined function:</b>
						<pre style="margin-left:1em">{func}</pre>
						<br/>
					</div>
				CO_OD_C_functions.push(func+"\n");
				accessFunctionName = "CO_ODF_"+index;
			}
			else{
				accessFunctionName = "CO_ODF";
			}

			/*** Generate contents CO_OD - Source code in C ***/
			//Objects, which are listed in associatedObjectList, will be defined together with their neighbours as an array.
			//For example, all objects from 1400...15FF are defined as Receive_PDO_Communication_Parameter[CO_NO_RECEIVE_PDO]
			if(associatedObjectList[index]){
				isCombinedObject.index = index;	//variable will be "", if object will be 'normal' - not combined into array with neighbour objects
				isCombinedObject.lastIndex = associatedObjectList[index];
				//data, which must be the same in all combined objects
				isCombinedObject.data.name = name;
				isCombinedObject.data.objectType = objectType;
				isCombinedObject.data.subNumber = subNumber;
				isCombinedObject.data.memoryType = memoryType;
			}
			if(isCombinedObject.index){
				var i = parseInt("0x"+index);
				var fi = parseInt("0x"+isCombinedObject.index);
				var li = parseInt("0x"+isCombinedObject.lastIndex);
				isCombinedObject.count = "[" + (li - fi + 1).toString() + "]";
				isCombinedObject.curentCount = "[" + (i - fi).toString() + "]";
				if(i == fi) isCombinedObject.br1 = "{";
				else{
					isCombinedObject.br1 = " ";
					//verify, if all next objects have the same attributes as the first object
					if(isCombinedObject.data.name != name) errorCombined("Name");
					if(isCombinedObject.data.objectType != objectType) errorCombined("Object Type");
					if(isCombinedObject.data.subNumber != subNumber) errorCombined("Sub Number");
					if(isCombinedObject.data.memoryType != memoryType) errorCombined("Memory Type");
				}
				if(i == li) isCombinedObject.br2 = "}"; else isCombinedObject.br2 = "";
			}
			function errorCombined(err){errorMessages.push("Error in object " + index + ": This object is combined with object " +
																		isCombinedObject.index + " into Array. " + err + " of both objects must be the same!");}

			//verify if nameNoSpace is unique
			if(isCombinedObject.index == "" || isCombinedObject.index == index){
				if(OD_nameArray.indexOf(nameNoSpace)>=0)
					errorMessages.push("Error in object " + index + ": Duplicate Name!");
				else OD_nameArray.push(nameNoSpace);
			}

			var varDefinition, varInitialization;
			switch(objectType){
				case "7":	//Variable
					var defaultValueMemorySize = dataType2c_codeSize(dataType, defaultValue)
					if(isCombinedObject.index == "" || isCombinedObject.index == index){
						//normal object of first combined object
						if(isCombinedObject.index){
							//only first conmined object
							isCombinedObject.data.dataType = dataType;
							isCombinedObject.data.accessType = accessType;
							isCombinedObject.data.PDOmapping = PDOmapping;
							isCombinedObject.data.defaultValueMemorySize = defaultValueMemorySize;
						}

						//data type and optional array definition
						var dt = dataType2c_code(dataType, defaultValue, isCombinedObject.count, index);
						var arr = "";
						var isArr = dt.indexOf("[");
						if(isArr >= 0){
							arr = dt.slice(isArr);
							dt = dt.slice(0, isArr);
						}
						var indexRange = "/*" + index + ((isCombinedObject.index==index)?(".."+isCombinedObject.lastIndex):"      ");
						//object definition
						varDefinition = indexRange + "*/ " + indent(dt, 15) + nameNoSpace + arr + ";"

						//alias for object
						CO_OD_H_aliases.push(indexRange.replace(/\s/g,"") + ", Data Type: " + dt + (arr?", Array"+arr:"") + " */");
						CO_OD_H_aliases.push("      #define OD_" + indent(nameNoSpace, 40) + "CO_OD_" + memoryType + "." + nameNoSpace);
					}
					else{
						//next combined objects
						if(isCombinedObject.data.dataType != dataType) errorCombined("Data Type");
						if(isCombinedObject.data.accessType != accessType) errorCombined("Access Type");
						if(isCombinedObject.data.PDOmapping != PDOmapping) errorCombined("PDO Mapping");
						if(isCombinedObject.data.defaultValueMemorySize != defaultValueMemorySize) errorCombined("Length of Default value");
					}
					//object initial value
					varInitialization = "/*" + index + "*/"+ isCombinedObject.br1 + value2c_code(defaultValue, dataType, index) + isCombinedObject.br2 + ",";
					//attribute for Object Dictionary
					var attribute = attribute4c_code(memoryType, accessType, PDOmapping);
					if(TPDOrequestCapable=="true" && !isCombinedObject.index && memoryType!="ROM" && accessType!="wo" && (PDOmapping=="optional" || PDOmapping=="TPDO")){
						varDefinition = varDefinition.slice(0,15) + "unsigned int   " + nameNoSpace + "_TPDOflags;\n               " + varDefinition.slice(15);
						varInitialization = varInitialization.slice(0, 9) + "0x0000, " + varInitialization.slice(9);
						attribute |= 0x40;
						CO_OD_H_aliases.push("      #define " + "ODR_" + indent(nameNoSpace+"_requestTPDO()", 39) +
																 "CO_TPDOsendIfFlag(CO_OD_" + memoryType + "." + nameNoSpace + "_TPDOflags)");
					}
					if(dataType=="03" || dataType=="04" || dataType=="06" || dataType=="07"){
					    attribute |= 0x80;  //Multi_byte value
					}
					//put object into Object Dictionary
					var arrayType = "";
					if(dataType=="09" || dataType=="0A"){
						arrayType = "[0]";
						if(isCombinedObject.index == "" || isCombinedObject.index == index)
							CO_OD_H_aliases.push("      #define ODL_" + indent(nameNoSpace+"_stringLength",39) + defaultValueMemorySize.replace(" ", ""));
					}
					CO_OD_C_OD.push("{0x"+index+", 0x01, 0x"+g_byteToHexString(attribute)+", "+defaultValueMemorySize+", (ROM void*)&"+
													indent("CO_OD_"+memoryType+"."+nameNoSpace+isCombinedObject.curentCount+arrayType+", ", 49)+accessFunctionName+"},");
					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_aliases.push("");
					break;
				case "8":	//Array
					if(isCombinedObject.index == "" || isCombinedObject.index == index){
						//normal object of first combined object
						if(isCombinedObject.index){
							//only first combined object
							isCombinedObject.data.dataType = dataType;
							isCombinedObject.data.accessType = accessType;
							isCombinedObject.data.PDOmapping = PDOmapping;
						}

						//data type and optional array definition
						var defVal = object.CANopenSubObject[1].@defaultValue.toString(); //needed only for case, when dataType is string
						var dt = dataType2c_code(dataType, defVal, isCombinedObject.count + "[" + (subNumberVal-1).toString() + "]", index);
						var arr = "";
						var isArr = dt.indexOf("[");
						if(isArr >= 0){
							arr = dt.slice(isArr);
							dt = dt.slice(0, isArr);
						}
						var indexRange = "/*" + index + ((isCombinedObject.index==index)?(".."+isCombinedObject.lastIndex):"      ");
						//object definition
						varDefinition = indexRange + "*/ " + indent(dt, 15) + nameNoSpace + arr + ";"

						//alias for object
						CO_OD_H_aliases.push(indexRange.replace(/\s/g,"") + ", Data Type: " + dt + (arr?", Array"+arr:"") + " */");
						CO_OD_H_aliases.push("      #define OD_" + indent(nameNoSpace, 40) + "CO_OD_" + memoryType + "." + nameNoSpace);
						CO_OD_H_aliases.push("      #define ODL_" + indent(nameNoSpace+"_arrayLength", 39) + (subNumberVal-1).toString());
					}
					else{
						//next combined objects
						if(isCombinedObject.data.dataType != dataType) errorCombined("Data Type");
						if(isCombinedObject.data.accessType != accessType) errorCombined("Access Type");
						if(isCombinedObject.data.PDOmapping != PDOmapping) errorCombined("PDO Mapping");
					}

					//subObjects
					var subAlias = [];
					var subInitials = [];
					for(var i=1; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						if(subObject.@subIndex.toString() != g_byteToHexString(i))
							errorMessages.push("Error in object " + index + ": Wrong SubObjects!");

						var subName = subObject.@name.toString();
						var subNameNoSpace = name2c_code(subName);
						var subDefaultValue = subObject.@defaultValue.toString();
						var subDefaultValueMemorySize = dataType2c_codeSize(dataType, subDefaultValue)

						//verify, if data size of all objects and subObjects is the same
						if(i==1 && (isCombinedObject.index == "" || isCombinedObject.index == index))
							isCombinedObject.data.subDefaultValueMemorySize = subDefaultValueMemorySize;
						if(isCombinedObject.data.subDefaultValueMemorySize != subDefaultValueMemorySize)
							errorMessages.push("Error in object " + index + ": Length of Default value must be the same on all Sub-Objects and on all Combined Objects!");

						//initial value
						subInitials.push(value2c_code(subDefaultValue, dataType, index+", "+g_byteToHexString(i)));

						subAlias.push(subNameNoSpace);
					}

					//object initial value
					varInitialization = "/*" + index + "*/"+ isCombinedObject.br1 + "{" + subInitials.join(", ") + "}" + isCombinedObject.br2 + ",";

					//attribute for Object Dictionary
					var subAccessType = object.CANopenSubObject[0].@accessType.toString();
					var attribute = attribute4c_code(memoryType, subAccessType=="rw"?"rw":accessType, PDOmapping);
					if(dataType=="03" || dataType=="04" || dataType=="06" || dataType=="07"){
					    attribute |= 0x80;  //Multi_byte value
					}
					//put object into Object Dictionary
					var arrayType = "[0]";
					if(dataType=="09" || dataType=="0A"){
						arrayType += "[0]";
						if(isCombinedObject.index == "" || isCombinedObject.index == index)
							CO_OD_H_aliases.push("      #define ODL_" + indent(nameNoSpace+"_stringLength", 39) + subDefaultValueMemorySize.replace(" ", ""));
					}
					CO_OD_C_OD.push("{0x"+index+", 0x"+g_byteToHexString(subNumberVal)+", 0x"+g_byteToHexString(attribute)+", "+subDefaultValueMemorySize+", (ROM void*)&"+
													indent("CO_OD_"+memoryType+"."+nameNoSpace+isCombinedObject.curentCount+arrayType+", ", 49)+accessFunctionName+"},");

					//make aliases for subObjects (for each array member)
					if(isCombinedObject.index == ""){
						var makeAliases = true;
						//first make sure, that names of subObjects inside object are all different
						for(var i=0; i<subAlias.length; i++)
							for(var j=0; j<i; j++) 
								if(subAlias[i] == subAlias[j]) makeAliases = false;
						if(makeAliases)
							for(var i=0; i<subAlias.length; i++)
								CO_OD_H_aliases.push("      #define ODA_" + indent(nameNoSpace+"_"+subAlias[i], 39) + i.toString());
					}

					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_aliases.push("");
					break;
				case "9":	//Record
					//subObjects
					var subNames = [];
					var subDefinitions = [];
					var subAttributes = [];
					var subStructure = [];
					var subInitials = [];
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						if(subObject.@subIndex.toString() != g_byteToHexString(i))
							errorMessages.push("Error in object " + index + ": Wrong SubObjects!");

						//name
						var subName = subObject.@name.toString();
						var subNameNoSpace = name2c_code(subName);
						for(var j=0; j<i; j++) 
							if(subNameNoSpace == subNames[j])
								errorMessages.push("Error in object " + index + ": Each SubObject must have unique name!");
						subNames.push(subNameNoSpace);
						//data type
						var subDataType = subObject.@dataType.toString();
						var subAccessType = subObject.@accessType.toString();
						var subPDOmapping = subObject.@PDOmapping.toString();
						var subDefaultValue = subObject.@defaultValue.toString();
						var subDefaultValueMemorySize = dataType2c_codeSize(subDataType, subDefaultValue)
						var subAttribute = attribute4c_code(memoryType, subAccessType, subPDOmapping);
						//data type string and optional array definition
						var dt = dataType2c_code(subDataType, subDefaultValue, "", index+", "+g_byteToHexString(i));
						var arr = "";
						var isArr = dt.indexOf("[");
						if(isArr >= 0){
							arr = dt.slice(isArr);
							dt = dt.slice(0, isArr);
						}
						if(subDataType=="03" || subDataType=="04" || subDataType=="06" || subDataType=="07"){
					        subAttribute |= 0x80;  //Multi_byte value
					    }
                        //output
						subDefinitions.push("               " + indent(dt, 15) + subNameNoSpace + arr + ";");
						subAttributes.push(subAttribute);
						subStructure.push("           {(ROM void*)&CO_OD_" + memoryType + "." + nameNoSpace+isCombinedObject.curentCount+
															"."+subNameNoSpace+(arr?[0]:"")+", 0x"+g_byteToHexString(subAttribute)+", "+subDefaultValueMemorySize+"}");
						subInitials.push(value2c_code(subDefaultValue, subDataType, index+", "+g_byteToHexString(i)));
					}

					if(isCombinedObject.index == "" || isCombinedObject.index == index){
						//normal object of first combined object
						if(isCombinedObject.index){
							//only first combined object
							isCombinedObject.data.dataType = subDefinitions.toString();
							isCombinedObject.data.accessType = subAttributes.toString();
						}

						var indexRange = "/*" + index + ((isCombinedObject.index==index)?(".."+isCombinedObject.lastIndex):"      ");

						//typedef for record
						CO_OD_H_typedefs.push(indexRange + "*/ typedef struct{");
						CO_OD_H_typedefs.push(subDefinitions.join("\n"));
						CO_OD_H_typedefs.push("               }              ODs_" + nameNoSpace + ";\n");

						//object definition
						varDefinition = indexRange + "*/ " + indent("ODs_"+nameNoSpace, 15) + nameNoSpace + isCombinedObject.count + ";"

						//alias for object
						CO_OD_H_aliases.push(indexRange.replace(/\s/g,"") + ", Data Type: " + "ODs_"+nameNoSpace + (isCombinedObject.count?", Array"+isCombinedObject.count:"") + " */");
						CO_OD_H_aliases.push("      #define OD_" + indent(nameNoSpace, 40) + "CO_OD_" + memoryType + "." + nameNoSpace);
					}
					else{
						//next combined objects
						if(isCombinedObject.data.dataType != subDefinitions.toString()) errorCombined("Data Type on all SubObjects");
						if(isCombinedObject.data.accessType != subAttributes.toString()) errorCombined("Access Type and PDO mapping on all SubObjects");
					}

					//object initial value
					varInitialization = "/*" + index + "*/"+ isCombinedObject.br1 + "{" + subInitials.join(", ") + "}" + isCombinedObject.br2 + ",";

					//Information obout record for object dictionary
					CO_OD_C_records.push("/*0x"+index+"*/ ROM ODrecord ODrecord"+index+"["+subNumberVal+"] = {");
					CO_OD_C_records.push(subStructure.join(",\n") + "};");

					//put object into Object Dictionary
					CO_OD_C_OD.push("{0x"+index+", 0x"+g_byteToHexString(subNumberVal)+", 0x00,  0, (ROM void*)&"+
													indent("ODrecord"+index+", ", 49)+accessFunctionName+"},");

					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_aliases.push("");
					break;
			}
			switch(memoryType){
				case "RAM":
					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_RAM.push(varDefinition);
					CO_OD_C_initRAM.push(varInitialization);
					break;
				case "EEPROM":
					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_EEPROM.push(varDefinition);
					CO_OD_C_initEEPROM.push(varInitialization);
					break;
				case "ROM":
					if(isCombinedObject.index == "" || isCombinedObject.index == index) CO_OD_H_ROM.push(varDefinition);
					CO_OD_C_initROM.push(varInitialization);
					break;
			}

			if(index == isCombinedObject.lastIndex){
				isCombinedObject.index = "";
				isCombinedObject.lastIndex = "";
				isCombinedObject.count = "";
				isCombinedObject.curentCount = "";
				isCombinedObject.br1 = " ";
				isCombinedObject.br2 = "";
			}

			/*** Generate contents for EDS specification ***/
			var EDSdefaultValue = defaultValue;
			if(dataType=="0A") EDSdefaultValue = EDSdefaultValue.replace(/\s/g, "");
			if(0x2000 <=indexVal && indexVal <0x6000)
				EDSspec_manufObj.push(EDSspec_manufObj.length.toString()+"=0x"+index+"\n");
			else if(indexVal!=0x1000 && indexVal!=0x1001 && indexVal!=0x1018)
				EDSspec_optObj.push(EDSspec_optObj.length.toString()+"=0x"+index+"\n");
			var EDScontents = [];
			switch(objectType){
				case "7":	//Variable
					EDScontents.push(
						"["+index+"]"+
						"\nParameterName="+name+
						"\nObjectType=7"+
						"\nDataType=0x00"+dataType+
						"\nAccessType="+EDSaccessType(accessType, PDOmapping)+
						"\nPDOMapping="+(PDOmapping=="no"?"0":"1")+
						"\nDefaultValue="+EDSdefaultValue+"\n\n"
					);
					break;
				case "8":	//Array
				case "9":	//Record
					EDScontents.push(
						"["+index+"]"+
						"\nParameterName="+name+
						"\nObjectType="+objectType+
						"\nSubNumber="+subNumber+"\n\n"
					);
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						var subDataType = subObject.@dataType.toString();
						var subAccessType = EDSaccessType(subObject.@accessType, subObject.@PDOmapping);
						var subPDOmapping = (subObject.@PDOmapping.toString()=="no") ? "0" : "1";
						var subDefaultValue = subObject.@defaultValue;
						//subObjects in arrays have some common attributes
						if(objectType=="8" && subObject.@subIndex.toString() != "00"){
							subDataType = dataType;
							subAccessType = EDSaccessType(accessType, PDOmapping);
							subPDOmapping = (PDOmapping=="no") ? "0" : "1";
						}
						//remove spaces for octet string
						if(subDataType=="0A") subDefaultValue = subDefaultValue.replace(/\s/g, "");
						EDScontents.push(
							"["+index+"sub"+subObject.@subIndex.toString().replace(/^0/, "")+"]"+
							"\nParameterName="+subObject.@name+
							"\nObjectType=7"+
							"\nDataType=0x00"+subDataType+
							"\nAccessType="+subAccessType+
							"\nPDOMapping="+subPDOmapping+
							"\nDefaultValue="+subDefaultValue+"\n\n"
						);
					}
					break;
			}

			/*** Generate contents for XML specification ***/
			var XMLcontents;
			switch(objectType){
				case "7":	//Variable
					XMLcontents =
						<CANopenObject index={index} name={name} objectType={objectType} dataType={dataType} accessType={accessType} defaultValue={defaultValue} PDOmapping={PDOmapping}/>;
					break;
				case "8":	//Array
					var XMLcontSubidx = <></>
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						if(subObject.@subIndex.toString() == "00") XMLcontSubidx += subObject;
						else XMLcontSubidx += <CANopenSubObject subIndex={subObject.@subIndex} name={subObject.@name} objectType="7" dataType={dataType} accessType={accessType} defaultValue={subObject.@defaultValue} PDOmapping={PDOmapping}/>
					}
					XMLcontents = <CANopenObject index={index} name={name} objectType={objectType} subNumber={subNumber}>{XMLcontSubidx}</CANopenObject>;
					break;
				case "9":	//Record
					var XMLcontSubidx = <></>
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						XMLcontSubidx += <CANopenSubObject subIndex={subObject.@subIndex} name={subObject.@name} objectType="7" dataType={subObject.@dataType} accessType={subObject.@accessType} defaultValue={subObject.@defaultValue} PDOmapping={subObject.@PDOmapping}/>
					}
					XMLcontents = <CANopenObject index={index} name={name} objectType={objectType} subNumber={subNumber}>{XMLcontSubidx}</CANopenObject>;
			}

			/*** Generate contents for Documentation ***/
			var DOCcontents;
			switch(objectType){
				case "7":	//Variable
					DOCcontents =
						<table border="1" style="text-align: center;">
							<tr>
								<th>Object Type</th>
								<th>Memory Type</th>
								<th>Data Type</th>
								<th>Access Type</th>
								<th>PDO Mapping</th>
								<th>Capable for TPDO request</th>
								<th>Default value</th>
								<th>Actual value</th>
							</tr>
							<tr>
								<td>Var</td>
								<td>{memoryType}</td>
								<td>{g_CANopenDataType(dataType).slice(5)}</td>
								<td>{accessType}</td>
								<td>{PDOmapping}</td>
								<td>{TPDOrequestCapable=="true"?"yes":"no"}</td>
								<td>{defaultValue}</td>
								<td>{actualValue}</td>
							</tr>
						</table>;
					break;
				case "8":	//Array
					var DOCcontSubidx = <></>
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						DOCcontSubidx +=
							<tr>
								<td>{subObject.@subIndex}</td>
								<td>{subObject.@name}</td>
								<td>{subObject.@defaultValue}</td>
								<td>{subObject.@actualValue}</td>
							</tr>
					}
					DOCcontents =
						<table border="1" style="text-align: center;">
							<tr>
								<th>Object Type</th>
								<th>Sub Number</th>
								<th>Memory Type</th>
								<th>Data Type</th>
								<th>Access Type</th>
								<th>PDO Mapping</th>
							</tr>
							<tr>
								<td>Array</td>
								<td>{subNumber}</td>
								<td>{memoryType}</td>
								<td>{g_CANopenDataType(dataType).slice(5)}</td>
								<td>{accessType}</td>
								<td>{PDOmapping}</td>
							</tr>
						</table>+
						<br/>+
						<table border="1" style="text-align: center;">
							<tr>
								<th>Subindex</th>
								<th>Name</th>
								<th>Default value</th>
								<th>Actual value</th>
							</tr>
							{DOCcontSubidx}
						</table>;
					break;
				case "9":	//Record
					var DOCcontSubidx = <></>
					for(var i=0; i<subNumberVal; i++){
						var subObject = object.CANopenSubObject[i];
						DOCcontSubidx +=
							<tr>
								<td>{subObject.@subIndex}</td>
								<td>{subObject.@name}</td>
								<td>{g_CANopenDataType(subObject.@dataType.toString()).slice(5)}</td>
								<td>{subObject.@accessType}</td>
								<td>{subObject.@PDOmapping}</td>
								<td>{subObject.@defaultValue}</td>
								<td>{subObject.@actualValue}</td>
							</tr>
					}
					DOCcontents =
						<table border="1" style="text-align: center;">
							<tr>
								<th>Object Type</th>
								<th>Sub Number</th>
								<th>Memory Type</th>
							</tr>
							<tr>
								<td>Record</td>
								<td>{subNumber}</td>
								<td>{memoryType}</td>
							</tr>
						</table>+
						<br/>+
						<table border="1" style="text-align: center;">
							<tr>
								<th>Subindex</th>
								<th>Name</th>
								<th>Data Type</th>
								<th>Access Type</th>
								<th>PDO Mapping</th>
								<th>Default value</th>
								<th>Actual value</th>
							</tr>
							{DOCcontSubidx}
						</table>;
					break;
			}

			/*** Output ***/
			//EDS specification
			EDSspec_objList.push(EDScontents.join(""));

			//XML specification
			XMLspec_objList += XMLcontents;

			//Documentation
			var DOChref = "object_" + index.toString().replace(/\W/g, "_");
			var DOCobjectIndex = <li><a href={"#"+DOChref}>{index}</a> - {name}</li>
			var DOCobject =
				<div style="page-break-inside: avoid;">
					<a name={DOChref}/>
					<h3>{index} - {name}</h3>
					<div style="margin-left:2em">
						{DOCcontents}
						<br/>
						{DOCaccessSDOoverride}
						{extractLabels(object)}
					</div>
					<br/>
				</div>

			if(indexVal < 0x2000){
				DOCobjDictCommIndex += DOCobjectIndex;
				DOCobjDictComm += DOCobject
			}
			else if(indexVal < 0x6000){
				DOCobjDictManufIndex += DOCobjectIndex;
				DOCobjDictManuf += DOCobject
			}
			else{
				DOCobjDictProfileIndex += DOCobjectIndex;
				DOCobjDictProfile += DOCobject
			}
		}
	}
}

function EDSaccessType(accessType, PDOmapping){
	if(accessType=="rw"){
		if(PDOmapping=="RPDO" || PDOmapping=="optional") return "rww";
		else if(PDOmapping=="TPDO") return "rwr";
	}
	return accessType;
}

function indent(string, length){
	if(string.length >= length) return string + " ";
	string += "                                                                                                    ";
	return string.slice(0, length);
}

function name2c_code(name){
	//remove all nonWord characters and make first word letters uppercase
	var arr = name.split(/\W+/);
	var str = arr[0].charAt(1);
	if("a"<=str && str<="z"){
		var str = arr[0];
		arr[0] = str.charAt(0).toLowerCase() + str.slice(1);
	}
	var prevLastChar = str.charAt(str.length-1);
	for(var i=1; i<arr.length; i++){
		var str = arr[i];
		arr[i] = str.charAt(0).toUpperCase() + str.slice(1);
		if(("A"<=prevLastChar && prevLastChar<="Z") && ("A"<=str.charAt(1) && str.charAt(1)<="Z")) arr[i] = "_" + arr[i];
		prevLastChar = str.charAt(str.length-1);
	}
	return arr.join("");
}

function dataType2c_code(dataType, value, arrayDef, object){
  dataType = g_CANopenDataType(dataType).slice(5);
	if(dataType == "VISIBLE_STRING")
		dataType += arrayDef + "["+value.length.toString()+"]";
	else if(dataType == "OCTET_STRING")
		dataType += arrayDef + "["+(value.replace(/\s/g, "").length/2).toString()+"]";
	else
		dataType += arrayDef;
	return dataType;
}

function dataType2c_codeSize(dataType, value){
	switch(dataType){
		case "02": //INTEGER8;
		case "05": //UNSIGNED8;
			return " 1";
		case "03": //INTEGER16;
		case "06": //UNSIGNED16;
			return " 2";
		case "04": //INTEGER32;
		case "07": //UNSIGNED32;
			return " 4";
		case "09": //VISIBLE_STRING;
			var str = value.length.toString();
			if(str.length==1) str = " " + str;
			return str;
		case "0A": //OCTET_STRING;
			var str = (value.replace(/\s/g, "").length/2).toString();
			if(str.length==1) str = " " + str;
			return str;
		default:
			return "??";
	}
}

function value2c_code(value, dataType, object){
	dataType = dataType.slice(0, 2);
	value = value.replace("$NODEID+", "");
	i = parseInt(value);
	switch(dataType){
		//case 0x01: return "01": //BOOLEAN;
		case "02": //INTEGER8;
			if(!(-128<=i && i<=127)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			return i.toString();
		case "03": //INTEGER16;
			if(!(-32768<=i && i<=32767)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			return i.toString();
		case "04": //INTEGER32;
			if(!(-2147483648<=i && i<=2147483647)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0L";
			}
			return i.toString()+"L";
		case "05": //UNSIGNED8;
			if(!(0<=i && i<=255)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			return "0x"+i.toString(16).toUpperCase();
		case "06": //UNSIGNED16;
			if(!(0<=i && i<=65536)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			return "0x"+i.toString(16).toUpperCase();
		case "07": //UNSIGNED32;
			if(!(0<=i && i<=4294967295)){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			return "0x"+i.toString(16).toUpperCase()+"L";
		//case "08": //REAL32;
		case "09": //VISIBLE_STRING;
			var strArray = value.match(/./g); //array of characters
			return "{'" + strArray.join("', '") + "'}";
			break;
		case "0A": //OCTET_STRING;
			//example for allowed formats: '11 AA BB 00 01' or '11AABB0001'
			var oct = value.replace(/[0-9A-F]{2}/gi, ""); //remove all pairs of two hex digits
			oct = oct.replace(/\s/g, ""); //remove all whitespaces
			if(oct.length){
				errorMessages.push("Error in object " + object + ": Invalid Default value!");
				return "0";
			}
			var strArray = value.match(/[0-9A-F]{2}/gi); //array of pairs
			return "{0x" + strArray.join(", 0x") + "}";
		default:
			errorMessages.push("Error in object " + object + ": Invalid Data Type!");
			return "0";
	}
}

function attribute4c_code(memoryType, accessType, PDOmapping){
	//for attribute description see generated CO_OD.h file
	var attr = 0;
	switch(memoryType){
		case "ROM": attr = 0x01; break;
		case "RAM": attr = 0x02; break;
		case "EEPROM": attr = 0x03; break;
	}
	if(accessType!="wo") attr |= 0x04;
	if(accessType=="wo" || accessType=="rw") attr |= 0x08;
	if(PDOmapping=="optional" || PDOmapping=="RPDO") attr |= 0x10;
	if(PDOmapping=="optional" || PDOmapping=="TPDO") attr |= 0x20;
	return attr;
}

function extractLabels(element){
	var langs = g_project.other.supportedLanguages.@supportedLanguages.toString().split(" ");
	var output = <></>;
	for(var i=0; i<langs.length; i++){
		var lang = langs[i];
		var label = element.label.(@lang==lang).toString();
		var description = element.description.(@lang==lang);
		if(label || description.length()){
			var URI = description.@URI.toString();
			var more = "";
			if(URI) more = <a onclick={"var w = window.open('"+URI+"', 'infoWindow', 'resizable=yes,scrollable=yes,location=yes'); w.focus(); return false;"} href="#">More...</a>
			//replace XML illegar characters and replace all newlines in description with <br/>
			description = description.toString()
			description = description.replace(/&/g, "&amp;");
			description = description.replace(/</g, "&lt;");
			description = description.replace(/\n/g, "<br/>");
			description = new XML("<span>"+description+"</span>");
			if(i>0) output += <br/>
			output +=
				<div>
					<b>{lang}: {label}</b><br/>
					<div style='margin-left:1em'>
						{description}<br/>
						{more}
					</div>
				</div>;
		}
	}
	return output;
}

function generateCO_OD_H(){
	document.getElementById("fileCO_OD_H").value =
		"/*******************************************************************************\n"+
		"\n"+
		"   CO_OD.h - Header for variables and Object Dictionary for CANopenNode\n"+
		"\n"+
		"   Copyright (C) 2004  Janez Paternoster, Slovenia\n"+
		"\n"+
		"   This library is free software; you can redistribute it and/or\n"+
		"   modify it under the terms of the GNU Lesser General Public\n"+
		"   License as published by the Free Software Foundation; either\n"+
		"   version 2.1 of the License, or (at your option) any later version.\n"+
		"\n"+
		"   This library is distributed in the hope that it will be useful,\n"+
		"   but WITHOUT ANY WARRANTY; without even the implied warranty of\n"+
		"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\n"+
		"   Lesser General Public License for more details.\n"+
		"\n"+
		"   You should have received a copy of the GNU Lesser General Public\n"+
		"   License along with this library; if not, write to the Free Software\n"+
		"   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n"+
		"\n"+
		"\n"+
		"   Author: janez.paternoster@siol.net\n"+
		"\n"+
		"\n"+
		"   This file was automatically generated with CANopenNode Object\n"+
		"   Dictionary Editor: http://canopennode.sourceforge.net/\n"+
		"   DON'T EDIT THIS FILE MANUALLY !!!!\n"+
		"\n"+
		"*******************************************************************************/\n"+
		"\n"+
		"#ifndef _CO_OD_H\n"+
		"#define _CO_OD_H\n"+
		"\n"+
		"#include <co_defs.h>"+
		"\n"+
		"/*******************************************************************************\n"+
		"   DEVICE INFO:\n"+
		CO_OD_H_info.join("\n")+"\n"+
		"*******************************************************************************/\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   FEATURES\n"+
		"*******************************************************************************/\n"+
		CO_OD_H_macros.join("\n")+"\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   CANOPEN BASIC DATA TYPES AND OBJECT DICTIONARY DEFINITIONS\n"+
		"*******************************************************************************/\n"+
		"/* One object in Object Dictionary */\n"+
		"   typedef struct {\n"+
		"      UNSIGNED16       index;\n"+
		"      UNSIGNED8        subNumber;\n"+
		"      unsigned char    attribute;\n"+
		"      unsigned char    length;\n"+
		"      ROM void*        pData;\n"+
		"      UNSIGNED32       (*pFunct)(UNSIGNED16 index, UNSIGNED8 subindex, unsigned char attribute,\n"+
		"                       unsigned char length, unsigned char dir, void* dataBuff, ROM void* pData);\n"+
		"   } sCO_OD_object;\n"+
		"\n"+
		"/* Attributes for Object Dictionary objects (flags) */\n"+
		"   #define CO_ODA_MEM_ROM          0x01\n"+
		"   #define CO_ODA_MEM_RAM          0x02\n"+
		"   #define CO_ODA_MEM_EEPROM       0x03\n"+
		"   #define CO_ODA_READABLE         0x04\n"+
		"   #define CO_ODA_WRITEABLE        0x08\n"+
		"   #define CO_ODA_RPDO_MAPABLE     0x10\n"+
		"   #define CO_ODA_TPDO_MAPABLE     0x20\n"+
		"   #define CO_ODA_TPDO_REQUESTABLE 0x40\n"+
		"   #define CO_ODA_MB_VALUE         0x80 // True when entry is a multibyte value\n"+
		"\n"+
		"/* Structure for record type objects */\n"+
		"   typedef struct {ROM void* pData; unsigned char attribute; unsigned char length;} ODrecord;\n"+
		"\n"+
		"/* Object Dictionary array */\n"+
		"   extern ROM sCO_OD_object CO_OD[];\n"+
		"   extern ROM unsigned int CO_OD_NoOfElements;\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   TYPE DEFINITIONS FOR RECORDS\n"+
		"*******************************************************************************/\n"+
		CO_OD_H_typedefs.join("\n")+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   STRUCTURES FOR VARIABLES IN DIFFERENT MEMORY LOCATIONS\n"+
		"*******************************************************************************/\n"+
		"#define  CO_OD_FIRST_LAST_BYTE     0x55 //Any value from 0x01 to 0xFE. If changed, EEPROM will be reinitialized.\n"+
		"\n"+
		"/***** Structure for RAM variables ********************************************/\n"+
		"struct sCO_OD_RAM{\n"+
		"           unsigned char FirstByte;\n"+
		"\n"+
		CO_OD_H_RAM.join("\n")+"\n"+
		"\n"+
		"           unsigned int LastByte;\n"+
		"};\n"+
		"\n"+
		"/***** Structure for EEPROM variables *****************************************/\n"+
		"struct sCO_OD_EEPROM{\n"+
		"           unsigned char FirstByte;\n"+
		"\n"+
		CO_OD_H_EEPROM.join("\n")+"\n"+
		"\n"+
		"#if CO_NO_RETENTIVE_USAGE != 3  //if CO_NO_RETENTIVE_USAGE==3, then combine ROM variables into EEPROM memory space\n"+
		"           unsigned int LastByte;\n"+
		"};\n"+
		"\n"+
		"\n"+
		"/***** Structure for ROM variables ********************************************/\n"+
		"struct sCO_OD_ROM{\n"+
		"           unsigned char FirstByte;\n"+
		"#endif\n"+
		"\n"+
		CO_OD_H_ROM.join("\n")+"\n"+
		"\n"+
		"           unsigned int LastByte;\n"+
		"};\n"+
		"\n"+
		"\n"+
		"/***** Declaration of Object Dictionary variables *****************************/\n"+
		"extern volatile struct sCO_OD_RAM CO_OD_RAM;\n"+
		"\n"+
		"extern struct sCO_OD_EEPROM CO_OD_EEPROM;\n"+
		"\n"+
		"//Memory location of ROM variables can be in RAM or in Flash\n"+
		"//if CO_NO_RETENTIVE_USAGE==3, then ROM variables are combined with EEPROM variables\n"+
		"#if CO_NO_RETENTIVE_USAGE != 3\n"+
		"   #if CO_NO_RETENTIVE_USAGE==0 || CO_NO_RETENTIVE_USAGE==2 || CO_NO_RETENTIVE_USAGE==4 || CO_NO_RETENTIVE_USAGE==6\n"+
		"      extern ROM struct sCO_OD_ROM CO_OD_ROM;\n"+
		"   #else\n"+
		"      extern struct sCO_OD_ROM CO_OD_ROM;\n"+
		"   #endif\n"+
		"#else\n"+
		"   #define CO_OD_ROM CO_OD_EEPROM\n"+
		"#endif\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   ALIASES FOR OBJECT DICTIONARY VARIABLES\n"+
		"*******************************************************************************/\n"+
		CO_OD_H_aliases.join("\n")+"\n"+
		"\n"+
		"#endif\n";
}
	
function generateCO_OD_C(){
	document.getElementById("fileCO_OD_C").value =
		"/*******************************************************************************\n"+
		"\n"+
		"   CO_OD.c - Variables and Object Dictionary for CANopenNode\n"+
		"\n"+
		"   Copyright (C) 2004  Janez Paternoster, Slovenia\n"+
		"\n"+
		"   This library is free software; you can redistribute it and/or\n"+
		"   modify it under the terms of the GNU Lesser General Public\n"+
		"   License as published by the Free Software Foundation; either\n"+
		"   version 2.1 of the License, or (at your option) any later version.\n"+
		"\n"+
		"   This library is distributed in the hope that it will be useful,\n"+
		"   but WITHOUT ANY WARRANTY; without even the implied warranty of\n"+
		"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\n"+
		"   Lesser General Public License for more details.\n"+
		"\n"+
		"   You should have received a copy of the GNU Lesser General Public\n"+
		"   License along with this library; if not, write to the Free Software\n"+
		"   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n"+
		"\n"+
		"\n"+
		"   Author: janez.paternoster@siol.net\n"+
		"\n"+
		"\n"+
		"   This file was automatically generated with CANopenNode Object\n"+
		"   Dictionary Editor: http://canopennode.sourceforge.net/\n"+
		"   DON'T EDIT THIS FILE MANUALLY !!!!\n"+
		"\n"+
		"*******************************************************************************/\n"+
		"\n"+
		"\n"+
		"#include \"CANopen.h\"\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   DEFINITION AND INITIALIZATION OF OBJECT DICTIONARY VARIABLES\n"+
		"*******************************************************************************/\n"+
		"\n"+
		"#ifdef __18CXX\n"+
		"   #pragma romdata CO_OD_RomVariables=0x1000 //ROM variables in PIC18fxxx must be above address 0x1000\n"+
		"#endif\n"+
		"\n"+
		"/***** Definition for RAM variables *******************************************/\n"+
		"volatile struct sCO_OD_RAM CO_OD_RAM = {\n"+
		"           CO_OD_FIRST_LAST_BYTE,\n"+
		"\n"+
		CO_OD_C_initRAM.join("\n")+"\n"+
		"\n"+
		"           CO_OD_FIRST_LAST_BYTE,\n"+
		"};\n"+
		"\n"+
		"\n"+
		"/***** Definition for EEPROM variables ****************************************/\n"+
		"struct sCO_OD_EEPROM CO_OD_EEPROM = {\n"+
		"           CO_OD_FIRST_LAST_BYTE,\n"+
		"\n"+
		CO_OD_C_initEEPROM.join("\n")+"\n"+
		"\n"+
		"#if CO_NO_RETENTIVE_USAGE != 3  //if CO_NO_RETENTIVE_USAGE==3, then combine ROM variables into EEPROM memory space\n"+
		"           CO_OD_FIRST_LAST_BYTE,\n"+
		"};\n"+
		"\n"+
		"\n"+
		"/***** Definition for ROM variables *******************************************/\n"+
		"#if CO_NO_RETENTIVE_USAGE==0 || CO_NO_RETENTIVE_USAGE==2 || CO_NO_RETENTIVE_USAGE==4 || CO_NO_RETENTIVE_USAGE==6\n"+
		"   ROM struct sCO_OD_ROM CO_OD_ROM = {    //constant variables, stored in flash\n"+
		"#else\n"+
		"   struct sCO_OD_ROM CO_OD_ROM = {        //variables stored in RAM (and saved)\n"+
		"#endif\n"+
		"           CO_OD_FIRST_LAST_BYTE,\n"+
		"#endif\n"+
		"\n"+
		CO_OD_C_initROM.join("\n")+"\n"+
		"\n"+
		"           CO_OD_FIRST_LAST_BYTE\n"+
		"};\n"+
		"\n"+
		"\n"+
		"#ifdef __18CXX\n"+
		"   #pragma romdata //return to the default section\n"+
		"#endif\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   STRUCTURES FOR RECORD TYPE OBJECTS\n"+
		"*******************************************************************************/\n"+
		CO_OD_C_records.join("\n")+"\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   SDO SERVER ACCESS FUNCTIONS WITH USER CODE\n"+
		"*******************************************************************************/\n"+
		"#define READING (dir==0)\n"+
		"#define WRITING (dir==1)\n"+
		"\n"+
		CO_OD_C_functions.join("\n")+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   OBJECT DICTIONARY\n"+
		"*******************************************************************************/\n"+
		"ROM sCO_OD_object CO_OD[] = {\n"+
		CO_OD_C_OD.join("\n")+"\n"+
		"};\n"+
		"\n"+
		"/***** Number of Elements in Object Dictionary ********************************/\n"+
		"ROM unsigned int CO_OD_NoOfElements = sizeof(CO_OD) / sizeof(CO_OD[0]);\n"+
		"\n";
}

function generateUSER_C(){
	document.getElementById("fileUSER_C").value =
		"/*******************************************************************************\n"+
		"\n"+
		"   User functions\n"+
		"\n"+
		"*******************************************************************************/\n"+
		"\n"+
		"#include <CANopen.h>\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   External Functions for handling PDO reception and transmission\n"+
		"   Must be called either from User_ProcessMain or User_ProcessTimer\n"+
		"*******************************************************************************/\n"+
		"void CO_PDOhandleReception(void);\n"+
		"void CO_PDOhandleTransmission(void);\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   User_Remove - USER EXECUTION ON EXIT OF PROGRAM\n"+
		"   Function is called before end of program. Not used in PIC.\n"+
		"*******************************************************************************/\n"+
		"void User_Remove(void){\n"+
		"\n"+
		"}\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   User_ResetComm - USER RESET COMMUNICATION\n"+
		"   Function is called after start of program and after CANopen NMT command: Reset\n"+
		"   Communication.\n"+
		"*******************************************************************************/\n"+
		"void User_ResetComm(void){\n"+
		"\n"+
		"}\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   User_ProcessMain - USER PROCESS MAINLINE\n"+
		"   This function is cyclycally called from main(). It is non blocking function.\n"+
		"   It is asynchronous. Here is longer and time consuming code.\n"+
		"*******************************************************************************/\n"+
		"void User_ProcessMain(void){\n"+
		"\n"+
		"}\n"+
		"\n"+
		"\n"+
		"/*******************************************************************************\n"+
		"   User_ProcessTimer - 1 ms USER TIMER FUNCTION\n"+
		"   Function is executed every 1 ms. It is deterministic and has priority over\n"+
		"   mainline functions.\n"+
		"*******************************************************************************/\n"+
		"void User_ProcessTimer(void){\n"+
		"/* PDO reception */\n"+
		"   #if CO_NO_RPDO > 0\n"+
		"      CO_PDOhandleReception();\n"+
		"   #endif\n"+
		"\n"+
		"\n"+
		"/* User Code goes here */\n"+
		"\n"+
		"\n"+
		"\n"+
		"/* PDO transmission */\n"+
		"   #if CO_NO_TPDO > 0\n"+
		"      CO_PDOhandleTransmission();\n"+
		"   #endif\n"+
		"\n"+
		"}\n"+
		"\n";
}

function generateEDSspec(){
	var num = EDSspec_optObj.length-1; EDSspec_optObj[0] = "SupportedObjects="+num.toString()+"\n"
	var num = EDSspec_manufObj.length-1; EDSspec_manufObj[0] = "SupportedObjects="+num.toString()+"\n"
	document.getElementById("fileEDSspec").value =
		"\n"+
		"; EDS-File for CANopenNode example _blank_project\n"+
		"; Copyright (C) 2004  Janez Paternoster, Slovenia\n"+
		"\n"+
		"\n"+
		"[FileInfo]\n"+
		"FileName=0\n"+
		"FileVersion=2\n"+
		"FileRevision=0\n"+
		"EDSVersion=4.0\n"+
		"Description=Open Source CANopen implementation\n"+
		"CreationTime=10:00AM\n"+
		"CreationDate=12-07-2007\n"+
		"CreatedBy=Janez Paternoster\n"+
		"ModificationTime=10:00AM\n"+
		"ModificationDate=12-07-2007\n"+
		"ModifiedBy=Janez Paternoster\n"+
		"\n"+
		"\n"+
		"[DeviceInfo]\n"+
		EDSspec_info.join("")+
		"\n"+
		"\n"+
		"[Comments]\n"+
		"Lines=5\n"+
		"Line1=EDS File for CANopenNode device\n"+
		"Line2=Open Source CANopen implementation\n"+
		"Line3=Stack Version: V2.00\n"+
		"Line4=Generated by CANopenNode Object Dictionary Editor\n"+
		"line5=http://canopennode.sourceforge.net/\n"+
		"\n"+
		"\n"+
		"[DummyUsage]\n"+
		"Dummy0001=0\n"+
		"Dummy0002=1\n"+
		"Dummy0003=1\n"+
		"Dummy0004=1\n"+
		"Dummy0005=1\n"+
		"Dummy0006=1\n"+
		"Dummy0007=1\n"+
		"\n"+
		"\n"+
		"[MandatoryObjects]\n"+
		"SupportedObjects=3\n"+
		"1=0x1000\n"+
		"2=0x1001\n"+
		"3=0x1018\n"+
		"\n"+
		"\n"+
		"[OptionalObjects]\n"+
		EDSspec_optObj.join("")+
		"\n"+
		"\n"+
		"[ManufacturerObjects]\n"+
		EDSspec_manufObj.join("")+
		"\n"+
		EDSspec_objList.join("");
}

function generateXMLspec(){
	var file =
		<ISO15745ProfileContainer xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="CANopen_Main.xsd">
			<ISO15745Profile>
				<ProfileHeader>
					<ProfileIdentification>CAN device profile</ProfileIdentification>
					<ProfileRevision>1</ProfileRevision>
					<ProfileName>{g_project.other.DeviceIdentity.productName.toString()}</ProfileName>
					<ProfileSource/>
					<ProfileClassID>Device</ProfileClassID>
					<ISO15745Reference>
						<ISO15745Part>1</ISO15745Part>
						<ISO15745Edition>1</ISO15745Edition>
						<ProfileTechnology>CANopen</ProfileTechnology>
					</ISO15745Reference>
				</ProfileHeader>
				<ProfileBody xsi:type="ProfileBody_Device_CANopen" supportedLanguages={g_project.other.supportedLanguages.@supportedLanguages} fileName="" fileCreator="" fileCreationDate="" fileModifiedBy="" fileModificationDate="" fileVersion="">
					{g_project.other.DeviceIdentity}
					<DeviceFunction>
						{g_project.other.capabilities}
					</DeviceFunction>
				</ProfileBody>
			</ISO15745Profile>
			<ISO15745Profile>
				<ProfileHeader>
					<ProfileIdentification>CAN comm net profile</ProfileIdentification>
					<ProfileRevision>1</ProfileRevision>
					<ProfileName>{g_project.other.DeviceIdentity.productName.toString()}</ProfileName>
					<ProfileSource/>
					<ProfileClassID>CommunicationNetwork</ProfileClassID>
					<ISO15745Reference>
						<ISO15745Part>1</ISO15745Part>
						<ISO15745Edition>1</ISO15745Edition>
						<ProfileTechnology>CANopen</ProfileTechnology>
					</ISO15745Reference>
				</ProfileHeader>
				<ProfileBody xsi:type="ProfileBody_CommunicationNetwork_CANopen" supportedLanguages={g_project.other.supportedLanguages.@supportedLanguages} fileName="" fileCreator="" fileCreationDate="" fileModifiedBy="" fileModificationDate="" fileVersion="">
					<ApplicationLayers>
						<CANopenObjectList>
							{XMLspec_objList}
						</CANopenObjectList>
						{g_project.other.dummyUsage}
					</ApplicationLayers>
					<TransportLayers>
						<PhysicalLayer>
							{g_project.other.baudRate}
						</PhysicalLayer>
					</TransportLayers>
				</ProfileBody>
			</ISO15745Profile>
		</ISO15745ProfileContainer>

	document.getElementById("fileXMLspec").value = "<?xml version=\"1.0\"?>\n" + file.toXMLString();
}

function generateDOC(){
	var html = new Namespace("http://www.w3.org/1999/xhtml")
	var file =
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<title>CANopenNode</title>
		</head>
		<body>
			<h1>Documentation for CANopen device</h1>
			<br/>
			<div>
				<h2>Contents</h2>
				<ul>
					<li><a href="#intro">Introduction</a></li>
					<li><a href="#identity">Device Identity</a></li>
					<li><a href="#features">CANopen features</a></li>

					<ul>{DOCfeaturesIndex}</ul>

					<li><a href="#objDict">Object Dictionary</a></li>
					<ul>
						<li><a href="#objDictComm">Communication Profile</a></li>

						<ul>{DOCobjDictCommIndex}</ul>

						<li><a href="#objDictManuf">Manufacturer specific</a></li>

						<ul>{DOCobjDictManufIndex}</ul>

						<li><a href="#objDictProfile">Device Profile</a></li>

						<ul>{DOCobjDictProfileIndex}</ul>

					</ul>
				</ul>
				<br/>
			</div>
			<div style="page-break-before: always;">
				<h2>Introduction<a name="intro"/></h2>
				<p>This document contains description for CANopen Device specified in Device Identity section. Document was generated by CANopenNode Object Dictionary Editor.</p>
				<p>CANopenNode is an open source software stack used for serial communication of multiple devices over the CAN/CANopen Network. For more information see <a href="http://canopennode.sourceforge.net/">Project home page</a>.</p>
				<br/>
			</div>
			<div>
				<a name="identity"/>
				<h2>Device Identity</h2>

				{DOCidentity}

				<br/>
			</div>
			<div style="page-break-before: always;">
				<a name="features"/>
				<h2>CANopen features</h2>

				{DOCfeatures}
				
				<br/>
			</div>
			<div style="page-break-before: always;">
				<a name="objDict"/>
				<h2>Object Dictionary</h2>
			</div>
			<div>
				<a name="objDictComm"/>
				<h3>Communication Profile</h3>

				{DOCobjDictComm}

				<br/>
			</div>
			<div style="page-break-before: always;">
				<a name="objDictManuf"/>
				<h3>Manufacturer specific</h3>

				{DOCobjDictManuf}

				<br/>
			</div>
			<div style="page-break-before: always;">
				<a name="objDictProfile"/>
				<h3>Device Profile</h3>

				{DOCobjDictProfile}

				<br/>
			</div>
			<hr/>
			<div style="text-align:center"><em>CANopenNode, 2007</em></div>
		</body>
		</html>;

	//HTML source
	document.getElementById("fileDOC").value =
		"<?xml version=\"1.0\"?>\n"+
		"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"+
		file.toXMLString();

	//HTML view
	var parser = new DOMParser();
	var html = parser.parseFromString(file.html::body.toXMLString(), "text/xml").documentElement;
	var node = document.importNode(html, true);
	document.getElementById("fileDOCview").appendChild(node);
}
