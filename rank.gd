class_name Rank
extends Node2D

var cards: Array = []

@onready var selection_area: Area2D = $SelectableArea


func force_stack(card: Card) -> void:
	_stack_internal(card)


func stack(card: Card) -> void:
	if stackable(card):
		_stack_internal(card)


func _stack_internal(card: Card) -> void:
	if _top_card():
		_stack_to_top_card(card)
	else:
		_stack_as_root(card)
	cards.push_back(card)
	var parent = card.get_parent()
	if parent is Card:
		parent.use_childless_collision_shape()
	if parent is Deck || inter_rank_move(parent):
		parent.pop()


func inter_rank_move(parent: Node) -> bool:
	return (parent is Rank) && parent != self


func _stack_to_top_card(card: Card) -> void:
	_top_card().force_stack(card)


func _stack_as_root(card: Card) -> void:
	disable()
	if card.get_parent():
		card.unstack_from_parent(card.get_parent())
		card.reparent(self)
	else:
		add_child(card)
	card.position = Vector2.ZERO


func stackable(card: Card) -> bool:
	return cards.size() == 0 && card.stats.value == 13


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		SelectionManager.rank_selected(self)


func pop() -> void:
	cards.pop_back()
	if cards.is_empty():
		enable()


func disable() -> void:
	selection_area.input_pickable = false


func enable() -> void:
	selection_area.input_pickable = true


func _top_card() -> Card:
	return null if cards.is_empty() else cards.back()
