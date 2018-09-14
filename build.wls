PacletUninstall["WebTools"];

(* copy source files to build directory *)

sourceDirectory = FileNameJoin[{Directory[],"WebTools"}];
Print["Using sourceDirectory: ", sourceDirectory];

buildDirectory = FileNameJoin[ { Directory[], "build", "WebTools" } ];
Print["Using buildDirectory: ", buildDirectory];

DeleteDirectory[ buildDirectory, DeleteContents->True ];
(*
CreateDirectory[ buildDirectory ];
*)

CopyDirectory[sourceDirectory, buildDirectory];

(* build documentation *)

Get["DocumentationBuild`"];
files = FileNames["*.nb", FileNameJoin[{buildDirectory, "Documentation"}], Infinity];
Print["files: ", files];
Scan[
 Function[{file},
  Module[{source},
   source = RenameFile[file, file <> "-source"];
   MakeNotebook[source, "RasterizeOutput" -> False, "outfile" -> file];
   DeleteFile[source];
   ]],
 files]

(* create index *)

Get["DocumentationSearch`"];

index = FileNameJoin[{buildDirectory, "Documentation", "English", "SearchIndex", "2"}];
Print["index: ", index];
CreateDirectory[index];
DocumentationSearch`CreateDocumentationIndex[
 files,
 FileNameDrop[index, -1],
 "2",
 OverwriteTarget -> True
 ]

ReinstallJava[]

(* create paclet *)

Print["Building new paclet"];
paclet = PackPaclet[ buildDirectory, ParentDirectory @ buildDirectory ];
Print["New paclet: ", paclet];
