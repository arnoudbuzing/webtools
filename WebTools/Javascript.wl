resourcefiles = FileNames["*.js", FileNameJoin[{$WebToolsDirectory, "Javascript"}]];
resources = Association @ Map[ FileBaseName[#] -> Import[#,"Text"] &, resourcefiles ];

BrowserExecute[javascript_String] := BrowserExecute[ $CurrentDriverObject, $CurrentBrowserObject, javascript ];
BrowserExecute[browser_BrowserObject, javascript_String] := BrowserExecute[ $CurrentDriverObject, browser, javascript ];
BrowserExecute[driver_DriverObject, browser_BrowserObject, javascript_String] := Module[{driverurl, sessionid},
  driverurl = driver["URL"];
  sessionid = browser["SessionID"];
  execute[driverurl, sessionid, javascript, {}]
]


(* Javascript based functions *)

BrowserPageLinks[] := BrowserPageLinks[ $CurrentDriverObject, $CurrentBrowserObject];
BrowserPageLinks[browser_] := BrowserPageLinks[ $CurrentDriverObject, browser];
BrowserPageLinks[driver_, browser_] := BrowserExecute[ driver, browser, resources["pagelinks"] ];

BrowserPageHTML[] := BrowserPageHTML[ $CurrentDriverObject, $CurrentBrowserObject];
BrowserPageHTML[browser_] := BrowserPageHTML[ $CurrentDriverObject, browser];
BrowserPageHTML[driver_, browser_] := BrowserExecute[ driver, browser, resources["pagehtml"] ];

BrowserPageURL[] := BrowserPageURL[ $CurrentDriverObject, $CurrentBrowserObject];
BrowserPageURL[browser_] := BrowserPageURL[ $CurrentDriverObject, browser];
BrowserPageURL[driver_, browser_] := BrowserExecute[ driver, browser, resources["pageurl"] ];


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
