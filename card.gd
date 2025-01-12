extends Sprite2D

@onready var selected_indicator: Polygon2D = $SelectedIndicator
var stats: CardStats

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	texture = stats.texture()

func on_card_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		select_card()

func select_card() -> void:
	selected_indicator.visible = !selected_indicator.visible
