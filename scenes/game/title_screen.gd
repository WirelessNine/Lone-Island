extends PanelContainer

var started: bool

@onready var start_panel: PanelContainer = %StartPanel
@onready var finish_panel: PanelContainer = %FinishPanel


func _ready() -> void:
	start_panel.show()
	finish_panel.hide()


func show_finish_panel() -> void:
	start_panel.hide()
	finish_panel.show()


func _on_start_pressed() -> void:
	if started:
		return

	started = true

	Game.fade_requested.emit(true, 2.0)

	await get_tree().create_timer(2.0).timeout

	Game.game_started.emit()
