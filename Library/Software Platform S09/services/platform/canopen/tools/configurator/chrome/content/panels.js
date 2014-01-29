/*******************************************************************************

   panels.js - JavaScript code for CANopenNode device configurator - panels

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

/*** g_codePanel panel. *******************************************************/
function g_codePanelInit(panelArgument){
	//This is the init function for built-in g_codePanel 
	eval("var text = " + panelArgument + ".toXMLString();");
	if(panelArgument == "g_project") text = "<?xml version=\"1.0\"?>\n" + text;
	document.getElementById('g_codePanel').value = text;
}

/*** g_panelLoading panel. ****************************************************/
function g_panelLoadingInit(panelArgument){
	//This is the init function for built-in panel g_panelLoading 
	document.getElementById("g_panelLoadingName").value = panelArgument;
}

/*** deviceid panel. **********************************************************/
var deviceIdentity = {};

function deviceidInit(panelArgument){
	var curent = g_project.other.DeviceIdentity;
	var el, field;
	deviceIdentity = {};

	//Text only elements
	document.getElementById("deviceid_vendorName").value = curent.vendorName;
	document.getElementById("deviceid_vendorID").value = curent.vendorID;
	el = curent.vendorText; if(el.length()) deviceIdentity.vendorText = el; else deviceIdentity.vendorText = <vendorText/>;
	el = curent.deviceFamily; if(el.length()) deviceIdentity.deviceFamily = el; else deviceIdentity.deviceFamily = <deviceFamily/>;
	document.getElementById("deviceid_productFamily").value = curent.productFamily;
	document.getElementById("deviceid_productName").value = curent.productName.toString();
	document.getElementById("deviceid_productID").value = curent.productID;
	el = curent.productText; if(el.length()) deviceIdentity.productText = el; else deviceIdentity.productText = <productText/>;
	el = curent.orderNumber;
		field = document.getElementById("deviceid_orderNumber");
		//delete curent items
		for(var i=field.getRowCount()-1; i>=0; i--) field.removeItemAt(i);
		//add new items
		if(el.length()) for each (var obj in el) field.appendItem(obj.toString());
	el = curent.version;
		field = document.getElementById("deviceid_version");
		//delete curent items
		for(var i=field.getRowCount()-1; i>=0; i--) field.removeItemAt(i);
		//add new items
		if(el.length())	for each (var obj in el) field.appendChild(g_createListitem([obj.@versionType, obj.toString()]));
	document.getElementById("deviceid_buildDate").value = curent.buildDate;
	document.getElementById("deviceid_specificationRevision").value = curent.specificationRevision;
	document.getElementById("deviceid_instanceName").value = curent.instanceName;
}

function deviceidUpdate(){
	var newId = <></>;
	var field;
	
	field = document.getElementById("deviceid_vendorName").value;
		if(field) newId += <vendorName>{field}</vendorName>;
		else {alert("Please specify the Vendor Name!"); return;}
	field = document.getElementById("deviceid_vendorID").value; if(field) newId += <vendorID>{field}</vendorID>;
	field = deviceIdentity.vendorText; if(field.children().length()) newId += field;
	field = deviceIdentity.deviceFamily; if(field.children().length()) newId += field;
	field = document.getElementById("deviceid_productFamily").value; if(field) newId += <productFamily>{field}</productFamily>;
	field = document.getElementById("deviceid_productName").value;
		if(field) newId += <productName>{field}</productName>;
		else {alert("Please specify the Product Name!"); return;}
	field = document.getElementById("deviceid_productID").value; if(field) newId += <productID>{field}</productID>;
	field = deviceIdentity.productText; if(field.children().length()) newId += field;
	field = document.getElementById("deviceid_orderNumber");
		for(var i=0; i<field.getRowCount(); i++) newId += <orderNumber>{field.getItemAtIndex(i).label}</orderNumber>;
	field = document.getElementById("deviceid_version");
		for(var i=0; i<field.getRowCount(); i++) newId += <version versionType={field.getItemAtIndex(i).firstChild.getAttribute("label")}>{field.getItemAtIndex(i).lastChild.getAttribute("label")}</version>;
	field = document.getElementById("deviceid_buildDate").value; if(field) newId += <buildDate>{field}</buildDate>;
	field = document.getElementById("deviceid_specificationRevision").value; if(field) newId += <specificationRevision>{field}</specificationRevision>;
	field = document.getElementById("deviceid_instanceName").value; if(field) newId += <instanceName>{field}</instanceName>;

	//Update project file
	g_project.other.DeviceIdentity.setChildren(newId);

}

