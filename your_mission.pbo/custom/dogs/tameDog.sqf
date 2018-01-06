_allowedDistance = 3;

_cursorTarget = cursorObject;

_typeOfCursorTarget = typeOf _cursorTarget;

_dogArray =  ["Alsatian_Random_F","Alsatian_Sandblack_F","Alsatian_Black_F","Alsatian_Sand_F","Fin_tricolour_F","Fin_ocherwhite_F"];

_isAlive = alive _cursorTarget;

if (_typeOfCursorTarget in _dogArray) then
{
	if (isNil "JohnOplayerHasDog") then 
	{
		JohnOplayerHasDog = false;
	};
	//if (playerHasDog == 1) then
	if !(JohnOplayerHasDog) then
	{
			if (("Exile_Item_BeefParts" in (magazines player)) || ("Exile_Item_DogFood" in (magazines player))) then
			{
				_caller = _this select 0;
				_action = _this select 2;
				_caller removeAction _action;
				JohnOplayerHasDog = true;

				_dogActual = _typeOfCursorTarget;
				_dogPos = getPos _cursorTarget;
				deleteVehicle _cursorTarget;

				BURK_dog = createAgent [_dogActual,_dogPos, [], 5, "CAN_COLLIDE"];

				BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
				[BURK_dog,player] say3d "whistle";
				[BURK_dog,player] say3d "whistle";
				[BURK_dog,player] say3d "dog_whine";
				[BURK_dog,player] say3d "dog_ruff";

				BURK_dog say3d "whistle"; //28.07.17 ADDED by AUSSIE
				BURK_dog say3d "whistle"; //28.07.17 ADDED by AUSSIE
				BURK_dog say3d "dog_whine"; //28.07.17 ADDED by AUSSIE
				BURK_dog say3d "dog_ruff"; //28.07.17 ADDED by AUSSIE
				Agressive = false;
				
				[] execVM "custom\dogs\JohnO_fnc_dogFollow.sqf";

			}
			else
			{
				titleText ["The dog wants beef parts or raw dog food....","PLAIN DOWN"];
			};
	}
	else
	{
		titleText ["You already own a dog...","PLAIN DOWN"];
	};
}
else
{
	titleText ["This animal cannot be tamed..","PLAIN DOWN"];
};	
