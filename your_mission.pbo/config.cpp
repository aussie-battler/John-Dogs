class CfgExileCustomCode 
{
	//JohnO Dogs
	ExileClient_object_player_initialize = "custom\dogs\ExileClient_object_player_initialize.sqf";
};

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
		recipe[] = {{"Exile_Item_BeefParts",1}};
		packable = 0;
		autoCleanUp = 0;
		quickFunction = "['ExAd_Dog'] call ExAd_XM8_DV_fnc_spawnVehicle";
	};
}; 

