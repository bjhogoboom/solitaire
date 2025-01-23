class_name Card
extends Selectable

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var stats: CardStats
var selected: bool
const CHILD_OFFSET = Vector2(0, 20)

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	sprite_2d.texture = stats.texture()
	super()

func _toggle_select() -> void:
	if selected:
		_unselect()
	else:
		_select()

func _select() -> void:
	print("Card selected! " + str(stats))
	selected_indicator.visible = true
	selected = true

func _unselect() -> void:
	print("Card unselected! " + str(stats))
	selected_indicator.visible = false
	selected = false

func stackable(card: Card) -> bool:
	#if card == self:
		#return false
	var can_stack = self.stats.stackable(card.stats)
	var str_can = ""
	if can_stack:
		str_can = " is "
	else:
		str_can = " is not "
	print(str(card) + str_can + "stackable on " + str(self))
	return self.stats.stackable(card.stats)
	
func _to_string():
	return str(stats)

func stack(card: Card) -> void:
	if stackable(card):
		card.reparent(self)
		card.position = Vector2.ZERO + CHILD_OFFSET
