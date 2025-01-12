class_name CardStats
extends Resource

@export var suit: Suit
@export var value: int

enum Suit {CLOVER, SPADE, DIAMOND, HEART}
const SUIT_NAMES: Dictionary = {
	Suit.CLOVER: "Clover",
	Suit.SPADE: "Spade",
	Suit.DIAMOND: "Diamond",
	Suit.HEART: "Heart",
}
const TEXTURE_EXTENSION = ".png"

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_suit = Suit.CLOVER, p_value = 2):
	suit = p_suit
	assert(p_value > 0 and p_value < 14, "Card value is invalid")
	value = p_value

func _to_string() -> String:
	return value_str() + " of " + SUIT_NAMES[suit] + "s"
	
func value_str() -> String:
	match value:
		1:
			return "Ace"
		11:
			return "Jack"
		12:
			return "Queen"
		13:
			return "King"
		_:
			return str(value)
			
func file_name() -> String:
	return "card_" + str(value) + "_" + SUIT_NAMES[suit].to_lower() + TEXTURE_EXTENSION

func texture() -> Texture2D:
	return load("res://Sprites/" + SUIT_NAMES[suit] + "/" + file_name())
	

static func random_card_stats() -> CardStats:
	var rng = RandomNumberGenerator.new()
	var p_suit: Suit = Suit.values()[ rng.randi_range(0, Suit.size() - 1)]
	var p_value: int = rng.randi_range(1, 13)
	return CardStats.new(p_suit, p_value)
