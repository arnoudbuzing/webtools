BeginPackage["WebTools`"];

InstallWebTools::usage = "InstallWebTools[] launches the default web driver which allows Mathematica to communicate with a web browser. InstallWebTools[driver] launches the specified driver.";
$SupportedWebDrivers::usage = "$SupportedWebDrivers returns the list of web drivers supported on your platform.";

(* Web session functions *)

StartWebToolsSession::usage = "StartWebToolsSession[] starts a new web session in a web browser and returns the unique session identifier.";
StopWebToolsSession::usage = "StopWebToolsSession[sessionid] stops the web session identified by 'sessionid'";
WebSessionStatus::usage = "WebSessionStatus[] returns status information for the current web session. WebSessionStatus[sessionid] returns status information for the specified 'sessionid'";
$CurrentWebSession::usage = "$CurrentWebSession holds the session identifier for the current web session.";
$WebSessions::usage = "$WebSessions returns the list of all open web sessions.";


OpenWebPage::usage = "OpenWebPage[url] opens the web page specified by 'url'";
RefreshWebPage::usage = "RefreshWebPage[] refreshes the currently open web page.";
PageBack::usage = "PageBack[] instructs the web browser to navigate to the previously visible page in its web session.";
PageForward::usage = "PageForward[] instructs the web browser to navigate to the next visible page in its web session and acts as the inverse operation of PageBack[].";
PageLinks::usage = "PageLinks[] returns the hyperlinks for the current active page.";

CaptureWebPage::usage = "CaptureWebPage[]";
SetBrowserWindow::usage = "SetBrowserWindow[windowid] changes the active browser window to the one specified by 'windowid'. A list of all window identifiers is given by BrowserWindows[].";
BrowserWindows::usage = "BrowserWindows[] returns a list of all window identifiers, that are open in a given web session.";

JavascriptExecute::usage = "JavascriptExecute[\"javascript\"] executes a piece of JavaScript in the current window";
LocateElement::usage = "LocateElement[id] returns";
ClickElement::usage = "ClickElement[id] clicks on the first web element identified by 'id'. ClickElement[{id,n}] clicks the n-th matching element identified by 'id'. Typical elements are form submit buttons and hyperlinks.";
TypeElement::usage = "TypeElement[id, text] types 'text' into a web element identified by 'id'. Typical elements are input fields and text areas.";
ClearElement::usage = "ClearElement[id] clears text of a web elements identified by 'id'. Typical elements are input field and text areas.";
SubmitElement::usage = "";
HoverElement::usage = "HoverElement[id] clicks on the first web element identified by 'id'. ClickElement[{id,n}] clicks the n-th matching element identified by 'id'. Typical elements are form submit buttons and hyperlinks.";
HideElement::usage = "";

FocusFrame::usage = "FocusFrame[id] gives focus to a web frame inside a web page. Typical usage is for giving focus to elements within <iframe> tags"

ElementClassName::usage = "";
CssSelector::usage = "";
Id::usage = "";
Name::usage = "";
LinkText::usage = "";
PartialLinkText::usage = "";
TagName::usage = "";
XPath::usage = "";

$WebDriver::usage = "";
$WebDriverBaseURL::usage = "";
(* Javascript based functions *)

GetPageHtml::usage = "";

Begin["`Private`"];

