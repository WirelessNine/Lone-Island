extends Node2D

const DAY_TIME: float = 120.0
const NIGHT_TIME: float = 60.0

@onready var day_timer: Timer = %DayTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player: Player2D = %Player
@onready var leto: Area2D = %Leto
@onready var ground_layer: TileMapLayer = %GroundLayer


func _ready() -> void:
	Game.safe_zone_changed.connect(_on_safe_zone_changed)

	despawn_monster()

	day_timer.start(DAY_TIME)

	Game.fade_requested.emit(false, 1.5)

	await get_tree().create_timer(2.0).timeout

	Game.dialogue_requested.emit("I need to escape...")


func spawn_monster() -> void:
	var tiles: Array[Vector2i] = ground_layer.get_used_cells()
	tiles.shuffle()

	var spawn_pos: Vector2

	for x: Vector2i in tiles:
		var pos: Vector2 = ground_layer.map_to_local(x)

		if pos < player.global_position:
			continue

		spawn_pos = pos
		break

	leto.global_position = spawn_pos
	leto.enable()


func despawn_monster() -> void:
	leto.disable()


func _on_safe_zone_changed() -> void:
	if Game.is_day:
		return

	if Game.is_player_in_safezone:
		despawn_monster()
	else:
		spawn_monster()


func _on_day_timer_timeout() -> void:
	if Game.is_day:
		Game.is_day = false
		animation_player.play(&"night")
		day_timer.start(NIGHT_TIME)

		if not Game.is_player_in_safezone:
			spawn_monster()
	else:
		Game.is_day = true
		animation_player.play(&"day")
		day_timer.start(DAY_TIME)

		despawn_monster()
