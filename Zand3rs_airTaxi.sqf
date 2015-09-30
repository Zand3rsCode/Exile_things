/*
	This script needs to be spawned, as it uses waitUntil()

	This does not handle the death of pilot and/or chopper.
*/

private ["_positionOfSmokeGrenade", "_flyHeight", "_group", "_startPosition", "_pilot", "_waypoint"];

_positionOfSmokeGrenade = _this select 0;

if (isNil "Zand3rsChopper") then
{
	_flyHeight = 60;

	// Find a start position 1km away from the smoke grenade
	_startPosition = [_positionOfSmokeGrenade, 1000, random 360] call ExileClient_util_math_getPositionInDirection;
	_startPosition set [2, _flyHeight];

	// Create a new group, so we dont trigger waypoint statements
	_group = createGroup independent;

	// Create the pilot
	// Put new units in the same group as the player
	_pilot = _group createUnit ["I_helipilot_F", [0, 0, _flyHeight], [], 1, "PRIVATE"];
 	_pilot setSkill 1;

 	// Dress the pilot accordingly :)
	removeUniform _pilot;
	_pilot forceAddUniform "Exile_Uniform_ExileCustoms";

	Zand3rsChopper = createVehicle ["Exile_Chopper_Hummingbird_Civillian_Blue", _startPosition, [], 0, "FLY"];

	// Clear possible chopper cargo
	clearBackpackCargoGlobal Zand3rsChopper;
	clearItemCargoGlobal Zand3rsChopper;
	clearMagazineCargoGlobal Zand3rsChopper;
	clearWeaponCargoGlobal Zand3rsChopper;

	// Move in the pilot
	_pilot assignAsDriver Zand3rsChopper;
	_pilot moveInDriver Zand3rsChopper;

	// Position
	Zand3rsChopper setPosATL _startPosition;

	// Make it look into the direction of our smoke grenade
	Zand3rsChopper setDir ([_startPosition, _positionOfSmokeGrenade] call BIS_fnc_dirTo);

	// Make it fly
	Zand3rsChopper setFuel 1;
	Zand3rsChopper engineOn true;
	Zand3rsChopper setVehicleAmmo 0;
	Zand3rsChopper flyInHeight _flyHeight;

	// Lock the pilot position, so players cannot fly away
	Zand3rsChopper lockDriver true;

	// Disable the copilot "Take Controls" feature
	Zand3rsChopper enableCopilot false;

	// The pilot should not care about enemies
	Zand3rsChopper setBehaviour "CARELESS";
	Zand3rsChopper setCaptive  true;
 	Zand3rsChopper disableAI "TARGET";
 	Zand3rsChopper disableAI "AUTOTARGET";

	// Land next to the smoke grenade, land and keep the engine on
	_waypoint = (group Zand3rsChopper) addWaypoint [_positionOfSmokeGrenade, 50];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointVisible true;
	_waypoint setWaypointStatements ["true", "Zand3rsChopper land 'GET IN'"];


	
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

	// Remove the old waypoint
	deleteWaypoint _waypoint;

	// Fly to the trader city, land and keep the engine on
	_waypoint = (group Zand3rsChopper) addWaypoint [[14599, 16797, 0], 50];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointVisible true;
	_waypoint setWaypointCompletionRadius 50;
	_waypoint setWaypointStatements ["true", "Zand3rsChopper land 'GET OUT'"];

	// Wait until the player is out (or ejected the chopper :D)
	waitUntil { !(player in (crew Zand3rsChopper)) };

	// Prevent ppl from getting in
	Zand3rsChopper lockCargo true;

	// Fly away
	_waypoint = (group Zand3rsChopper) addWaypoint [[0, 0, 0], 50];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointVisible true;
	_waypoint setWaypointCompletionRadius 50;

	// Wait 30 seconds
	uiSleep 30;

	// Cleanup
	deleteWaypoint _waypoint;
	deleteVehicle _pilot;
	deleteVehicle Zand3rsChopper;
	deleteGroup _group;

	Zand3rsChopper = nil;
};