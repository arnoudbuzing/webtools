StartDriver::usage = "StartDriver[] launches the default web driver which allows Mathematica to communicate with a web browser.\n\
StartDriver[driver] launches the specified driver.\n\
StartDriver[\"Chrome\"] launches the driver for Chrome.\n\
StartDriver[\"Firefox\"] launches the driver for Firefox.\n\
StartDriver[\"Edge\"] launches the driver for Edge.";

StopDriver::usage = "StopDriver[driver] stops the process associated with 'driver'";

DriverObject::usage = "DriverObject[...] represents the driver launched by StartDriver.";

GetDrivers::usage = "GetDrivers[] gives the list of web drivers supported on your platform.\n\
GetDrivers[\"systemid\"] gives the list for the specified 'systemid' ($SystemID)";

(* Web session functions *)

StartBrowser::usage = "StartBrowser[driver] launches a new browser using the DriverObject 'driver'";
wtStopWebSession::usage = "wtStopWebSession[sessionid] stops the web session identified by 'sessionid'";
wtWebSessionStatus::usage = "wtWebSessionStatus[] returns status information for the current web session. wtWebSessionStatus[sessionid] returns status information for the specified 'sessionid'";
$currentsession::usage = "$currentsession holds the session identifier for the current web session.";
$wtWebSessions::usage = "$wtWebSessions returns the list of all open web sessions.";


wtOpenWebPage::usage = "wtOpenWebPage[url] opens the web page specified by 'url'";
wtRefreshWebPage::usage = "wtRefreshWebPage[] refreshes the currently open web page.";
wtPageBack::usage = "wtPageBack[] instructs the web browser to navigate to the previously visible page in its web session.";
wtPageForward::usage = "wtPageForward[] instructs the web browser to navigate to the next visible page in its web session and acts as the inverse operation of wtPageBack[].";
wtPageLinks::usage = "wtPageLinks[] returns the hyperlinks for the current active page.";

wtCaptureWebPage::usage = "wtCaptureWebPage[]";
wtSetBrowserWindow::usage = "wtSetBrowserWindow[windowid] changes the active browser window to the one specified by 'windowid'. A list of all window identifiers is given by wtBrowserWindows[].";
wtBrowserWindows::usage = "wtBrowserWindows[] returns a list of all window identifiers, that are open in a given web session.";

wtJavascriptExecute::usage = "wtJavascriptExecute[\"javascript\"] executes a piece of JavaScript in the current window";
wtLocateElement::usage = "wtLocateElement[id] returns";
wtClickElement::usage = "wtClickElement[id] clicks on the first web element identified by 'id'. wtClickElement[{id,n}] clicks the n-th matching element identified by 'id'. Typical elements are form submit buttons and hyperlinks.";
wtTypeElement::usage = "wtTypeElement[id, text] types 'text' into a web element identified by 'id'. Typical elements are input fields and text areas.";
wtClearElement::usage = "wtClearElement[id] clears text of a web elements identified by 'id'. Typical elements are input field and text areas.";
wtSubmitElement::usage = "";
wtHoverElement::usage = "wtHoverElement[id] clicks on the first web element identified by 'id'. wtClickElement[{id,n}] clicks the n-th matching element identified by 'id'. Typical elements are form submit buttons and hyperlinks.";
wtHideElement::usage = "";

wtFocusFrame::usage = "wtFocusFrame[id] gives focus to a web frame inside a web page. Typical usage is for giving focus to elements within <iframe> tags"

wtElementClassName::usage = "";
wtCssSelector::usage = "";
wtId::usage = "";
wtName::usage = "";
wtLinkText::usage = "";
wtPartialLinkText::usage = "";
wtTagName::usage = "";
wtXPath::usage = "";

wtSelector::usage="";

$wtWebDriver::usage = "";
$wtWebDriverBaseURL::usage = "";
(* Javascript based functions *)

wtGetPageHtml::usage = "Get HTML of current tab.";

wtGetHtml::usage = "Get part of HTML of current tab, search method include wtId[], wtXPath and wtSelector[].
Option \"Seletion\" could be set to \"inner\" or \"outer\" which control the returned part of the selected HTML segment.";

wtGetPageURL::usage = "Get URL of current tab.";

wtOffAlert::usage = "wtOffAlert[] would turn off all bump up windows including alerts(), confirm() and prompt() and automatically confirm them."
