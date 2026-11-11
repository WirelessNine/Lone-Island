extends Node


func _ready() -> void:
	Game.dialogue_requested.emit("I need to escape...")
