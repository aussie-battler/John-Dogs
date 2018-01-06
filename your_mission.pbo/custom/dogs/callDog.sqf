/*

	Add this to object to call dog

	BURK_dog = this addAction ["Call Dog","callDog.sqf","",0,false];
*/

//if (playerHasDog == 1) then

if (isNil "JohnOplayerHasDog") then 
{
	JohnOplayerHasDog = false;
};

if !(JohnOplayerHasDog) then
{

	if (("Exile_Item_BeefParts" in (magazines player)) || ("Exile_Item_DogFood" in (magazines player))) then
	{
		_caller = _this select 0;
		_action = _this select 2;
		_caller removeAction _action;
		JohnOplayerHasDog = true;
		_dogArray = ["Alsatian_Random_F","Alsatian_Sandblack_F","Alsatian_Black_F","Alsatian_Sand_F","Fin_tricolour_F","Fin_ocherwhite_F"];

		_randomDog = selectRandom _dogArray;

		BURK_dog = createAgent [_randomDog, getPos player, [], 5, "CAN_COLLIDE"];

		BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

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

