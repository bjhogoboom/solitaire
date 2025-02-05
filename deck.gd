class_name Deck
extends Node

var cards: Array = []
var dealt_cards: Array = []
const DECK_SIZE = 52

func _ready() -> void:
	pass

func reset() -> void:
	cards = []
	for suit in CardStats.Suit:
		for value in CardStats.VALUES_COUNT:
			cards.push_back(CardStats.new(CardStats.Suit[suit], value + 1))
	cards.shuffle()

func _on_area_2d_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		deal()

func deal() -> void:
	if cards.size() == 0:
		return
	var card = Card.new_card(cards.pop_back())
	card.position = Vector2(-124, 0)
	add_child(card)
	if top_card():
		top_card().disable()
	dealt_cards.push_back(card)
	SelectionManager.unselect()
	
# STACKING FROM DECK TO ACE STACK MAKES ALL IN DEALT CARDS ENABLED

func top_card() -> Card:
	return null if dealt_cards.is_empty() else dealt_cards.back()

func pop_from_dealt() -> void:
	dealt_cards.pop_back()
	if top_card():
		top_card().enable()

func pop_from_deck(flip: Card.Flip) -> Card:
	return Card.new_card(cards.pop_back(), flip)
