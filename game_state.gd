extends Node

@export var deck: Deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	
func reset() -> void:
	deck.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
