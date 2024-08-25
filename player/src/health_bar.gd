extends ProgressBar

@onready var _damage_bar: ProgressBar = $ProgressBar
@onready var _damage_timer: Timer = $Timer
var _hp: float = -1


func setup(hp: float):
	_hp = hp
	value = _hp
	_damage_bar.value = _hp


func take_damage(damage: float):
	_hp -= damage
	value = _hp
	_damage_timer.start(0.1)


func _on_timer_timeout():
	_damage_bar.value = _hp
