(*
status::usage = "";
sessions::usage = "";
setsession::usage = "";
getsession::usage = "";
forward::usage = "";
back::usage = "";
refresh::usage = "";
execute::usage = "";
availableengines::usage = "";
activeengine::usage = "";
activated::usage = "";
deactivate::usage = "";
activate::usage = "";
frame::usage = "";
geturl::usage = "";
seturl::usage = "";
screenshot::usage = "";
getcookie::usage = "";
setcookie::usage = "";
deletecookie::usage = "";
title::usage = "";
source::usage = "";
getorientation::usage = "";
setorientation::usage = "";
getalerttext::usage = "";
setalerttext::usage = "";
acceptalert::usage = "";
dismissalert::usage = "";
localstorage::usage = "";
moveto::usage = "";
setwindow::usage = "";
deletewindow::usage = "";
windowhandle::usage = "";
windowhandles::usage = "";
getwindowsize::usage = "";
setwindowsize::usage = "";
getwindowposition::usage = "";
setwindowposition::usage = "";
windowmaximize::usage = "";
element::usage = "";
activeelement::usage = "";
elements::usage = "";
describe::usage = "";
click::usage = "";
submit::usage = "";
text::usage = "";
name::usage = "";
clear::usage = "";
selected::usage = "";
enabled::usage = "";
displayed::usage = "";
attribute::usage = "";
equals::usage = "";
size::usage = "";
location::usage = "";
locationinview::usage = "";
elementcssproperty::usage = "";
value::usage = "";
keys::usage = "";
*)

(* web driver api *)

status[] := get["/status"];

sessions[] := get["/sessions"];

setsession[] := setsession[$WebDriver];
setsession["Chrome"] := ($CurrentWebSession = post["/session", {"desiredCapabilities" -> {"browserName" -> "chrome"}}, "sessionId"]);
setsession["InternetExplorer"] := ($CurrentWebSession = post["/session", {"desiredCapabilities" -> {"browserName" -> "internet explorer"}}, "sessionId"]);
setsession["Edge"] := ($CurrentWebSession = post["/session", {"desiredCapabilities" -> {}, "requiredCapabilities"->{}}, "sessionId"]);
getsession[sessionId_] := get["/session/" <> sessionId];

forward[] := forward[$CurrentWebSession];
forward[sessionId_] := post["/session/" <> sessionId <> "/forward"];

back[] := back[$CurrentWebSession];
back[sessionId_] := post["/session/" <> sessionId <> "/back"];

refresh[] := refresh[$CurrentWebSession];
refresh[sessionId_] := post["/session/" <> sessionId <> "/refresh"];

execute[script_, args_] := execute[$CurrentWebSession, script, args];
execute[sessionId_, script_, args_] := post["/session/" <> sessionId <> "/execute", {"script" -> script, "args" -> args}];

availableengines[] := availableengines[$CurrentWebSession];
availableengines[sessionId_] := get["/session/" <> sessionId <> "/available_engines"];

activeengine[] := activeengine[$CurrentWebSession];
activeengine[sessionId_] := get["/session/" <> sessionId <> "/active_engine"];

activated[] := activated[$CurrentWebSession];
activated[sessionId_] := get["/session/" <> sessionId <> "/activated"];

deactivate[] := deactivate[$CurrentWebSession];
deactivate[sessionId_] := post["/session/" <> sessionId <> "/deactivate"];

activate[] := activate[$CurrentWebSession];
activate[sessionId_, engine_] := post["/session/" <> sessionId <> "/activate", {"engine" -> engine}];

frame[] := frame[Null];
frame[elementId_] := frame[$CurrentWebSession,elementId];
frame[sessionId_, elementId_] := post["/session/" <> sessionId <> "/frame", {"id" -> If[elementId===Null,Null,{"ELEMENT"->elementId}]}];

geturl[] := geturl[$CurrentWebSession];
geturl[sessionId_] := get["/session/" <> sessionId <> "/url"];
seturl[url_] := seturl[$CurrentWebSession,url];
seturl[sessionId_, url_] := post["/session/" <> sessionId <> "/url", {"url" -> url}];

screenshot[] := screenshot[$CurrentWebSession];
screenshot[sessionId_] := ImportString[get["/session/" <> sessionId <> "/screenshot"], "Base64"];

getcookie[] := cookie[$CurrentWebSession];
getcookie[sessionId_] := get["/session/" <> sessionId <> "/cookie"];
setcookie[cookie_] := setcookie[$CurrentWebSession,cookie];
setcookie[sessionId_, cookie_] := post["/session/" <> sessionId <> "/cookie", {"cookie" -> cookie}];
deletecookie[] := deletecookie[$CurrentWebSession];
deletecookie[sessionId_] := delete["/session/" <> sessionId <> "/cookie"];

title[] := title[$CurrentWebSession];
title[sessionId_] := get["/session/" <> sessionId <> "/title"];

source[] := source[$CurrentWebSession];
source[sessionId_] := get["/session/" <> sessionId <> "/source"];

getorientation[] := orientation[$CurrentWebSession];
getorientation[sessionId_] := get["/session/" <> sessionId <> "/orientation"];
setorientation[orientation_] := setorientation[$CurrentWebSession,orientation];
setorientation[sessionId_, orientation_] := post["/session/" <> sessionId <> "/orientation", {"orientation" -> orientation}];

getalerttext[] := getalerttext[$CurrentWebSession];
getalerttext[sessionId_] := get["/session/" <> sessionId <> "/alert_text"];
setalerttext[text_] := setalerttext[$CurrentWebSession,text];
setalerttext[sessionId_, text_] := post["/session/" <> sessionId <> "/alert_text", {"text" -> Characters[text]}];

