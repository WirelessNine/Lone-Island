extends CharacterBody2D
class_name Player2D

const WALK_SPEED: float = 60.0
const SPRINT_SPEED: float = 90.0
const STAMINA_MULTIPLIER: float = 15.0

var stamina: float = 100.0
var is_exhausted: bool = false
var is_disabled: bool = false

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var footstep_sfx: AudioStreamPlayer = %FootstepSFX
@onready var footstep_timer: Timer = %FootstepTimer
@onready var death_sfx: AudioStreamPlayer = %DeathSFX


func _physics_process(delta: float) -> void:
	if is_disabled:
		return

	var input_vector: Vector2 = Input.get_vector(&"left", &"right", &"up", &"down")

	var is_sprinting: bool = Input.is_action_pressed(&"sprint")

	var speed: float = WALK_SPEED

	is_exhausted = stamina <= 0

	if is_sprinting and not is_exhausted and velocity:
		speed = SPRINT_SPEED
		stamina = clampf(stamina - delta * STAMINA_MULTIPLIER, 0.0, 100.0)

	if not (is_sprinting and velocity):
		stamina = clampf(stamina + delta * STAMINA_MULTIPLIER, 0.0, 100.0)

	Game.stamina_changed.emit(stamina)

	if not velocity:
		if not footstep_timer.paused:
			footstep_timer.paused = true

	else:
		footstep_timer.wait_time = 0.2 if is_sprinting and not is_exhausted else 0.4

		if footstep_timer.paused:
			footstep_timer.paused = false

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


func kill() -> void:
	is_disabled = true
	footstep_timer.stop()
	sprite.modulate.a = 0.0

	death_sfx.play()


func _on_footstep_timer_timeout() -> void:
	footstep_sfx.play()
