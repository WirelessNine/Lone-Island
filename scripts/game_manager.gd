extends Node

signal items_changed

enum Item {
	WOOD,
	CLOTH,
	ROPE,
}

var items: Dictionary[Item, int] = { Item.WOOD: 0, Item.CLOTH: 0, Item.ROPE: 0 }


func add_item(item: Item) -> void:
	items[item] += 1

	items_changed.emit()


func get_item_amount(item: Item) -> int:
	return items[item]
