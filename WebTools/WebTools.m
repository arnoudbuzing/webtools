BeginPackage["WebTools`", {"CloudObject`", "CURLLink`"}];

Get[ FileNameJoin[{DirectoryName[$InputFileName], "Usage.wl"}] ];
Get[ FileNameJoin[{DirectoryName[$InputFileName], "Messages.wl"}] ];

Begin["`Private`"];

Get[ FileNameJoin[{DirectoryName[$InputFileName], "Driver.wl"}] ];
Get[ FileNameJoin[{DirectoryName[$InputFileName], "Browser.wl"}] ];

$currentsession = None;

files = {"WebDriverAPI.m", "Utilities.m"};
Map[ Get[ FileNameJoin[{DirectoryName[$InputFileName], #}] ] &, files ];

(* Implementation of the package *)

(* where am i? *)
$WebToolsDirectory = DirectoryName[$InputFileName];

(* toplevel functions to api binding translations *)


wtStopWebSession[x___] := Null;
wtWebSessionStatus[x___] := status[x];
$wtWebSessions := sessions[];

BrowserOpen[x___] := seturl[x];
wtRefreshWebPage[x___] := refresh[x];
wtPageBack[x___] := back[x];
wtPageForward[x___] := forward[x];

wtBrowserWindows[x___] := windowhandles[x];
wtSetBrowserWindow[x___] := setwindow[x];

wtCaptureWebPage[x___] := screenshot[x];








(* higher level functions *)

QueryMethod[ wtElementClassName[_String] ] ^:= "class name";
QueryMethod[ wtCssSelector[_String] ] ^:= "css selector";
QueryMethod[ wtId[_String] ] ^:= "id";
QueryMethod[ wtName[_String] ] ^:= "name";
QueryMethod[ wtLinkText[_String] ] ^:= "link text";
QueryMethod[ wtPartialLinkText[_String] ] ^:= "partial link text";
QueryMethod[ wtTagName[_String] ] ^:= "tag name";
QueryMethod[ wtXPath[_String] ] ^:= "xpath";

QueryValue[ wtElementClassName[s_String] ] ^:= s;
QueryValue[ wtCssSelector[s_String] ] ^:= s;
QueryValue[ wtId[s_String] ] ^:= s;
QueryValue[ wtName[s_String] ] ^:= s;
QueryValue[ wtLinkText[s_String] ] ^:= s;
QueryValue[ wtPartialLinkText[s_String] ] ^:= s;
QueryValue[ wtTagName[s_String] ] ^:= s;
QueryValue[ wtXPath[s_String] ] ^:= s;



Options[wtJavascriptExecute] = { "SessionID" -> Automatic };

wtJavascriptExecute[javascript_, OptionsPattern[]] := Module[ {sessionId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	execute[sessionId,javascript, {}]
];

Options[wtLocateElement] = { "SessionID" -> Automatic };

wtLocateElement[valueId_, options:OptionsPattern[]] := wtLocateElement[{valueId,1},options];

wtLocateElement[{valueId_,num_},OptionsPattern[]] := Module[{sessionId, result},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	result = elements[sessionId,{"using"->QueryMethod[valueId], "value"->QueryValue[valueId]}];
	If[ result === "ELEMENT", result = {} ];
	If[ Length[result]>0, result[[num]], result ]
]

Options[wtClickElement] = Options[wtLocateElement];

wtClickElement[valueId_, options:OptionsPattern[]] := wtClickElement[{valueId,1},options];

wtClickElement[{valueId_,num_}, OptionsPattern[] ] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	elementId=If[StringQ[valueId],valueId,wtLocateElement[{valueId,num},"SessionID"->sessionId]];
	click[sessionId,elementId];
];

Options[wtTypeElement] = Options[wtLocateElement];

wtTypeElement[valueId_, text_, options:OptionsPattern[]] := wtTypeElement[{valueId,1}, text,options];

wtTypeElement[{valueId_,num_}, text_, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	elementId=If[StringQ[valueId],valueId,wtLocateElement[{valueId,num},"SessionID"->sessionId]];
	clear[sessionId,elementId];
	value[sessionId,elementId, text];
];

Options[wtHoverElement] = Options[wtLocateElement];

wtHoverElement[valueId_, options:OptionsPattern[]] := wtHoverElement[{valueId,1}, options];

wtHoverElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	elementId=If[StringQ[valueId],valueId,wtLocateElement[valueId,"SessionID"->sessionId]];
	moveto[sessionId,elementId];
];

Options[wtSubmitElement] = Options[wtLocateElement];

wtSubmitElement[valueId_, options:OptionsPattern[]] := wtSubmitElement[{valueId,1}, options];

wtSubmitElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	elementId=If[StringQ[valueId],valueId,wtLocateElement[valueId,"SessionID"->sessionId]];
	submit[sessionId,elementId]
];

Options[wtHideElement] = Options[wtLocateElement];

wtHideElement[valueId_, options:OptionsPattern[]] := wtHideElement[{valueId,1}, options];

wtHideElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	elementId=If[StringQ[valueId],valueId,wtLocateElement[valueId,"SessionID"->sessionId]];
	execute[sessionId,"arguments[0].style.visibility='hidden'",{{"ELEMENT"->elementId}}];
];

Options[wtFocusFrame] = Options[wtLocateElement];

wtFocusFrame[valueId_, options:OptionsPattern[]] := wtFocusFrame[{valueId,1}, options];

wtFocusFrame[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	If[valueId===Null,
		frame[sessionId,Null]
		,
		elementId=wtLocateElement[valueId,"SessionID"->sessionId];
		frame[sessionId,elementId];
	];
];


(* Javascript based functions *)

wtPageLinks[] := wtJavascriptExecute["
	var result = [];
	for( i=0; i<document.links.length; i++ ) {
	 result[i] = document.links[i].href;
	};
	return result;
"];

wtGetPageHtml[] := wtJavascriptExecute["return document.getElementsBywtTagName('html')[0].innerHTML;"]

(*Get part of HTML*)
Options[wtGetHtml]={"Selection"->"outer"};

wtGetHtml[] := wtGetPageHtml[]
wtGetHtml[wtSelector[sel_String],OptionsPattern[]] := wtJavascriptExecute[ "return document.querySelector('" <> sel <> "')."<>OptionValue["Selection"]<>"HTML;"]
wtGetHtml[wtXPath[xp_String],OptionsPattern[]] := wtJavascriptExecute["document.evaluate('"<>xp<>"', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue."<>OptionValue["Selection"]<>"HTML;"]
wtGetHtml[wtId[id_String],OptionsPattern[]] := wtJavascriptExecute["return document.getElementById('" <> id <> "')."<>OptionValue["Selection"]<>"HTML;"]

(*Get Current URL*)
wtGetPageURL[]:=wtJavascriptExecute["return window.location.href;"]

(*Turn off all alerts! They are annoying*)
wtOffAlert[]:=wtJavascriptExecute[ "window.alert=function(){return 1}; window.confirm=function(){return 1}; window.prompt=function(){return 1};"]

End[];

EndPackage[];
