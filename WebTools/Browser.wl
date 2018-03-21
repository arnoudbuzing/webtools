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

BrowserOpen[url_] := BrowserOpen[ $CurrentDriverObject, $CurrentBrowserObject, url];
BrowserOpen[browser_, url_] := BrowserOpen[ $CurrentDriverObject, browser, url];
BrowserOpen[driver_, browser_, url_] := seturl[driver["URL"], browser["SessionID"], url ];

BrowserTabs[] := BrowserTabs[ $CurrentDriverObject, $CurrentBrowserObject ];
BrowserTabs[browser_] := BrowserTabs[ $CurrentDriverObject, browser ];
BrowserTabs[driver_, browser_] := windowhandle[ driver["URL"], browser["SessionID"] ];