/*** feature panel. ***********************************************************/
var feature = {};

function featureInit(panelArgument){
	var curent = g_project.features.feature.(@name==panelArgument);
	var el, field;
	feature = {};

	//Text only elements
	document.getElementById("feature_name").value = curent.@name;
	document.getElementById("feature_value").value = curent.@value;
	feature.curent = curent;
	el = curent.associatedObject;
		field = document.getElementById("feature_objects");
		//delete curent items
		for(var i=field.getRowCount()-1; i>=0; i--) field.removeItemAt(i);
		//add new items
		if(el.length()) for each (var obj in el) field.appendChild(g_createListitem([obj.@index, obj.@indexMax]));
}

function featureInsertNewObject(){
	var tf1 = document.getElementById("feature_index");
	var tf2 = document.getElementById("feature_indexMax");
	var text1 = tf1.value;
	var text2 = tf2.value; if(!text2) text2 = text1;
	var n1 = parseInt("0x"+text1);
	var n2 = parseInt("0x"+text2);

	if(!(n1 >= 0x1000 && n1 <= 0xFFFF && n2 >= 0x1000 && n2 <= 0xFFFF)){
		alert("Index must be between 0x1000 and 0xFFFF!");
		return;
	}
	if(n1 > n2){
		alert("Index Max must be greater or equal than Index!");
		return;
	}
	text1 = g_wordToHexString(n1);
	if(n1==n2) text2 = "";
	else text2 = g_wordToHexString(n2);

	document.getElementById("feature_objects").appendChild(g_createListitem([text1, text2]));
	
	tf1.value = "";
	tf2.value = "";
}

function featureUpdateOrInsertNew(insertNew){
	//function updates curent feature or it inserts new, if insertNew is true
	var newFeature = <></>;
	var newFeatureElement = <feature/>;
	var field, i;
	
	//name attribute
	field = document.getElementById("feature_name").value;
		//name must not be duplicated
		i = 0; if(feature.curent.@name == field && !insertNew) i = 1;
		if(g_project.features.feature.(@name == field).length() > i){alert("Feature Name must not be duplicated!"); return;}
		if(!field) {alert("Please specify the Feature Name!"); return;}
		if(insertNew) newFeatureElement.@name = field;
		else feature.curent.@name = field;
	//value attribute
	field = document.getElementById("feature_value");
		val = parseInt(field.value);
		if(!(val>=0)) {alert("Please enter a zero or positive value!"); return;}
		if(insertNew) newFeatureElement.@value = val;
		else feature.curent.@value = val;
		field.value = val;
	//labels
	newFeature += feature.curent.label;
	newFeature += feature.curent.description;
	//associated objects
	field = document.getElementById("feature_objects");
		for(var i=0; i<field.getRowCount(); i++){
			var index = field.getItemAtIndex(i).firstChild.getAttribute("label");
			var indexMax = field.getItemAtIndex(i).lastChild.getAttribute("label")
			var ao = <associatedObject index={index}/>;
			if(indexMax) ao.@indexMax = indexMax;
			newFeature += ao;
		}

	//Update project file
	if(insertNew){
		newFeatureElement.setChildren(newFeature);
		g_project.features.insertChildAfter(g_project.features.feature[feature.curent.childIndex()], newFeatureElement);
	}
	else feature.curent.setChildren(newFeature);

	//re-create the tree
	g_createTree(true);
}

/*** object panel. ************************************************************/
var object = {};

