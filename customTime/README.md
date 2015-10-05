
@ExileServer\addons\exile_server\bootstrap\fn_preInit.sqf

Add execWM At the bottom like below!

// Call custom buildings below but before call "ExileServer_system_process_preInit;"
[] execVM "customTime\SpeedTime.sqf";
call ExileServer_system_process_preInit;
true
