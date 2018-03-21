Options[wtJavascriptExecute] = { "SessionID" -> Automatic };

wtJavascriptExecute[javascript_, OptionsPattern[]] := Module[ {sessionId},
	sessionId = OptionValue["SessionID"] /. {Automatic -> $currentsession};
	execute[sessionId,javascript, {}]
];

BrowserExecute[javascript_String] := BrowserExecute[ $CurrentDriverObject, $CurrentBrowserObject, javascript ];
BrowserExecute[browser_BrowserObject, javascript_String] := BrowserExecute[ $CurrentDriverObject, browser, javascript ];
BrowserExecute[driver_DriverObject, browser_BrowserObject, javascript_String] := Module[{baseurl, sessionid},
  baseurl = driver["URL"];
  sessionid = browser["SessionID"];
  execute[baseurl, sessionid, javascript, {}]
]
