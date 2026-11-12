extends Node

signal items_changed
signal stamina_changed(new_value: float)
signal dialogue_requested(text: String)
signal prompt_requested(visible: bool, text: String)
signal fade_requested(fade_in: bool, time: float)
signal flash_item_requested(item: Game.Item)
signal game_started
signal game_finished

const WOOD_REQUIRED: int = 4
const CLOTH_REQUIRED: int = 5
const ROPE_REQUIRED: int = 6

enum Item {
	STICKS,
	WOOD,
	CLOTH,
	ROPE,
}

var items: Dictionary[Item, int] = { Item.STICKS: 0, Item.WOOD: 0, Item.CLOTH: 0, Item.ROPE: 0 }
var is_player_in_safezone: bool = false
var is_day: bool = true


func add_item(item: Item) -> void:
	items[item] += 1

	items_changed.emit()


func remove_item(item: Item) -> void:
	items[item] -= 1

	items_changed.emit()


func get_item_amount(item: Item) -> int:
	return items[item]
