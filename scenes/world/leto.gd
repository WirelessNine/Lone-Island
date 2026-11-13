extends Area2D

const SPEED: float = 65.0

@export var player: CharacterBody2D

var enabled: bool = true

@onready var sprite: AnimatedSprite2D = %Sprite


func enable() -> void:
	enabled = true
	monitoring = true
	show()


func disable() -> void:
	enabled = false
	monitoring = false
	hide()


func _physics_process(delta: float) -> void:
	if not (enabled and player):
		return

	global_position = global_position.move_toward(player.global_position, delta * SPEED)

	sprite.flip_h = player.global_position.x < global_position.x

	print(global_position.distance_squared_to(player.global_position))


func _on_body_entered(body: Node2D) -> void:
	if body is not Player2D:
		return

	Game.game_failed.emit()