function objectInit(panelArgument){
	var curent = g_project.CANopenObjectList.CANopenObject.(@index==panelArgument);
	var f;
	//clear previous timeout
	if(object.timeout) clearTimeout(object.timeout);
	object = {};

	document.getElementById("object_index").value = panelArgument;
	document.getElementById("object_index").style.color = 'black';
	document.getElementById("object_name").value = curent.@name;
	//button
		f = document.getElementById("object_buttonDisEn");
		if(curent.@disabled=="true") f.label = "Enable this Object";
		else f.label = "Disable this Object";
	//object Type
		f = document.getElementById("object_objectType");
		var objectType = parseInt(curent.@objectType.toString());
		switch(objectType){
			case 7: f.selectedIndex = 0; f.setAttribute("label", "7 - Var"); break;
			case 8: f.selectedIndex = 1; f.setAttribute("label", "8 - Array"); break;
			case 9: f.selectedIndex = 2; f.setAttribute("label", "9 - Record"); break;
			default: f.setAttribute("label", "");
		}
	//subnumber in case of array or record
		f = document.getElementById("object_subNumber");
		if(objectType==8 || objectType==9)
			f.value = parseInt(curent.@subNumber.toString()).toString();
		else f.value = "";
	//memory type
		f = document.getElementById("object_memoryType");
		switch(curent.@memoryType.toString()){
			case "RAM": 	f.selectedIndex = 0; f.setAttribute("label", "RAM"); break;
			case "EEPROM":f.selectedIndex = 1; f.setAttribute("label", "EEPROM"); break;
			case "ROM":		f.selectedIndex = 2; f.setAttribute("label", "ROM"); break;
			default: f.setAttribute("label", "");
		}
	//data type
		objectSetDataType(document.getElementById("object_dataType"), curent.@dataType.toString());
	//access type
		objectSetAccessType(document.getElementById("object_accessType"), curent.@accessType.toString());
	//PDO mapping
		objectSetPDOmapping(document.getElementById("object_PDOmapping"), curent.@PDOmapping.toString());
	//Capable for TPDO request, default and actual value
		document.getElementById("object_TPDOrequestCapable").checked = (curent.@TPDOrequestCapable.toString()=="true")?true:false;
		document.getElementById("object_defaultValue").value = curent.@defaultValue;
		document.getElementById("object_actualValue").value = curent.@actualValue;
	//SDO Server access function
		var object_accessFunctionNameBox = document.getElementById("object_accessFunctionNameBox");
		var object_accessFunctionCode = document.getElementById("object_accessFunctionCode");
		object_accessFunctionNameBox.hidden = true;
		object_accessFunctionCode.hidden = true;
		var elName = curent.@accessFunctionName.toString();
		var elPreCode = curent.accessFunctionPreCode.toString();
		var elPostCode = curent.accessFunctionPostCode.toString();
		var filedSelected = 0;
		var filedName = "";
		var filedPreCode = "";
		var filedPostCode = "";
		if(elName){ //external function
			filedSelected = 1;
			filedName = elName;
			object_accessFunctionNameBox.hidden = false;
		}
		else if(elPreCode || elPostCode){
			filedSelected = 2;
			filedPreCode = elPreCode;
			filedPostCode = elPostCode;
			object_accessFunctionCode.hidden = false;
		}		
		document.getElementById("object_accessFunction").selectedIndex = filedSelected;
		document.getElementById("object_accessFunctionName").value = filedName;
		document.getElementById("object_accessFunctionPreCode").value = filedPreCode;
		document.getElementById("object_accessFunctionPostCode").value = filedPostCode;

	objectTypeChanged();
	object.curent = curent;
}

