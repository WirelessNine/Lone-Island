@tool
extends Sprite2D

const CLOTH: AtlasTexture = preload("uid://b6dy5vkioy2i7")
const ROPE: AtlasTexture = preload("uid://f8oxlwo7qheu")
const WOOD: AtlasTexture = preload("uid://8m3oak8yimmf")

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

var player_inside: bool = false
var picked_up: bool = false


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if not player_inside:
		return

	if not event.is_action_pressed(&"pickup"):
		return

	if picked_up:
		return

	picked_up = true

	GameManager.add_item(item)

	queue_free()


func _on_pickup_body_entered(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = true
	GameManager.pickup_entered.emit()


func _on_pickup_body_exited(body: Node2D) -> void:
	if not body is Player2D:
		return

	player_inside = false
	GameManager.pickup_exited.emit()
