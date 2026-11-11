extends Node

signal items_changed
signal stamina_changed(new_value: float)
signal prompt_requested(visible: bool, text: String)

enum Item {
	STICKS,
	WOOD,
	CLOTH,
	ROPE,
}

var items: Dictionary[Item, int] = { Item.STICKS: 0, Item.WOOD: 0, Item.CLOTH: 0, Item.ROPE: 0 }
var is_player_in_safezone: bool = false


func add_item(item: Item) -> void:
	items[item] += 1

	items_changed.emit()


func remove_item(item: Item) -> void:
	items[item] -= 1

	items_changed.emit()


func get_item_amount(item: Item) -> int:
	return items[item]
