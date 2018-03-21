status[] := get["/status"];

sessions[] := get["/sessions"];

setsession[ driver_DriverObject ] := Module[{assoc=First[driver],response,result,sessionid,name,version},
  response = URLRead[
    HTTPRequest[
      assoc["URL"]<>"/session",
      <|"Method" -> "POST", "Body" -> ExportString[{"desiredCapabilities" -> {"browserName" -> assoc["Driver"]}}, "JSON"]|>
    ]
  ];
  result = ImportString[response["Body"],"JSON"];
  name = Capitalize @ First @ Cases[result,HoldPattern["browserName"->s_String]:>s,Infinity];
  version = First @ Cases[result, HoldPattern[("version"|"browserVersion")->s_String]:>s, Infinity ];
  sessionid = First @ Cases[result,HoldPattern["sessionId"->s_String]:>s,Infinity];
  $CurrentBrowserObject = BrowserObject[ <| "Name" -> name, "Version"->version, "SessionID"->sessionid|> ]
]


getsession[sessionId_] := get["/session/" <> sessionId];

forward[] := forward[$currentsession];
forward[sessionId_] := post["/session/" <> sessionId <> "/forward"];

back[] := back[$currentsession];
back[sessionId_] := post["/session/" <> sessionId <> "/back"];

refresh[] := refresh[$currentsession];
refresh[sessionId_] := post["/session/" <> sessionId <> "/refresh"];

execute[script_, args_] := execute[$currentsession, script, args];
execute[sessionId_, script_, args_] := post["/session/" <> sessionId <> "/execute", {"script" -> script, "args" -> args}];

availableengines[] := availableengines[$currentsession];
availableengines[sessionId_] := get["/session/" <> sessionId <> "/available_engines"];

activeengine[] := activeengine[$currentsession];
activeengine[sessionId_] := get["/session/" <> sessionId <> "/active_engine"];

activated[] := activated[$currentsession];
activated[sessionId_] := get["/session/" <> sessionId <> "/activated"];

deactivate[] := deactivate[$currentsession];
deactivate[sessionId_] := post["/session/" <> sessionId <> "/deactivate"];

activate[] := activate[$currentsession];
activate[sessionId_, engine_] := post["/session/" <> sessionId <> "/activate", {"engine" -> engine}];

frame[] := frame[Null];
frame[elementId_] := frame[$currentsession,elementId];
frame[sessionId_, elementId_] := post["/session/" <> sessionId <> "/frame", {"id" -> If[elementId===Null,Null,{"ELEMENT"->elementId}]}];

geturl[] := geturl[$currentsession];
geturl[sessionId_] := get["/session/" <> sessionId <> "/url"];

seturl[url_] := seturl[$CurrentBrowserObject["SessionID"],url];
seturl[sessionId_, url_] := post["/session/" <> sessionId <> "/url", {"url" -> url}];

screenshot[] := screenshot[$currentsession];
screenshot[sessionId_] := ImportString[get["/session/" <> sessionId <> "/screenshot"], "Base64"];

getcookie[] := cookie[$currentsession];
getcookie[sessionId_] := get["/session/" <> sessionId <> "/cookie"];
setcookie[cookie_] := setcookie[$currentsession,cookie];
setcookie[sessionId_, cookie_] := post["/session/" <> sessionId <> "/cookie", {"cookie" -> cookie}];
deletecookie[] := deletecookie[$currentsession];
deletecookie[sessionId_] := delete["/session/" <> sessionId <> "/cookie"];

title[] := title[$currentsession];
title[sessionId_] := get["/session/" <> sessionId <> "/title"];

source[] := source[$currentsession];
source[sessionId_] := get["/session/" <> sessionId <> "/source"];

getorientation[] := orientation[$currentsession];
getorientation[sessionId_] := get["/session/" <> sessionId <> "/orientation"];
setorientation[orientation_] := setorientation[$currentsession,orientation];
setorientation[sessionId_, orientation_] := post["/session/" <> sessionId <> "/orientation", {"orientation" -> orientation}];

getalerttext[] := getalerttext[$currentsession];
getalerttext[sessionId_] := get["/session/" <> sessionId <> "/alert_text"];
setalerttext[text_] := setalerttext[$currentsession,text];
setalerttext[sessionId_, text_] := post["/session/" <> sessionId <> "/alert_text", {"text" -> Characters[text]}];

acceptalert[] := acceptalert[$currentsession];
acceptalert[sessionId_] := post["/session/" <> sessionId <> "/accept_alert"];

dismissalert[] := dismissalert[$currentsession];
dismissalert[sessionId_] := post["/session/" <> sessionId <> "/dismiss_alert"];

