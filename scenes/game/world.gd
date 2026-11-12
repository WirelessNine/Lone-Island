extends Node2D

const DAY_TIME: float = 120.0
const NIGHT_TIME: float = 60.0

@onready var day_timer: Timer = %DayTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	day_timer.start(DAY_TIME)

	Game.fade_requested.emit(false, 1.5)

	await get_tree().create_timer(2.0).timeout

	Game.dialogue_requested.emit("I need to escape...")


func _on_day_timer_timeout() -> void:
	if Game.is_day:
		Game.is_day = false
		animation_player.play(&"night")
		day_timer.start(NIGHT_TIME)
	else:
		Game.is_day = true
		animation_player.play(&"day")
		day_timer.start(DAY_TIME)
