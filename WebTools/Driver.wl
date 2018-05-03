randomport[] := Module[{sock,port},
	sock=SocketOpen[Automatic];
	port=sock["DestinationPort"];
	Close[sock];
	ToString[port]
	]

getdriver[driver_,version_] := Module[{directory},
	directory= FileNameJoin[{ $WebToolsDirectory, "Driver", driver, $SystemID, version }];
	First[ FileNames["*",directory] ] (* assume only one driver per versioned directory *)
	]

(* driver object *)
DriverObject[assoc_Association][key_] := assoc[key];

DriverObject /: MakeBoxes[object:_DriverObject, form:(StandardForm|TraditionalForm)] := Module[{assoc=First[object]},
	BoxForm`ArrangeSummaryBox[DriverObject, object, None, {
		{BoxForm`SummaryItem[{"Driver: ", assoc["Driver"]}], BoxForm`SummaryItem[{"Version: ", assoc["Version"]}]},
	 	{BoxForm`SummaryItem[{"URL: ", assoc["URL"]}]}
	}, {
		{BoxForm`SummaryItem[{"Executable: ", assoc["Executable"]}]},
		{BoxForm`SummaryItem[{"Process: ", assoc["Process"]}]}
	}, form, "Interpretable" -> True]
];

(* execute once to start the standalone driver *)
StartDriver[] := StartDriver["Chrome", "2.37"];

StartDriver["Chrome"] := StartDriver["Chrome", "2.37"];
StartDriver["Firefox"] := StartDriver["Firefox", "0.20.0"];
StartDriver["Edge"] := StartDriver["Edge", "15063"];

StartDriver[driver_, version_] := Module[{executable,process,port},
  executable = getdriver[driver,version];
	port = randomport[];
	process=Switch[$OperatingSystem,
		"Windows",StartProcess[{executable,"--port="<>port}],
		"MacOSX",StartProcess[{executable,"--port="<>port}],
		"Unix",StartProcess[{"/usr/bin/env","--unset=LD_LIBRARY_PATH",executable,"--port="<>port}]
		];
	$CurrentDriverObject = DriverObject[ <| "Driver" -> driver, "Version" -> version, "Process" -> process, "URL" -> "http://localhost:"<>port, "Port" -> port, "Executable" -> executable |> ]
]

(* terminate the driver process *)
StopDriver[ driver_DriverObject ] := Module[{status},
	KillProcess[ driver["Process"] ];
	status=ProcessStatus[driver["Process"]]
]
