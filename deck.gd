class_name Deck
extends Node

var cards: Array = []
const DECK_SIZE = 52

func _ready() -> void:
	for suit in CardStats.Suit:
		for value in CardStats.VALUES_COUNT:
			cards.push_back(CardStats.new(CardStats.Suit[suit], value + 1))
	cards.shuffle()
