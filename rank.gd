class_name Rank
extends Node2D

@export var nice_name: String = "Rank 0"

var cards: Array = []

@onready var selection_area: Area2D = $SelectableArea


func force_stack(card: Card) -> void:
	_stack_internal(card)
	card.card_stacked.connect(on_card_stacked_from)


func stack(card: Card) -> bool:
	var card_stackable = stackable(card)
	if card_stackable:
		_stack_internal(card)
	return card_stackable


func _stack_internal(card: Card) -> void:
	if _top_card():
		_stack_to_top_card(card)
	else:
		_stack_as_root(card)
	on_card_stacked_to(card)


func _stack_to_top_card(card: Card) -> void:
	_top_card().force_stack(card)


func _stack_as_root(card: Card) -> void:
	if card.get_parent():
		card.reparent(self)
	else:
		add_child(card)
	card.position = Vector2.ZERO


func stackable(card: Card) -> bool:
	return cards.size() == 0 && card.stats.value == 13


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		SelectionManager.rank_selected(self)


func disable() -> void:
	selection_area.input_pickable = false


func enable() -> void:
	selection_area.input_pickable = true


func _top_card() -> Card:
	return null if cards.is_empty() else cards.back()


func on_card_stacked_to(card: Card):
	disable()
	cards.push_back(card)


func on_card_stacked_from(card: Card):
	cards.pop_back()
	if cards.is_empty():
		enable()
	else:
		_top_card().flip = Card.Flip.FACE_UP
		_top_card().enable()
	card.card_stacked.disconnect(on_card_stacked_from)
