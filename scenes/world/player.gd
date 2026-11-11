extends CharacterBody2D
class_name Player2D

const WALK_SPEED: float = 70.0
const SPRINT_SPEED: float = 90.0
const STAMINA_MULTIPLIER: float = 15.0

var stamina: float = 100.0
var is_exhausted: bool = false

@onready var sprite: AnimatedSprite2D = %Sprite


func _physics_process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector(&"left", &"right", &"up", &"down")

	var is_sprinting: bool = Input.is_action_pressed(&"sprint")

	var speed: float = WALK_SPEED

	is_exhausted = stamina <= 0

	if is_sprinting and not is_exhausted and velocity:
		speed = SPRINT_SPEED
		stamina = clampf(stamina - delta * STAMINA_MULTIPLIER, 0.0, 100.0)

	if not (is_sprinting and velocity):
		stamina = clampf(stamina + delta * STAMINA_MULTIPLIER, 0.0, 100.0)

	print(speed)

	Game.stamina_changed.emit(stamina)

	velocity = speed * input_vector

	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

	if velocity == Vector2.ZERO:
		sprite.play(&"idle")
	else:
		if is_sprinting and not is_exhausted:
			sprite.play(&"sprint")
		else:
			sprite.play(&"walk")

	move_and_slide()
