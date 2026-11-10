extends CharacterBody2D
class_name Player2D

const WALK_SPEED: float = 70.0
const SPRINT_SPEED: float = 90.0

@onready var sprite: AnimatedSprite2D = %Sprite


func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector(&"left", &"right", &"up", &"down")

	var is_sprinting: bool = Input.is_action_pressed(&"sprint")
	var speed: float = SPRINT_SPEED if is_sprinting else WALK_SPEED

	velocity = speed * input_vector

	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

	if velocity == Vector2.ZERO:
		sprite.play(&"idle")
	else:
		if is_sprinting:
			sprite.play(&"sprint")
		else:
			sprite.play(&"walk")

	move_and_slide()
