BeginPackage["WebTools`", {"CloudObject`", "CURLLink`"}];

Get[ FileNameJoin[{DirectoryName[$InputFileName], "Usage.wl"}] ];
Get[ FileNameJoin[{DirectoryName[$InputFileName], "Messages.wl"}] ];

Begin["`Private`"];

$WebToolsDirectory = DirectoryName[$InputFileName];

files = {	"Driver.wl", "Browser.wl", "Javascript.wl", "Page.wl", "WebDriverAPI.m", "Utilities.m"};
Map[ Get[ FileNameJoin[{DirectoryName[$InputFileName], #}] ] &, files ];

End[];
EndPackage[];
