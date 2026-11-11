extends MarginContainer

@onready var wood: Label = %Wood
@onready var cloth: Label = %Cloth
@onready var rope: Label = %Rope
@onready var sticks: Label = %Sticks

@onready var prompt_label: Label = %PromptLabel


func _ready() -> void:
	GameManager.items_changed.connect(_on_items_changed)
	GameManager.prompt_requested.connect(_on_prompt_requested)


func _on_items_changed() -> void:
	sticks.text = str(GameManager.get_item_amount(GameManager.Item.STICKS))
	wood.text = str(GameManager.get_item_amount(GameManager.Item.WOOD))
	cloth.text = str(GameManager.get_item_amount(GameManager.Item.CLOTH))
	rope.text = str(GameManager.get_item_amount(GameManager.Item.ROPE))


func _on_prompt_requested(prompt_visible: bool, text: String) -> void:
	prompt_label.visible = prompt_visible
	prompt_label.text = text
