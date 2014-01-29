/*******************************************************************************

   device.js - JavaScript code for CANopenNode device configurator

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

//Global variables
var g_embpath;
var g_project;							//E4X XML object with CANopenNode Device description
var g_projectFeatures = {}; //Object with collection of all CANopen objects, which are associated with specific feature (index:featureName)
var g_labelEditingElement;

function g_error(text){
	//function displays the alert message in case it is an error in project file.
	var codeName = g_project.other.codeName.@name.toString();
	alert("Error in file with codeName" + codeName + ":\n" + text + "\n\nPlease edit the project file manually!");
}

function g_labelShow(element){
//function displays a g_label for the given element as defined in CIA DSP311. 
	eval("var XMLElement = " + element + ";");

	var language = document.getElementById("g_Language").label;
  var infoName = XMLElement.label.(@lang == language);
	var infoText = XMLElement.description.(@lang == language);
	var infoSrc = infoText.@URI;

	g_labelDisplay(infoName.toString(), infoText.toString(), infoSrc.toString());
}

function g_labelDisplay(infoName, infoText, infoSrc){
//function displays info text on the right side of the screen. It also sets oncommand event handler to 'More...' button, 
//so that on click it opens new window with location under infoSrc.
	//get the fields
	var infoWindow = document.getElementById("g_infoWindow");
	var caption = document.getElementById("g_infoWindowCaption");
	var languageBox = document.getElementById("g_infoWindowLanguageBox");
	var labelText = document.getElementById("g_infoWindowLabelText");
	var descText = document.getElementById("g_infoWindowDescText");
	var URIBox = document.getElementById("g_infoWindowURIBox");
	var button = document.getElementById("g_infoWindowButton");

	//boxes and text
	caption.label = "Info";
	languageBox.setAttribute("hidden", "true");
	URIBox.setAttribute("hidden", "true");
	labelText.value = infoName;
	labelText.setAttribute("readonly", "true");
	descText.value = infoText;
	descText.setAttribute("readonly", "true");
	//more/update button
	button.setAttribute("label", "more ...");
	if(infoSrc){
		var comm = 'var w = window.open("'+infoSrc+'", "infoWindow", "left=0,top=150,height=600,width=320,resizable=yes,scrollable=yes,location=yes"); w.focus();';
    button.setAttribute("oncommand", comm);
    button.setAttribute("disabled", "false");
	}
	else{
    button.setAttribute("disabled", "true");
	}
	//Show window
	infoWindow.removeAttribute("hidden");
}

function g_labelEdit(element, captionText){
//function edits g_labels of the given element as defined in CIA DSP311. First it opens new panel on right.
//For each language can be the entered a Name, Description and URI.
	//Variable g_labelEditingElement will contain an E4X object, where labels are edited
	if(element) eval("g_labelEditingElement = " + element + ";");

	//get the fields
	var infoWindow = document.getElementById("g_infoWindow");
	var caption = document.getElementById("g_infoWindowCaption");
	var languageBox = document.getElementById("g_infoWindowLanguageBox");
	var labelText = document.getElementById("g_infoWindowLabelText");
	var descText = document.getElementById("g_infoWindowDescText");
	var URIBox = document.getElementById("g_infoWindowURIBox");
	var button = document.getElementById("g_infoWindowButton");
	var language = document.getElementById("g_infoWindowLanguage").label;
	var URI = document.getElementById("g_infoWindowURIText");

	//get the data
	try{g_labelEditingElement.label.(@lang)}catch(e){g_error("Every <label> must have an 'lang' attribute! ("+element+".label)"); return false;};
	try{g_labelEditingElement.description.(@lang)}catch(e){g_error("Every <description> must have an 'lang' attribute! ("+element+".description)"); return false;};
  var curLabel = g_labelEditingElement.label.(@lang == language);
	var curDesc = g_labelEditingElement.description.(@lang == language);
	if(curLabel.length() > 1){g_error("Only one <label> for specific language is allowed! ("+element+".label)"); return false;}
	if(curDesc.length() > 1){g_error("Only one <description> for specific language is allowed! ("+element+".description)"); return false;}
	var curURI = curDesc.@URI;

	//boxes and text
	if(captionText) caption.label = captionText;
	languageBox.removeAttribute("hidden");
	URIBox.removeAttribute("hidden");
	labelText.removeAttribute("readonly");
	descText.removeAttribute("readonly");
	labelText.value = curLabel;
	descText.value = curDesc;
	URI.value = curURI;

	//more/update button
	button.setAttribute("label", "Update");
	button.setAttribute("oncommand", "g_labelEditUpdate();");
  button.setAttribute("disabled", "false");

	//Show window
	infoWindow.removeAttribute("hidden");

	return true;
}

function g_labelEditUpdate(){
//Function updates g_labels for the element g_labelEditingElement from editor

	//get the fields
	var language = document.getElementById("g_infoWindowLanguage").label;
	var labelText = document.getElementById("g_infoWindowLabelText").value;
	var descText = document.getElementById("g_infoWindowDescText").value;
	var URI = document.getElementById("g_infoWindowURIText").value;

	if(!language){alert("Please define a language!"); return false;}

	//get the data
  var curLabel = g_labelEditingElement.label.(@lang == language);
	var curDesc = g_labelEditingElement.description.(@lang == language);
	var curURI = curDesc.@URI;

	//create elements
	var newLabel = <label lang={language}>{labelText}</label>;
	var newDesc = <description lang={language}>{descText}</description>;
	if(URI) newDesc.@URI = URI;

	//update project
	if(labelText){
		if(curLabel.length()==1) g_labelEditingElement.children()[curLabel.childIndex()] = newLabel;
		else g_labelEditingElement.appendChild(newLabel);
	}
	else if(curLabel.length()==1) delete g_labelEditingElement.children()[curLabel.childIndex()];
	if(descText || URI){
		if(curDesc.length()==1) g_labelEditingElement.children()[curDesc.childIndex()] = newDesc;
		else g_labelEditingElement.appendChild(newDesc);
	}
	else if(curDesc.length()==1) delete g_labelEditingElement.children()[curDesc.childIndex()];
}

function g_showFrame(parentWindow, frameName){
//Function hides all child elements of the parent windov, except this, which has matched frameName attribute. If element exists, function returns true, othervise false.
	var frameFound = false;
	var child = parentWindow.firstChild;

	while(child){
		//is child element node?
		if(child.nodeType == Node.ELEMENT_NODE){
			//Is frameName attribute matched
			if(child.getAttribute("frameName") == frameName){
				frameFound = true;
				child.hidden = false;
			}
			else{
				child.hidden = true
			}
		}
		//go next
		child = child.nextSibling;
	}
	return frameFound;
}

function g_showPanelOrLoadIt(panelName, panelArgument){
//Function hides all childern in 'rightBottomWindow' and shows only that child, which has attribute 'frameName' 
//equal to panelName. If such  child does not exist, then function loads external xul file with filename qual to panelName.
//Then it appends file's contents as new child node to the 'rightBottomWindow'.
//Also scripts from that file are evaluated. It's attribute 'frameName' is set to panelName.
//I external file doesn't exist, function causes an error and returns false. User will see, which file is missing.
	var parentWindow = document.getElementById("g_rightBottomWindow");
	if(g_showFrame(parentWindow, panelName) == false){
		//panel is not found, so load it from outside
		var httpRequest = new XMLHttpRequest();
		
		//Show progressmeter with filename loading
		var progressmeter = document.getElementById("g_panelLoading");
		var progressmeterName = document.getElementById("g_panelLoadingName");
		progressmeter.hidden = false;
		progressmeterName.value = "Loading " + panelName + ".xul ...";
		
		//this function is executed, after the file is loaded - see below
		httpRequest.onreadystatechange = function(){
			if(httpRequest.readyState == 4){
				//everything is good, the response is received
				if(httpRequest.status == 0 || httpRequest.status == 200){
					//valid response is received
					var panelDocument = httpRequest.responseXML;
					var i;
					var node;
					
					//get panel - it is the first element node, which is not a <script> element
					var panel = panelDocument.documentElement.childNodes;
					for (i = 0; i < panel.length; i++) {
					    if(panel[i].nodeType==Node.ELEMENT_NODE && panel[i].nodeName!="script")	break;
					}

					//is panel OK
					if(!panel[i]){
						progressmeterName.value = progressmeterName.value + "  Error in the file!";
						return false;
					}
					
					//append panel to the parentWindow
					node = document.importNode(panel[i], true);
					panel[i].setAttribute("frameName", panelName);
					panel[i].setAttribute("hidden", false);
    			    parentWindow.appendChild(node);

					//hide progressmeter
					progressmeter.hidden = true;
			
					//Execute Init function for curent panel if it exists
					var initExists;
					try{
						eval("if("+panelName+"Init) initExists = true")
					}
					catch(e){}
					if(initExists) eval(panelName + "Init(panelArgument);");

					//hide info window
					document.getElementById("g_infoWindow").hidden = "true";

					return true;
				}
				else{
					//file was not found or other http error
					g_showPanelOrLoadIt("g_codePanel", panelArgument);
					return false;
				}
			}
		}
		httpRequest.open("GET", "panels/" + panelName + ".xul", true);
		httpRequest.send(null);
	}
	else{
		//Execute Init function for curent panel if it exists
		var initExists;
		try{
			eval("if("+panelName+"Init) initExists = true")
		}
		catch(e){}
		if(initExists) eval(panelName + "Init(panelArgument);");

		//hide info window
		document.getElementById("g_infoWindow").hidden = "true";

		return true;
	}
}

function g_setMode(label){
//Function sets the operating mode
	var panelToShowOnBottom;
	
	switch(label){
		case "Access Device":
		case "Access Object Dictionary on Device":
			document.getElementById("g_codeNameField").setAttribute("readonly", "true");
			document.getElementById("g_modeAccess").hidden = false;
			document.getElementById("g_modeEdit").hidden = true;
			panelToShowOnBottom = "access";
			break;
		case "Edit Object Dictionary":
		case "Edit Object Dictionary and hide disabled Objects":
			document.getElementById("g_codeNameField").removeAttribute("readonly");
			document.getElementById("g_modeAccess").hidden = true;
			document.getElementById("g_modeEdit").hidden = false;
			panelToShowOnBottom = "editor";
			break;
	}

	//show frame on top right
	g_showFrame(document.getElementById("g_rightTopWindow"), "modeAccessOrEdit");

	//set groupbox caption
	var gboxCaption = document.getElementById("g_modeCaption");
	gboxCaption.setAttribute("label", label);
	gboxCaption.hidden = false;

	if(g_project) g_createTree();
	g_updateCodeName();

	//show frame (or panel) on bottom right
	g_showPanelOrLoadIt(panelToShowOnBottom);
}

function g_updateCodeName(newCodeName){
	if(newCodeName) g_project.other.codeName.@name = newCodeName;
	else if(g_project) newCodeName = g_project.other.codeName.@name.toString();
	else newCodeName = "";
	
	document.title = newCodeName + (newCodeName?" - ":"") + "CANopenNode";
	document.getElementById("g_codeNameField").value = newCodeName;
}

function g_openProjectFile(filename){
//Function opens new CANopenNode Device description file
	var httpRequest = new XMLHttpRequest();

	//Show progressmeter with filename loading
	var progressmeter = document.getElementById("g_panelLoading");
	var progressmeterName = document.getElementById("g_panelLoadingName");
	progressmeter.hidden = false;
	progressmeterName.value = "Loading " + filename + " ...";
		
	//this function is executed, after the file is loaded - see below
	httpRequest.onreadystatechange = function(){
		if(httpRequest.readyState == 4){
			//everything is good, the response is received
			if(httpRequest.status == 0 || httpRequest.status == 200){
				//valid response is received
				return g_createProject(httpRequest.responseText);
			}
			else{
				//file was not found or other http error
				alert("ERROR: File '" + filename + "' wasn't found!");
				return false;
			}
		}
	}
	httpRequest.open("GET", filename, true);
	httpRequest.send(null);
}

function g_createProject(XMLsource){
//function creates E4X object from XML text and creates whole projects tree 
	if(!XMLsource) return false;
	//remove first line, because of bug 336551 in mozilla
	XMLsource = XMLsource.replace('<?xml version="1.0"?>', "");
	XMLsource = XMLsource.replace('<?xml version="1.0" encoding="UTF-8"?>', "");
	try{
		g_project = new XML(XMLsource);
	}
	catch(e){
		alert("ERROR in XML source!\n" + e);
		return false;
	}

	//Create tree in left window. Some validation of g_project is made in the function.
	if(g_createTree(true) != true){
		g_project = null;
		return false;
	}
	
	//add languages to the lists
	var l1 = document.getElementById("g_Language");
	var l2 = document.getElementById("g_infoWindowLanguage");
	var lang = g_project.other.supportedLanguages.@supportedLanguages.toString().split(" ");
	l1.removeAllItems(); l2.removeAllItems();
	l1.value=""; l2.value="";
	for(var i=0; i<lang.length; i++){
		var s = lang[i];
		l1.appendItem(s, s); l2.appendItem(s, s);
	}
	l1.selectedIndex = 0; l2.selectedIndex = 0;

	//update codeName (descriptive name for the project)
	g_updateCodeName();

	return true;
}

function g_createTree(extraValidation){
//Function creates project tree in the left window.  In case of error in XML file it returns false.

	function err(text){
		g_error(text);
		//Show blank panel
		g_showPanelOrLoadIt("g_panelBlank");
	}

	//Show progressmeter while creating tree
	g_showPanelOrLoadIt("g_panelLoading", "Creating tree, please wait...");
	
	//create new XUL tree children
	var tree = <treechildren xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul" id="g_deviceTreeChildren"/>

	//some XML validation
	if(!g_project){alert("No project opened!"); return false;}
	if(extraValidation){
		if(g_project.features.length() !=1 ){err("One 'features' element under the root element is necessary!"); return false;}
		if(g_project.CANopenObjectList.length() !=1 ){err("One 'CANopenObjectList' element under the root element is necessary!"); return false;}
		if(g_project.other.length() !=1 ){err("One 'other' element under the root element is necessary!"); return false;}
		try{g_project.features.feature.(@name)}catch(e){err("Every <feature> must have a 'name' attribute!"); return false;};
		try{g_project.CANopenObjectList.CANopenObject.(@index)}catch(e){err("Every <CANopenObject> must have an 'index' attribute!"); return false;};
		try{g_project.CANopenObjectList.CANopenObject.(@name)}catch(e){err("Every <CANopenObject> must have a 'name' attribute!"); return false;};
		try{g_project.CANopenObjectList.CANopenObject.(@objectType)}catch(e){err("Every <CANopenObject> must have an 'objectType' attribute!"); return false;};
		try{g_project.CANopenObjectList.CANopenObject.CANopenSubObject.(@name)}catch(e){err("Every <CANopenSubObject> must have a 'name' attribute!"); return false;};
	}

	//FEATURES
	tree.appendChild(
		<treeitem	id="g_treeFeature" panelName="features" panelArg="" container="true" open="true">
			<treerow>
				<treecell label="Features"/>
			</treerow>
			<treechildren>
			</treechildren>
		</treeitem>
	);
	var i = 0;
	if(extraValidation) g_projectFeatures = {};
	for each (var feature in g_project.features.feature){
		var name = feature.@name;
		var featureValue = parseInt(feature.@value);
		if(name==""){err("Every <feature> must have a name!"); return false;}
		if(g_project.features.feature.(@name==name).length() != 1){err("Duplicate <feature> name not allowed: name='"+name+"'!"); return false;}

		//update all associated objects.
		if(extraValidation){
			for each (var associatedObject in feature.associatedObject){
				var index = parseInt("0x" + associatedObject.@index);
				var indexMax = parseInt("0x" + associatedObject.@indexMax);
				if(!indexMax) indexMax = index;
				if(index<0x1000 || index>0xFFFF){err("In <feature name=\""+name+"\">:\nindex in <associatedObject> must be between 1000 and FFFF !"); return false;}
				if(indexMax<index || indexMax>0xFFFF){err("In <feature name=\""+name+"\">:\nindexMax in <associatedObject> must be between index and FFFF !"); return false;}

				//generate new objects in project or disable unused if necessary
				var j = 1;	//incremented each loop pass
				var objectPrevious = null;
				for(var objIndex=index; objIndex<=indexMax; objIndex++){
					var objIndexHex = objIndex.toString(16).toUpperCase();
					//following line takes quite long time
					var object = g_project.CANopenObjectList.CANopenObject.(@index == objIndexHex);
					if(object.length()>1){err("<CANopenObject index=\""+objIndexHex+"\"> must not be duplicated!"); return false;}
					//Verify, if associated object allready exists in any of the previous features
					if(g_projectFeatures[objIndexHex]){
						//make also this tree element, so user can edit feature
						tree.treeitem.treechildren.appendChild(
							<treeitem panelName="feature" panelArg={name}>
								<treerow>
									<treecell label={++i}/>
									<treecell label={name}/>
								</treerow>
							</treeitem>
						);
						g_treeMakeNewChildren(tree);
						alert("Error in <feature name=\""+name+"\">:\nIndex in <associatedObject> must not be duplicated with any feature! (index=\""+objIndexHex+"\")\n\nPlease edit the feature!");
						g_showPanelOrLoadIt("g_panelBlank");
						return false;
					}
					//add "CANopenObject:featureName" property to the global object variable
					g_projectFeatures[objIndexHex] = name;
					//decide here, if objects need to be enabled or disabled
					if(j <= featureValue){
						//enable or create objects
						if(object.length() > 0){
							delete object.@disabled;
						}
						else{
							//if the first object does not exist, create new object. If it does, just make a copy of it.
							if(objectPrevious == null){
								object = <CANopenObject index={objIndexHex} name="New object" objectType="7" memoryType="RAM" dataType="05" accessType="rw" PDOmapping="no" defaultValue="0"/>
							}
							else{
								object = objectPrevious.copy();
								object.@index = objIndexHex;
							}
							//insert new <CANopenObject> into g_project on the right place
							var found = false;
							for each (var objectAfter in g_project.CANopenObjectList.CANopenObject){
								if(objectAfter.@index > objIndexHex){
									g_project.CANopenObjectList.insertChildBefore(objectAfter, object);
									found = true;
									break;
								}
							}
							if(!found) g_project.CANopenObjectList.appendChild(object);
						}
						objectPrevious = object;
					}
					else{
						//disable objects
						if(object.length() > 0) object.@disabled = "true";
					}
					j++;
				}
			}
		}

		//make tree element
		tree.treeitem.treechildren.appendChild(
			<treeitem panelName="feature" panelArg={name}>
				<treerow>
					<treecell label={++i}/>
					<treecell label={name}/>
				</treerow>
			</treeitem>
		);
	}


	//OBJECTS
	tree.appendChild(
		<treeitem	panelName="objects" panelArg="" container="true" open="true">
			<treerow>
				<treecell label="Objects"/>
			</treerow>
			<treechildren>
				<treeitem	id="g_treeComm" panelName="g_panelBlank" panelArg="" container="true" open="false">
					<treerow>
						<treecell label="Comm"/>
					</treerow>
					<treechildren/>
				</treeitem>
				<treeitem	id="g_treeManuf" panelName="g_panelBlank" panelArg="" container="true" open="false">
					<treerow>
						<treecell label="Manuf"/>
					</treerow>
					<treechildren/>
				</treeitem>
				<treeitem	id="g_treeProfile" panelName="g_panelBlank" panelArg="" container="true" open="false">
					<treerow>
						<treecell label="Profile"/>
					</treerow>
					<treechildren/>
				</treeitem>
			</treechildren>
		</treeitem>
	);
	var lastIndex = 0xFFF;
	for each (var object in g_project.CANopenObjectList.CANopenObject){
		//skip disabled objects, except in mode 'Edit Object Dictionary'
		var disabled = (object.@disabled == "true");
		if(disabled && document.getElementById("g_modeCaption").getAttribute("label")!="Edit Object Dictionary") continue;

		var index = parseInt("0x" + object.@index);
		var indexHex = index.toString(16).toUpperCase();
		var name = object.@name;
		var objectType = parseInt(object.@objectType);
		if(index<0x1000 || index>0xFFFF){err("Index in <CANopenObject> '"+name+"' must be between 1000 and FFFF !"); return false;}
		if(index<=lastIndex){err("<CANopenObject> elements must be ordered by index! Index must not be duplicated! (index="+indexHex+")"); return false;}
		if(name==""){err("<CANopenObject index=\""+indexHex+"\"> must have a name!"); return false;}
		if(objectType<7 || objectType>9){err("objectType in <CANopenObject index=\""+indexHex+"\"> must be between 7 and 9 !"); return false;}
		lastIndex = index;
		
		//make tree element
		var treeitem = 
			<treeitem panelName="object" container={objectType>7?"true":""} panelArg={indexHex}>
				<treerow>
					<treecell src={disabled?"pict/disabled.png":""} label={indexHex}/>
					<treecell label={name}/>
				</treerow>
			</treeitem>;
		//in case of array or record add sub objects if necessary
		if(objectType > 7){ 
			var subNumber = parseInt(object.@subNumber);
			if(subNumber<2 || subNumber>255){err("subNumber in <CANopenObject index=\""+indexHex+"\"> must be between 2 and 255 !"); return false;}
			//if necessary, append new subobjects to the project file
			var subObjects = object.CANopenSubObject;
			var subObjectsChanged = false;
			for(var i=subObjects.length(); i<subNumber; i++){
				var subObjects = object.CANopenSubObject;
				var subObject;
				if(i == 0){
					subObject =	<CANopenSubObject subIndex="00" name="Number of Entries" objectType="7" dataType="05" accessType="ro" PDOmapping="no" defaultValue="0"/>
				}
				else{
					subObject = subObjects[i-1].copy();
				}
				object.CANopenSubObject += subObject;
				subObjectsChanged = true;
			}
			if(subObjectsChanged) object.CANopenSubObject[0].@defaultValue = (subNumber-1).toString();
			//generate subtree
			treeitem.appendChild(<treechildren/>);
			var subObjects = object.CANopenSubObject;
			for(var i=0; i<subNumber; i++){
				var subIndexString = g_byteToHexString(i);
				subObjects[i].@subIndex = subIndexString;
				subObjects[i].@objectType = 7;
				var name = subObjects[i].@name;
				if(name==""){err("In <CANopenObject index=\""+indexHex+"\">: <CANopenSubObject subIndex=\""+subIndexString+"\"> must have a name!"); return false;}
				treeitem.treechildren.appendChild(
					<treeitem panelName="subobj" panelArg={indexHex+"_"+subIndexString}>
						<treerow>
							<treecell label={subIndexString}/>
							<treecell label={name}/>
						</treerow>
					</treeitem>);
			}
		}
		var i = 0;
		if(index >= 0x2000) i = 1;
		if(index >= 0x6000) i = 2;
		tree.treeitem[1].treechildren.treeitem[i].treechildren.appendChild(treeitem);
	}


	//OTHER
	tree.appendChild(
		<treeitem	id="g_treeOther" panelName="other" panelArg="" container="true" open="true">
			<treerow>
				<treecell label="Other"/>
			</treerow>
			<treechildren>
			</treechildren>
		</treeitem>
	);
	var i = 0;
	for each (var elem in g_project.other.*){
		var name = elem.localName();
		if(g_project.other.child(name).length() != 1){err("Duplicate element name is not allowed in <other>: '"+name+"'!"); return false;}
		//make tree element
		tree.treeitem[2].treechildren.appendChild(
			<treeitem panelName={g_toEightCharString(name)} panelArg={"g_project.other."+name}>
				<treerow>
					<treecell label={++i}/>
					<treecell label={name}/>
				</treerow>
			</treeitem>
		);
	}


	//replace original tree children with the new tree
	g_treeMakeNewChildren(tree);

	//Show blank panel
	g_showPanelOrLoadIt("g_panelBlank");

	return true;
}

function g_treeMakeNewChildren(tree){
//replace original tree children with the new tree. Subtrees remain open (or closed).
	var treeElement = document.getElementById("g_deviceTree");
	var treeChildren = document.getElementById("g_deviceTreeChildren");

	var parser = new DOMParser();
	var newTreeChildren = parser.parseFromString(tree.toXMLString(), "text/xml").documentElement;

	var featureOpen = "true";
	var commOpen = "false";
	var manufOpen = "false";
	var profileOpen = "false";
	var otherOpen = "true";
	var t;
	var t = document.getElementById("g_treeFeature"); if(t) featureOpen = t.getAttribute("open");
	var t = document.getElementById("g_treeComm"); if(t) commOpen = t.getAttribute("open");
	var t = document.getElementById("g_treeManuf"); if(t) manufOpen = t.getAttribute("open");
	var t = document.getElementById("g_treeProfile"); if(t) profileOpen = t.getAttribute("open");
	var t = document.getElementById("g_treeOther"); if(t) otherOpen = t.getAttribute("open");
	if(treeChildren) treeElement.removeChild(treeChildren);

    //append panel to the parentWindow
	var	node = document.importNode(newTreeChildren, true);

	treeElement.appendChild(node);
	document.getElementById("g_treeFeature").setAttribute("open", featureOpen);
	document.getElementById("g_treeComm").setAttribute("open", commOpen);
	document.getElementById("g_treeManuf").setAttribute("open", manufOpen);
	document.getElementById("g_treeProfile").setAttribute("open", profileOpen);
	document.getElementById("g_treeOther").setAttribute("open", otherOpen);
}

function g_treeSelected(tree){
	//function is called, when new item is selected in tree on the left
	var selection = tree.contentView.getItemAtIndex(tree.currentIndex);
	var panelName = selection.getAttribute("panelName");
	var panelArgument = selection.getAttribute("panelArg");
	g_showPanelOrLoadIt(panelName, panelArgument);
}
