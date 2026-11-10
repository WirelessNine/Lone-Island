extends MarginContainer

@onready var wood: Label = %Wood
@onready var cloth: Label = %Cloth
@onready var rope: Label = %Rope

@onready var pickup_label: Label = $PickupLabel


func _ready() -> void:
	GameManager.items_changed.connect(_on_items_changed)
	GameManager.pickup_entered.connect(pickup_label.show)
	GameManager.pickup_exited.connect(pickup_label.hide)


func _on_items_changed() -> void:
	wood.text = str(GameManager.get_item_amount(GameManager.Item.WOOD))
	cloth.text = str(GameManager.get_item_amount(GameManager.Item.CLOTH))
	rope.text = str(GameManager.get_item_amount(GameManager.Item.ROPE))
