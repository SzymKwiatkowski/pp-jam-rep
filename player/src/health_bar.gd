extends ProgressBar

@onready var _damage_bar: ProgressBar = $ProgressBar
@onready var _damage_timer: Timer = $Timer
var _hp = -1


func setup(hp: int):
	_hp = hp
	value = _hp
	_damage_bar.value = _hp


func take_damage(damage: int):
	_hp -= damage
	value = _hp
	_damage_timer.start(0.1)


func _on_timer_timeout():
	_damage_bar.value = _hp
