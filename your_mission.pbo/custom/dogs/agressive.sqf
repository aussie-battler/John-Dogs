_caller= _this select 0;
_action = _this select 2;
_caller removeAction _action;
Agressive = true;

titleText ["Your dog is now aggressive and will attack living things around you...","PLAIN DOWN"];
passiveAction = player addAction ["Dog: Passive","custom\dogs\passive.sqf","",0,false];