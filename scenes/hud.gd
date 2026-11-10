extends MarginContainer

@onready var wood: Label = %Wood
@onready var cloth: Label = %Cloth
@onready var rope: Label = %Rope


func _ready() -> void:
	GameManager.items_changed.connect(_on_items_changed)


func _on_items_changed() -> void:
	wood.text = str(GameManager.get_item_amount(GameManager.Item.WOOD))
	cloth.text = str(GameManager.get_item_amount(GameManager.Item.CLOTH))
	rope.text = str(GameManager.get_item_amount(GameManager.Item.ROPE))
