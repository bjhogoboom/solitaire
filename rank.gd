class_name Rank
extends Node2D

@onready var selection_area: Area2D = $SelectableArea

var cards: Array = []

func stack(card: Card) -> void:
	if stackable(card):
		cards.push_back(card)
		var parent = card.get_parent()
		if parent is Card:
			parent.use_childless_collision_shape()
		if parent is Deck || parent is Rank:
			parent.pop()
		card.reparent(self)
		card.position = Vector2.ZERO
		disable()

func stackable(card: Card) -> bool:
	return cards.size() == 0 && card.stats.value == 13
#
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		SelectionManager.rank_selected(self)

func pop() -> void:
	print("pop from rank")
	cards.pop_back()
	if cards.is_empty():
		print("rank is empty")
		enable()

func disable() -> void:
	selection_area.input_pickable = false
	
func enable() -> void:
	selection_area.input_pickable = true