acceptalert[] := acceptalert[$CurrentWebSession];
acceptalert[sessionId_] := post["/session/" <> sessionId <> "/accept_alert"];

dismissalert[] := dismissalert[$CurrentWebSession];
dismissalert[sessionId_] := post["/session/" <> sessionId <> "/dismiss_alert"];

localstorage[] := localstorage[$CurrentWebSession];
localstorage[sessionId_] := get["/session/" <> sessionId <> "/local_storage"];

moveto[elementId_] := moveto[$CurrentWebSession, elementId];
moveto[sessionId_, elementId_] := post["/session/" <> sessionId <> "/moveto", {"element" -> elementId}];

setwindow[window_] := setwindow[$CurrentWebSession,window];
setwindow[sessionId_, window_] := post["/session/" <> sessionId <> "/window", {"name" -> window}];
deletewindow[] := deletewindow[$CurrentWebSession];
deletewindow[sessionId_] := delete["/session/" <> sessionId <> "/window"];

windowhandle[] := windowhandle[$CurrentWebSession];
windowhandle[sessionId_] := get["/session/" <> sessionId <> "/window_handle"];

windowhandles[] := windowhandles[$CurrentWebSession];
windowhandles[sessionId_] := get["/session/" <> sessionId <> "/window_handles"];

getwindowsize[windowHandle_] := getwindowsize[$CurrentWebSession, windowHandle];
getwindowsize[sessionId_, windowHandle_] := get["/session/" <> sessionId <> "/window" <> windowHandle <> "/size"];
setwindowsize[windowHandle_, {width_, height_}] := setwindowsize[$CurrentWebSession, windowHandle, {width, height}];
setwindowsize[sessionId_, windowHandle_, {width_, height_}] := post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"width" -> width, "height" -> height}];

getwindowposition[windowHandle_] := getwindowposition[$CurrentWebSession, windowHandle];
getwindowposition[sessionId_, windowHandle_] :=  get["/session/" <> sessionId <> "/window" <> windowHandle <> "/position"];
setwindowposition[windowHandle_, {x_, y_}] := setwindowposition[$CurrentWebSession,windowHandle, {x, y}];
setwindowposition[sessionId_, windowHandle_, {x_, y_}] :=  post["/session/" <> sessionId <> "/window" <> windowHandle <> "/size", {"x" -> x, "y" -> y}];

windowmaximize[windowHandle_] := windowmaximize[$CurrentWebSession,windowHandle];
windowmaximize[sessionId_, windowHandle_] := post["/session/" <> sessionId <> "/window/" <> windowHandle <> "/maximize"];

element[data_] := element[$CurrentWebSession, data];
element[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element", data];

activeelement[] := activeelement[$CurrentWebSession];
activeelement[sessionId_] := "ELEMENT" /. post["/session/" <> sessionId <> "/element/active"];

elements[data_] := elements[$CurrentWebSession, data];
elements[sessionId_, data_] := "ELEMENT" /. post["/session/" <> sessionId <> "/elements", data];

describe[elementId_] := describe[$CurrentWebSession, elementId];
describe[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element" <> elementId];

click[elementId_] := click[$CurrentWebSession, elementId];
click[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/click"];

submit[elementId_] := submit[$CurrentWebSession,elementId];
submit[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/submit"];

text[elementId_] := text[$CurrentWebSession,elementId];
text[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/text"];

name[elementId_] := name[$CurrentWebSession,elementId];
name[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/name"];

clear[elementId_] := clear[$CurrentWebSession,elementId];
clear[sessionId_, elementId_] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/clear"];

selected[elementId_] := selected[$CurrentWebSession,elementId];
selected[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/selected"];

enabled[elementId_] := enabled[$CurrentWebSession,elementId];
enabled[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/enabled"];

displayed[elementId_] := displayed[$CurrentWebSession,elementId];
displayed[sessionId_, elementId_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/displayed"];

attribute[elementId_, attributeName_] := attribute[$CurrentWebSession, elementId, attributeName];
attribute[sessionId_, elementId_, attributeName_] :=  get["/session/" <> sessionId <> "/element/" <> elementId <> "/attribute/" <> attributeName];

equals[elementId1_,elementId2_] := equals[$CurrentWebSession,elementId1,elementId2];
equals[sessionId_, elementId1_, elementId2_] := get["/session/" <> sessionId <> "/element/" <> elementId1 <> "/equals/" <> elementId2];

size[elementId_] := size[$CurrentWebSession,elementId];
size[sessionId_, elementId_] := {"width", "height"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/size"];

location[elementId_] := location[$CurrentWebSession,elementId];
location[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location"];

locationinview[elementId_] := locationinview[$CurrentWebSession,elementId];
locationinview[sessionId_, elementId_] := {"x", "y"} /. get["/session/" <> sessionId <> "/element/" <> elementId <> "/location_in_view"];

elementcssproperty[elementId_, propertyName_] := elementcssproperty[$CurrentWebSession,elementId,propertyName];
elementcssproperty[sessionId_, elementId_, propertyName_] := get["/session/" <> sessionId <> "/element/" <> elementId <> "/css/" <> propertyName];

value[elementId_, keyStrokeSequence_String] := value[$CurrentWebSession,elementId, keyStrokeSequence];
value[sessionId_, elementId_, keyStrokeSequence_String] := value[sessionId, elementId, Characters[keyStrokeSequence]];
value[sessionId_, elementId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/element/" <> elementId <> "/value", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];

keys[keyStrokeSequence_String] := keys[$CurrentWebSession, keyStrokeSequence];
keys[sessionId_, keyStrokeSequence_String] := keys[sessionId, Characters[keyStrokeSequence]];
keys[sessionId_, keyStrokeSequence_List] := post["/session/" <> sessionId <> "/keys", {"value" -> (keyStrokeSequence /. NonTextKeys[])}];
