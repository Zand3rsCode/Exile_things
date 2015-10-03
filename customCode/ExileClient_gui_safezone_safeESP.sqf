/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_espRenderRange","_vehicle","_velocity","_direction","_distance","_alpha","_clr","_crew","_veh","_bbr","_p1","_p2","_maxHeight","_pos"];
_espRenderRange = _this;
_vehicle = vehicle player;
if (local _vehicle) then 
{
	if (_vehicle isKindOf "LandVehicle") then 
	{
			if ((speed _vehicle) > 500) then // Just added 500 to remove glitch.. /Zand3rs
		{
			_velocity = velocity _vehicle;
			_direction = direction _vehicle;
			_vehicle setVelocity 
			[
				((sin _direction) * 5.5556),
				((cos _direction) * 5.5556),
				(_velocity select 2)
			];
		};
	};
};
if (!isNull cameraOn) then
{
	{
		if (!isNull _x) then
		{
			if (isPlayer _x) then
			{
				_distance = cameraOn distance _x;
				_alpha = (1-(_distance/_espRenderRange));
				_clr = [1,1,1,_alpha];	
				_crew = crew (vehicle _x);
				_name = '';
				{
					if(_forEachIndex == 0) then
					{
						_name = _name + format['%1',name _x];
					}
					else
					{
						if(alive _x) then {_name = _name + format[', %1',name _x];};
					};
				}
				forEach _crew;
				_veh = vehicle _x;
				_bbr = boundingBoxReal _veh;
				_p1 = _bbr select 0;
				_p2 = _bbr select 1;
				_maxHeight = (abs ((_p2 select 2) - (_p1 select 2))) * 1.25; 
				_pos = visiblePosition _veh;
				_pos set[2,(_pos select 2) + _maxHeight];
				drawIcon3D['',_clr,_pos,0,0,0,_name,1,0.04];
			};
		};
	}
	forEach ((cameraOn nearEntities[['Exile_Unit_Player', 'LandVehicle', 'Ship', 'Air'], _espRenderRange]) - [cameraOn, vehicle cameraOn]);
};
true