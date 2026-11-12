extends PanelContainer

var started: bool


func _on_start_pressed() -> void:
	if started:
		return

	started = true

	Game.fade_requested.emit(true, 2.0)

	await get_tree().create_timer(2.0).timeout

	Game.game_started.emit()
