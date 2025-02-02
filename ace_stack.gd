class_name AceStack
extends Node2D

var cards: Array = []

func stack(card: Card) -> void:
	if stackable(card):
		cards.push_back(card)
		var parent = card.get_parent()
		if parent is Card:
			parent.use_childless_collision_shape()
		if parent is Deck:
			parent.pop()
		card.reparent(self)
		card.disable()
		card.position = Vector2.ZERO

func stackable(card: Card) -> bool:
	print("checking ace stack stackable")
	if cards.size() == 0:
		print("ace stack stackable: " + str(card.stats.value == 1))

		return card.stats.value == 1

	var same_suit = top_card().stats.suit == card.stats.suit
	var value_stackable = top_card().stats.value == (card.stats.value - 1)
	print("ace stack stackable: " + str(same_suit) + str(value_stackable))
	return same_suit && value_stackable

func top_card() -> Card:
	return null if cards.is_empty() else cards.back()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		SelectionManager.ace_stack_selected(self)

func select_top_card():
	top_card().show_selection_indicators()
	
func pop() -> void:
	cards.pop_back()
