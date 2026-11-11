extends MarginContainer

@onready var wood: Label = %Wood
@onready var cloth: Label = %Cloth
@onready var rope: Label = %Rope
@onready var sticks: Label = %Sticks

@onready var prompt_label: Label = %PromptLabel

@onready var stamina_progress: TextureProgressBar = %Stamina


func _ready() -> void:
	Game.items_changed.connect(_on_items_changed)
	Game.stamina_changed.connect(_on_stamina_changed)
	Game.prompt_requested.connect(_on_prompt_requested)


func _on_items_changed() -> void:
	sticks.text = str(Game.get_item_amount(Game.Item.STICKS))
	wood.text = str(Game.get_item_amount(Game.Item.WOOD))
	cloth.text = str(Game.get_item_amount(Game.Item.CLOTH))
	rope.text = str(Game.get_item_amount(Game.Item.ROPE))


func _on_prompt_requested(prompt_visible: bool, text: String) -> void:
	prompt_label.visible = prompt_visible
	prompt_label.text = text


func _on_stamina_changed(new_value: float) -> void:
	stamina_progress.value = new_value
