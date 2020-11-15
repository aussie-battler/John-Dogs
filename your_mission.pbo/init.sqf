
{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
    ['BURK_dogSeek', 'custom\dogs\JohnO_fnc_seeking.sqf'],	
	['BURK_dogFollowPlayer', 'custom\dogs\JohnO_fnc_following.sqf']
];