function objectTypeChanged(){
//enable/disable some fields, of object type has changed
	var objectType = document.getElementById("object_objectType").label;
	var f;
	switch(objectType){
		case "7 - Var":
		default:
			document.getElementById("object_dataType").removeAttribute("disabled");
			document.getElementById("object_accessType").removeAttribute("disabled");
			document.getElementById("object_PDOmapping").removeAttribute("disabled");
			document.getElementById("object_TPDOrequestCapable").removeAttribute("disabled");
			document.getElementById("object_defaultValue").removeAttribute("disabled");
			document.getElementById("object_actualValue").removeAttribute("disabled");
			break;
		case "8 - Array":
			document.getElementById("object_dataType").removeAttribute("disabled");
			document.getElementById("object_accessType").removeAttribute("disabled");
			document.getElementById("object_PDOmapping").removeAttribute("disabled");
			f = document.getElementById("object_TPDOrequestCapable"); f.setAttribute("disabled", "true"); f.checked = false;
			f = document.getElementById("object_defaultValue"); f.value = ""; f.setAttribute("disabled", "true");
			f = document.getElementById("object_actualValue"); f.value = ""; f.setAttribute("disabled", "true");
			break;
		case "9 - Record":
			f = document.getElementById("object_dataType"); f.setAttribute("disabled", "true"); f.setAttribute("label", "");
			f = document.getElementById("object_accessType"); f.setAttribute("disabled", "true"); f.setAttribute("label", "");
			f = document.getElementById("object_PDOmapping"); f.setAttribute("disabled", "true"); f.setAttribute("label", "");
			f = document.getElementById("object_TPDOrequestCapable"); f.setAttribute("disabled", "true"); f.checked = false;
			f = document.getElementById("object_defaultValue"); f.value = ""; f.setAttribute("disabled", "true");
			f = document.getElementById("object_actualValue"); f.value = ""; f.setAttribute("disabled", "true");
	}
}

