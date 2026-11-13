extends StaticBody2D

var player_inside = false
var is_repaired: bool = false

@onready var error_sfx: AudioStreamPlayer = %ErrorSFX


func _input(event: InputEvent) -> void:
	if not (player_inside and not is_repaired and event.is_action_pressed(&"interact")):
		return

	var wood: int = Game.get_item_amount(Game.Item.WOOD)
	var cloth: int = Game.get_item_amount(Game.Item.CLOTH)
	var rope: int = Game.get_item_amount(Game.Item.ROPE)

	var has_enough_items: bool = true

	if wood < Game.WOOD_REQUIRED:
		has_enough_items = false
		Game.flash_item_requested.emit(Game.Item.WOOD)

	if cloth < Game.CLOTH_REQUIRED:
		has_enough_items = false
		Game.flash_item_requested.emit(Game.Item.CLOTH)

	if rope < Game.ROPE_REQUIRED:
		has_enough_items = false
		Game.flash_item_requested.emit(Game.Item.ROPE)

	if not has_enough_items:
		error_sfx.play()
		return

	Game.game_finished.emit()


func update_prompt() -> void:
	if not player_inside:
		Game.prompt_requested.emit(false, "")
		return

	Game.prompt_requested.emit(true, "Press E to repair")


func _on_area_body_entered(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = true
	update_prompt()


func _on_area_body_exited(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = false
	update_prompt()
