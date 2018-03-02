Print[];
directory = DirectoryName[$InputFileName];
Print["Using directory: ", directory];
files = FileNames["*.paclet", directory];
Print["Found paclets (to be deleted): ", files];
DeleteFile /@ files;
Print["Building new paclet"];
paclet = PackPaclet[FileNameJoin[{directory, "WebUnit"}]];
Print["New paclet: ", paclet];
