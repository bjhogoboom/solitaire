extends Sprite2D

@onready var selected_indicator: Polygon2D = $SelectedIndicator

func on_card_input(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		select_card()

func select_card() -> void:
	print("Toggling visibility")
	selected_indicator.visible = !selected_indicator.visible
