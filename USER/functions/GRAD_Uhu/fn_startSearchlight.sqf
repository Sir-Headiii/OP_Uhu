params ["_searchlight", ["_code", {(damage _this < 0.1) && !((behaviour _this) isEqualTo "COMBAT")}], ["_turnDegrees", 0.4], ["_turnStart", 275], ["_turnEnd", 445], ["_sleepTime", 0.05], ["_allTheWay", false]];

_searchlight action ["SearchlightOn"];
_searchlight addWeaponTurret ["fakeweapon", [0]];

private _incrementer = _turnStart;
private _condition = _searchlight call _code;

if (_allTheWay) then {
	private _incrementer = 1;
	while {(_incrementer >= 0) && _condition} do {
		_searchlight lookAt (_searchlight getRelPos [1000, _incrementer]);
		_incrementer = _incrementer + _turnDegrees;
		sleep _sleepTime;
		_condition = _searchlight call _code;
		if (_incrementer >= 360) then {
			_incrementer = 0
		};
	};
} else {
	while {_condition} do {
		while {(_incrementer < _turnEnd) && _condition} do {
			_searchlight lookAt (_searchlight getRelPos [1000, _incrementer]);
			_incrementer = _incrementer + _turnDegrees;
			sleep _sleepTime;
			_condition = _searchlight call _code;
		};

		while {(_incrementer > _turnStart) && _condition} do {
			_searchlight lookAt (_searchlight getRelPos [1000, _incrementer]);
			_incrementer = _incrementer - _turnDegrees;
			sleep _sleepTime;
			_condition = _searchlight call _code;
		};
	};
};