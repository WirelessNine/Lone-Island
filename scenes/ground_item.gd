@tool
extends Sprite2D

const CLOTH: AtlasTexture = preload("uid://b6dy5vkioy2i7")
const ROPE: AtlasTexture = preload("uid://f8oxlwo7qheu")
const WOOD: AtlasTexture = preload("uid://8m3oak8yimmf")
const STICKS: AtlasTexture = preload("uid://bfsb4wqnl77tn")

@export var item: GameManager.Item:
	set(value):
		item = value

		match value:
			GameManager.Item.WOOD:
				texture = WOOD
			GameManager.Item.CLOTH:
				texture = CLOTH
			GameManager.Item.ROPE:
				texture = ROPE
			GameManager.Item.STICKS:
				texture = STICKS

var player_inside: bool = false
var picked_up: bool = false


func _input(event: InputEvent) -> void:
	if not (player_inside and not picked_up and event.is_action_pressed(&"interact")):
		return

	picked_up = true

	GameManager.add_item(item)

	queue_free()


func _on_pickup_body_entered(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = true
	GameManager.prompt_requested.emit(true, "Press E to Pickup")


func _on_pickup_body_exited(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = false
	GameManager.prompt_requested.emit(false, "")
