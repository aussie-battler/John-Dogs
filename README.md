## John Dogs for Arma3 Exile: made by JohnO

**About JohnO:** JohnO created this script and many others for Arma3 Exile. Unfortunately JohnO left Exile but was kind enough to let me release the script again. Some of JohnO's work includes Exile Reborn, Weather Script, Travelling Traders, Air Drops and Mission Events.

**Description:** Spawn an ai dog from your XM8 and command it. 

**How it works:** Deploy a dog from your Xm8 using x1 beef parts. Scroll on the spawned dog with another set of beef parts & choose "Tame Animal". The dog can now be commanded. 

**Rules:** 
+ Can't deploy the dog in a safe zone (you have to set the safe zones up in the file JohnO_fnc_following.sqf). 
+ You can only have one dog per restart. 


**Install: John Dogs from your XM8.**

1. Install ExAd by @Janski https://goo.gl/VBxFFa

2. Drop the DeployVehicle folder into your.mission\ExAdClient\XM8\Apps\DeployVehicle
   
3. Drop the Deploy Vehicle server file in your @ExileServer/addons/exad_dv.pbo 

4. In config.cpp search for class CFGXM8

Add the following to extraApps[] = { };

"ExAd_Dog" 

The line should now read:  
```
extraApps[] = {"ExAd_Dog"};
```
5. Underneath the extraApps line add:
```
class CfgXM8

{
	extraApps[] = {"ExAd_Dog"}; 
	
	class ExAd_Dog
	{
		title = "Attack Dog: x2 Beef Parts needed";
		config = "ExAdClient\XM8\Apps\DeployVehicle\dog_config.sqf";
		logo = "ExAdClient\XM8\Apps\DeployVehicle\dog.paa";
		bambiState = 0;
		vehicleClass = "Alsatian_Black_F";
		recipe[] = {{"Exile_Item_Dogfood",1}};
		packable = 0;
		autoCleanUp = 0;
		quickFunction = "['ExAd_Dog'] call ExAd_XM8_DV_fnc_spawnVehicle";
	};
}; 
```

(change XM8_App01_Button to the app number that is spare eg. "XM8_App01_Button","XM8_App02_Button") 
```
class XM8_App01_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "ExAdClient\XM8\Apps\DeployVehicle\dog.paa";
    text = "Attack Dog: x2 Dog Food needed";
    onButtonClick = "['ExAd_Dog'] call ExAd_XM8_DV_fnc_spawnVehicle";
    resource = "";
}; 
```

6. Add this line to your config.cpp file Custom Code Section:
```
class CfgExileCustomCode 
{
	//JohnO Dogs
	ExileClient_object_player_initialize = "custom\dogs\ExileClient_object_player_initialize.sqf";
};
```
Now drop the "custom" folder into your.mission.pbo

7. Add this line in your description.ext file:

```
	class CfgSounds
	{
		#include "custom\dogs\sounds\defines.hpp"
	};

```
+ note that if you already have class CfgSounds in the description.ext just add the line below to CfgSounds:
```
#include "custom\dogs\sounds\defines.hpp"
```
8. Add these lines to your init.sqf:
```
BURK_dogSeek = compileFinal preprocessFileLineNumbers "custom\dogs\JohnO_fnc_seeking.sqf"; 
BURK_dogFollowPlayer = compileFinal preprocessFileLineNumbers "custom\dogs\JohnO_fnc_following.sqf"; 
```
9. Now change the price of the dog, x2 beef parts are needed. In config.cpp search for BeefParts and change the line to:

class Exile_Item_BeefParts { quality = 1; price = 10000; sellPrice = 14;}; // change the buy/sell price to whatever suits.

**Infistar Settings:**
Add "Craft Vehicle" to the allowedActions section:

allowedActions[] = {"Break free","Use AutoLockPicker","Craft Vehicle","Hack UAV"};

**Future Requests (please help):** 

+ The dog will attack other players, but only the owner can hear the dog bark & the player scream. I would love for the sounds to be global. Here is the code currently being used:
```
[BURK_dog,_actualTarget] say3d "barkmean1";
```
+ I can get the dog into a vehicle, but can't get it back out. Here is the code currently being used:
```
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
```
![JohnDog](https://github.com/aussie-battler/John-Dogs/blob/master/20180105215828_1.jpg?raw=true)
![JohnDog](https://github.com/aussie-battler/John-Dogs/blob/master/20180105225703_1.jpg)