function objectUpdateOrInsertNew(insertNew){
//function updates curent object or inserts new, if insertNew is true
	var reCreateTree = false;
	var NumberOfEntries = 0;
	var oldObject = object.curent;
	var newObject = <CANopenObject/>;
	var field; //multi purpose use

	//index attribute
		var index;
		if(insertNew){
			index = prompt("Please specify index for the new Object.\n\nIf object is disabled, it will be enabled, otherwise new object based on curent object will be created.","");
			if(!index) return;
			index = parseInt(index, 16);
			if(!(index>=0x1000 && index<=0xFFFF)){alert("Object Index must be between 1000 and FFFF!"); return;}
			index = index.toString(16).toUpperCase();
			//verify, if object isn't controlled by feature
			var feature = g_projectFeatures[index];
			if(feature){alert("This object is controlled by feature "+feature+".\nPlease edit the feature!"); return;}
			//if there is existing, but disabled object, enable it
			var existing = g_project.CANopenObjectList.CANopenObject.(@index == index);
			if(existing.length()){
				delete existing.@disabled;
				g_createTree();
				return;
			}
			reCreateTree = 2;
		}
		else{
			index = document.getElementById("object_index").value;
		}
		newObject.@index = index;
	//Object Name
		field = document.getElementById("object_name").value;
		if(!field){alert("Please specify the Name for the object!"); return;}
		newObject.@name = field;
		if(field != oldObject.@name) reCreateTree = 1;
	//Object Type
		field = document.getElementById("object_objectType").label;
		if(!field){alert("Please choose Object Type!"); return;}
		var objectType = field.slice(0,1);
		newObject.@objectType = objectType;
		if(objectType != oldObject.@objectType) reCreateTree = 1;
	//subnumber in case of array or record
		if(objectType=="8" || objectType=="9"){
			var subNo = parseInt(document.getElementById("object_subNumber").value);
			if(!(subNo>=2 && subNo<=255)){alert("Sub Number must be between 2 and 255!"); return;}
			field = subNo.toString();
			newObject.@subNumber = field;
			if(newObject.@subNumber != oldObject.@subNumber){
				reCreateTree = 1;
				if(oldObject.@objectType.toString() != "7") NumberOfEntries = subNo;
			}
		}
		else field = "";
		document.getElementById("object_subNumber").value = field;
	//memory type
		var memoryType = document.getElementById("object_memoryType").label;
		if(memoryType!="RAM" && memoryType!="EEPROM" && memoryType!="ROM")
				{alert("Please choose a valid Memory Type!"); return;}
		newObject.@memoryType = memoryType;
	//some fields are used only, if Object Type is Var or Array
	if(objectType=="7" || objectType=="8"){
		//data type
			field = document.getElementById("object_dataType").label;
			if(!field){alert("Please choose Data Type!"); return;}
			field = field.slice(0, field.indexOf(" "));
			if(field=="01" || field=="08"){alert("Please choose a valid Data Type!"); return;}
			newObject.@dataType = field;
		//access type
			var accessType = document.getElementById("object_accessType").label;
			if(accessType!="const" && accessType!="ro" && accessType!="wo" && accessType!="rw")
					{alert("Please choose a valid Access Type!"); return;}
			newObject.@accessType = accessType;
		//PDO mapping
			var PDOmapping = document.getElementById("object_PDOmapping").label;
			if(PDOmapping!="no" && PDOmapping!="optional" && PDOmapping!="TPDO" && PDOmapping!="RPDO")
					{alert("Please choose a valid PDO mapping!"); return;}
			if(PDOmapping!="no" && memoryType=="ROM"){alert("PDO mapping with ROM variables is not possible!"); return;}
			if(PDOmapping!="no" && document.getElementById("object_accessFunction").selectedIndex==1)
					{alert("PDO mapping with Extarnal SDO server access function is not possible!"); return;}
			newObject.@PDOmapping = PDOmapping;
	}
	else{
		document.getElementById("object_dataType").setAttribute("label", "");
		document.getElementById("object_accessType").setAttribute("label", "");
		document.getElementById("object_PDOmapping").setAttribute("label", "");
	}
	//some fields are used only, if Object Type is Var
	if(objectType=="7"){
		//TPDO Request Capable
			field = document.getElementById("object_TPDOrequestCapable").checked;
			if(field){
				var err = "Variable is not capable for TPDO request, if ";
				if(accessType=="wo"){alert(err+"Access Type is 'wo'"); return;}
				if(PDOmapping!="optional" && PDOmapping!="TPDO"){alert(err+"PDOmapping is 'no' or 'RPDO'"); return;}
				newObject.@TPDOrequestCapable = "true";
			}
		//default and actual value
			field = document.getElementById("object_defaultValue").value;
			if(!field){alert("Please choose a Default value!"); return;}
			newObject.@defaultValue = field;
			field = document.getElementById("object_actualValue").value;
			if(field) newObject.@actualValue = field;
	}
	else{
		document.getElementById("object_TPDOrequestCapable").checked = false;
		document.getElementById("object_defaultValue").value = "";
		document.getElementById("object_actualValue").value = "";
	}
	//SDO Server access function
		var radioSelected = document.getElementById("object_accessFunction").selectedIndex;
		if(radioSelected == 1){
			field = document.getElementById("object_accessFunctionName").value;
			if(field) newObject.@accessFunctionName = field;
			else radioSelected = 0;
		}
		else if(radioSelected == 2){
			var pre = document.getElementById("object_accessFunctionPreCode").value;
			var post = document.getElementById("object_accessFunctionPostCode").value;
			if(pre || post){
				if(pre) newObject.appendChild(<accessFunctionPreCode>{pre}</accessFunctionPreCode>);
				if(post) newObject.appendChild(<accessFunctionPostCode>{post}</accessFunctionPostCode>);
			}
			else radioSelected = 0;
		}
		document.getElementById("object_accessFunction").selectedIndex = radioSelected;
	//labels and subobjects
		newObject.appendChild(object.curent.label);
		newObject.appendChild(object.curent.description);
		newObject.appendChild(object.curent.CANopenSubObject);
		if(NumberOfEntries) newObject.CANopenSubObject[0].@defaultValue = (NumberOfEntries-1).toString();

	//Update project file
	if(insertNew){
		//insert new <CANopenObject> into g_project on the right place
		var found = false;
		for each (var objectAfter in g_project.CANopenObjectList.CANopenObject){
			if(objectAfter.@index > index){
				g_project.CANopenObjectList.insertChildBefore(objectAfter, newObject);
				found = true;
				break;
			}
		}
		if(!found) g_project.CANopenObjectList.appendChild(newObject);
	}
	else g_project.CANopenObjectList.replace(oldObject.childIndex(), newObject);

	//re-create the tree
	if(reCreateTree) g_createTree(reCreateTree==2?true:false);
	else{
		var desc = document.getElementById("object_index");
		desc.value = "Updated";
		desc.style.color = "red";
		function back(){
			desc.value = index;
			desc.style.color = 'black';
		}
		object.timeout = setTimeout(back, 1500);
	}
}

