status[] := get["/status"];

sessions[] := get["/sessions"];

setsession[] := setsession[$wtWebDriver];
setsession["Chrome"] := ($wtCurrentWebSession = post["/session", {"desiredCapabilities" -> {"browserName" -> "chrome"}}, "sessionId"]);
setsession["InternetExplorer"] := ($wtCurrentWebSession = post["/session", {"desiredCapabilities" -> {"browserName" -> "internet explorer"}}, "sessionId"]);
setsession["Edge"] := ($wtCurrentWebSession = post["/session", {"desiredCapabilities" -> {}, "requiredCapabilities"->{}}, "sessionId"]);
setsession["Firefox"] := ($wtCurrentWebSession = post["/session", {"desiredCapabilities" -> {"browserName" -> "firefox"}}, "sessionId"]);
getsession[sessionId_] := get["/session/" <> sessionId];

forward[] := forward[$wtCurrentWebSession];
forward[sessionId_] := post["/session/" <> sessionId <> "/forward"];

back[] := back[$wtCurrentWebSession];
back[sessionId_] := post["/session/" <> sessionId <> "/back"];

refresh[] := refresh[$wtCurrentWebSession];
refresh[sessionId_] := post["/session/" <> sessionId <> "/refresh"];

execute[script_, args_] := execute[$wtCurrentWebSession, script, args];
execute[sessionId_, script_, args_] := post["/session/" <> sessionId <> "/execute", {"script" -> script, "args" -> args}];

availableengines[] := availableengines[$wtCurrentWebSession];
availableengines[sessionId_] := get["/session/" <> sessionId <> "/available_engines"];

activeengine[] := activeengine[$wtCurrentWebSession];
activeengine[sessionId_] := get["/session/" <> sessionId <> "/active_engine"];

activated[] := activated[$wtCurrentWebSession];
activated[sessionId_] := get["/session/" <> sessionId <> "/activated"];

deactivate[] := deactivate[$wtCurrentWebSession];
deactivate[sessionId_] := post["/session/" <> sessionId <> "/deactivate"];

activate[] := activate[$wtCurrentWebSession];
activate[sessionId_, engine_] := post["/session/" <> sessionId <> "/activate", {"engine" -> engine}];

frame[] := frame[Null];
frame[elementId_] := frame[$wtCurrentWebSession,elementId];
frame[sessionId_, elementId_] := post["/session/" <> sessionId <> "/frame", {"id" -> If[elementId===Null,Null,{"ELEMENT"->elementId}]}];

geturl[] := geturl[$wtCurrentWebSession];
geturl[sessionId_] := get["/session/" <> sessionId <> "/url"];
seturl[url_] := seturl[$wtCurrentWebSession,url];
seturl[sessionId_, url_] := post["/session/" <> sessionId <> "/url", {"url" -> url}];

screenshot[] := screenshot[$wtCurrentWebSession];
screenshot[sessionId_] := ImportString[get["/session/" <> sessionId <> "/screenshot"], "Base64"];

getcookie[] := cookie[$wtCurrentWebSession];
getcookie[sessionId_] := get["/session/" <> sessionId <> "/cookie"];
setcookie[cookie_] := setcookie[$wtCurrentWebSession,cookie];
setcookie[sessionId_, cookie_] := post["/session/" <> sessionId <> "/cookie", {"cookie" -> cookie}];
deletecookie[] := deletecookie[$wtCurrentWebSession];
deletecookie[sessionId_] := delete["/session/" <> sessionId <> "/cookie"];

title[] := title[$wtCurrentWebSession];
title[sessionId_] := get["/session/" <> sessionId <> "/title"];

source[] := source[$wtCurrentWebSession];
source[sessionId_] := get["/session/" <> sessionId <> "/source"];

getorientation[] := orientation[$wtCurrentWebSession];
getorientation[sessionId_] := get["/session/" <> sessionId <> "/orientation"];
setorientation[orientation_] := setorientation[$wtCurrentWebSession,orientation];
setorientation[sessionId_, orientation_] := post["/session/" <> sessionId <> "/orientation", {"orientation" -> orientation}];

getalerttext[] := getalerttext[$wtCurrentWebSession];
getalerttext[sessionId_] := get["/session/" <> sessionId <> "/alert_text"];
setalerttext[text_] := setalerttext[$wtCurrentWebSession,text];
setalerttext[sessionId_, text_] := post["/session/" <> sessionId <> "/alert_text", {"text" -> Characters[text]}];

acceptalert[] := acceptalert[$wtCurrentWebSession];
acceptalert[sessionId_] := post["/session/" <> sessionId <> "/accept_alert"];

dismissalert[] := dismissalert[$wtCurrentWebSession];
dismissalert[sessionId_] := post["/session/" <> sessionId <> "/dismiss_alert"];

localstorage[] := localstorage[$wtCurrentWebSession];
localstorage[sessionId_] := get["/session/" <> sessionId <> "/local_storage"];

