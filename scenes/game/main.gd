extends Node

const WORLD: PackedScene = preload("uid://cynwuhlfs1dpj")

@onready var title_screen: PanelContainer = %TitleScreen


func _ready() -> void:
	Game.game_started.connect(_on_game_started)


func _on_game_started() -> void:
	title_screen.hide()

	var world: Node2D = WORLD.instantiate()
	add_child(world)
