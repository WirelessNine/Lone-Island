extends MarginContainer

const AMOUNT_STRING: String = "%d/%d"

@onready var sticks_icon: TextureRect = %SticksIcon
@onready var wood_icon: TextureRect = %WoodIcon
@onready var cloth_icon: TextureRect = %ClothIcon
@onready var rope_icon: TextureRect = %RopeIcon

@onready var wood: Label = %Wood
@onready var cloth: Label = %Cloth
@onready var rope: Label = %Rope
@onready var sticks: Label = %Sticks

@onready var prompt_label: Label = %PromptLabel
@onready var dialogue_label: Label = %DialogueLabel

@onready var stamina_progress: TextureProgressBar = %Stamina


func _ready() -> void:
	Game.items_changed.connect(_on_items_changed)
	Game.flash_item_requested.connect(_on_flash_item_requested)
	Game.stamina_changed.connect(_on_stamina_changed)
	Game.prompt_requested.connect(_on_prompt_requested)
	Game.dialogue_requested.connect(_on_dialogue_requested)

	_on_items_changed()


func _on_items_changed() -> void:
	sticks.text = str(Game.get_item_amount(Game.Item.STICKS))

	wood.text = AMOUNT_STRING % [Game.get_item_amount(Game.Item.WOOD), Game.WOOD_REQUIRED]
	cloth.text = AMOUNT_STRING % [Game.get_item_amount(Game.Item.CLOTH), Game.CLOTH_REQUIRED]
	rope.text = AMOUNT_STRING % [Game.get_item_amount(Game.Item.ROPE), Game.ROPE_REQUIRED]


func _on_flash_item_requested(item: Game.Item) -> void:
	var rect: TextureRect = null
	var label: Label = null

	match item:
		Game.Item.STICKS:
			rect = sticks_icon
			label = sticks
		Game.Item.WOOD:
			rect = wood_icon
			label = wood
		Game.Item.CLOTH:
			rect = cloth_icon
			label = cloth
		Game.Item.ROPE:
			rect = rope_icon
			label = rope

	rect.modulate = Color.RED
	label.modulate = Color.RED

	await get_tree().create_timer(0.1).timeout

	rect.modulate = Color.WHITE
	label.modulate = Color.WHITE


func _on_prompt_requested(prompt_visible: bool, text: String) -> void:
	prompt_label.visible = prompt_visible
	prompt_label.text = text


func _on_dialogue_requested(text: String) -> void:
	dialogue_label.visible_ratio = 0.0
	dialogue_label.text = text

	dialogue_label.show()
	dialogue_label.modulate.a = 1.0

	var tween: Tween = create_tween()

	tween.tween_property(dialogue_label, ^"visible_ratio", 1.0, 1.4)
	tween.tween_interval(2.0)
	tween.tween_property(dialogue_label, ^"modulate:a", 0.0, 1.0)
	tween.tween_callback(dialogue_label.hide)


func _on_stamina_changed(new_value: float) -> void:
	stamina_progress.value = new_value
