In this folder are XUL files, contents of which is integrating into device.xul file dinamically.

Here is the workflow:
 - in the device.xul file is <vbox> element with attribute id="rightBottomWindow". It is the parent window for any of the panels.
 - When there is a need for a new panel, function showPanelOrLoadIt(panelName, panelArgument) is called.
 - Function loops through all children of <vbox id="rightBottomWindow"> element and sets each children's attribute 'hidden' to 'true'.
 - if child node has attribute 'frameName' equal to panelName, it's attribute 'hidden' is set to 'false'.
 - if there is no such child node, then new child node is appended from xul file with filename qual to panelName. Also scripts from that file are evaluated. It's attribute 'frameName' is set to panelName and it's attribute 'hidden' is set to 'false'. At the function '{panelName}Init(panelArgument)' is called.

Code from external xul file is now a part of device.xul file and behaves like that.

For a new panel template '_blank.xul' can be used.

NOTE: Some XUL elements like listboxes or menulists does not render properly, if they are added dinamically to main XUL file.
For this reason some panels can not be in external file - they must be integrated into main XUL file.