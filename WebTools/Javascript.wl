BrowserExecute[javascript_String] := BrowserExecute[ $CurrentDriverObject, $CurrentBrowserObject, javascript ];
BrowserExecute[browser_BrowserObject, javascript_String] := BrowserExecute[ $CurrentDriverObject, browser, javascript ];
BrowserExecute[driver_DriverObject, browser_BrowserObject, javascript_String] := Module[{driverurl, sessionid},
  driverurl = driver["URL"];
  sessionid = browser["SessionID"];
  execute[driverurl, sessionid, javascript, {}]
]
