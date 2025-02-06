class_name GameState
extends Node

@export var deck: Deck
@export var ranks_parent: Node
@export var ace_stacks_parent: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	for ace_stack in ace_stacks_parent.get_children():
		if ace_stack is AceStack:
			ace_stack.ace_stacked.connect(on_ace_stacked)


func reset() -> void:
	deck.reset()
	deal()


func on_ace_stacked(_card: Card) -> void:
	check_win_condition()


func check_win_condition() -> void:
	var won = true
	for ace_stack in ace_stacks_parent.get_children():
		if ace_stack is AceStack:
			if ace_stack.num_cards < 13:
				won = false
				break
	if won:
		print("YOU WON")
	else:
		print("YOU HAVEN'T WON YET")


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
func _process(_delta: float) -> void:
	pass
