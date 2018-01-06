BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
BURK_dogFollowing = false;
BURK_dogSeeking = true;

private ["_safeZoneLocations","_safeZone"];

_safeZoneLocations = [[4936.08,6530.2,0],[2841.43,7517.61,0],[705.254,12229,0],[2747.54,7587.09,0],[7720.23,6193.19,0],[7721.81,6219.78,0],[617.054,12015.5,0]];

while {BURK_dogSeeking} do 
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
	};	
	if !(alive BURK_dog) exitWith 
	{
		player removeAction Dogfollow;
		player removeAction Dogseek;
		player removeAction Dogpassive;
		player removeAction Dogstay;
		player removeAction Dogrun;
		player removeAction Dogsprint;
		player removeAction agressiveAction;
		player removeAction passiveAction;
		playerHasDog = false;
	};
	_dogPos = getPos BURK_dog;

	_target = _dogPos nearEntities ["Man",150];

	_distanceArray = [];
	{
			

		if ((_x isKindOf "animal") && !(_x == BURK_dog)) then
		{	
			_tar = player distance _x;
			_distanceArray = _distanceArray + [[_tar,_x]];
		};
			
	} forEach _target;
		
	if ((alive BURK_dog) && !(_distanceArray isEqualTo [])) then 
	{
		_distanceArray sort true;

		_actualTarget = (_distanceArray select 0) select 1;
		_targetPos = getPos _actualTarget;
		_distanceToTarget = BURK_dog distance _actualTarget;

		if ((random 1 > 0.5) && (_distanceToTarget > 2)) then
		{	
			[BURK_dog,_actualTarget] say3d "dog_one";
		};

		BURK_dog moveTo _targetPos;

		if (_distanceToTarget < 2) then
		{
			BURK_dog playMove "Dog_Sit";
			if (random 1 > 0.5) then
			{
				BURK_dog say3d "whistle";
				uiSleep 0.5;
				BURK_dog say3d "dog_whine";
				player say3d "whistle";
				BURK_dog say3d "bark2";
			};	
		}
		else
		{
			BURK_dog moveTo _targetPos;
		};	

	}
	else
	{
		_playerpos = position player;
		_randomPos = [(_playerpos select 0) + random (150) - random (150), (_playerpos select 1) + random (150) - random (150)];
		BURK_dog moveTo _randomPos;
	};	
	uiSleep 1;
};	