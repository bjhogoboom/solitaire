class_name Deck
extends Node

var cards: Array = []
const DECK_SIZE = 52

func _ready() -> void:
	for suit in CardStats.Suit:
		for value in CardStats.VALUES_COUNT:
			cards.push_back(CardStats.new(CardStats.Suit[suit], value + 1))
	cards.shuffle()
	
func _on_area_2d_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		deal()

func deal() -> void:
	print("Dealing")
	var card = Card.new_card(cards.pop_back())
	card.position = Vector2(-124, 0)
	add_child(card)