/*** subobj panel. ************************************************************/
var subobj = {};

function objectSetDataType(field, dataType){
	var dataTypeVal = parseInt(dataType, 16);
	if(1<=dataTypeVal && dataTypeVal<= 0x0A) field.selectedIndex = (dataTypeVal-1).toString();
	field.setAttribute("label", g_CANopenDataType(dataType));
}

function objectSetAccessType(field, accessType){
	switch(accessType){
		case "const":	field.selectedIndex = 0; field.setAttribute("label", "const"); break;
		case "ro": 		field.selectedIndex = 1; field.setAttribute("label", "ro"); break;
		case "wo": 		field.selectedIndex = 2; field.setAttribute("label", "wo"); break;
		case "rw": 		field.selectedIndex = 3; field.setAttribute("label", "rw"); break;
		default: field.setAttribute("label", "");
	}
}

function objectSetPDOmapping(field, PDOmapping){
	switch(PDOmapping){
		case "no":			field.selectedIndex = 0; field.setAttribute("label", "no"); break;
		case "optional":field.selectedIndex = 2; field.setAttribute("label", "optional"); break;
		case "TPDO": 		field.selectedIndex = 3; field.setAttribute("label", "TPDO"); break;
		case "RPDO": 		field.selectedIndex = 4; field.setAttribute("label", "RPDO"); break;
		default: field.setAttribute("label", "");
	}
}

function subobjInit(panelArgument){
	var index = panelArgument.slice(0,4);
	var subindex = panelArgument.slice(5,7);
	var parent = g_project.CANopenObjectList.CANopenObject.(@index==index);
	var curent = parent.CANopenSubObject.(@subIndex==subindex);
	
	//fields
	var subobj_index = document.getElementById("subobj_index");
	var subobj_name = document.getElementById("subobj_name");
	var subobj_dataType = document.getElementById("subobj_dataType");
	var subobj_accessType = document.getElementById("subobj_accessType");
	var subobj_PDOmapping = document.getElementById("subobj_PDOmapping");
	var subobj_defaultValue = document.getElementById("subobj_defaultValue");
	var subobj_actualValue = document.getElementById("subobj_actualValue");
	
	//data
	var parentObjectType = parent.@objectType.toString();
	var dataType = curent.@dataType.toString();
	var accessType = curent.@accessType.toString();
	var text;

	//clear previous timeout
	if(subobj.timeout) clearTimeout(subobj.timeout);
	subobj = {};

	subobj_index.value = panelArgument;
	subobj_index.style.color = 'black';
	subobj_name.value = curent.@name;

	//first subindex contains only number of entries
	if(subindex == "00"){
		subobj_dataType.setAttribute("label", "05 - UNSIGNED8"); subobj_dataType.setAttribute("disabled", "true");
		subobj_PDOmapping.setAttribute("label", "no"); subobj_PDOmapping.setAttribute("disabled", "true");
		subobj_actualValue.value = ""; subobj_actualValue.setAttribute("disabled", "true");
		//enable two fields, if SDO access function is external
		if(parent.@accessFunctionName.length()){
			subobj_accessType.removeAttribute("disabled"); objectSetAccessType(subobj_accessType, accessType)
			subobj_defaultValue.value = curent.@defaultValue; subobj_defaultValue.removeAttribute("disabled");
		}
		else{
			subobj_accessType.setAttribute("label", "ro"); subobj_accessType.setAttribute("disabled", "true");
			subobj_defaultValue.value = (parseInt(parent.@subNumber)-1).toString(); subobj_defaultValue.setAttribute("disabled", "true");
		}
	}
	else{
		//If parent object type is array, then three fields are disabled here
		if(parentObjectType == "8"){
			subobj_dataType.setAttribute("label", g_CANopenDataType(parent.@dataType.toString()));
			subobj_dataType.setAttribute("disabled", "true");
			subobj_accessType.setAttribute("label", parent.@accessType.toString());
			subobj_accessType.setAttribute("disabled", "true");
			subobj_PDOmapping.setAttribute("label", parent.@PDOmapping.toString());
			subobj_PDOmapping.setAttribute("disabled", "true");
		}
		else{
			//parent object type is record
			subobj_dataType.removeAttribute("disabled"); objectSetDataType(subobj_dataType, dataType);
			subobj_accessType.removeAttribute("disabled"); objectSetAccessType(subobj_accessType, accessType);
			subobj_PDOmapping.removeAttribute("disabled"); objectSetPDOmapping(subobj_PDOmapping, curent.@PDOmapping.toString());
		}
		subobj_defaultValue.value = curent.@defaultValue;	subobj_defaultValue.removeAttribute("disabled");
		subobj_actualValue.value = curent.@actualValue;	subobj_actualValue.removeAttribute("disabled");
	}

	subobj.parent = parent;
	subobj.curent = curent;
}

