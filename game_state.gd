class_name GameState
extends Node

@export var deck: Deck
@export var ranks_parent: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	
func reset() -> void:
	deck.reset()
	deal()

func deal() -> void:
	var ranks: Array[Node] = ranks_parent.get_children()
	for i in ranks.size():
		var rank = ranks[i]
		for j in i:
			var face_down_card = deck.pop_from_deck(Card.Flip.FACE_DOWN)
			face_down_card.flip = Card.Flip.FACE_DOWN
			rank.force_stack(face_down_card)
		var face_up_card = deck.pop_from_deck(Card.Flip.FACE_UP)
		rank.force_stack(face_up_card)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
