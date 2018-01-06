// Dog follower
BURK_dogFollowing = true;
JohnOplayerHasDog = true;

BURK_dog playMove "Dog_Run";
Dogfollow = player addAction ["Dog: Follow", {BURK_dog playMove "Dog_Run"; [] call BURK_dogFollowPlayer;}];

dogseek = player addAction ["Dog: Seek", {titleText ["Your dog will seekout animals..","PLAIN DOWN"];[] call BURK_dogSeek;}];
Dogpassive = player addAction ["Dog: Kill","custom\dogs\agressive.sqf","",0,false];

Dogstay = player addAction ["Dog: Stay", {BURK_dog playMove "Dog_Sit";}];

Dogrun = player addAction ["Dog: Run", {BURK_dog playMove "Dog_Run";}];
Dogsprint = player addAction ["Dog: Sprint", {BURK_dog playMove "Dog_Sprint";}];


/*
DogGetIn = player addAction ["Dog: Get In",{player=_this select 0;{BURK_dog attachto [vehicle player,(vehicle player) worldToModel (player modelToWorld [0,0,0])}]; //addaction getin


DogGetOut = player addAction ["Dog: Get Out",{player=_this select 0;{detach BURK_dog}}]; //addaction getout


player addaction ["Dog: Get In",{
player=_this select 0;{BURK_dog attachto [vehicle player,(vehicle player) worldToModel (player modelToWorld [0,0,0])]} foreach (player getvariable "MyDogs");player setvariable ["Dogonboard",true];
},nil,0,false,true,"",'(!isnull objectparent _this)&&!(_this getvariable "Dogonboard")']; //addaction getin
player addaction ["Dog: Get Out",{
player=_this select 0;{detach BURK_dog} foreach (player getvariable ["MyDogs",[]]);player setvariable ["Dogonboard",false];
},nil,0,false,true,"",'(isnull objectparent _this)&&(_this getvariable "Dogonboard")']; //addaction getout
*/

BURK_dogStopFollowing = 
{
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", false];
	BURK_dogFollowing = false;

	BURK_dog playMove "Dog_Idle_Stop";	
};

/** 

//start get in vehicle


inVehicle = false;


inVehicleCheck = 
{
	if !(inVehicle) then // if false check if in vehicle
	{	
		if (vehicle player != player) then // if in vehicle
		{
			inVehicle = true;
			
			_vehicleObject = vehicle player;
			BURK_dog attachTo [_vehicleObject, [0.00683594,-1.80609,-1.31031]];  
			player removeAction Dogfollow;
			player removeAction dogseek;
			player removeAction Dogpassive;
			player removeAction Dogstay;
			player removeAction Dogrun;
			player removeAction Dogsprint;
			player removeAction agressiveAction;
			player removeAction passiveAction;

			BURK_dogFollowing = false;
			BURK_dogSeeking = false;

		}
		else // run this when player gets out of vehicle..
		{
			if (inVehicle) then //only recreate the dog if inVehicle was set true
			{	
				inVehicle = false; // set it to false to check again
				//BURK_dog setpos [getpos BURK_dog select 0,getpos BURK_dog select 5,0];
				
				detach BURK_dog;
				deleteVehicle BURK_dog;
				//BURK_dog setpos [((getpos player) select 0) + 2,((getpos player) select 1) + 2,0];
				BURK_dog = createAgent ["Alsatian_Black_F", getPos player, [], 5, "CAN_COLLIDE"];

				BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

				[] execVM "JohnO_fnc_dogFollow.sqf";
			};
		};
	};
};

[5, inVehicleCheck, [], true] call ExileClient_system_thread_addtask;

//end get in vehicle   **/

[] call BURK_dogFollowPlayer;