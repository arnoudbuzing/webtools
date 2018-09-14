sourceDirectory = FileNameJoin[{Directory[],"WebTools"}];
Print["Using sourceDirectory: ", sourceDirectory];
buildDirectory = FileNameJoin[ { Directory[], "build" } ];
Print["Using buildDirectory: ", buildDirectory];

Quiet @ DeleteDirectory[ buildDirectory, DeleteContents->True ];
CreateDirectory[buildDirectory];

Print["Building new paclet"];
paclet = PackPaclet[ sourceDirectory, buildDirectory ];
Print["New paclet: ", paclet];
