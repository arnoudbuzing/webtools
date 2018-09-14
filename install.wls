(* uninstall old paclets first *)
paclets = PacletFind["WebTools"];
Print["Found the following old paclets (uninstalling): ", Map[ #["Location"]&, paclets]];
Map[ PacletUninstall, paclets ];

(* install new version *)
buildDirectory = FileNameJoin[{Directory[],"build"}];
Print["Using directory: ", buildDirectory];
files = FileNames["*.paclet", buildDirectory];
Print["Paclet file(s) found: ", files];
paclet = Last @ Sort @ files;
Print["Selecting paclet: ",paclet];
PacletInstall[paclet, IgnoreVersion -> True];
RebuildPacletData[];
