extends Node

var selected_card: Card

signal selectable_selected(selectable: Selectable)

func _ready() -> void:
	self.selectable_selected.connect(_on_selectable_selected)

func set_selected_card(card: Card):
	if selected_card:
		print("Stacking")
		card.stack(selected_card)
		selected_card._unselect()
		selected_card = null
	else:
		selected_card = card
		selected_card._select()
		print("Selecting")

func _on_selectable_selected(card: Card):
	set_selected_card(card)
