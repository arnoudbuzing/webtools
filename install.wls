Print[];

(* uninstall old paclets first *)
paclets = PacletFind["WebUnit"];
Print["Found the following old paclets (uninstalling): ", Map[ #["Location"]&, paclets]];
Map[ PacletUninstall, paclets ];

(* install new version *)
directory = DirectoryName[$InputFileName];
Print["Using directory: ", directory];
files = FileNames["*.paclet", directory];
Print["Paclet file(s) found: ", files];
paclet = Last @ Sort @ files;
Print["Selecting paclet: ",paclet];
PacletInstall[paclet, IgnoreVersion -> True];
