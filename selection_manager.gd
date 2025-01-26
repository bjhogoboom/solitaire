extends Node

var selected_card: Card

signal card_selected(card: Card)

func _ready() -> void:
	self.card_selected.connect(_on_card_selected)

func set_selected_card(card: Card):
	if selected_card:
		card.stack(selected_card)
		selected_card._unselect()
		selected_card = null
	else:
		selected_card = card
		selected_card._select()

func _on_card_selected(card: Card):
	set_selected_card(card)
	
func stack_to_ace_stack(ace_stack: AceStack):
	if !selected_card:
		return
	ace_stack.stack(selected_card)
	unselect()

func unselect():
	if selected_card:
		selected_card._unselect()
	selected_card = null