function subobjUpdate(){
//function updates curent subobj
	var reCreateTree = false;
	var oldObject = subobj.curent;
	var newObject = <CANopenSubObject/>;
	var field; //multi purpose use
	var parentObjectType = subobj.parent.@objectType.toString();

	//subIndex attribute
		var subIndex = document.getElementById("subobj_index").value.slice(5,7);
		newObject.@subIndex = subIndex;
	//Object Name
		field = document.getElementById("subobj_name").value;
		if(!field){alert("Please specify the Name for the subobj!"); return;}
		newObject.@name = field;
		if(field != oldObject.@name) reCreateTree = true;
	//Object Type
		newObject.@objectType = "7";
	//only for records
	if(parentObjectType=="9" || subIndex=="00"){
		//data type
			field = document.getElementById("subobj_dataType").label;
			if(!field){alert("Please choose Data Type!"); return;}
			field = field.slice(0, field.indexOf(" "));
			if(field=="01" || field=="08"){alert("Please choose a valid Data Type!"); return;}
			newObject.@dataType = field;
		//access type
			var accessType = document.getElementById("subobj_accessType").label;
			if(accessType!="const" && accessType!="ro" && accessType!="wo" && accessType!="rw")
					{alert("Please choose a valid Access Type!"); return;}
			newObject.@accessType = accessType;
		//PDO mapping
			var PDOmapping = document.getElementById("subobj_PDOmapping").label;
			if(PDOmapping!="no" && PDOmapping!="optional" && PDOmapping!="TPDO" && PDOmapping!="RPDO")
					{alert("Please choose a valid PDO mapping!"); return;}
			var parentMemoryType = subobj.parent.@memoryType.toString();
			if(PDOmapping!="no" && parentMemoryType=="ROM"){alert("PDO mapping with ROM variables is not possible!"); return;}
			newObject.@PDOmapping = PDOmapping;
	}
	//default and actual value
		field = document.getElementById("subobj_defaultValue").value;
		if(!field){alert("Please choose a Default value!"); return;}
		newObject.@defaultValue = field;
		field = document.getElementById("subobj_actualValue").value;
		if(field) newObject.@actualValue = field;

	//Update project file
	g_project.CANopenObjectList.CANopenObject[subobj.parent.childIndex()].replace(oldObject.childIndex(), newObject);

	//re-create the tree or put a note
	if(reCreateTree) g_createTree();
	else{
		var desc = document.getElementById("subobj_index");
		var oldDesc = desc.value;
		desc.value = "Updated";
		desc.style.color = "red";
		function back(){
			desc.value = oldDesc;
			desc.style.color = 'black';
		}
		subobj.timeout = setTimeout(back, 1500);
	}
}
