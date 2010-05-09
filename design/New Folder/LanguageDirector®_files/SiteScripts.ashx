// A module which connects to the custom file upload Web Service to determine the 
// percentage completion of a file upload.
var _fileUploadXmlHttp = null;
var DEBUG = false;
var postCount = 0;
var progressID = 0;

function getProgress(id)
{
	progressID = id;

	var xml = "<" + "?xml version=\"1.0\" encoding=\"utf-8\"?>\n";	
	xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n";
	xml += "	<soap:Body>\n";
	xml += "		<GetProgress xmlns=\"http://www.thebigword.com/FileUploadProgress\">\n";
	xml += "			<id>" + id + "</id>\n";
	xml += "		</GetProgress>\n";
	xml += "	</soap:Body>\n";
	xml += "</soap:Envelope>\n";
	
	// Set up the 
	// xmlHttp object
	
	// branch for native XMLHttpRequest object
	if(window.XMLHttpRequest) 
	{
		try 
		{
			_fileUploadXmlHttp = new XMLHttpRequest();
		} 
		catch(e) 
		{
			_fileUploadXmlHttp = false;
			
			if(DEBUG)
			{
				alert("Unable to create an instance of XmlHttp for FireFox.");
			}
		}
	// branch for IE/Windows ActiveX version
	} 
	else if(window.ActiveXObject) 
	{
		try 
		{
			_fileUploadXmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch(e) 
		{
			try 
			{
				_fileUploadXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch(e) 
			{
				_fileUploadXmlHttp = false;
				
				if(DEBUG)
				{
					alert("Unable to create an instance of XmlHttp for Internet Explorer.");
				}
			}
		}
	}
		
	if(_fileUploadXmlHttp)
	{		
		_fileUploadXmlHttp.onreadystatechange = fileUpload_xmlHttpStateChange;
		
		try
		{
		    var urlToPost = getPath() + "/FileUploader.asmx?id=" + id;
			
			_fileUploadXmlHttp.open("POST", urlToPost, true);
			_fileUploadXmlHttp.setRequestHeader("SOAPAction", "http://www.thebigword.com/FileUploadProgress/GetProgress");
			_fileUploadXmlHttp.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
			_fileUploadXmlHttp.send(xml);
			
			postCount ++;
		}
		catch(e)
		{
			alert("An error occurred whilst attempting to contact the server during file upload: " + e);
		}
	}
	
	// If we're still null, display an error message
	if(_fileUploadXmlHttp == null)
	{
		//TODO: Display error message
		if(DEBUG)
		{
			alert("For some reason, the XmlHttp object is still null.");
		}
	}	
}

// This function cannot be called outside of the class above
function fileUpload_xmlHttpStateChange()
{
	if(_fileUploadXmlHttp.readyState == 4) 
	{
		// only if "OK"
		try
		{
			if(_fileUploadXmlHttp.status == 200)
			{
				// Parse the returned xml in order to find out the operation which was performed and whether it was successful
				var id = getXmlValue(_fileUploadXmlHttp.responseText, "ID");				
				var uploaded = unescape(getXmlValue(_fileUploadXmlHttp.responseText, "Received"));
				var total = unescape(getXmlValue(_fileUploadXmlHttp.responseText, "Total"));
				var complete = unescape(getXmlValue(_fileUploadXmlHttp.responseText, "Complete"));
							
				fileUpload_updatePercentageBar(id, uploaded, total, complete);
			}
			else 
			{	
				if(DEBUG)
				{
					alert(_fileUploadXmlHttp.responseText);
				}
			}
		}
		catch(e)
		{
			if(DEBUG)
			{
				alert("XmlHttpStateChange: Error 1: --> " + e.toString());
				alert("XmlHttpStateChange: Error 1: --> " + e.description);
			}
		}
		
		// Wait for 3 seconds.
		window.setTimeout("getProgress(\"" + progressID + "\")", 3000);
	}
}

function fileUpload_updatePercentageBar(id, uploaded, total, complete)
{
	var percentage = (uploaded / total) * 100;
	
	if(Math.round(percentage) == 100)
	{
		percentage = 99;
	}

	getAspNetElementById("UploadArea").style.display = "block";
	getAspNetElementById("PercentageComplete").style.width = (Math.round(percentage).toString() + "%");
	getAspNetElementById("PercentageComplete").innerHTML = " " + (Math.round(percentage).toString() + "%");
	
	window.scrollTo(0,0);	
}

// A basic Xml parsing function
function getXmlValue(xml, tagName)
{
	var regularExpression = "<(" + tagName + ")>(.*?)</" + tagName + ">";
	var regexp = new RegExp(regularExpression);
	
	// 1 returns the tag name
	if(regexp.test(xml))
	{
		return(regexp.exec(xml)[2]);
	}
	else
	{
		if(DEBUG)
		{
			alert("getXmlValue: Null Value: Error 1: --> " + e.toString());
		}
	
		return null;
	}
}

function getPath()
{
	return(document.location.href.substring(0, document.location.href.lastIndexOf("/")));
}

function getDomain()
{
	var l = document.location.href;
	
	var protocol = l.substring(0, l.indexOf("://")).toLowerCase();
	var domain = l.substring(l.indexOf("//") + 2);
	
	if(protocol == "file")
	{
		domain = domain.substring(0, domain.lastIndexOf("/"))
	}
	else
	{
		domain = protocol + "://" + domain.substring(0, domain.indexOf("/"))
	}

	return domain;
}
﻿// Used by TermImport.aspx
function displayProgressBar()
{
    // This uses a custom function in standard.js
    var content = document.getElementById("divInputForm");
	content.style.opacity = "0.2";
	document.getElementById("pageHeader").style.opacity = "0.2";
	
	// IE users don't get the full effect... :(
	if(ie)
	{
		content.style.display = "none";
		document.getElementById("pageHeader").style.display = "none";
	}

	var id = document.forms[0].__MEDIACHASE_FORM_UNIQUEID.value;
	getProgress(id);
}

// These functions are used on Submit.aspx
function submitFile()
{
	// Call the ASP.Net functions
	Page_ClientValidate();
	if(Page_IsValid)
	{
		showProgressForUpload();
		return true;
	}
	else
	{
		return false;
	}
}

function showProgressForUpload()
{
    // This uses a custom function in standard.js
    var content = getAspNetElementById("tblInputForm");
    if (content == null)
    {  
        content = document.getElementById("mainContent");
    } 
	content.style.opacity = "0.2";
	getAspNetElementById("pageHeader").style.opacity = "0.2";
	
	// IE users don't get the full effect... :(
	if(ie)
	{
		content.style.display = "none";
		getAspNetElementById("pageHeader").style.display = "none";
	}

	var id = document.forms[0].__MEDIACHASE_FORM_UNIQUEID.value;
	getProgress(id);
}

function showLangs(theSelect, grrr){
	if(getElementById)
	{
		var theText = getElementById(grrr);
		var selectcount = 0;
		
		theText.innerHTML = '';
		var curItem;
		var first = true;
		for(curItem = 0; curItem < theSelect.length; ++curItem)
		{
			if(theSelect[curItem].selected == true) 
			{
				selectcount += 1;
				
				if(!first) 
				{
					theText.innerHTML += ", ";
					if (selectcount%6==0)
					{
						theText.innerHTML += "<br/>"
					}
				} 
				else 
				{
					first = false;
				}
				
				theText.innerHTML += theSelect[curItem].text;
			}
		}
	}
}

/* These functions are used on Jobs.aspx */

/*
function download(id)
{
	var inputs = getChildCheckboxes(getElementById(id));
	
	var output = new Array();
	
	var fileSize = 0;
	for(var i = 0; i < inputs.length; i ++)
	{
		if(inputs[i].checked)
		{
			output.push(inputs[i]);
			var newID = inputs[i].id.replace("file", "fileSize");
			fileSize += parseInt(getElementById(newID).innerHTML);
		}	
	}
	
	var url = "DownloadJobFiles.aspx?TaskFileInfoIDs=";
	
	for(var i = 0; i < output.length; i ++)
	{
		if(output[i].id.indexOf("file") == 0)
		{
			url += output[i].id.replace("file", "") + ",";
		}
	}
	
	url = url.substring(0, url.length - 1);
	
	// Redirect to the download screen
	//TODO: Do this via a postback instead.
	//alert(url);
	
	if(output.length > 0)
	{
		document.location.href = url;
	}
	
	return false;
}
*/

function download(id)
{
	var inputs = getChildCheckboxes(getElementById(id));
	
	var output = new Array();
	
	var fileSize = 0;
	for(var i = 0; i < inputs.length; i ++)
	{
		if(inputs[i].checked)
		{
			output = arrayPush(output, inputs[i]);
			var newID = inputs[i].id.replace("file", "fileSize");
			fileSize += parseInt(getElementById(newID).innerHTML);
		}	
	}
	
	var url = "ZipAndDownload.aspx?TaskFileInfoIDs=";
	
	for(var i = 0; i < output.length; i ++)
	{
		if(output[i].id.indexOf("file") == 0)
		{
			url += output[i].id.replace("file", "") + ",";
		}
	}
		
	url = url.substring(0, url.length - 1);
	
	// Redirect to the download screen
	//TODO: Do this via a postback instead.
	//alert(url);
	
	if(output.length > 0)
	{
		document.location.href = url;
	}
	
	return false;
}

function calculateDownload(id)
{
	var inputs = getChildCheckboxes(document.getElementById(id));

	var output = new Array();
	
	var fileSize = 0;
	for(var i = 0; i < inputs.length; i ++)
	{
		if(inputs[i].checked)
		{
			if(inputs[i].id.indexOf("file") == 0)
			{
				output = arrayPush(output, inputs[i]);
				
				var newID = inputs[i].id.replace("file", "fileSize");
				fileSize += parseInt(document.getElementById(newID).innerHTML);
			}
		}	
	}
	
	var kb = Math.floor(fileSize / 1024);
	document.getElementById("DownloadAmount").innerHTML = kb + "KB";
	document.getElementById("FileCount").innerHTML = output.length;
	
	document.getElementById("DownloadAmountTwo").innerHTML = kb + "KB";
	document.getElementById("FileCountTwo").innerHTML = output.length;
	
	// If the file count > 0
	getAspNetElementById("btnDownloadUsingJava", "input").disabled = (output.length == 0);
	getAspNetElementById("btnDownloadTwo", "input").disabled = (output.length == 0);
}

function standard_show(o)
{
	if(typeof(o) == "string")
	{
		o = getElementById(o);
	}
	
	o.style.display = "block";
}

function standard_hide(o)
{
	if(typeof(o) == "string")
	{
		o = getElementById(o);
	}
	
	o.style.display = "none";
}

function showHide(o)
{
	if(typeof(o) == "string")
	{
		o = getElementById(o);
	}
	
	o.style.display = o.style.display == "none" || o.style.display == "" ? "block" : "none";
}

function showHideButton(hider, o)
{
	if(typeof(o) == "string")
	{
		o = getElementById(o);
	}

	o.style.display = o.style.display == "none" || o.style.display == "" ? "block" : "none";
	hider.attributes["alt"].value = o.style.display == "none" ? "+" : "-";
	hider.src = o.style.display == "none" ? "images/plus.gif" : "images/minus.gif";
	return false;
}

function selectChildCheckboxes(id, checkstate)
{
	var checkboxes = getChildCheckboxes(document.getElementById(id));	
	
	for(var i = 0; i < checkboxes.length; i ++)
	{
		if(!checkboxes[i].disabled)
		{
			checkboxes[i].checked = checkstate;
		}
	}
	
	calculateDownload(getAspNetElementById("viewCollect", "div").id);
}

function arrayPush(array, objectToPush)
{
	if(array.push)
	{
		array.push(objectToPush);
	}
	else
	{
		array[array.length] = objectToPush;	
	}
	
	return array;
}

function getChildren(o, tagName, type)
{
	var output = new Array();;

	var inputs = o.getElementsByTagName(tagName);

	for(var j = 0; j < inputs.length; j ++)
	{	
		if(inputs[j].attributes["type"].value == type)
		{
			output = arrayPush(output, inputs[j]);
		}
	}

	return output;
}

function getChildCheckboxes(o)
{
	return getChildren(o, "input", "checkbox");
}

function enableSearchDates(o)
{
	getAspNetElementById("StartYear").disabled = (!o.checked);
	getAspNetElementById("StartMonth").disabled = (!o.checked);
	getAspNetElementById("StartDay").disabled = (!o.checked);
	getAspNetElementById("EndYear").disabled = (!o.checked);
	getAspNetElementById("EndMonth").disabled = (!o.checked);
	getAspNetElementById("EndDay").disabled = (!o.checked);
}

function selectUsers(clientCode)
{
	var showAll = clientCode == "0" ? true : false;
	
	var cmb = getAspNetElementById("lvwClientContacts");
	var regex = new RegExp(".* \\(" + clientCode + "\\)");
	var hidden = 0;
	for(var i = 0; i < cmb.options.length; i ++)
	{
		if(!showAll && regex.exec(cmb.options[i].text) == null)
		{
			cmb.options[i].style.display = "none";	
			cmb.options[i].selected = false;
			hidden ++;
		}
		else
		{
			cmb.options[i].style.display = "block";	
		}
	}
	
	if(hidden == cmb.options.length)
	{
		cmb.style.width = "310px";
		cmb.style.height = "80px";
	}
}

// Used on Submit.aspx
function fileChanged(o, addNew)
{
	var pathID = o.id.replace("File", "FilePath");	
	getAspNetElementById(pathID).value = o.value;

	if(addNew)
	{
		NextFile();
	}
}

function countFileInputs()
{
	var inputs = 0;
	
	for(var i = 0; i < document.getElementsByTagName("input").length; i ++)
	{
		var o = document.getElementsByTagName("input")[i];
		
		var attributeIndex = 0;
		
		for(attributeIndex = 0; attributeIndex < o.attributes.length; attributeIndex ++)
		{
			if(o.attributes[attributeIndex].nodeName == "type")
			{
				if(o.attributes[attributeIndex].nodeValue == "file")
				{
					inputs ++;
				}
			}
		}
	}
	
	return inputs;
}

function NextFile(e)
{
	e = e || window.event;

	if(e != null)
	{
		var o = e.target ? e.target : e.srcElement;
		
		var pathID = o.id.replace("File", "FilePath");
		getElementById(pathID).value = o.value;
	}

	var o = getElementById("fileControls");
	
	var fileInputs = countFileInputs();
	
	var newFileInput = document.createElement("input");
	var newFilePathInput = document.createElement("input");
	
	// Add the type attribute
	var typeAttribute = document.createAttribute("type");
	typeAttribute.value = "file";
	newFileInput.setAttributeNode(typeAttribute);
	
	typeAttribute = document.createAttribute("type");
	typeAttribute.value = "hidden";
	newFilePathInput.setAttributeNode(typeAttribute);
	
	
	// Add the name attribute
	var nameAttribute = document.createAttribute("name");
	nameAttribute.value = "theFile";
	newFileInput.setAttributeNode(nameAttribute);
	
	nameAttribute = document.createAttribute("name");
	nameAttribute.value = "FilePath" + fileInputs.toString();
	newFilePathInput.setAttributeNode(nameAttribute);
	
	// Add the id attribute
	var idAttribute = document.createAttribute("id");
	idAttribute.value = "File" + fileInputs.toString();
	newFileInput.setAttributeNode(idAttribute);
	
	idAttribute = document.createAttribute("id");
	idAttribute.value = "FilePath" + fileInputs.toString();
	newFilePathInput.setAttributeNode(idAttribute);
	
	// Add the size attribute to set the width equal to the existing control
	var styleAttribute = document.createAttribute("size");
	styleAttribute.value = "50"
	newFileInput.setAttributeNode(styleAttribute);	
	
	if(ie)
	{
		// Microsoft way
		newFileInput.onchange = NextFile;
	}
	else
	{
		// The W3C (correct) way
		newFileInput.addEventListener("change", NextFile, false);
	}
	
	var lineBreak = document.createElement("br");
	
	o.appendChild(lineBreak);
	o.appendChild(newFileInput);
	o.appendChild(newFilePathInput);
}

function enableDisableFiles(o)
{
	var objects = getChildren(getElementById("fileControls"), "input", "file");
	for(var i = 0; i < objects.length; i ++)
	{
		objects[i].disabled = (!objects[i].disabled);
	}
}

/* Sniff Java */
function hasJava()
{
	if(navigator.mimeTypes) 
	{
		for(var i = 0; i < navigator.mimeTypes.length; i++) 
		{
			var mimeType = navigator.mimeTypes[i].type;
			
			if(mimeType != null)
			{
				if(mimeType.indexOf("application/x-java-applet;version=") >= 0)
				{
					if(mimeType.split("=")[1] >= 1.5)
					{
						return true;
					}
				}
			}
		}
	}
	
	return false;
}

function hideFileInfo(fileID)
{
	var o = getElementById("fileInformation" + fileID.toString());
	o.style.display = "none";
}

function showFileInfo(fileID)
{
	var o = getElementById("fileInformation" + fileID.toString());
	o.style.display = "block";
}

function jobsViewLoad()
{
	// The header number text box may not be visible
	// to javascript at this point.
	if(getElementById("txtHeaderNumber") != null)
	{
		var objectArray = document.getElementsByTagName("span");
	
		var headerNumber = getElementById("txtHeaderNumber").value;
		var jobNumber = getElementById("txtJobNumber").value;
		var fileName = getElementById("txtFileName").value;
		var poNumber = getElementById("txtPONumber").value;
		var projectReference = getElementById("txtProjectReference").value;
		
		for(var i = 0; i < objectArray.length; i ++)
		{
			var o = objectArray[i];	
			
			// Highlight header number
			if(headerNumber != "")
			{
				if(o.innerHTML.indexOf(headerNumber) >= 0)
				{
					o.className = "CHighlighted";
				}
			}
			
			if(jobNumber != "")
			{
				if(o.innerHTML.indexOf(jobNumber) >= 0)
				{
					o.className = "CHighlighted";
				}
			}
			
			if(fileName != "")
			{
				if(o.innerHTML.indexOf(fileName) >= 0)
				{
					o.className = "CHighlighted";
				}
			}
			
			if(poNumber != "")
			{
				if(o.innerHTML.indexOf(poNumber) >= 0)
				{
					o.className = "CHighlighted";
				}
			}
			
			if(projectReference != "")
			{
				if(o.innerHTML.indexOf(projectReference) >= 0)
				{
					o.className = "CHighlighted";
				}
			}
		}
	}
}

function jobEnquiryChanged()
{
	var isQuote = getElementById("JobOrEnquiry_1").checked;
	var display = isQuote ? "none" : "inline";
	var optional = getElementById("lblPoNumberOptional");
	
	if(optional != null)
	{
		optional.style.display = display;
	}
}

function submitLoad()
{
	var o1 = getAspNetElementById("JobOrEnquiry_0");
	var o2 = getAspNetElementById("JobOrEnquiry_1");
	
	if(o1 != null && o2 != null)
	{
		if(ie)
		{
			// Microsoft way
			o1.onclick = jobEnquiryChanged;
			o2.onclick = jobEnquiryChanged;
		}
		else
		{
			// The W3C (correct) way
			o1.addEventListener("click", jobEnquiryChanged, false);
			o2.addEventListener("click", jobEnquiryChanged, false);
		}
	}
}

function additionalGovernmentInformation_Load()
{
// this function has problem, will investigate in the future. --By Susan
	if(getElementById("chkSummary").checked)
	{
		getElementById("divSummary").style.display = "block";
	}
	

	if(getElementById("pnlGovernInfo_chkArtWorkTypesettingRequired").checked)
	{
		getElementById("contactNote").style.display = "block";
	}
}

function governmentInformationSummaryCheck(o)
{
	getElementById('divSummary').style.display = o.checked ? "block" : "none";
	
	var general = getElementById("pnlGovernInfo_rdSummaryTranslationGeneral");
	var specific = getElementById("pnlGovernInfo_rdSummaryTranslationSpecific");
	
	if(o.checked && ((general.checked || specific.checked) == false))
	{
		general.checked = true;
	}
	else if(!o.checked)
	{
		general.checked = false;
		specific.checked = false;
	}
}

function getAspNetElementById(id, type)
{
	return getElementById(id, type);
}

// Gets the element by the id, taking into account
// the changes which ASP.Net makes to the page
function getElementById(id, type)
{
	var e;
	
	if(type == null)
	{
		type = "*";
	}
	
	var elements = document.getElementsByTagName(type);
	
	for(var i = 0; i < elements.length; i ++)
	{
		var e = elements[i];
		
		if(e.id == id)
		{
			return e;
		}
		
		if(e.id.indexOf("_") > 0)
		{
			var array = e.id.split("_");
		    var tagName = getTagNameWithSlash(array);
		    
		    if (tagName == id)
		    {
		        return e;
		    }
		    /*
			if(array[array.length - 1] == id)
			{
				return e;
			}*/
		}
	}
	
	return null;
}

function getTagNameWithSlash(array)
{
    var tagName = '';
    
    for (var i = 2; i < array.length; i++)
    {
        if (tagName != '')
            tagName += '_';
        tagName += array[i];    
    }
    
    return tagName;
}

function round(f, decimalPlaces)
{
	var factor = Math.pow(10, decimalPlaces);
	return Math.round(f * factor) / factor;
}

function textBoxInputLimitation(txtControl, maxLength, evt) {
    if (txtControl != null) {
        try {
            if (txtControl.value.length >= maxLength) {
                txtControl.value = txtControl.value.substring(0, maxLength);
            }
        }
        catch (e){
        }
    }
}
	// A module which connects to thebigword's machine translation
	// web service to translate text.
	var _xmlHttp = null;

	function getTranslation(index, sourceLanguage, targetLanguage, text, isURL)
	{
		var xml = "<" + "?xml version=\"1.0\" encoding=\"utf-8\"?>\n";	
		xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n";
		xml += "	<soap:Body>\n";
		xml += "		<Translate xmlns=\"http://www.thelittleword.com/MachineTranslation\">\n";
		xml += "			<translationReference>" + escape(index) + "</translationReference>\n";
		xml += "			<sourceLanguage>" + escape(sourceLanguage) + "</sourceLanguage>\n";
		xml += "			<targetLanguage>" + escape(targetLanguage) + "</targetLanguage>\n";
		xml += "			<text>" + text.replace("<", "&lt;").replace(">", "&gt;") + "</text>\n";
		xml += "			<isURL>" + isURL.toString() + "</isURL>\n";
		xml += "		</Translate>\n";
		xml += "	</soap:Body>\n";
		xml += "</soap:Envelope>\n";
		
		// Set up the 
		// xmlHttp object
		
		// branch for native XMLHttpRequest object
		if(_xmlHttp == null)
		{
			if(window.XMLHttpRequest) 
			{
				try 
				{
					_xmlHttp = new XMLHttpRequest();
				} 
				catch(e) 
				{
					_xmlHttp = false;
				}
			// branch for IE/Windows ActiveX version
			} 
			else if(window.ActiveXObject) 
			{
				try 
				{
					_xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch(e) 
				{
					try 
					{
						_xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch(e) 
					{
						_xmlHttp = false;
					}
				}
			}
		}
		
		if(_xmlHttp)
		{		
			_xmlHttp.onreadystatechange = xmlHttpStateChange;
			
			try
			{
				_xmlHttp.open("POST", "http://localhost/MachineTranslation/MachineTranslation.asmx", true);
				_xmlHttp.setRequestHeader("SOAPAction", "http://www.thelittleword.com/MachineTranslation/Translate");
				_xmlHttp.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
				_xmlHttp.send(xml);
			}
			catch(e)
			{
				alert("An error occurred whilst attempting to contact thebigword for machine translation: " + e);
			}
		}
		
		// If we're still null, display an error message
		if(_xmlHttp == null)
		{
			//TODO: Display error message
		}	
	}
	
	// This function cannot be called outside of the class above
	function xmlHttpStateChange()
	{
		if(_xmlHttp.readyState == 4) 
		{
			// only if "OK"
			if(_xmlHttp.status == 200)
			{
				// Parse the returned xml in order to find out the operation which was performed and whether it was successful
				var index = getXmlValue(_xmlHttp.responseText, "TranslationReference");				
				var translation = unescape(getXmlValue(_xmlHttp.responseText, "Translation"));
				
				machineTranslationSuccessful(index, translation);
			}
			else 
			{
				//alert("There was a problem translating the text:\n" + _xmlHttp.status + " - " + _xmlHttp.statusText);
				alert(SmartReviewClient_ProblemTranslatingTheText + "\n" + _xmlHttp.status + " - " + _xmlHttp.statusText);
				alert(_xmlHttp.responseText);
			}
		}
	}
	
	function machineTranslationSuccessful(index, translation)
	{
		//alert("Machine Translation Index: " + index);
		//alert("Machine Translation Translation: " + translation);
		completeMachineTranslation(index, translation);
	}

	// A basic Xml parsing function
	function getXmlValue(xml, tagName)
	{
		var regularExpression = "<(" + tagName + ")>(.*?)</" + tagName + ">";
		var regexp = new RegExp(regularExpression);
		
		// 1 returns the tag name
		if(regexp.test(xml))
		{
			return(regexp.exec(xml)[2]);
		}
		else
		{
			return null;
		}
	}
	/* 	
	
		SmartReview(tm) Web Edition
		Adrian Hesketh
		www.thebigword.com
		Copyright 2006 thebigword
		
	*/

	var _Context = window;
	var _SelectedText = "";

	var ie = false;

	function setContext(o)
	{
		_Context = o;
	}

	function assignContextMenu(o)
	{
		if(o.addEventListener)
		{
			// For Mozilla type browsers
			o.addEventListener("mousedown", storeSelectedText, true);
			o.addEventListener("contextmenu", showMenu, true);		
		}
		else if(o.attachEvent)
		{
			// For IE
			o.attachEvent("onmousedown", storeSelectedText, true);
			o.attachEvent("oncontextmenu", showMenu);		
		}
	}

	function setupContextMenu()
	{
		// document.oncontextmenu = showMenu;
		enableMenuDestruction();
		
		var i = 0;		
		var o = null;

		// Add the listener to the translation textareas
		for(i = 0; i < document.getElementsByTagName("textarea").length; i ++)
		{
			o = document.getElementsByTagName("textarea")[i];

			assignContextMenu(o);
		}				
		
		// Add the listener to the source text
		for(i = 0; i < document.getElementsByTagName("td").length; i ++)
		{
			o = document.getElementsByTagName("td")[i];

			if(o.className == "CSourceText" || o.className == "CTargetText")
			{
				assignContextMenu(o);
			}
		}
	}

	function disableMenuDestruction()
	{
		document.onclick = null;
	}

	function enableMenuDestruction()
	{
		document.onclick = hideMenu;
	}

	function setEnabledDisabled(o, enabled)
	{
		if(enabled)
		{
			o.className = "";
		}
		else
		{
			o.className = "CContextMenuDisabled";
		}
	}

	function showMenu(e)
	{
		e = e || window.event;

		// IE 5.0 doesn't allow preventDefault
		if(e.preventDefault) { e.preventDefault(); };
		e.returnValue = false;
		e.cancel = true;
		
		_Context = e.target ? e.target : e.srcElement;
					
		// At this point, if we want to have an actual context menu, we would choose which 
		// menu we wanted to display based on the context variable.
		
		// The closeMenu function would simply close ALL context menus that we had set up.

		var oMenu = document.getElementById("ContextMenu");

		var rightedge = 0;

		if(ie)
		{
			rightedge = document.body.clientWidth - event.clientX;
		}
		else
		{
			rightedge = window.innerWidth - e.clientX;
		}

		var bottomedge = 0;

		if(ie)
		{
			bottomedge = document.body.clientHeight - event.clientY;
		}
		else
		{
			bottomedge = window.innerHeight - e.clientY;
		}
		
		// If the horizontal distance isn't enough to accomodate the width of the context menu
		if(rightedge < oMenu.offsetWidth)
		{
			// Move the horizontal position of the menu to the left by it's width
			if(ie)
			{
				oMenu.style.left = document.body.scrollLeft + e.clientX - oMenu.offsetWidth;
			}
			else
			{
				oMenu.style.left = window.pageXOffset + e.clientX - oMenu.offsetWidth + "px";
			}
		}	
		else // Position the horizontal position of the menu where the mouse was clicked
		{
			if(ie)
			{
				oMenu.style.left = document.body.scrollLeft + e.clientX;
			}
			else
			{
				oMenu.style.left = window.pageXOffset + e.clientX + "px";
			}
		}
		
		var top = 0;
		
		// Same concept with the vertical position
		if(bottomedge < oMenu.offsetHeight)
		{
			if(ie)
			{
				top = 0;

				if (document.documentElement && document.documentElement.scrollTop)
				{
					top = document.documentElement.scrollTop;
				}
				else if (document.body)
				{
					top = document.body.scrollTop;
				}

				oMenu.style.top = top + e.clientY + oMenu.offsetHeight;
			}
			else
			{
				oMenu.style.top = window.pageYOffset + e.clientY - oMenu.offsetHeight + "px";
			}
		}
		else
		{
			if(ie)
			{
				// More IE specific stuff...
				top = 0;

				if (document.documentElement && document.documentElement.scrollTop)
				{
					top = document.documentElement.scrollTop;
				}
				else if (document.body)
				{
					top = document.body.scrollTop;
				}

				oMenu.style.top = top + e.clientY; //  + oMenu.offsetHeight;
			}
			else
			{
		
				oMenu.style.top = window.pageYOffset + e.clientY + "px";
			}
		}
		
		oMenu.style.visibility = "visible";
		
		return false;
	}

	function canCheckSpelling(language)
	{
		switch(language.toLowerCase())
		{
			case "en-gb":
			case "en-us":
			case "de-de":
			case "es-es":
				return true;
				break;
			default:
				return false;
				break;
		}
	}
	
	function hideMenu(e)
	{
		var oMenu = document.getElementById("ContextMenu");
		
		if(oMenu != null)
		{
		    if(oMenu.style.visibility == "visible")
		    {
			    oMenu.style.visibility = "hidden";		
		    }
		}
	}

	// Below here are the context functions

	function searchGoogle()
	{
		var searchText = getTextSelection(_Context);

		var domain = "co.uk";
		var knownLanguage = true;
		var lang = _Context.getAttribute("lang").toLowerCase();

		switch(lang)
		{
			case "en-us":
				domain = "com";
				break;
			case "en-gb":
				domain = "co.uk";
				break;
			case "de-de":
				domain = "de";
				break;
			case "fr-fr":
				domain = "fr";
				break;
			case "es-es":
				domain = "es";
				break;
			case "it-it":
				domain = "it";
				break;
			default:
				knownLanguage = false;
				break;
		}

		if(knownLanguage)
		{
			var url = "http://www.google." + domain + "/search?q=" + escape(searchText) + "&meta=lr%3Dlang_" + lang;
			window.open(url);
		}
		else
		{
			//alert("Sorry, but Google search is not available for this language.");
			alert(SmartReviewContextMenu_GoogleSearchNotAvailable);
		}
		
		hideMenu();
	}

	function defineGoogle()
	{
		var searchText = getTextSelection(_Context);

		var domain = "co.uk";
		var knownLanguage = true;
		var lang = _Context.getAttribute("lang").toLowerCase();

		switch(lang)
		{
			case "en-us":
				domain = "com";
				break;
			case "en-gb":
				domain = "co.uk";
				break;
			case "de-de":
				domain = "de";
				break;
			case "fr-fr":
				domain = "fr";
				break;
			case "es-es":
				domain = "es";
				break;
			case "it-it":
				domain = "it";
				break;
			default:
				knownLanguage = false;
				break;
		}

		if(knownLanguage)
		{
			var url = "http://www.google." + domain + "/search?q=define:" + escape(searchText) + "&meta=lr%3Dlang_" + lang;
			window.open(url);
		}
		else
		{
			//alert("Sorry, but Google definitions are not available for this language.");
			alert(SmartReviewContextMenu_GoogleDefinitionNotAvailable);
		}
		
		hideMenu();
	}

	function getTextSelection(o)
	{
		var returnValue = "";

		if(ie)
		{
			returnValue = document.selection.createRange().text;

			if(returnValue == "" && o.value)
			{
				returnValue = o.value;
			}
			else if(returnValue == "")
			{
				returnValue = o.innerHTML;
			}
		}
		else
		{
			if(o.value)
			{
				if(o.selectionStart == o.value.length || (o.selectionStart - o.selectionEnd) == 0)
				{
					returnValue = o.value;
				}
				else
				{
					returnValue = o.value.substring(o.selectionStart, o.selectionEnd);
				}
			}
			else
			{
				if(_SelectedText.toString() != "")
				{
					returnValue = _SelectedText;
				}
				else
				{
					returnValue = o.innerHTML;
				}
			}
		}

		return trim(returnValue.toString());
	}

	// lifted from quirksmode.org - thanks!
	function storeSelectedText(e)
	{
		if (window.getSelection)
		{
			_SelectedText = window.getSelection();
		}
		else if (document.getSelection)
		{
			_SelectedText = document.getSelection();
		}
		else if (document.selection)
		{
			_SelectedText = document.selection.createRange().text;
		}
		
		return false;
	}


	// Clipboard functions below...
	function copyToClipboard(copyText) 
	{
		if(window.clipboardData) 
		{ 
			// IE send-to-clipboard method.
			try
			{
				window.clipboardData.setData("Text", copyText);
			}
			catch(ex)
			{
				//alert("Unable to access the clipboard.");
				alert(SmartReviewContextMenu_UnableToAccessTheClipboard_IE);
			}
		} 
		else if (window.netscape) 
		{
			// You have to sign the code to enable this or allow the action in about:config by changing user_pref("signed.applets.codebase_principal_support", true);
			try
			{
				netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');   
			}
			catch(ex)
			{	
				alert(SmartReviewContextMenu_UnableToAccessFeature_Mozilla);
				//alert("Sorry, but when using a Mozilla or Netscape browser, this feature requires you to allow UniversalXPConnect privileges.");
				alert(SmartReviewContextMenu_PleaseSeeUserGuide);
				//alert("Please see the user guide for more details.");
			}
			
			// Store support string in an object.
			var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
			if (!str) return false;
			str.data=copyText;
			
			// Make transferable.
			var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
			if (!trans) return false;
			
			// Specify what datatypes we want to obtain, which is text in this case.
			trans.addDataFlavor("text/unicode");
			trans.setTransferData("text/unicode",str,copyText.length*2);
			
			var clipid=Components.interfaces.nsIClipboard;
			var clip = Components.classes["@mozilla.org/widget/clipboard;1"].getService(clipid);
			if (!clip) return false;
			
			clip.setData(trans,null,clipid.kGlobalClipboard);
		}

		hideMenu();
	}

	function pasteFromClipboard() 
	{
		if(window.clipboardData) 
		{ 
			// IE send-to-clipboard method.
			return window.clipboardData.getData('Text');
		} 
		else if (window.netscape) 
		{
			// You have to sign the code to enable this or allow the action in about:config by changing user_pref("signed.applets.codebase_principal_support", true);
			try
			{
				netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');   
			}
			catch(ex)
			{	
				alert(SmartReviewContextMenu_UnableToAccessFeature_Mozilla);
				//alert("Sorry, but when using a Mozilla or Netscape browser, this feature requires you to allow UniversalXPConnect privileges.");
				alert(SmartReviewContextMenu_PleaseSeeUserGuide);
				//alert("Please see the user guide for more details.");
			}
	   
			var transferableCID  = '@mozilla.org/widget/transferable;1';
			var transferableIID  = Components.interfaces.nsITransferable; 
		   
			var clipCID          = '@mozilla.org/widget/clipboard;1';
			var clipIID          = Components.interfaces.nsIClipboard; 
			var gClip            = Components.classes[clipCID].getService(clipIID); 
			  
			var supportstrCID    = '@mozilla.org/supports-string;1';
			var supportstrIID    = Components.interfaces.nsISupportsString; 
			  
			// have to do it manually here...
			var trans = Components.classes[transferableCID].createInstance(transferableIID);
			trans.addDataFlavor('text/unicode');
			gClip.getData(trans, gClip.kGlobalClipboard);
			var str   = new String();
			var len   = new Number();
			trans.getTransferData('text/unicode', str, len);
			str      = str.value.QueryInterface(supportstrIID);
			str      = str.data.substring(0, len.value / 2);

			return str;
		}

		hideMenu();
	} 

	function getTargetLanguage()
	{
		var oArray = document.getElementsByTagName("textarea");
		for(var i = 0; i < oArray.length; i ++)
		{
			if(oArray[i].className == "CTagEdit")
			{
				return oArray[i].getAttribute("lang");
			}
		}
	}

	function getSourceLanguage()
	{
		var oArray = document.getElementsByTagName("td");
		for(var i = 0; i < oArray.length; i ++)
		{
			if(oArray[i].className == "CSourceText")
			{
				return oArray[i].getAttribute("lang");
			}
		}
	}

	function machineTranslate()
	{
		// Decide whether to show the link as enabled or disabled
		// var canUse = canCheckSpelling(_Context.getAttribute("lang"));	
		var index = _Context.id.substr(2);
		var sourceLanguage = getSourceLanguage().substr(0,2).toLowerCase();
		var targetLanguage = _Context.getAttribute("lang").substr(0,2).toLowerCase();
		var text = _Context.value;

		//alert(sourceLanguage);
		//alert(targetLanguage);

		getTranslation(index, sourceLanguage, targetLanguage, text, false);

		hideMenu();
	}

	function completeMachineTranslation(index, translation)
	{
		// alert("Translation: " + translation);
		document.getElementById("tu" + index.toString()).value = translation;
		// From SmartReviewPageFunctions.js
		setTranslationUnitDirty(index);
	}
	
	function searchTerminology()
	{
		var selectedText = getTextSelection(_Context);
		var lang = _Context.getAttribute("lang").toLowerCase();

		// See SmartReviewPageFunctions.js
		toggleTermSearch(selectedText, lang);
	
		hideMenu();
	}

	function getSourceAndTarget()
	{
		var tableRow = null;
	
		if(_Context.className == "CSourceText")
		{
			// It's the source text
			tableRow = _Context.parentNode;
		}
		else
		{
			// It's the translation unit
			tableRow = _Context.parentNode.parentNode;
		}
		
		var sourceText = tableRow.cells[2].innerHTML;
		var targetText = tableRow.cells[3].getElementsByTagName("textarea")[0].value;
		
		return new Array(sourceText, targetText);
	}

	function addNewTerm() 
	{
	    var selectedText = getTextSelection(_Context);
	    var sourceAndTargetContext = getSourceAndTarget();

	    // The language of the currently selected text
	    var termLanguage = _Context.getAttribute("lang").toLowerCase();

	    var source = getSourceLanguage();
	    var target = getTargetLanguage();

	    // The translation language should be the opposite of
	    // the current context
	    var translationLanguage = (termLanguage.toLowerCase() == source.toLowerCase()) ? target : source;
	    var termContext = (termLanguage.toLowerCase() == source.toLowerCase()) ? sourceAndTargetContext[0] : sourceAndTargetContext[1];
	    var translationContext = (termLanguage.toLowerCase() == source.toLowerCase()) ? sourceAndTargetContext[1] : sourceAndTargetContext[0];

	    toggleAddNewTerm(selectedText, termLanguage, translationLanguage, termContext, translationContext);

	    hideMenu();
	}

	function searchTranslationMemory()
	{
		var selectedText = getTextSelection(_Context);
		var lang = _Context.getAttribute("lang").toLowerCase();

		// See SmartReviewPageFunctions.js
		toggleTranslationMemorySearch(selectedText, lang);

		hideMenu();
	}
	var replaceFix = true;
	function getPerformingFindAndReplace()
	{
	    var performingFindAndReplaceElement = document.getElementById("ctl00_phContent_PerformingFindAndReplace");
	    
	    if(performingFindAndReplaceElement != null)
	    {
		    return performingFindAndReplaceElement.value == 1;
		}
		else
		{
			return false;
		}
	}

	function setPerformingFindAndReplace(bVal)
	{
		if(bVal)
		{
			document.getElementById("ctl00_phContent_PerformingFindAndReplace").value = 1;
		}
		else
		{
			document.getElementById("ctl00_phContent_PerformingFindAndReplace").value = 0;
		}
	}

	function toggleFindAndReplaceVisibility(performingObject)
	{
		var o = document.getElementById("FindAndReplace");
		if(o.style.visibility == "visible")
		{
			// Reset the search facilities
			_LastSearchText = "";
			_LastTuIndex = -1;

			setPerformingFindAndReplace(false);

			o.style.visibility = "hidden";
		}
		else
		{
			o.style.visibility = "visible";
			
			o.style.left = findPosX(performingObject) + "px";
			o.style.top = findPosY(performingObject) + performingObject.offsetHeight + 5 + "px";

			setPerformingFindAndReplace(true);
		}
	}

	var _LastSearchText = "";
	var _LastTuIndex = -1;
	var _LastChar = 0;

	function findNext()
	{
		var toFind = document.getElementById("ctl00_phContent_txtToFind").value;
		var caseSensitive = document.getElementById("ctl00_phContent_chkCaseSensitive").checked;

		if(_LastSearchText != toFind)
		{
			_LastSearchText = toFind;
			_LastTuIndex = -1;
		}

		var oTextareas = document.getElementsByTagName("textarea");

		// Perform the replace
		var regexpModifiers = "";
		if(!caseSensitive)
		{
			regexpModifiers += "i";
		}

		var oRegExp = new RegExp(toFind, regexpModifiers);
		oRegExp.global = true;

		var iCurrentTuIndex = -1;

		for(var i = 0; i < oTextareas.length; i ++)
		{
			if(oTextareas[i].id.indexOf("tu") == 0)
			{
				iCurrentTuIndex ++;

				// If we've not finished replacing in the last unit we were working on
				if((iCurrentTuIndex == _LastTuIndex && _LastChar > 0) || (iCurrentTuIndex > _LastTuIndex))
				{
					var isMatch = oTextareas[i].value.substring(_LastChar).match(oRegExp); 

					if(isMatch)
					{
						var result = oRegExp.exec(oTextareas[i].value.substring(_LastChar));

						// For each result, set the selection in the textarea.
						setTextSelection(oTextareas[i], result.index + _LastChar, toFind.length);

						// Fill in the temporary values so that we don't have to much about
						// finding what we've just selected in the textbox
						_FindAndReplaceStartIndex = result.index + _LastChar;
						_FindAndReplaceLength = toFind.length;

						_LastTuIndex = iCurrentTuIndex;
						_LastChar = result.index + toFind.length + _LastChar;

						// Scroll the screen to the correct point
						window.scroll(findPosX(oTextareas[i]), findPosY(oTextareas[i]) - 20);

						// Move the "Find / Replace" controls there too!
						document.getElementById("FindAndReplace").style.left = findPosX(oTextareas[i]) - 320 + "px";
						document.getElementById("FindAndReplace").style.top = findPosY(oTextareas[i]) + "px";

						// Enable the replace button
						var replaceButton = document.getElementById("ctl00_phContent_btnReplace");
						replaceButton.disabled = false;
													
						if(replaceButton.addEventListener && replaceFix)
						{
							// For Mozilla type browsers
							replaceButton.addEventListener("click", replace, true);	
							replaceFix = false;	
						}
						else if(replaceButton.attachEvent && replaceFix)
						{
							// For IE
							replaceButton.attachEvent("onclick", replace);	
							replaceFix = false;	
						}						
							
						return;
					}
					else
					{
						//TODO: Clear the textarea selection for safety.
						
						// Enable the replace button
						document.getElementById("ctl00_phContent_btnReplace").disabled = true;
						// Set the last char index to 0
						_LastChar = 0;
					}
				}
			}
		}

		// We didn't find anything
		if(_LastTuIndex == -1)
		{
			alert(SmartReviewFindAndReplace_PhraseNotFound);
			//alert("The phrase was not found on this page.");
		}

		// If we're not at the end of the file
		if(document.getElementById("ctl00_phContent_custom_Next").disabled == false)
		{
			// Check to see if we should go to the next page
			//var carryOn = confirm("End of page reached. Save and continue to next page?");
			var carryOn = confirm(SmartReviewFindAndReplace_EndOfPage);
			debugger;
			if(carryOn)
			{
				moveNext();
			}
		}
		else
		{
			//var carryOn = confirm("End of document reached.  Save and search from the beginning of the document?");
			var carryOn = confirm(SmartReviewFindAndReplace_EndOfDocument);
			if(carryOn)
			{
				getAspNetElementById("ddlPage").selectedIndex = 0;
				__doPostBack('ddlPage','')
			}
		}
	}

	function replace()
	{
		var toFind = document.getElementById("ctl00_phContent_txtToFind").value;
		var toReplace = document.getElementById("ctl00_phContent_txtToReplace").value;
		var caseSensitive = document.getElementById("ctl00_phContent_chkCaseSensitive").checked;

		var oTextareas = document.getElementsByTagName("textarea");

		var iCurrentTuIndex = -1;

		for(var i = 0; i < oTextareas.length; i ++)
		{
			if(oTextareas[i].id.indexOf("tu") == 0)
			{
				iCurrentTuIndex ++;

				if(iCurrentTuIndex == _LastTuIndex)
				{
					// Perform the replace
					var newValue = oTextareas[i].value.substring(0, _FindAndReplaceStartIndex);
					newValue += toReplace;
					newValue += oTextareas[i].value.substring(_FindAndReplaceStartIndex + _FindAndReplaceLength);

					//var newValue = oTextareas[i].value.substring(0, oTextareas[i].selectionStart);
					//newValue += toReplace;
					//newValue += oTextareas[i].value.substring(oTextareas[i].selectionEnd);
					
					oTextareas[i].value = newValue;

					// Get the actual translation unit index, not the current textbox on the page
					var tuIndex = oTextareas[i].id.substring(2);

					// Mark the unit as changed
					translationUnitChanged(tuIndex);
				}
			}
		}

		findNext();
	}

	var _FindAndReplaceStartIndex;
	var _FindAndReplaceLength;

	function setTextSelection(textarea, startIndex, length)
	{
		if(ie)
		{
			// Curse you - Internet explorer!
			textarea.focus();
			var textRange = textarea.createTextRange();
			textRange.moveStart("character", startIndex);
			var charsFromEnd = textarea.value.length - (startIndex + length);
			textRange.moveEnd("character", charsFromEnd * -1);
			textRange.select();
		}
		else
		{
			textarea.selectionStart = startIndex;
			textarea.selectionEnd = startIndex + length;
		}
	}
	var __selectedObject;

	function DraggableObject()
	{
		// This defines the draggable layer class.

		// Flags up Netscape browser
		this.isNetscape = (document.all) ? 0 : 1;
		
		// Sets the object to move around
		this.objectToMove;

		// Flags whether the object has mouse focus
		this.isMouseOver = false;
		this.isMouseDown = false;

		//Temporarily stores the last X and Y positions of the layer
		this.X = 0;
		this.Y = 0;
	}

	function DraggableLayer_mouseDown(e) 
	{
		if(__selectedObject.isMouseOver)
		{
			__selectedObject.isMouseDown = true;

			if(__selectedObject.isNetscape) 
			{
				__selectedObject.X = e.layerX;
				__selectedObject.Y = e.layerY;
			}
			else 
			{
				__selectedObject.X = event.offsetX;
				__selectedObject.Y = event.offsetY;
			}
		}
	}

	function DraggableLayer_mouseMove(e) 
	{
		if(__selectedObject.isMouseDown)
		{
			if(__selectedObject.isNetscape) 
			{
				__selectedObject.objectToMove.style.top = (e.pageY - __selectedObject.Y) + "px";
				__selectedObject.objectToMove.style.left = (e.pageX - __selectedObject.X) + "px";

				e.returnValue = false;

				return false;
			}
			else 
			{
				__selectedObject.objectToMove.style.pixelLeft = event.clientX - __selectedObject.X + document.body.scrollLeft;
				__selectedObject.objectToMove.style.pixelTop = event.clientY - __selectedObject.Y + document.body.scrollTop;

				hideCoveredDropDownLists(__selectedObject.objectToMove);

				return false;
			}
		}
	}

	function DraggableLayer_mouseUp(e)
	{
		//TODO: Hide overlapping select boxes
		__selectedObject.isMouseDown = false;
	}

	function setObjectDraggable(movableObjectClass, movableObject, isMouseOver)
	{
		__selectedObject = movableObjectClass;
		__selectedObject.objectToMove = movableObject;
		__selectedObject.isMouseOver = isMouseOver;
	}


	function isHiding(parentObject, childObject)
	{
		var x = findPosX(parentObject);
		var y = findPosY(parentObject);
		var width = parentObject.offsetWidth;
		var height = parentObject.offsetHeight;

		var childX = findPosX(childObject);
		var childY = findPosY(childObject);
		var childWidth = childObject.offsetWidth;
		var childHeight = childObject.offsetHeight;

		// If the child X is in the right X axis area
		var inXArea = (childX >= x && childX <= x + width);
		var inYArea = (childY >= y && childY <= y + height);
		
		var widthClashes = (childX + childWidth) > x;
		var heightClashes = (childY + childHeight) > y;
		
		var clash = false;
		
		if(inXArea && inYArea)
		{
			clash = true;
		}
		
		if(widthClashes && heightClashes)
		{
			clash = true;
		}
		
		return clash;
	}

	function hideCoveredDropDownLists(coveringObject)
	{
		var oDropDownLists = document.getElementsByTagName("select");
		
		for(var i = 0; i < oDropDownLists.length; i ++)
		{
			if(isHiding(coveringObject, oDropDownLists[i]))
			{
				oDropDownLists[i].style.visibility = "hidden";
			}
			else
			{
				oDropDownLists[i].style.visibility = "visible";
			}
		}
	}

	// http://www.xs4all.nl/~ppk/js/findpos.html

	function findPosX(obj)
	{
		var curleft = 0;
		if (obj.offsetParent)
		{
			while (obj.offsetParent)
			{
				curleft += obj.offsetLeft
				obj = obj.offsetParent;
			}
		}
		else if (obj.x)
			curleft += obj.x;
		return curleft;
	}

	function findPosY(obj)
	{
		var curtop = 0;
		if (obj.offsetParent)
		{
			while (obj.offsetParent)
			{
				curtop += obj.offsetTop
				obj = obj.offsetParent;
			}
		}
		else if (obj.y)
			curtop += obj.y;
		return curtop;
	}

	/****************************************/
	// This section is for each object that you want to move about


	// Define classes for all movable objects
	var oFindAndReplaceDialog = new DraggableObject();

	// Set the selected object
	__selectedObject = oFindAndReplaceDialog;

	/****************************************/
	// Finally, we need to use the IE / Netscape events
	// to drag stuff around
	document.onmousedown = DraggableLayer_mouseDown;
	document.onmousemove = DraggableLayer_mouseMove;
	document.onmouseup = DraggableLayer_mouseUp;

	var xmlHttpRequests = new Array(1);

	function spellCheck(tuIndex)
	{
		var targetLanguage = getTargetLanguage();

		if (targetLanguage.toLowerCase() == "es-em") 
		{
			targetLanguage = "es-es";
		}

		if (targetLanguage.toLowerCase() == "cs" || targetLanguage.toLowerCase() == "cz-cs") 
		{
		    targetLanguage = "cs-cz";
		}
		
		if(targetLanguage.toLowerCase() == "ja")
		{
			targetLanguage = "ja-jp";
		}
		
		if(targetLanguage.toLowerCase() == "pl")
		{
			targetLanguage = "pl-pl";
		}

		if (targetLanguage.toLowerCase() == "el") 
		{
		    targetLanguage = "el-gr";
		}

		if (targetLanguage.toLowerCase() == "da") 
		{
		    targetLanguage = "da-dk";
		}

		if (targetLanguage.toLowerCase() == "sl") 
		{
		    targetLanguage = "sl-si";
		}

		if (targetLanguage.toLowerCase() == "fi")
		{
		    targetLanguage = "fi-fi";
		}

		if (targetLanguage.toLowerCase() == "sk")
		{
		    targetLanguage = "sk-sk";
		}

		if (targetLanguage.toLowerCase() == "hu")
		{
		    targetLanguage = "hu-hu";
		}

		if (targetLanguage.toLowerCase() == "tr")
		{
		    targetLanguage = "tr-tr";
		}

		if (targetLanguage.toLowerCase() == "no-no") 
		{
		    targetLanguage = "nn-no";
		}
		
		switch(targetLanguage.toLowerCase())
		{
		    case "cs-cz":
		    case "da-dk":
		    case "de-de":
		    case "el-gr":
		    case "en-gb":
		    case "en-us":
		    case "es-es":
		    case "fi-fi":
		    case "fr-ca":
		    case "fr-fr":
		    case "hu-hu":
		    case "it-it":
		    case "ja-jp":
		    case "nl-nl":
		    case "nn-no":
		    case "pl-pl":
		    case "pt-br":
		    case "pt-pt":
		    case "ru-ru":
		    case "sk-sk":
		    case "sl-si":
		    case "sl-sl":
		    case "sp-es":
		    case "sv-se":
		    case "tr-tr":
		    case "zh-cn":
		    case "zh-tw":	
				var text = eval("document.forms[0].tu" + tuIndex + ".value");
				
				var spellcheckTextarea = "tu" + tuIndex + "SpellCheck";
				document.getElementById(spellcheckTextarea + "Results").innerHTML = "<img src=\"Images/Working.gif\" alt=\"Working...\">";
				document.getElementById(spellcheckTextarea).className = "CSpellCheck";
				
				var oSpellCheck = new SpellCheckService();
				oSpellCheck.spellCheck(tuIndex, targetLanguage, text);			
			break;
			
			default:	
				//alert("Sorry, but no dictionary is available for this language.");
				alert(SmartReviewSpellCheck_DictionaryNotAvailable);
			break;
		}
	}

	function SpellCheckService(tuIndex)
	{
		this.tuIndex = tuIndex;
		xmlHttpRequests[tuIndex] = getXmlHttp();
		this.spellCheck = spellCheckInternal;
	}

	function getDomain()
	{
		var l = document.location.href;
		
		var protocol = l.substring(0, l.indexOf("://")).toLowerCase();
		var domain = l.substring(l.indexOf("//") + 2);
		
		if(protocol == "file")
		{
			domain = domain.substring(0, domain.lastIndexOf("/"))
		}
		else
		{
			domain = protocol + "://" + domain.substring(0, domain.indexOf("/"))
		}

		return domain;
	}

	function spellCheckInternal(reference, languageCode, toCheck)
	{
		var xml = "<" + "?xml version=\"1.0\" encoding=\"utf-8\"?>\n";	
		xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n";
		xml += "	<soap:Body>\n";
		xml += "		<CheckSpelling xmlns=\"http://tempuri.org/\">\n";
		xml += "			<languageCode>" + escape(languageCode) + "</languageCode>\n";
		xml += "			<toCheck>" + toCheck.replace("<", "&lt;", "g").replace(">", "&gt;", "g").replace("&", "&#38;", "g") + "</toCheck>\n";
		xml += "			<reference>" + escape(reference) + "</reference>\n";
		xml += "		</CheckSpelling>\n";
		xml += "	</soap:Body>\n";
		xml += "</soap:Envelope>\n";
		
		// Set up the 
		// xmlHttp object
		if(xmlHttpRequests[this.tuIndex])
		{		
			xmlHttpRequests[this.tuIndex].onreadystatechange = xmlHttpStateChange;

			try
			{
				xmlHttpRequests[this.tuIndex].open("POST", getDomain() + "/SpellCheck/SpellCheck.asmx", true);
				xmlHttpRequests[this.tuIndex].setRequestHeader("SOAPAction", "http://tempuri.org/CheckSpelling");
				xmlHttpRequests[this.tuIndex].setRequestHeader("Content-Type", "text/xml; charset=utf-8");
				xmlHttpRequests[this.tuIndex].send(xml);
			}
			catch(e)
			{
				//alert("An error occurred whilst attempting to contact thebigword: " + e);
				alert(SmartReviewSpellCheck_ErrorContactingSpellCheckService.replace("{0}", e));
			}
		}
		else
		{
			//TODO: Some sort of warning.	
		}
		
		// If we're still null, display an error message
		if(xmlHttpRequests[this.tuIndex] == null)
		{
			//alert("Cannot intiailise xmlHttp.");
			alert(SmartReviewSpellCheck_CannotInitialiseXmlHttp);
		}	
	}

	function getXmlHttp()
	{
		if(window.XMLHttpRequest) 
		{
			try 
			{
				return new XMLHttpRequest();
			} 
			catch(e) 
			{
				return false;
			}
		// branch for IE/Windows ActiveX version
		} 
		else if(window.ActiveXObject) 
		{
			try 
			{
				return new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch(e) 
			{
				try 
				{
					return new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch(e) 
				{
					return false;
				}
			}
		}
	}
	
	// This function cannot be called outside of the class above
	function xmlHttpStateChange()
	{
		if(xmlHttpRequests[this.tuIndex].readyState == 4) 
		{
			// only if "OK"
			if (xmlHttpRequests[this.tuIndex].status == 200)
			{
				// Parse the returned xml in order to find out the operation which was performed and whether it was successful
				var index = getXmlValue(xmlHttpRequests[this.tuIndex].responseText, "Reference");				
				var spellCheckText = getXmlValue(xmlHttpRequests[this.tuIndex].responseText, "Result");
				
				spellCheckSuccessful(index, spellCheckText);
			}
			else
			{
				if (xmlHttpRequests[this.tuIndex].status == 0)
				{
					// Swallow this status.
				}			
				else 
				{
					//alert("There was a problem accessing the spell checker service:\n" + xmlHttpRequests[this.tuIndex].status + " - " + xmlHttpRequests[this.tuIndex].statusText);
					alert(SmartReviewSpellCheck_ErrorContactingSpellCheckService + "\n" + xmlHttpRequests[this.tuIndex].status + " - " + xmlHttpRequests[this.tuIndex].statusText);
					// alert(xmlHttpRequests[this.tuIndex].responseText);
				}
			}
		}
	}
	
	function spellCheckSuccessful(index, spellCheckText)
	{
		//alert("Spell Check Index: " + index);
		//alert("Spell Check Text: " + spellCheckText);
		
		var spellcheckTextarea = "tu" + index + "SpellCheck";

		var gtRegexp = new RegExp("&gt;", "g");
		var ltRegexp = new RegExp("&lt;", "g");
		var ampRegexp = new RegExp("&amp;", "g");
		
		spellCheckText = spellCheckText.replace(gtRegexp, ">");
		spellCheckText = spellCheckText.replace(ltRegexp, "<");
		spellCheckText = spellCheckText.replace(ampRegexp, "&");
		
		document.getElementById(spellcheckTextarea + "Results").innerHTML = spellCheckText;
		document.getElementById(spellcheckTextarea).className = "CSpellCheck";
	}

	// A basic Xml parsing function
	function getXmlValue(xml, tagName)
	{
		var regularExpression = "<(" + tagName + ")>(.*?)</" + tagName + ">";
		var regexp = new RegExp(regularExpression);
		
		// 1 returns the tag name
		if(regexp.test(xml))
		{
			return(regexp.exec(xml)[2]);
		}
		else
		{
			return null;
		}
}
	/* 	
	
		SmartReview(tm) Web Edition
		Adrian Hesketh
		www.thebigword.com
		Copyright 2006 thebigword
		
	*/

	var OPEN_SR_TAG = "{#";
	var CLOSE_SR_TAG = "}";
	
	var TAG = "\\" + OPEN_SR_TAG + "((\\d+)[ab]?)\\" + CLOSE_SR_TAG;
	var UNTRANSLATABLE_TAG = OPEN_SR_TAG + "\\d+" + CLOSE_SR_TAG;
	var INTERNAL_TAG = OPEN_SR_TAG + "(\\d+)[ab]" + CLOSE_SR_TAG;
	var OPEN_TAG = new RegExp("\\" + OPEN_SR_TAG + "(\\d+)[a]\\" + CLOSE_SR_TAG);
	var CLOSE_TAG = new RegExp("\\" + OPEN_SR_TAG + "(\\d+)[b]\\" + CLOSE_SR_TAG);

	// This variable stores how many translation units are dirty on the page.
	// When this is not 0, the Save button has an asterix next to it
	var dirtyTranslationUnits = 0;

	// The variable used to test whether an Internet connection is available
	// the value if 0 for unknown, 1 for true and -1 for error status
	var internetConnectionStatus = 0;
	
	function getInternetExplorerVersion()
	{
		var rv = -1;
		if(navigator.appName == "Microsoft Internet Explorer")
		{
			var ua = navigator.userAgent;
			var re  = new RegExp("MSIE ([0-9]{1,}[\\.0-9]{0,})");

			if(re.exec(ua) != null)
			{
				rv = parseFloat(RegExp.$1);
			}
		}
		
		return rv;
	}

	function checkBrowserVersion()
	{
		var ieVersion = getInternetExplorerVersion();

		if(ieVersion > -1)
		{
			if(ieVersion < 6.0) 
			{
				//alert("This version of Internet Explorer is not compatible with SmartReview and is not safe.\nYou should upgrade your copy of Internet Explorer immediately.\n");
				alert(SmartReviewPageFunctions_OldIEVersion);
				document.location.href = "JavaScriptDisabled.aspx";
				return false;
			}
		}

		return true;
	}

	function smartReviewPageLoad()
	{
		checkBrowserVersion();

		// Set up the initial values of some form based elements
		itemsPerPage_WasDisabled = isDisabled("ctl00_phContent_itemsPerPage");
		previousButton_WasDisabled = isDisabled("ctl00_phContent_btnPrevious");
		nextButton_WasDisabled = isDisabled("ctl00_phContent_btnNext");
		saveButton_WasDisabled = isDisabled("ctl00_phContent_btnSave");

		findNextNon100_WasDisabled = isDisabled("ctl00_phContent_btnFindNextNon100");
		findNextNonMatchComparison_WasDisabled = isDisabled("ctl00_phContent_btnFindNextNonMatchComparison");

		setFileReviewedButton_WasDisabled = isDisabled("ctl00_phContent_btnComplete");

		if(findNextNon100_WasDisabled)
		{
			setDisabled("ctl00_phContent_btnFindNextNon100", true);
		}
		
		if(findNextNonMatchComparison_WasDisabled)
		{
			setDisabled("ctl00_phContent_btnFindNextNonMatchComparison", true);
		}

		if(saveButton_WasDisabled)
		{
			setDisabled("ctl00_phContent_custom_Save", true);
		}

		if(previousButton_WasDisabled)
		{
			setDisabled("ctl00_phContent_custom_Previous", true);
		}

		if(nextButton_WasDisabled)
		{
			setDisabled("ctl00_phContent_custom_Next", true);
		}

		// Setup the keypress event handlers to disable invalid keys
		setKeyPressEventHandlers();

		startInternetConnectionCheck();
		setupContextMenu();

		// Check that the textareas aren't small - this is only a problem within Mozilla type
		// browsers within files with a lot of tags
		checkTextareaSizes();

		// If we're in the middle of a find and replace, make sure that we show the find and replace
		if(getPerformingFindAndReplace())
		{
			document.getElementById("FindAndReplace").style.visibility = "visible";
			findNext();
		}
	}
	
	function onSliderChanged(sliderID, sliderValue)
	{
		var targetID = "SourceText";
		
		if(sliderID == "ctl1")
		{
			if(getAspNetElementById("ComparisonText") == null)
			{
				targetID = "TargetText";
			}
			else
			{
				targetID = "ComparisonText";
			}
		}
		
		if(sliderID == "ctl2")
		{
			targetID = "TargetText";
		}

		getAspNetElementById(targetID).style.width = sliderValue + "%";
		alert(sliderID + "Bar");
		getAspNetElementById(sliderID + "Bar").style.position = "relative";
		getAspNetElementById(sliderID + "Bar").style.left = sliderValue + "px";
	}
	
	function checkTextareaSizes()
	{
		for(var i = 0; i < document.getElementsByTagName("textarea").length; i ++)
		{
			var o = document.getElementsByTagName("textarea")[i];
			
			if(o.offsetWidth < 300)
			{
				o.style.width = 400 + "px";
			}
			
			if(o.offsetHeight < 30)
			{
				o.style.height = 30 + "px";
			}
		}
	}

	// Sets up the keypress event handlers to disable invalid keys, such as
	// the enter key.
	function setKeyPressEventHandlers()
	{
		var elements = document.getElementsByTagName("textarea");
		for(var i = 0; i < elements.length; i ++)
		{
			var o = elements[i];

			if(o.addEventListener)
			{
				// For Mozilla type browsers
				o.addEventListener("keypress", disableInvalidCharacters, true);		
			}
			else if(o.attachEvent)
			{
				// For IE
				o.attachEvent("onkeypress", disableInvalidCharacters);		
			}
			else
			{
				//alert("Your browser does not support removing invalid characters.\n\nPlease do not insert any line breaks within the translation units.");
				alert(SmartReviewPageFunctions_BrowserCannotRemoveInvalid);
			}
		}
	}

	var warnedAboutInvalidCharacters = 0;

	function disableInvalidCharacters(event)
	{
		event = event || window.event;

		if(event.keyCode == 13) 
		{
			// IE 5.0 doesn't allow preventDefault
			if(event.preventDefault) { event.preventDefault(); };
			event.returnValue = false;
			event.cancel = true;

			if(warnedAboutInvalidCharacters == 0)
			{
				//alert("You are not permitted to place line breaks into a translation unit.");
				alert(SmartReviewPageFunctions_LineBreaksNotPermitted);
				warnedAboutInvalidCharacters ++;
			}

			return false;
		}

		return true;
	}

	// These functions work out whether the user has a valid Internet connection
	function startInternetConnectionCheck()
	{
		checkInternetConnection();
		window.setTimeout("startInternetConnectionCheck()", 15000);
	}

	function checkInternetConnection()
	{
		var img = new Image();
		img.onerror = internetConnectionError;
		img.onload = internetConnectionOK;
		img.onabort = internetConnectionError;

		img.src = "KeepSessionAlive.aspx";
	}
	
	function internetConnectionError(e)
	{
		//alert("Sorry, but you do not have a valid Internet connection.  Therefore, you cannot save any edits.");		
		alert(SmartReviewPageFunctions_NoInternetConnection);
		setInternetConnection(-1);
	}
	
	function internetConnectionOK(e)
	{
		setInternetConnection(1);
	}
	
	function setInternetConnection(value)
	{
		internetConnectionStatus = value;
	}
	// End of Internet Connection status functions
	
	function translationUnitChanged(tuIndex)
	{
		var original = eval("document.forms[0].tu" + tuIndex + "OriginalValue.value");
		var edit = eval("document.forms[0].tu" + tuIndex + ".value");
	
		original = trimBreaks(original);
		edit = trimBreaks(edit);

		if(original == edit)
		{
			setTranslationUnitClean(tuIndex);
			checkTags(tuIndex);
		}
		else
		{
			setTranslationUnitDirty(tuIndex);
			checkTags(tuIndex);
		}
		
		if(eval("document.forms[0].tu" + tuIndex + "CompareValue") != null && document.getElementById("tu" + tuIndex + "Approve") != null)
		{
			var comparison = eval("document.forms[0].tu" + tuIndex + "CompareValue.value");
			if(trimBreaks(comparison) == edit)
			{
				document.getElementById("tu" + tuIndex + "Approve").className = "CHide";
			}
			else
			{
				document.getElementById("tu" + tuIndex + "Approve").className = "CShow";
			}
		}
	}
	
	function trimBreaks(stringInput)
	{
		return stringInput.replace(/^\n*|\n*$/g, "");
	}

	function trim(stringInput)
	{
		return stringInput.replace(/^\s*|\s*$/g, "");

		// Rubbish version for old browsers below.
		// Doesn't support line break removal.

		/*
		while(stringInput.substring(0, 1) == " ")
		{
			stringInput = stringInput.substring(1, stringInput.length);
		}

		while(stringInput.substring(stringInput.length - 1, stringInput.length) == " ")
		{
			stringInput = stringInput.substring(0, stringInput.length - 1);
		}

		return stringInput;
		*/
	}

	function setSaveText()
	{
		var objSave = document.getElementById("ctl00_phContent_btnSave", "input");
		var objCustomSave = document.getElementById("ctl00_phContent_custom_Save", "input");
		
		if(dirtyTranslationUnits > 0)
		{
			if (objSave != null)
			{
				objSave.value = objSave.value.replace(" *", "") + " *";
			}
			
			if (objCustomSave != null)
			{
				objCustomSave.value = objSave.value;
			}
		}
		else
		{
			if (objSave != null)
			{
				objSave.value = objSave.value.replace(" *", "");
			}
			
			if (objCustomSave != null)
			{
				objCustomSave.value = objSave.value;
			}
		}
	}
	
	function setTranslationUnitDirty(tuIndex)
	{
		eval("document.forms[0].tu" + tuIndex + "Dirty.value = true;");
		eval("document.forms[0].tu" + tuIndex + ".style.fontStyle = 'italic';");
		enableRevert(tuIndex);
		
		dirtyTranslationUnits ++;

		setSaveText();
	}
	
	function setTranslationUnitClean(tuIndex)
	{
		eval("document.forms[0].tu" + tuIndex + "Dirty.value = false;");
		eval("document.forms[0].tu" + tuIndex + ".style.fontStyle = 'normal';");
		disableRevert(tuIndex);

		dirtyTranslationUnits --;

		setSaveText();
	}
	
	function countTags(text)
	{
		var exp = new RegExp(TAG, "g");
		exp.global = true;

		var returnValue = 0;
		
		for(var results = exp.exec(text); results != null; results = exp.exec(text))
		{
			returnValue++;
		}

		return returnValue;
	}

	function push(array, objectToPush)
	{
		array[array.length] = objectToPush;	
		return array;
	}

	function compareTags(original, newText, compareTagOrder)
	{
		var tagRegexp = new RegExp(TAG, "g");
		tagRegexp.global = true;

		var originalTags = new Array();
		var newTags = new Array();

		var results;

		for(results = tagRegexp.exec(original); results != null; results = tagRegexp.exec(original))
		{
			var currentTag = results[0];

			// IE 5.0 doesn't push / pop arrays, so we need this...
			try
			{
				originalTags.push(currentTag);
			}
			catch(e)
			{
				originalTags = push(originalTags, currentTag);
			}
		}

		for(results = tagRegexp.exec(newText); results != null; results = tagRegexp.exec(newText))
		{
			var currentTag = results[0];

			// IE 5.0 doesn't push / pop arrays, so we need this...
			try
			{
				newTags.push(currentTag);
			}
			catch(e)
			{
				newTags = push(newTags, currentTag);
			}
		}

		if(!compareTagOrder)
		{
			originalTags.sort();
			newTags.sort();
		}

		if(originalTags.length != newTags.length)
		{
			return false;
		}

		for(var i = 0; i < originalTags.length; i ++)
		{
			if(originalTags[i] != newTags[i])
			{
				return false;
			}
		}

		return true;
	}

	// Check that the internal tags are available for a given translation unit.
	function checkTags(tuIndex)
	{
		var valid = true;

		var text = eval("document.forms[0].tu" + tuIndex + ".value");
				
		var currentInternalTagCount = countTags(text);
		var originalInternalTagCount = eval("document.forms[0].tu" + tuIndex + "InternalTagCount.value;");
	
		var currentInternalTag = 0;	
		
		var tagRegexp = new RegExp(INTERNAL_TAG, "g");
		tagRegexp.global = true;		
		
		if(text.replace(tagRegexp, "").length == 0)
		{	
			//setTooltip(tuIndex, "There is no text in this translation unit.  This is not permitted.");
			setTooltip(tuIndex, SmartReviewPageFunctions_NoTextInTranslationUnit);
			valid = false;
		}

		if(valid && currentInternalTagCount != originalInternalTagCount)
		{
			if(currentInternalTagCount > originalInternalTagCount)
			{
				//setTooltip(tuIndex, "There are more tags in the new text than there are in the original text.");
				setTooltip(tuIndex, SmartReviewPageFunctions_MoreTagsInNewText);
			}
			else
			{
				//setTooltip(tuIndex, "There are more tags in the original text than there are in the new text.");
				setTooltip(tuIndex, SmartReviewPageFunctions_MoreTagsInOriginalText);
			}

			valid = false;
		}
		else if(valid)
		{
			// Checking that a tag exists in the text before attempting to use
			// regular expressions to check the order of the tags results in a massive
			// performance increase
			if(currentInternalTagCount > 0)
			{
				// Check that the order of the tags is correct and ensure that all tags are 
				// properly closed
				for(var results = tagRegexp.exec(text); results != null; results = tagRegexp.exec(text))
				{
					var currentTag = results[0];
					var tagNumber = results[1];

					// At the end, the number of open tags should be 0
					if(OPEN_TAG.test(currentTag))
					{
						// Check that the tag order is correct - that {1b} never comes before {1a}
						var closingTag = OPEN_SR_TAG + tagNumber + "b" + CLOSE_SR_TAG;

						if(text.indexOf(closingTag) == -1)
						{
							//setTooltip(tuIndex, "Tag number " + tagNumber + " does not have a closing tag.");
							var s = SmartReviewPageFunctions_TagNumber_NoClosingTag.replace("{0}", tagNumber);
							setTooltip(tuIndex, s);
							
							valid = false;
							break;
						}

						if(text.indexOf(currentTag) > text.indexOf(closingTag))
						{
							//setTooltip(tuIndex, "Tag number " + tagNumber + " closes before it opens!");
							var t = SmartReviewPageFunctions_TagNumber_ClosesImproperly.replace("{0}", tagNumber);
							setTooltip(tuIndex, t);
							
							valid = false;
							break;
						}
					}
				}
			}

			var originalValue = eval("document.forms[0].tu" + tuIndex + "OriginalValue.value;");

			if(valid && compareTags(originalValue, text, false) == false)
			{
				//setTooltip(tuIndex, "The tag structure is incorrect. A tag exists in the target text which does not exist in the source or vice versa.");
				setTooltip(tuIndex, SmartReviewPageFunctions_IncorrectTagStructure);
				valid = false;
			}
		}

		if(!valid)
		{
			// Disable the save feature and alert the user that they have deleted something by
			// changing the colour.
			eval("document.forms[0].tu" + tuIndex + ".className = 'CTagError';");
			disableSave(tuIndex);
		}
		else
		{
			// Set the colour to be standard
			eval("document.forms[0].tu" + tuIndex + ".className = 'CTagEdit';");
			setTooltip(tuIndex, "");
			enableSave(tuIndex);
		}
	}
	
	function setTooltip(tuIndex, tooltip)
	{
		eval("document.forms[0].tu" + tuIndex + ".title = '" + tooltip + "';");
		window.status = tooltip;
	}

	// Enable and disable the save functionality for a given translation unit.
	function enableSave(tuIndex)
	{
		// Enable the previous / next buttons etc.
		if(!pageHasErrors())
		{
			setDisabled("ctl00_phContent_itemsPerPage", itemsPerPage_WasDisabled);
			setDisabled("ctl00_phContent_btnPrevious", previousButton_WasDisabled);
			setDisabled("ctl00_phContent_btnNext", nextButton_WasDisabled);
			setDisabled("ctl00_phContent_btnSave", saveButton_WasDisabled)
			setDisabled("ctl00_phContent_btnComplete", setFileReviewedButton_WasDisabled);
			setDisabled("ctl00_phContent_btnFindNextNon100", findNextNon100_WasDisabled);
			setDisabled("ctl00_phContent_btnFindNextNonMatchComparison", findNextNonMatchComparison_WasDisabled);

			// Copying the pager functions to the bottom of the screen too
			setDisabled("ctl00_phContent_custom_Save", saveButton_WasDisabled);
			setDisabled("ctl00_phContent_custom_Previous", previousButton_WasDisabled);
			setDisabled("ctl00_phContent_custom_Next", nextButton_WasDisabled);
		}
	}

	function pageHasErrors()
	{
		for(var i = 0; i < document.getElementsByTagName("textarea").length; i ++)
		{
			var o = document.getElementsByTagName("textarea")[i];

			if(o.className == "CTagError")
			{
				return true;
			}
		}

		return false;
	}

	var itemsPerPage_WasDisabled;
	var previousButton_WasDisabled;
	var nextButton_WasDisabled;
	var saveButton_WasDisabled;
	var setFileReviewedButton_WasDisabled;
	var findNextNon100_WasDisabled;
	var findNextNonMatchComparison_WasDisabled;

	function disableSave(tuIndex)
	{
		// Disable the previous / next buttons etc.

		setDisabled("ctl00_phContent_itemsPerPage", true);
		setDisabled("ctl00_phContent_btnPrevious", true);
		setDisabled("ctl00_phContent_btnNext", true);
		setDisabled("ctl00_phContent_btnSave", true)
		setDisabled("ctl00_phContent_btnComplete", true);
		setDisabled("ctl00_phContent_btnFindNextNon100", true);
		setDisabled("ctl00_phContent_btnFindNextNonMatchComparison", true);		

		// Copying the pager functions to the bottom of the screen too
		setDisabled("ctl00_phContent_custom_Save", true);
		setDisabled("ctl00_phContent_custom_Previous", true);
		setDisabled("ctl00_phContent_custom_Next", true);
	}

	function setDisabled(id, value)
	{
	    var o = document.getElementById(id);
	    
	    if(o != null)
	    {
		    o.disabled = value;
        }
	}

	function isDisabled(id)
	{
	    var o = document.getElementById(id);
	    
	    if(o == null)
	    {
	        return true;
		}
	    else
	    {
			return o.disabled;
		}
	}

	function enableRevert(tuIndex)
	{
		var obj = document.getElementById("tu" + tuIndex + "RevertToOriginal");
		if (obj != null)
		{
			obj.className = "CShow";
		}
	}

	function disableRevert(tuIndex)
	{
		var obj = document.getElementById("tu" + tuIndex + "RevertToOriginal");
		if (obj != null)
		{
			obj.className = "CHide";
		}
	}
	
	function revertToOriginal(tuIndex)
	{
		eval("document.forms[0].tu" + tuIndex).value = eval("document.forms[0].tu" + tuIndex + "OriginalValue").value;
		setTranslationUnitClean(tuIndex);
		checkTags(tuIndex);
	}
	
	function approveUnitTranslation(tuIndex)
	{
		document.getElementById("tu" + tuIndex + "ApproveClicked").value = true;
		document.getElementById("tu" + tuIndex + "Approve").className = "CHide";
	}

	// The variable and two functions allow us to resize the textarea elements 
	// which make up the user interface
	var _originalHeight = -1;

	function makebig(o)
	{
		if(_originalHeight == -1)
		{
			var td = document.getElementById("tu" + o.id.substring(2) + "TargetTextTD");
			_originalHeight = td.offsetHeight;
		}
		
		o.style.height = 200 + "px";
	}
	
	function makesmall(o)
	{
		var td = document.getElementById("tu" + o.id.substring(2) + "TargetTextTD");
		td.height = _originalHeight;
		o.style.height = "100%"; // + "px";
	}
	
	// Sends the script to sleep for a short while, best used in short bursts
	function sleep(ms)
	{
		var startDate = new Date();
		var currentDate = new Date();
		
		while(currentDate - startDate < ms)
		{
			currentDate = new Date(); 
		}
	}	

	function replicateSave()
	{
		document.getElementById("ctl00_phContent_btnSave", "input").click();
	}

	function movePrevious()
	{
		document.getElementById("ctl00_phContent_btnPrevious", "input").click();
	}

	function moveNext()
	{
		document.getElementById("ctl00_phContent_btnNext", "input").click();
	}

	function confirmSetJobAsComplete()
	{
		var confirmed = true;

		if(getAspNetElementById("chkAllApproved").Checked == false)
		{
			alert(SmartReviewPageFunctions_AlertNotApproved);
			return false;
		}

		if(!nextButton_WasDisabled)
		{
			//confirmed = confirm("You are not on the last page of the job.\nAre you sure you have completed all translation / review work for this job?");
			confirmed = confirm(SmartReviewPageFunctions_ConfirmLastPageOfJob);
		}

		if(confirmed)
		{
			//return confirm("Are you sure you want to set this job as complete?");
			return confirm(SmartReviewPageFunctions_ConfirmSetComplete);
		}
		else
		{
			return false;
		}
	}

	function focusHandler(o)
	{
		makebig(o);
	}

	function blurHandler(o)
	{
		makesmall(o);

		var tuIndex = o.id.replace("tu", "");
		var original = eval("document.forms[0].tu" + tuIndex + "OriginalValue.value");
		var edit = eval("document.forms[0].tu" + tuIndex + ".value");

		if(o.className != "CTagError" && compareTags(original, edit, true) == false)
		{
			//alert("The internal tags in this translation unit have been reordered.\nThis could result in the returned translation being incorrect.\n\nPlease be sure that you meant to reorder the tags.");			
			alert(SmartReviewPageFunctions_InternalTagsReordered);
		}
	}

	function readCookie(name)
	{
		var cookieParameters = document.cookie.split(";");
		for(var i = 0; i < cookieParameters.length; i++)
		{
			var cookieName = trim(cookieParameters[i].split("=")[0]);
			
			if(cookieName.toLowerCase() == name.toLowerCase())
			{
				return cookieParameters[i].split("=")[1];
			}
		}
		
		return null;
	}
	
	function getFileID()
	{
		var parameters = document.forms[0].action.split("?")[1].split("&");
		for(var i = 0; i < parameters.length; i ++)
		{
			if(parameters[i].split("=")[0].toLowerCase() == "fileid")
			{
				return parameters[i].split("=")[1];
			}
		}	
		
		return -1;
	}
	
	function loadBookMark()
	{
		//if(confirm("Are you sure you want to load your last saved position?\nAll unsaved work will be lost."))
		if(confirm(SmartReviewPageFunctions_LoadSavedPosition))
		{
			var itemsPerPage = readCookie(getFileID() + "_ItemsPerPage");
			var pageNumber = readCookie(getFileID() + "_PageNumber");
		
			if(itemsPerPage == null || pageNumber == null) 
			{
				alert("No saved position found.");
			}
			else
			{
				document.location.href = "SmartReview.aspx?FileID=" + getFileID() + "&ItemsPerPage=" + itemsPerPage + "&PageNumber=" + pageNumber;
			}
		}
	}
	
	function bookMark()
	{
		var fileID = getFileID();
		
		var itemsPerPage = document.getElementById("ctl00_phContent_itemsPerPage", "select").value;
		var pageNumber = document.getElementById("ctl00_phContent_ddlPage", "select").value;

		// Set the cookie
		document.cookie = fileID + "_ItemsPerPage=" + itemsPerPage;
		document.cookie = fileID + "_PageNumber=" + pageNumber;
		
		//alert("The current page position has been saved in your browser settings.");
		alert(SmartReviewPageFunctions_PagePositionSaved);
	}
	
	function showEditArea(tuIndex)
	{
		//differenceReportObject.className = "CHidden";
		document.getElementById("tu" + tuIndex + "TextInput").className = "CVisible";
		document.getElementById("tu" + tuIndex + "DiffResult").className = "CHide";
		focusHandler(document.getElementById("tu" + tuIndex));
	}
	
	function concordanceSearch(tuIndex)
	{
		var fileID = getFileID();
		var url = "ConcordanceSearch.aspx?TuIndex=" + tuIndex + "&SupplierFileID=" + fileID;
		window.open(url, "concordance", "directories=0,fullscreen=0,height=400,width=600,location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0");
	}
		
	// Terminology Search features
	var _termTextbox = null;
	var _actionButton = null;

	function focusTextbox(clickButton)
	{
		if(_termTextbox != null)
		{
			try
			{
				_termTextbox.focus();
			}
			catch(e)
			{
				// IE doesn't like to focus hidden controls
			}
		}
		
		if(_actionButton != null && clickButton)
		{
			try
			{
				_actionButton.click();
			}
			catch(e)
			{
				// IE doesn't like to focus hidden controls
			}
		}
	}
	
	var _lastUrl = "";

	function toggleTermSearch(searchText, searchLanguage)
	{
		toggleForm(searchText, searchLanguage, null, null, null, "ctl00_phContent_frmSearch", "ctl00_phContent_btnSearch", toggleTermSearch, true);
	}
	
	function toggleAddNewTerm(termText, termLanguage, translationLanguage, sourceContext, targetContext)
	{
		toggleForm(termText, termLanguage, translationLanguage, sourceContext, targetContext, "ctl00_phContent_frmAddNewTerm", "ctl00_phContent_btnSave", toggleAddNewTerm, false);
	}

	function toggleForm(termText, termLanguage, translationLanguage, sourceContext, targetContext, frameId, actionButtonId, fn, clickButton)
	{
		var popupForm = document.getElementById(frameId);
		var sourceLanguageDropDown = null;
		var translationLanguageDropDown = null;
		var translationTextbox = null;
		var sourceContextTextbox = null;
		var targetContextTextbox = null;

		if (popupForm.src == "") {
		    return;
		}

		if(popupForm.style.display == "none")
		{
			popupForm.style.display = "block";
			toggleEventHandling(true, fn);

			// Set the textbox as focussed		
			if(popupForm.contentDocument)
			{
				_termTextbox = popupForm.contentDocument.getElementById("ctl00_phContent_txtTerm");
				_actionButton = popupForm.contentDocument.getElementById(actionButtonId);
				
				sourceLanguageDropDown = popupForm.contentDocument.getElementById("ctl00_phContent_cmbLanguage");
				translationLanguageDropDown = popupForm.contentDocument.getElementById("ctl00_phContent_cmbTranslationLanguage");
				sourceContextTextbox = popupForm.contentDocument.getElementById("ctl00_phContent_txtContext");
				targetContextTextbox = popupForm.contentDocument.getElementById("ctl00_phContent_txtTranslationContext");
				translationTextbox = popupForm.contentDocument.getElementById("ctl00_phContent_txtTermTranslation");
				
				_lastUrl = popupForm.src;
			}
			else
			{
				var frm = document.frames[frameId];
				_lastUrl = frm.document.location.href;
				
				if(frm != null)
				{
					_termTextbox = frm.document.getElementById("ctl00_phContent_txtTerm");
					_actionButton = frm.document.getElementById(actionButtonId);
										
					sourceLanguageDropDown = frm.document.getElementById("ctl00_phContent_cmbLanguage");
					translationLanguageDropDown = frm.document.getElementById("ctl00_phContent_cmbTranslationLanguage");
					sourceContextTextbox = frm.document.getElementById("ctl00_phContent_txtContext");		
					targetContextTextbox = frm.document.getElementById("ctl00_phContent_txtTranslationContext");
					translationTextbox = frm.document.getElementById("ctl00_phContent_txtTermTranslation");			
				}
				else
				{
					_termTextbox = null;
					_actionButton = null;
				}
			}
			
			if(termText != null && _termTextbox != null)
			{
				_termTextbox.value = termText;
			}
			
			if(termLanguage != null && sourceLanguageDropDown != null)
			{
				setSelectedLanguage(sourceLanguageDropDown, termLanguage);
				removeSelectOption(sourceLanguageDropDown);
			}
			
			if(translationLanguage != null && translationLanguageDropDown != null)
			{
				setSelectedLanguage(translationLanguageDropDown, translationLanguage);
				removeSelectOption(translationLanguageDropDown);
			}
			
			if(sourceContext != null && sourceContextTextbox != null)
			{
				sourceContextTextbox.value = sourceContext;
			}
			
			if(targetContext != null && targetContextTextbox != null)
			{
				targetContextTextbox.value = targetContext;
			}
			
			if(translationTextbox != null)
			{
				_termTextbox = translationTextbox;
			}
			
			if((termText != null || termLanguage != null) && clickButton)
			{
				window.setTimeout("focusTextbox(true)", 100);
			}
			else
			{
				window.setTimeout("focusTextbox(false)", 100);
			}
		}
		else
		{
			popupForm.style.display = "none";
			toggleEventHandling(false, fn);
			
			// Set the textbox as focussed		
			if(popupForm.contentDocument)
			{
				popupForm.src = _lastUrl;
			}
			else
			{
				var frm = document.frames[frameId];
				frm.document.location.href = _lastUrl;
			}			
		}
	}

    // Removes the SELECT (DropDownList) from the screen and replaces 
    // it with the text of the current selected item.
	function removeSelectOption(selectBox) 
	{
	    selectBox.style.display = "none";
	    var selectBoxText = selectBox.options[selectBox.selectedIndex].text;
	    var selectBoxTextNode = document.createTextNode(selectBoxText);

	    try {
	        selectBox.parentNode.insertBefore(selectBoxTextNode, selectBox);
	    }
	    catch (e) {
	        // IE 6 doesn't support many DOM operations
	        selectBox.parentNode.innerHTML += selectBoxText;
	    }
	}
	
	function setSelectedLanguage(languageDropDown, terminologyLanaguage)
	{
	    terminologyLanaguage = terminologyLanaguage.replace("-", "_").toLowerCase();
	    setSelectedValue(languageDropDown, terminologyLanaguage);
    }

    function setSelectedValue(dropDown, value)
    {
    	for (var i = 0; i < dropDown.options.length; i++)
    	{
    		if (dropDown.options[i].value.toLowerCase() == value)
    		{
    			dropDown.selectedIndex = i;
    			if (document.createEvent)
    			{
    				var evObj = document.createEvent('HTMLEvents')
    				evObj.initEvent('change', true, false)
    				dropDown.dispatchEvent(evObj)
    			}
    			else if (document.createEventObject)
    			{
    				dropDown.fireEvent('onchange')
    			}
    			return;
    		}
    	}
    }

	function toggleEventHandling(add, fn)
	{
		if(add)
		{
			if(document.body.addEventListener)
			{
				// For Mozilla type browsers
				document.body.addEventListener("click", fn, true);					
			}
			else if(document.body.attachEvent)
			{
				// For IE
				document.body.attachEvent("onclick", fn);
			}
		}
		else
		{
			if(document.body.removeEventListener)
			{
				// For Mozilla type browsers
				document.body.removeEventListener("click", fn, true);		
			}
			else if(document.body.attachEvent)
			{
				// For IE
				document.body.detachEvent("onclick", fn);	
			}
		}
    }

    var _translationMemorySearchButton;

    function toggleTranslationMemorySearch(searchText, searchLanguage)
    {
    	var popupForm = document.getElementById("ctl00_phContent_frmSearchTranslationMemory");

    	if (popupForm.src == "")
    	{
    		return;
    	}

    	var translationMemoryTextBox;
    	var translationMemoryLanguageDropDownList;

    	if (popupForm.style.display == "none")
    	{
    		popupForm.style.display = "block";
    		toggleEventHandling(true, toggleTranslationMemorySearch);

    		// Set the textbox as focussed		
    		if (popupForm.contentDocument)
    		{
    			translationMemoryTextBox = popupForm.contentDocument.getElementById("txtToSearch");
    			_translationMemorySearchButton = popupForm.contentDocument.getElementById("btnSearch");
    			translationMemoryLanguageDropDownList = popupForm.contentDocument.getElementById("cmbLanguage");
    		}
    		else
    		{
    			var frm = document.frames[frameId];

    			if (frm != null)
    			{
    				translationMemoryTextBox = frm.document.getElementById("txtToSearch");
    				_translationMemorySearchButton = frm.document.getElementById("btnSearch");
    				translationMemoryLanguageDropDownList = frm.document.getElementById("cmbLanguage");
    			}
    		}

    		setSelectedValue(translationMemoryLanguageDropDownList, searchLanguage);

    		if (searchText != null && translationMemoryTextBox != null)
    		{
    			translationMemoryTextBox.value = searchText;

    			window.setTimeout("translationMemorySearchSetup()", 100);
    		}
    	}
    	else
    	{
    		popupForm.style.display = "none";
    		toggleEventHandling(false, toggleTranslationMemorySearch);
    	}
    }

    function translationMemorySearchSetup()
    {
    	if (_translationMemorySearchButton != null)
    	{
    		try
    		{
    			_translationMemorySearchButton.click();
    		}
    		catch (e)
    		{
    			// IE doesn't like to focus hidden controls
    		}
    	}
    }    
﻿function waitForInstallCompletion() {
    try {
        //This forces Firefox/Safari to refresh their
        //list of known plugins.
        navigator.plugins.refresh();
    }
    catch (e) {
        //IE does not support the method, so an
        //exception will be thrown.
    }
    if (isSilverlightInstalled()) {
        //Silverlight is installed. Refresh the page.
        window.location.reload(false);
    }
    else {
        //Wait 3 seconds and try again
        setTimeout(waitForInstallCompletion, 3000);
    }
}

function silverlightPageLoad() {
    //This only works if we are performing a clean install,
    //not an upgrade.
    if (!isSilverlightInstalled()) {
        //Silverlight is not installed. Try to refresh
        //the page when it is installed.
        waitForInstallCompletion();
    }
}

function isSilverlightInstalled() {
    var isSilverlightInstalled = false;

    try {
        //check on IE
        try {
            var slControl = new ActiveXObject('AgControl.AgControl');
            isSilverlightInstalled = true;
        }
        catch (e) {
            //either not installed or not IE. Check Firefox
            if (navigator.plugins["Silverlight Plug-In"]) {
                isSilverlightInstalled = true;
            }
        }
    }
    catch (e) {
        //we don't want to leak exceptions. However, you may want
        //to add exception tracking code here.
    }
    return isSilverlightInstalled;
}
﻿function toggleAdditionalInformation(performingObject)
{
	var additionalInformation = document.getElementById("AdditionalInformation");
	
	if(additionalInformation.style.visibility == "visible")
	{
		additionalInformation.style.visibility = "hidden";
	}
	else
	{
		additionalInformation.style.visibility = "visible";
		
		var additionalInformationWidth = additionalInformation.offsetWidth;
		var performingObjectWidth = performingObject.offsetWidth;
		
		var difference = 0
		
		if(additionalInformationWidth > performingObjectWidth)
		{
			difference = additionalInformation.offsetWidth - performingObject.offsetWidth;	
		}
		
		additionalInformation.style.left = findPosX(performingObject) - difference + "px";
		additionalInformation.style.top = findPosY(performingObject) + performingObject.offsetHeight + "px";	
	}	
}
﻿function formatDate(date) {
	var yyyy = date.getFullYear();
	var MM = date.getMonth() + 1;
	var dd = date.getDate();

	var hh = date.getHours() + (date.getTimezoneOffset() / 60);
	var mm = date.getMinutes();
	var ss = date.getSeconds();

	return pad(yyyy) + "-" + pad(MM) + "-" + pad(dd) + " " + pad(hh) + ":" + pad(mm) + ":" + pad(ss);
}

function updateDateTime(millisecondsSince1970) {
	var dateTimeDisplay = document.getElementById("litDateTime");

	if (dateTimeDisplay != null) {
		var myDate = new Date();
		myDate.setTime(millisecondsSince1970);

		dateTimeDisplay.innerHTML = formatDate(myDate);

		millisecondsSince1970 += 1000;

		// Update the clock every second
		window.setTimeout("updateDateTime(" + millisecondsSince1970 + ")", 1000);
	}
}

function pad(i) {
	if (parseInt(i) < 10) {
		return "0" + i.toString();
	}
	else {
		return i.toString();
	}
}