moveto[elementId_] := moveto[$wtCurrentWebSession, elementId];
moveto[sessionId_, elementId_] := post["/session/" <> sessionId <> "/moveto", {"element" -> elementId}];

setwindow[window_] := setwindow[$wtCurrentWebSession,window];
setwindow[sessionId_, window_] := post["/session/" <> sessionId <> "/window", {"name" -> window}];
deletewindow[] := deletewindow[$wtCurrentWebSession];
deletewindow[sessionId_] := delete["/session/" <> sessionId <> "/window"];

windowhandle[] := windowhandle[$wtCurrentWebSession];
windowhandle[sessionId_] := get["/session/" <> sessionId <> "/window_handle"];

windowhandles[] := windowhandles[$wtCurrentWebSession];
windowhandles[sessionId_] := get["/session/" <> sessionId <> "/window_handles"];

getwindowsize[windowHandle_] := getwindowsize[$wtCurrentWebSession, windowHandle];
getwindowsize[sessionId_, windowHandle_] := get["/session/" <> sessionId <> "/window" <> windowHandle <> "/size"];
setwindowsize[windowHandle_, {width_, height_}] := setwindowsize[$wtCurrentWebSession, windowHandle, {width, height}];
setwindowsize[sessionId_, windowHandle_, {width_, height_}] := post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"width" -> width, "height" -> height}];

getwindowposition[windowHandle_] := getwindowposition[$wtCurrentWebSession, windowHandle];
getwindowposition[sessionId_, windowHandle_] :=  get["/session/" <> sessionId <> "/window" <> windowHandle <> "/position"];
setwindowposition[windowHandle_, {x_, y_}] := setwindowposition[$wtCurrentWebSession,windowHandle, {x, y}];
setwindowposition[sessionId_, windowHandle_, {x_, y_}] :=  post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"x" -> x, "y" -> y}];

windowmaximize[windowHandle_] := windowmaximize[$wtCurrentWebSession,windowHandle];
windowmaximize[sessionId_, windowHandle_] := post["/session/" <> sessionId <> "/window/" <> windowHandle <> "/maximize"];

element[data_] := element[$wtCurrentWebSession, data];
element[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element", data];

activeelement[] := activeelement[$wtCurrentWebSession];
activeelement[sessionId_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element/active"];

elements[data_] := elements[$wtCurrentWebSession, data];
elements[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/elements", data];

describe[elementId_] := describe[$wtCurrentWebSession, elementId];
describe[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element" <> elementId];

click[elementId_] := click[$wtCurrentWebSession, elementId];
click[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/click"];

submit[elementId_] := submit[$wtCurrentWebSession,elementId];
submit[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/submit"];

text[elementId_] := text[$wtCurrentWebSession,elementId];
text[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/text"];

name[elementId_] := name[$wtCurrentWebSession,elementId];
name[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/name"];

clear[elementId_] := clear[$wtCurrentWebSession,elementId];
clear[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/clear"];

selected[elementId_] := selected[$wtCurrentWebSession,elementId];
selected[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/selected"];

enabled[elementId_] := enabled[$wtCurrentWebSession,elementId];
enabled[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/enabled"];

displayed[elementId_] := displayed[$wtCurrentWebSession,elementId];
displayed[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/displayed"];

attribute[elementId_, attributeName_] := attribute[$wtCurrentWebSession, elementId, attributeName];
attribute[sessionId_, elementId_, attributeName_] :=  get["/session/" <> sessionId <> "/element/" <> elementId <> "/attribute/" <> attributeName];

equals[elementId1_,elementId2_] := equals[$wtCurrentWebSession,elementId1,elementId2];
equals[sessionId_, elementId1_, elementId2_] := get["/session/" <> sessionId <> "/element/" <> elementId1 <> "/equals/" <> elementId2];

size[elementId_] := size[$wtCurrentWebSession,elementId];
size[sessionId_, elementId_] := {"width", "height"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/size"];

location[elementId_] := location[$wtCurrentWebSession,elementId];
location[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location"];

locationinview[elementId_] := locationinview[$wtCurrentWebSession,elementId];
locationinview[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location_in_view"];

elementcssproperty[elementId_, propertyName_] := elementcssproperty[$wtCurrentWebSession,elementId,propertyName];
elementcssproperty[sessionId_, elementId_, propertyName_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/css/" <> propertyName];

value[elementId_, keyStrokeSequence_String] := value[$wtCurrentWebSession,elementId, keyStrokeSequence];
value[sessionId_, elementId_, keyStrokeSequence_String] := value[sessionId, elementId, Characters[keyStrokeSequence]];
value[sessionId_, elementId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/value", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];

keys[keyStrokeSequence_String] := keys[$wtCurrentWebSession, keyStrokeSequence];
keys[sessionId_, keyStrokeSequence_String] := keys[sessionId, Characters[keyStrokeSequence]];
keys[sessionId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/keys", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];