localstorage[] := localstorage[$currentsession];
localstorage[sessionId_] := get["/session/" <> sessionId <> "/local_storage"];

moveto[elementId_] := moveto[$currentsession, elementId];
moveto[sessionId_, elementId_] := post["/session/" <> sessionId <> "/moveto", {"element" -> elementId}];

setwindow[window_] := setwindow[$currentsession,window];
setwindow[sessionId_, window_] := post["/session/" <> sessionId <> "/window", {"name" -> window}];
deletewindow[] := deletewindow[$currentsession];
deletewindow[sessionId_] := delete["/session/" <> sessionId <> "/window"];

windowhandle[] := windowhandle[$currentsession];
windowhandle[sessionId_] := get["/session/" <> sessionId <> "/window_handle"];

windowhandles[] := windowhandles[$currentsession];
windowhandles[sessionId_] := get["/session/" <> sessionId <> "/window_handles"];

getwindowsize[windowHandle_] := getwindowsize[$currentsession, windowHandle];
getwindowsize[sessionId_, windowHandle_] := get["/session/" <> sessionId <> "/window" <> windowHandle <> "/size"];
setwindowsize[windowHandle_, {width_, height_}] := setwindowsize[$currentsession, windowHandle, {width, height}];
setwindowsize[sessionId_, windowHandle_, {width_, height_}] := post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"width" -> width, "height" -> height}];

getwindowposition[windowHandle_] := getwindowposition[$currentsession, windowHandle];
getwindowposition[sessionId_, windowHandle_] :=  get["/session/" <> sessionId <> "/window" <> windowHandle <> "/position"];
setwindowposition[windowHandle_, {x_, y_}] := setwindowposition[$currentsession,windowHandle, {x, y}];
setwindowposition[sessionId_, windowHandle_, {x_, y_}] :=  post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"x" -> x, "y" -> y}];

windowmaximize[windowHandle_] := windowmaximize[$currentsession,windowHandle];
windowmaximize[sessionId_, windowHandle_] := post["/session/" <> sessionId <> "/window/" <> windowHandle <> "/maximize"];

element[data_] := element[$currentsession, data];
element[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element", data];

activeelement[] := activeelement[$currentsession];
activeelement[sessionId_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element/active"];

elements[data_] := elements[$currentsession, data];
elements[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/elements", data];

describe[elementId_] := describe[$currentsession, elementId];
describe[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element" <> elementId];

click[elementId_] := click[$currentsession, elementId];
click[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/click"];

submit[elementId_] := submit[$currentsession,elementId];
submit[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/submit"];

text[elementId_] := text[$currentsession,elementId];
text[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/text"];

name[elementId_] := name[$currentsession,elementId];
name[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/name"];

clear[elementId_] := clear[$currentsession,elementId];
clear[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/clear"];

selected[elementId_] := selected[$currentsession,elementId];
selected[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/selected"];

enabled[elementId_] := enabled[$currentsession,elementId];
enabled[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/enabled"];

displayed[elementId_] := displayed[$currentsession,elementId];
displayed[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/displayed"];

attribute[elementId_, attributeName_] := attribute[$currentsession, elementId, attributeName];
attribute[sessionId_, elementId_, attributeName_] :=  get["/session/" <> sessionId <> "/element/" <> elementId <> "/attribute/" <> attributeName];

equals[elementId1_,elementId2_] := equals[$currentsession,elementId1,elementId2];
equals[sessionId_, elementId1_, elementId2_] := get["/session/" <> sessionId <> "/element/" <> elementId1 <> "/equals/" <> elementId2];

size[elementId_] := size[$currentsession,elementId];
size[sessionId_, elementId_] := {"width", "height"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/size"];

location[elementId_] := location[$currentsession,elementId];
location[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location"];

locationinview[elementId_] := locationinview[$currentsession,elementId];
locationinview[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location_in_view"];

elementcssproperty[elementId_, propertyName_] := elementcssproperty[$currentsession,elementId,propertyName];
elementcssproperty[sessionId_, elementId_, propertyName_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/css/" <> propertyName];

value[elementId_, keyStrokeSequence_String] := value[$currentsession,elementId, keyStrokeSequence];
value[sessionId_, elementId_, keyStrokeSequence_String] := value[sessionId, elementId, Characters[keyStrokeSequence]];
value[sessionId_, elementId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/value", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];

keys[keyStrokeSequence_String] := keys[$currentsession, keyStrokeSequence];
keys[sessionId_, keyStrokeSequence_String] := keys[sessionId, Characters[keyStrokeSequence]];
keys[sessionId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/keys", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];
