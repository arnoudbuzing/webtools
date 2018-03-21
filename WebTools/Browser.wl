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
