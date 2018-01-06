_caller= _this select 0;
_action = _this select 2;
_caller removeAction _action;
Agressive = false;

titleText ["Your dog is passive and will only follow you","PLAIN DOWN"];
agressiveAction = player addAction ["Dog: Aggressive","custom\dogs\agressive.sqf","",0,false];