extends Node

const WORLD: PackedScene = preload("uid://cynwuhlfs1dpj")

@onready var title_screen: PanelContainer = %TitleScreen
@onready var fade_rect: ColorRect = %Fade


func _ready() -> void:
	Game.game_started.connect(_on_game_started)
	Game.fade_requested.connect(_on_fade_requested)


func _on_game_started() -> void:
	title_screen.hide()

	var world: Node2D = WORLD.instantiate()
	add_child(world)


func _on_fade_requested(fade_in: bool, time: float) -> void:
	var alpha: float = 1.0 if fade_in else 0.0
	var tween: Tween = create_tween()

	tween.tween_property(fade_rect, ^"color:a", alpha, time)
