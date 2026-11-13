extends Node

const WORLD: PackedScene = preload("uid://r3le8lu8wy1u")

@onready var title_screen: PanelContainer = %TitleScreen
@onready var fade_rect: ColorRect = %Fade

var world: Node2D
var skip_start: bool = false


func _ready() -> void:
	Game.game_started.connect(_on_game_started)
	Game.game_failed.connect(_on_game_failed)
	Game.game_finished.connect(_on_game_finished)
	Game.fade_requested.connect(_on_fade_requested)

	if skip_start:
		_on_game_started()


func _on_game_started() -> void:
	title_screen.hide()

	world = WORLD.instantiate()
	add_child(world)


func _on_game_failed() -> void:
	world.player.kill()

	await get_tree().create_timer(1.0).timeout

	Game.fade_requested.emit(true, 1.5)

	await get_tree().create_timer(1.5).timeout

	world.queue_free()

	await get_tree().process_frame

	_on_game_started()


func _on_game_finished() -> void:
	world.process_mode = Node.PROCESS_MODE_DISABLED

	Game.fade_requested.emit(true, 0.5)

	await get_tree().create_timer(0.5).timeout

	world.queue_free()
	title_screen.show()
	title_screen.show_finish_panel()

	Game.fade_requested.emit(false, 0.5)


func _on_fade_requested(fade_in: bool, time: float) -> void:
	var alpha: float = 1.0 if fade_in else 0.0
	var tween: Tween = create_tween()

	tween.tween_property(fade_rect, ^"color:a", alpha, time)
