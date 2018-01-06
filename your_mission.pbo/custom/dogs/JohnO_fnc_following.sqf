BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

BURK_dogFollowing = true;
BURK_dogSeeking = false;

private ["_safeZoneLocations","_safeZone"];

_safeZoneLocations = [[4936.08,6530.2,0],[2841.43,7517.61,0],[705.254,12229,0],[2747.54,7587.09,0],[7720.23,6193.19,0],[7721.81,6219.78,0],[617.054,12015.5,0]];

//_safeZoneLocations = [[0,0,0],[0,0,0]];

while {BURK_dogFollowing} do 
{
	_safeZone = false;
	{
		if (player distance _x < 200) then
		{
			_safeZone = true;
		};
	} forEach _safeZoneLocations;

	if (_safeZone) then
	{
		BURK_dog playMove "Dog_Sit";
		playSound3D [call currMissionDir + "custom\dogs\sounds\dog_ruff.ogg", BURK_dog, false, getPosASL BURK_dog, 1, 1, 50];

	}
	else
	{
	
		if !(alive BURK_dog) exitWith 
		{
			player removeAction Dogfollow;
			player removeAction dogseek;
			player removeAction Dogpassive;
			player removeAction Dogstay;
			player removeAction Dogrun;
			player removeAction Dogsprint;
			player removeAction agressiveAction;
			player removeAction passiveAction;
			playerHasDog = false;
		};
		if ((alive BURK_dog) && !(Agressive)) then 
		{
			BURK_dog moveTo getPos player;				
		};
		if ((alive BURK_dog) && (Agressive)) then 
		{
			// Scan
			_dogPos = getPos BURK_dog;

			_target = _dogPos nearEntities ["Man",50];
		
			_distanceArray = [];
			{
				if ((_x in units group player) || (_x == player) || (_x isKindOf "animal")) then
				{
					
				}
				else
				{	
					_tar = player distance _x;
					_distanceArray = _distanceArray + [[_tar,_x]];
				};	
			} forEach _target;

			if ((alive BURK_dog) && !(_distanceArray isEqualTo []) && (Agressive)) then 
			{
				_distanceArray sort true;
				_actualTarget = (_distanceArray select 0) select 1;
				_targetPos = getPos _actualTarget;

				_damage = damage _actualTarget;
				//hint str _distanceArray;
				if (random 1 > 0.5) then
				{	
					[BURK_dog,_actualTarget] say3d "growls3";
				};	

				BURK_dog moveTo _targetPos;

				if (BURK_dog distance _actualTarget < 2) then
				{
					[BURK_dog,_actualTarget] say3d "growls3"; //only the dog owner can here this sound...
					_dir = getDir BURK_dog;
					BURK_dog attachTo [_actualTarget, [0, -0.5, 0.1] ];
					_actualTarget say3d "pain";
					BURK_dog setDir _dir;
					[BURK_dog,_actualTarget] say3d "barkmean1";
					uiSleep 0.5; 
					_actualTarget setDamage _damage + 0.2;
					_actualTarget playMove "AmovPpneMstpSrasWrflDnon";
					detach BURK_dog;
					uiSleep 0.15; 
				};		
			}
			else	
			{
				BURK_dog moveTo getPos player;	
			};	
		};
		uiSleep 1;
	};
	uiSleep 1;	
};