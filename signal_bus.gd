extends Node

var selected_card: Card

signal selectable_selected(selectable: Selectable)

func set_selected_card(card: Card):
	selected_card = card