files = {"WebDriverAPI.m", "Utilities.m"};
Map[ Get[ FileNameJoin[{DirectoryName[$InputFileName], #}] ] &, files ];

(* Implementation of the package *)

(* where am i? *)
$WebToolsDirectory = DirectoryName[$InputFileName];

(* toplevel functions to api binding translations *)

StartWebToolsSession[x___] := setsession[x];
StopWebToolsSession[x___] := Null;
WebSessionStatus[x___] := status[x];
$WebSessions := sessions[];

OpenWebPage[x___] := seturl[x];
RefreshWebPage[x___] := refresh[x];
PageBack[x___] := back[x];
PageForward[x___] := forward[x];

BrowserWindows[x___] := windowhandles[x];
SetBrowserWindow[x___] := setwindow[x];

CaptureWebPage[x___] := screenshot[x];

$SupportedWebDrivers = Switch[ $SystemID ,
	"Windows-x86-64", {"ChromeDriver","InternetExplorerDriver","MicrosoftWebDriver"},
	"MacOSX-x86-64", {"ChromeDriver"},
	_, {}
];

(* execute once to start the standalone driver *)
InstallWebTools[] := InstallWebTools["ChromeDriver"];

InstallWebTools[driver_] := Module[{dir},
	{$WebDriver,$WebDriverBaseURL} = Switch[ driver,
		"ChromeDriver", {"Chrome","http://localhost:9515"},
		"InternetExplorerDriver", {"InternetExplorer","http://localhost:5555"},
		"MicrosoftWebDriver", {"Edge", "http://localhost:17556"},
		_, Null ];
	If[ TimeConstrained[URLRead[$WebDriverBaseURL<>"/status"],0.5] === $Aborted, (* only launch driver if not running *)
		dir = FileNameJoin[{ $WebToolsDirectory, "WebDriver", driver, $SystemID }]; Print @ dir;
		SetDirectory[dir];
		Switch[ driver,
			"ChromeDriver",
				Switch[ $SystemID,
					"Windows-x86-64", StartProcess[ FileNameJoin[{ dir, "chromedriver.exe" }] ],
					"MacOSX-x86-64", Run[ FileNameJoin[{ dir, "chromedriver"}] <> " &" ],
					"Linux-x86-64", Null,
					_, Null
				],
			"InternetExplorerDriver",
				Switch[ $SystemID,
					"Windows-x86-64", Run["start " <> FileNameJoin[{ dir, "iedriverserver.exe" }]],
					_, Null
				],
			"MicrosoftWebDriver",
				Switch[ $SystemID,
					"Windows-x86-64", Run["start " <> FileNameJoin[{ dir, "microsoftwebdriver.exe" }]],
					_, Null
				],
			"FirefoxDriver",
				Switch[ $SystemID,
					"Windows-x86-64", Null,
					"MacOSX-x86-64", Null,
					_, Null
				],
			"SafariDriver",
				Switch[ $SystemID,
					"MacOSX-x86-64", Null,
					_, Null
				],
			_, Null];
		ResetDirectory[];
	]
]




(* higher level functions *)

QueryMethod[ ElementClassName[_String] ] ^:= "class name";
QueryMethod[ CssSelector[_String] ] ^:= "css selector";
QueryMethod[ Id[_String] ] ^:= "id";
QueryMethod[ Name[_String] ] ^:= "name";
QueryMethod[ LinkText[_String] ] ^:= "link text";
QueryMethod[ PartialLinkText[_String] ] ^:= "partial link text";
QueryMethod[ TagName[_String] ] ^:= "tag name";
QueryMethod[ XPath[_String] ] ^:= "xpath";

QueryValue[ ElementClassName[s_String] ] ^:= s;
QueryValue[ CssSelector[s_String] ] ^:= s;
QueryValue[ Id[s_String] ] ^:= s;
QueryValue[ Name[s_String] ] ^:= s;
QueryValue[ LinkText[s_String] ] ^:= s;
QueryValue[ PartialLinkText[s_String] ] ^:= s;
QueryValue[ TagName[s_String] ] ^:= s;
QueryValue[ XPath[s_String] ] ^:= s;



Options[JavascriptExecute] = { "SessionID" -> Automatic };

JavascriptExecute[javascript_, OptionsPattern[]] := Module[ {sessionId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	execute[sessionId,javascript, {}]
];

Options[LocateElement] = { "SessionID" -> Automatic };

LocateElement[valueId_, options:OptionsPattern[]] := LocateElement[{valueId,1},options];

LocateElement[{valueId_,num_},OptionsPattern[]] := Module[{sessionId, result},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	result = elements[sessionId,{"using"->QueryMethod[valueId], "value"->QueryValue[valueId]}];
	If[ result === "ELEMENT", result = {} ];
	If[ Length[result]>0, result[[num]], result ]
]

Options[ClickElement] = Options[LocateElement];

ClickElement[valueId_, options:OptionsPattern[]] := ClickElement[{valueId,1},options];

ClickElement[{valueId_,num_}, OptionsPattern[] ] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	elementId=If[StringQ[valueId],valueId,LocateElement[{valueId,num},"SessionID"->sessionId]];
	click[sessionId,elementId];
];

Options[TypeElement] = Options[LocateElement];

TypeElement[valueId_, text_, options:OptionsPattern[]] := TypeElement[{valueId,1}, text,options];

TypeElement[{valueId_,num_}, text_, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	elementId=If[StringQ[valueId],valueId,LocateElement[{valueId,num},"SessionID"->sessionId]];
	clear[sessionId,elementId];
	value[sessionId,elementId, text];
];

Options[HoverElement] = Options[LocateElement];

HoverElement[valueId_, options:OptionsPattern[]] := HoverElement[{valueId,1}, options];

HoverElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	elementId=If[StringQ[valueId],valueId,LocateElement[valueId,"SessionID"->sessionId]];
	moveto[sessionId,elementId];
];

Options[SubmitElement] = Options[LocateElement];

SubmitElement[valueId_, options:OptionsPattern[]] := SubmitElement[{valueId,1}, options];

SubmitElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	elementId=If[StringQ[valueId],valueId,LocateElement[valueId,"SessionID"->sessionId]];
	submit[sessionId,elementId]
];

Options[HideElement] = Options[LocateElement];

HideElement[valueId_, options:OptionsPattern[]] := HideElement[{valueId,1}, options];

HideElement[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	elementId=If[StringQ[valueId],valueId,LocateElement[valueId,"SessionID"->sessionId]];
	execute[sessionId,"arguments[0].style.visibility='hidden'",{{"ELEMENT"->elementId}}];
];

Options[FocusFrame] = Options[LocateElement];

FocusFrame[valueId_, options:OptionsPattern[]] := FocusFrame[{valueId,1}, options];

FocusFrame[{valueId_,num_}, OptionsPattern[]] := Module[ {sessionId,elementId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $CurrentWebSession};
	If[valueId===Null,
		frame[sessionId,Null]
		,
		elementId=LocateElement[valueId,"SessionID"->sessionId];
		frame[sessionId,elementId];
	];
];


(* Javascript based functions *)

PageLinks[] := JavascriptExecute["
	var result = [];
	for( i=0; i<document.links.length; i++ ) {
	 result[i] = document.links[i].href;
	};
	return result;
"];

GetPageHtml[] := JavascriptExecute["return document.getElementsByTagName('html')[0].innerHTML;"]

GetHtmlForId[id_String] := JavascriptExecute[ "return document.getElementById('" <> id <> "').innerHTML;"]

End[];

EndPackage[];
