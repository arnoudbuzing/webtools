




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
