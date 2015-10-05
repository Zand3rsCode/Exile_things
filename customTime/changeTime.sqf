if (!isServer) exitWith {};
while {true} do {

	// after 7pm and before 5am time multiplier changes
	if (daytime >= 19 || daytime < 5) then  {

		// adjust this value for slower or faster night cycle ( 24 hours will take 1 hour )
		setTimeMultiplier 20
	} 
	else { 

		// adjust this value for slower or faster day cycle  ( 12 hours will take 1 hour )
		setTimeMultiplier 5      
		};

	uiSleep 30;
};