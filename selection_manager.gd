extends Node

signal card_selected(card: Card)

var selected_card: Card


func _ready() -> void:
	self.card_selected.connect(_on_card_selected)


func set_selected_card(card: Card):
	if selected_card:
		var stacked = card.stack(selected_card)
		if stacked:
			selected_card.card_stacked.emit(selected_card)
			selected_card.card_stacked.connect(card.on_card_stacked_from)
		selected_card._unselect()
		selected_card = null
	else:
		selected_card = card
		selected_card._select()


func _on_card_selected(card: Card):
	set_selected_card(card)


func ace_stack_selected(ace_stack: AceStack):
	if !selected_card:
		selected_card = ace_stack.top_card()
		ace_stack.select_top_card()
		return
	var stacked = ace_stack.stack(selected_card)
	if stacked:
		selected_card.card_stacked.emit(selected_card)
		selected_card.card_stacked.connect(ace_stack.on_card_stacked_from)
	unselect()


func rank_selected(rank: Rank):
	if !selected_card:
		return
	var stacked = rank.stack(selected_card)
	if stacked:
		selected_card.card_stacked.emit(selected_card)
		selected_card.card_stacked.connect(rank.on_card_stacked_from)
	unselect()


func unselect():
	if selected_card && is_instance_valid(selected_card):
		selected_card._unselect()
	selected_card = null
