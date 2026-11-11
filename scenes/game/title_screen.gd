extends PanelContainer


func _on_start_pressed() -> void:
	Game.game_started.emit()
