
	while {true} do {

	// Wait until player gets in the chopper
	waitUntil { player in (crew Zand3rsChopper) };		

	// If player dead chopper goes away
	if (!(alive player)) then {

	deleteWaypoint _waypoint;
	deleteVehicle _pilot;
	deleteVehicle Zand3rsChopper;
	deleteGroup _group;
	Zand3rsChopper = nil;
};

