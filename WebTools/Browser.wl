BrowserObject[assoc_Association][key_] := assoc[key];

BrowserObject /: MakeBoxes[object:_BrowserObject, form:(StandardForm|TraditionalForm)] := Module[{assoc=First[object]},
	BoxForm`ArrangeSummaryBox[BrowserObject, object, None, {
		{BoxForm`SummaryItem[{"Name: ", assoc["Name"]}], BoxForm`SummaryItem[{"Version: ", None}]},
	 	{BoxForm`SummaryItem[{"SessionID: ", assoc["SessionID"]}]}
	}, {
		{BoxForm`SummaryItem[{"Bla: ", None}]}
	}, form, "Interpretable" -> True]
];


StartBrowser[ driver_DriverObject ] := setsession[ driver ];

BrowserOpenPage[url_] := BrowserOpenPage[ $CurrentDriverObject, $CurrentBrowserObject, url];
BrowserOpenPage[browser_, url_] := BrowserOpenPage[ $CurrentDriverObject, browser, url];
BrowserOpenPage[driver_, browser_, url_] := seturl[driver["URL"], browser["SessionID"], url ];

BrowserTabs[] := BrowserTabs[ $CurrentDriverObject, $CurrentBrowserObject ];
BrowserTabs[browser_] := BrowserTabs[ $CurrentDriverObject, browser ];
BrowserTabs[driver_, browser_] := windowhandle[ driver["URL"], browser["SessionID"] ];


(* toplevel functions to api binding translations *)


wtStopWebSession[x___] := Null;
wtWebSessionStatus[x___] := status[x];
$wtWebSessions := sessions[];


wtRefreshWebPage[x___] := refresh[x];
wtPageBack[x___] := back[x];
wtPageForward[x___] := forward[x];



wtCaptureWebPage[x___] := screenshot[x];
