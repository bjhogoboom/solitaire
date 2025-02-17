class_name AceStack
extends Node2D

signal ace_stacked(card: Card)

var cards: Array = []
var num_cards: int:
	get:
		return cards.size()


func stack(card: Card) -> bool:
	var card_stackable = stackable(card)
	if card_stackable:
		on_card_stacked_to(card)
	return card_stackable


func stackable(card: Card) -> bool:
	if cards.size() == 0:
		return card.stats.value == 1

	var same_suit = top_card().stats.suit == card.stats.suit
	var value_stackable = top_card().stats.value == (card.stats.value - 1)
	return same_suit && value_stackable


func top_card() -> Card:
	return null if cards.is_empty() else cards.back()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		SelectionManager.ace_stack_selected(self)


func select_top_card():
	if top_card():
		top_card().show_selection_indicators()


func pop() -> void:
	cards.pop_back()


func on_card_stacked_to(card: Card):
	cards.push_back(card)
	var parent = card.get_parent()
	card.reparent(self)
	card.disable()
	card.position = Vector2.ZERO
	ace_stacked.emit(card)


func on_card_stacked_from(card: Card):
	pop()
	card.card_stacked.disconnect(on_card_stacked_from)
