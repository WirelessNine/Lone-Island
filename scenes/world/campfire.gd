extends StaticBody2D

var fuel: int = 0
var is_on: bool = false
var player_inside: bool = false

@onready var fuel_timer: Timer = %FuelTimer
@onready var fire_sprite: AnimatedSprite2D = %Fire
@onready var area_light: PointLight2D = %AreaLight


func _ready() -> void:
	toggle_fire(false)


func _input(event: InputEvent) -> void:
	if not (player_inside and event.is_action_pressed(&"interact")):
		return

	if Game.get_item_amount(Game.Item.STICKS) <= 0:
		Game.flash_item_requested.emit(Game.Item.STICKS)
		return

	Game.remove_item(Game.Item.STICKS)
	fuel += 1

	if not is_on:
		is_on = true
		toggle_fire(true)
		fuel_timer.start()

	update_prompt()


func toggle_fire(value: bool) -> void:
	fire_sprite.visible = value
	area_light.visible = value


func update_prompt() -> void:
	if not player_inside:
		Game.prompt_requested.emit(false, "")
		return

	Game.prompt_requested.emit(true, "Press E to add Fuel")


func _on_area_body_entered(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = true
	Game.is_player_in_safezone = is_on
	update_prompt()


func _on_area_body_exited(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = false
	Game.is_player_in_safezone = false
	update_prompt()


func _on_fuel_timer_timeout() -> void:
	if fuel > 0:
		fuel -= 1

	if fuel == 0:
		is_on = false
		toggle_fire(false)
		fuel_timer.stop()

	update_prompt()
