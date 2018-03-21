BrowserCommand["GetAllCookies"] := BrowserCommand[ $CurrentDriverObject, $CurrentBrowserObject, "GetAllCookies"];
BrowserCommand[browser_, "GetAllCookies"] := BrowserCommand[ $CurrentDriverObject, browser, "GetAllCookies"];
BrowserCommand[driver_, browser_, "GetAllCookies"] := Module[{request, response,  result},
  request = HTTPRequest[ driver["URL"] <> "/session/" <> browser["SessionID"] <> "/cookie" ];
  response = URLRead[ request ];
  result = Dataset[ImportString[response["Body"], "RawJSON"]["value"]];
  result[All, Function[ <| "Name" -> #name, "Value" -> #value, "Domain" -> #domain, "Path" -> #path, "Expiration" -> FromUnixTime[#expiry], "Secure" -> #secure, "HTTPOnly" -> #httpOnly |> ] ]
]

BrowserCommand["GetNamedCookie", name_String ] := BrowserCommand[ $CurrentDriverObject, $CurrentBrowserObject, "GetNamedCookie", name];
BrowserCommand[browser_, "GetNamedCookie", name_String] := BrowserCommand[ $CurrentDriverObject, browser, "GetNamedCookie", name];
BrowserCommand[driver_, browser_, "GetNamedCookie", name_String] := Module[{request, response,  result},
  request = HTTPRequest[ driver["URL"] <> "/session/" <> browser["SessionID"] <> "/cookie/" <> name ];
  response = URLRead[ request ];
  result = Dataset[ImportString[response["Body"], "RawJSON"]["value"]];
  result[Function[ <| "Name" -> #name, "Value" -> #value, "Domain" -> #domain, "Path" -> #path, "Expiration" -> FromUnixTime[#expiry], "Secure" -> #secure, "HTTPOnly" -> #httpOnly |> ] ]
]
